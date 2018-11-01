class BookingsController < ApplicationController
  before_action :set_listing, only: [:new, :create]
  before_action :check_for_errors, only: [:new, :create]
  def new
    if params[:booking]
      @booking = Booking.new(
        start_date: @start_date,
        end_date: @end_date,
        total_cost: @amount
      )
    end
  end

  def create
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
    # Remove booked days from available days table
    @avail_days.destroy_all
    if @booking.save
      redirect_to listing_path(@listing), notice: 'Booking was successfully created.'
    else
      redirect_to listing_path(@listing), alert: 'Booking failed'
    end

  rescue Stripe::CardError => e
    redirect_to new_listing_booking_path(@listing), alert: e.message
  end

  private

  def set_listing
    @listing = Listing.find(params[:listing_id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :total_cost)
  end

  def check_for_errors
    if params[:booking]
      begin
        @start_date = params[:booking][:start_date]
        @end_date = params[:booking][:end_date]
        if @end_date <= @start_date
          raise BookingError, "Error: Start date needs to be before end date"
        end
        date_arr = (@start_date..@end_date).to_a
        @avail_days = AvailableDay.where(listing_id: @listing.id, day: date_arr)
        if date_arr.count != @avail_days.count
          raise BookingError, "Error: Dates not available"
        end
        @num_days = @avail_days.count
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
