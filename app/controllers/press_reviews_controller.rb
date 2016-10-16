class PressReviewsController < ApplicationController
  before_action :authenticate_admin!,
                only: [:new, :create, :edit, :update, :destroy]

  before_action :set_press_review,
                only: [:show, :edit, :update, :destroy]

  # GET /press_reviews
  # GET /press_reviews.json
  def index
    @press_reviews = PressReview.all
    respond_to do |format|
      format.html do
        authenticate_admin!
        render :index
      end
      format.json { render json: @press_reviews }
    end
  end

  # GET /press_reviews/1.json
  def show
    respond_to do |format|
      format.html { render nothing: true }
      format.json { render json: @press_review }
    end
  end

  # GET /press_reviews/new
  def new
    @press_review = PressReview.new
  end

  # GET /press_reviews/1/edit
  def edit
  end

  # POST /press_reviews
  # POST /press_reviews.json
  def create
    @press_review = PressReview.new(press_review_params)

    if @press_review.save
      redirect_to press_reviews_path, notice: t('actions.save.success')
    else
      flash.now[:error] = t('actions.save.error')
      render :new
    end
  end

  # PATCH/PUT /press_reviews/1
  # PATCH/PUT /press_reviews/1.json
  def update
    respond_to do |format|
      if @press_review.update(press_review_params)
        format.html { redirect_to press_reviews_path, notice: t('actions.save.success') }
        format.json { render :show, status: :ok, location: @press_review }
      else
        format.html do
          flash.now[:error] = t('actions.save.error')
          render :edit
        end
        format.json { render json: @press_review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /press_reviews/1
  # DELETE /press_reviews/1.json
  def destroy
    @press_review.destroy
    respond_to do |format|
      format.html { redirect_to press_reviews_path, notice: t('actions.destroy.success') }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_press_review
    @press_review = PressReview.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def press_review_params
    params.require(:press_review).permit(
      :source_url,
      :source_title,
      :title,
      :description,
      :link
    )
  end
end
