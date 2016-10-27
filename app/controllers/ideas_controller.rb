class IdeasController < ApplicationController
  before_action :authenticate_admin!, except: [:create]
  before_action :set_idea, only: [:show, :destroy]

  # GET /ideas
  # GET /ideas.json
  def index
    @ideas = Idea.all
  end

  # GET /ideas/1
  # GET /ideas/1.json
  def show
  end

  # POST /ideas.json
  def create
    @idea = Idea.new(idea_params)
    if @idea.save
      render json: { status: 'idea saved' },
             status: :ok
    else
      render json: @idea.errors,
             status: :unprocessable_entity
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
