class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_booking, only: [:destroy]
  before_action :set_listing, only: [:new, :create]
  before_action :check_for_errors, only: [:new, :create]

  def index
    @renter_bookings = Booking.where(user_id: current_user.id).includes(listing: :user).order(start_date: :asc)
    # @renter_bookings = []
    listing_ids = Listing.where(user_id: current_user.id).pluck(:id)
    @lister_bookings = Booking.where(listing_id: listing_ids).includes(:listing, :user).order(start_date: :asc)
    # @lister_bookings = []
  end

  def new
    @unavailable_days = UnavailableDay.where(listing_id: @listing.id).pluck(:day)
    if params[:booking]
      @booking = Booking.new(
        start_date: @start_date,
        end_date: @end_date,
        total_cost: @amount
      )
    end
  end

  def create
    begin
      # Amount in cents
      if current_user.stripe_cust_id.nil?
        customer = Stripe::Customer.create(
          :email => params[:stripeEmail],
          :source  => params[:stripeToken]
        )
        current_user.stripe_cust_id = customer.id
        current_user.save
      end

      charge = Stripe::Charge.create(
        :customer    => current_user.stripe_cust_id,
        :amount      => @amount,
        :description => 'Rails Stripe customer',
        :currency    => 'aud'
      )
      # Create Booking
      @booking = Booking.new(booking_params)
      @booking.user_id = current_user.id
      @booking.listing_id = @listing.id
      @booking.booking_date = Date.today
      @booking.stripe_charge_id = charge.id
      if @booking.save
        redirect_to bookings_path, notice: 'Booking was successfully created.'
      else
        redirect_to new_listing_booking_path(@listing), alert: 'Booking failed.'
      end

    rescue Stripe::CardError => e
      redirect_to new_listing_booking_path(@listing), alert: e.message
    end
  end

  def destroy
    begin
      refund = Stripe::Refund.create(
        charge: @booking.stripe_charge_id
      )
      if @booking.destroy
        redirect_to bookings_path, notice: "Booking succesfully destroyed and refunded: $#{refund.amount / 100}.00"
      end
    rescue Stripe::StripeError => e
      redirect_to bookings_path, alert: e.message
    end
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def set_listing
    @listing = Listing.find(params[:listing_id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :total_cost)
  end
0
  def check_for_errors
    if params[:booking]
      begin
        @start_date = params[:booking][:start_date].to_date
        if @start_date < Time.now.to_date
          raise BookingError, "Error: Start date can't be in the past"
        end
        @end_date = params[:booking][:end_date].to_date
        if @end_date <= @start_date
          raise BookingError, "Error: Start date needs to be before end date"
        end
        date_arr = (@start_date..@end_date).to_a
        unavail_days = UnavailableDay.where(listing_id: @listing.id, day: date_arr)
        unless unavail_days.empty?
          raise BookingError, "Error: Dates not available"
        end
        @num_days = date_arr.count
        @amount = @num_days * @listing.daily_price
        if params[:booking][:total_cost] && @amount != params[:booking][:total_cost].to_i
          raise BookingError, "Error: Amount Incorrect - Payment Stopped"
        end
      rescue BookingError => e
        redirect_to new_listing_booking_path(@listing), alert: e.message
        return
      end
    end
  end
end
