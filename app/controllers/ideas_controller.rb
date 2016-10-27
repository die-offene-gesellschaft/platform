class IdeasController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_idea, only: [:edit, :update, :destroy]

  # GET /ideas
  # GET /ideas.json
  def index
    @ideas = Idea.all
  end

  # GET /ideas/1/edit
  def edit
  end

  # POST /ideas.json
  def create
    @idea = Event.new(idea_params)
    if @idea.save
      render :nothing, status: :ok
    else
      render status: :unprocessable_entity, json: @idea.errors
    end
  end

  # PATCH/PUT /ideas/1
  def update
    if @idea.update(idea_params)
      redirect_to @idea, notice: t('actions.save.success')
    else
      flash.now[:error] = t('actions.save.error')
      render :edit
    end
  end

  # DELETE /ideas/1
  def destroy
    @idea.destroy
    redirect_to ideas_url, notice: t('actions.destroy.success')
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_idea
    @idea = Idea.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def idea_params
    params.require(:idea).permit(
      :subject,
      :time,
      :location,
      :contact_person,
      :organisation,
      :email,
      :phone
    )
  end
end
