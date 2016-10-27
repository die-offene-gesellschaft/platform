class OrganizersController < ApplicationController
  before_action :authenticate_admin!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_organizer, only: [:show, :edit, :update, :destroy]
  before_action :set_event

  # GET /organizers
  # GET /events/1/organizers
  # GET /organizers.json
  # GET /events/1/organizers.json
  def index
    @organizers = Organizer.all
    @organizers = @organizers.reject do |organizer|
      !organizer.events.include?(@event)
    end if @event
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @organizers }
    end
  end

  # GET /organizers/1
  # GET /events/1/organizers/1
  # GET /organizers/1.json
  # GET /events/1/organizers/1.json
  def show
    respond_to do |format|
      format.html { render nothing: true }
      format.json { render json: @organizer }
    end
  end

  # GET /organizers/new
  def new
    @organizer = Organizer.new
  end

  # GET /organizers/1/edit
  def edit
  end

  # POST /organizers
  def create
    @organizer = Organizer.new(organizer_params)
    if @organizer.save
      redirect_to organizers_path, notice: t('actions.save.success')
    else
      flash.now[:error] = t('actions.save.error')
      render :new
    end
  end

  # PATCH/PUT /organizers/1
  def update
    if @organizer.update(organizer_params)
      redirect_to organizers_path, notice: t('actions.save.success')
    else
      flash.now[:error] = t('actions.save.error')
      render :edit
    end
  end

  # DELETE /organizers/1
  def destroy
    if @event
      @organizer.events.delete(@event)
      redirect_to edit_event_path(@event), notice: t('actions.destroy.success')
    else
      @organizer.destroy
      redirect_to organizers_url, notice: t('actions.destroy.success')
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_organizer
    @organizer = Organizer.find(params[:id])
  end

  def set_event
    @event = Event.find(params[:event_id]) if params[:event_id]
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def organizer_params
    params.require(:organizer).permit(:name, :url, :logo)
  end
end
