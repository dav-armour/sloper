class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]

  # GET /review
  # GET /review
  def show
  end

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
      redirect_to booking_review_path(@review), notice: 'Review was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /review
  def update
    if @review.update(review_params)
      redirect_to @review, notice: 'Review was successfully updated.'
      render :show, status: :ok, location: @review
    else
      render :edit
    end
  end

  # DELETE /review
  def destroy
    @review.destroy
    redirect_to reviews_url, notice: 'Review was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:booking_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:rating, :content, :booking_id)
    end
end
