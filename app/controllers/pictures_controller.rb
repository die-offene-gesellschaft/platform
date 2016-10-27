class PicturesController < ApplicationController
  before_action :authenticate_admin!,
                only: [:destroy]
  before_action :set_event
  before_action :set_picture,
                only: [:show, :edit, :update, :destroy]

  # GET /events/1/pictures.json
  def index
    @pictures = Picture.all
    respond_to do |format|
      format.html { render nothing: true }
      format.json { render json: @pictures }
    end
  end

  # GET /events/1/pictures/1.json
  def show
    respond_to do |format|
      format.html { render nothing: true }
      format.json { render json: @picture }
    end
  end

  # POST /events/1/pictures
  def create
    @picture = Picture.new(picture_params)
    @picture.event = @event
    if @picture.save
      redirect_to edit_event_path(@event), notice: t('actions.save.success')
    else
      set_embeded_models
      flash.now[:error] = t('actions.save.error')
      render 'events/edit'
    end
  end

  # DELETE /events/1/pictures/1
  def destroy
    @picture.destroy
    redirect_to edit_event_path(@event), notice: t('actions.destroy.success')
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_picture
    @picture = Picture.find(params[:id])
  end

  def set_embeded_models
    @quote = Statement.new
    @moment = Statement.new
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def picture_params
    params.require(:picture).permit(:picture, :description, :locked)
  end
end
