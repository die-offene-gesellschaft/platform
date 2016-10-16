class EventsController < ApplicationController
  before_action :authenticate_admin!, only: [:edit, :update, :create, :new, :destroy]
  before_action :set_events,
                only: [:index]
  before_action :set_event,
                only: [:show, :edit, :update, :destroy]
  before_action :set_user,
                only: [:create]

  # GET /events
  # GET /events.json
  def index
    respond_to do |format|
      format.html do
        authenticate_admin! if request.query_parameters.keys & %w(appointments archive) == []
        render :index
      end
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @event }
    end
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    @event.user = @user
    respond_to do |format|
      if @event.save
        format.html { redirect_to events_path, notice: t('actions.save.success') }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html do
          flash.now[:error] = t('actions.save.error')
          render :new
        end
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to events_path, notice: t('actions.save.success') }
        format.json { render :show, status: :ok, location: @event }
      else
        flash.now[:error] = t('actions.save.error')
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_path, notice: t('actions.destroy.success') }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_events
    if request.query_parameters.keys.include?('appointments')
      set_appointment_events
    elsif request.query_parameters.keys.include?('archive')
      set_archive_events
    else
      @events = Event.all
    end
  end

  def set_appointment_events
    @events = Event.where('end_at >= ?', Time.zone.now)
                   .where(planned: false)
                   .order(begin_at: :asc)
                   .group_by { |event| event.begin_at.send(:beginning_of_month) }
    @planned_events = Event.where(planned: true)
                           .order(:title)
  end

  def set_archive_events
    @events = Event.where.not(begin_at: nil)
                   .where('end_at < ?', Time.zone.now)
                   .order(begin_at: :desc)
                   .group_by { |event| event.begin_at.send(:beginning_of_year) }
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def set_user
    @user = current_user
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(
      :title,
      :event_type,
      :begin_at,
      :end_at,
      :active_members,
      :description,
      :venue_id,
      :link,
      :facebook_identifier,
      :locked,
      :planned,
      :post_description,
      :post_description_source
    )
  end
end
