class VenuesController < ApplicationController
  before_action :authenticate_admin!, only: [:edit, :update, :create, :new, :destroy]
  before_action :set_venues, only: [:index, :update]
  before_action :set_venue, only: [:show, :edit, :update, :destroy]

  # GET /venues
  # GET /venues.json
  def index
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @venues }
    end
  end

  # GET /venues/1
  # GET /venues/1.json
  def show
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @venue }
    end
  end

  # GET /venues/new
  def new
    @venue = Venue.new
  end

  # GET /venues/1/edit
  def edit
  end

  # POST /venues
  # POST /venues.json
  def create
    @venue = Venue.new(venue_params)

    respond_to do |format|
      if @venue.save
        format.html { redirect_to venues_path, notice: t('actions.save.success') }
        format.json { render :show, status: :created, location: @venue }
      else
        format.html do
          flash.now[:error] = t('actions.save.error')
          render :new
        end
        format.json { render json: @venue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /venues/1
  # PATCH/PUT /venues/1.json
  def update
    respond_to do |format|
      if @venue.update(venue_params)
        format.html { redirect_to venues_path, notice: t('actions.save.success') }
        format.json { render :show, status: :ok, location: @venue }
      else
        format.html do
          flash.now[:error] = t('actions.save.error')
          render :edit
        end
        format.json { render json: @venue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /venues/1
  # DELETE /venues/1.json
  def destroy
    @venue.destroy
    respond_to do |format|
      format.html { redirect_to venues_url, notice: t('actions.destroy.success') }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_venue
    @venue = Venue.find(params[:id])
  end

  def set_venues
    @venues = Venue.all
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def venue_params
    params.require(:venue).permit(:name, :street, :zip_code, :city, :description, :locked)
  end
end
