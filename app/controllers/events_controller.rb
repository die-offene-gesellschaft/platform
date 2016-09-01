class EventsController < ApplicationController
  before_action :set_event,
                only: [:show, :edit, :update, :destroy]
  before_action :set_user,
                only: [:create]

  # GET /events
  # GET /events.json
  def index
    archive = request.query_parameters.keys.include?('archive')
    if archive
      where_statement = 'end_at < ?'
      group_statement = :beginning_of_year
      order_statement = { begin_at: :desc }
    else
      where_statement = 'end_at >= ?'
      group_statement = :beginning_of_month
      order_statement = { begin_at: :asc }
    end
    @events = Event
                .all
                .where(where_statement, Time.zone.now)
                .order(order_statement)
                .group_by { |event| event.begin_at.send(group_statement) }
  end

  # GET /events/1
  # GET /events/1.json
  def show
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

    if @event.save
      redirect_to @event, notice: 'Event was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
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
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
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
      :facebook_identifier,
      :locked
    )
  end
end
