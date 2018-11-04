class ReviewsController < ApplicationController
  before_action :set_review, only: [:edit, :update, :destroy]

  # GET /review/new
  def new
    @review = Review.new
  end

  # GET /review/edit
  def edit
  end

  # POST /review
  def create
    @review = Review.new(review_params)
    @review.booking_id = params[:booking_id]
    if @review.save
      redirect_to bookings_path, notice: 'Review was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /review
  def update
    if @review.update(review_params)
      redirect_to bookings_path, notice: 'Review was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /review
  def destroy
    @review.destroy
    redirect_to bookings_path, notice: 'Review was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find_by(booking_id: params[:booking_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:rating, :content, :booking_id)
    end
end
