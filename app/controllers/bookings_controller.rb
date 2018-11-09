class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_booking, :check_permission, only: [:destroy]
  before_action :set_listing, only: [:new, :create]
  before_action :check_for_errors, only: [:new, :create]

  def index
    # Eager load listing, owner and reviews to allow for title and name and review links in view
    @renter_bookings = Booking.where(user_id: current_user.id).includes(:review, listing: :user).order(start_date: :asc)
    # Get current user's listings ids to allow booking retrieval
    listing_ids = Listing.where(user_id: current_user.id).pluck(:id)
    # Eager load listing and user to allow for title and name in view
    @lister_bookings = Booking.where(listing_id: listing_ids).includes(:listing, :user).order(start_date: :asc)
  end

  def new
    # Generate array of unavailable days to use with displaying calendar
    @unavailable_days = UnavailableDay.where(listing_id: @listing.id).pluck(:day)
    # Generate booking summary if date's are submitted
    if params[:booking]
      @booking = Booking.new(
        start_date: @start_date,
        end_date: @end_date,
        total_cost: @amount
      )
    else
      # Used to fix bug with view remembering last searched dates
      params[:booking] = Hash.new
    end
  end

  def create
    begin
      # Create customer if neeeded
      if current_user.stripe_cust_id.nil?
        customer = Stripe::Customer.create(
          :email => params[:stripeEmail],
        )
        # Save stripe customer id
        current_user.stripe_cust_id = customer.id
        current_user.save
      end
      # Update source
      customer = Stripe::Customer.retrieve(current_user.stripe_cust_id)
      customer.source = params[:stripeToken]
      customer.save

      # Create stripe charge for given date range
      charge = Stripe::Charge.create(
        :customer    => current_user.stripe_cust_id,
        :amount      => @amount,
        :description => "Booking for listing id: #{@listing.id}, for #{@num_days} days: #{@start_date} to #{@end_date}",
        :currency    => 'aud'
      )
      # Create Booking
      @booking = Booking.new(booking_params)
      @booking.user_id = current_user.id
      @booking.listing_id = @listing.id
      @booking.booking_date = Date.today
      @booking.stripe_charge_id = charge.id
      # Check if successfully saves to database
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
      # Check if charge needs refunding on stripe
      if @booking.stripe_charge_id == 'fake'
        @booking.destroy
        redirect_to bookings_path, notice: "Fake booking destroyed"
      else
        refund = Stripe::Refund.create(
          charge: @booking.stripe_charge_id
        )
        # Check if refund succeeded and record was destroyed in database
        if @booking.destroy && refund
          redirect_to bookings_path, notice: "Booking succesfully destroyed and refunded: $#{refund.amount / 100}.00"
        elsif refund
          redirect_to bookings_path, alert: "Booking refunded but failed to be destroyed"
        else
          redirect_to bookings_path, alert: "Booking refund and destroy both failed"
        end
      end
    rescue Stripe::StripeError => e
      redirect_to bookings_path, alert: e.message
    end
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  # Used to save listing details with booking
  def set_listing
    @listing = Listing.find(params[:listing_id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :total_cost)
  end

  # Check if current user is allowed to perform action
  def check_permission
    begin
      unless @booking.user_id == current_user.id || current_user.id == @booking.listing.user_id
        raise BookingError, "Error: Permission denied - Invalid User"
      end
      if @booking.user_id == current_user.id && @booking.start_date <= Time.now.to_date
        raise BookingError, "Error: Permission denied - Cancelling past booking not allowed"
      end
    rescue BookingError => e
      redirect_to bookings_path(@listing), alert: e.message
      return
    end
  end

  # Checks for input errors when making new booking
  def check_for_errors
    if params[:booking]
      begin
        @start_date = params[:booking][:start_date].to_date
        # Don't allow dates in the past
        if @start_date < Time.now.to_date
          raise BookingError, "Error: Start date can't be in the past"
        end
        @end_date = params[:booking][:end_date].to_date
        # Don't allow start date to be after end date
        if @end_date < @start_date
          raise BookingError, "Error: Start date needs to be before end date"
        end
        # Check if dates are available
        date_arr = (@start_date..@end_date).to_a
        unavail_days = UnavailableDay.where(listing_id: @listing.id, day: date_arr)
        unless unavail_days.empty?
          raise BookingError, "Error: Dates not available"
        end
        # Calculate booking cost
        @num_days = date_arr.count
        if @num_days < 7
          # Daily rate
          @amount = @num_days * @listing.daily_price
        else
          # Weekly rate if renting 1 week or more
          @amount = (@num_days * (@listing.weekly_price / 7.0)).to_i
        end
        # Check for dodgy form manipulation
        if params[:booking][:total_cost] && @amount != params[:booking][:total_cost].to_i
          raise BookingError, "Error: Amount Incorrect - Payment Stopped"
        end
      # Catches custom errors above and invalid dates
      rescue BookingError, ArgumentError => e
        redirect_to new_listing_booking_path(@listing), alert: e.message
        return
      end
    end
  end
end
