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

  # POST /ideas
  def create
    @idea = Event.new(idea_params)
    if @idea.save
      redirect_to ideas_path, notice: t('actions.save.success')
    else
      flash.now[:error] = t('actions.save.error')
      render :new
    end
  end

  # PATCH/PUT /ideas/1
  # PATCH/PUT /ideas/1.json
  def update
    respond_to do |format|
      if @idea.update(idea_params)
        format.html { redirect_to @idea, notice: t('actions.save.success') }
        format.json { render :show, status: :ok, location: @idea }
      else
        format.html do
          flash.now[:error] = t('actions.save.error')
          render :edit
        end
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ideas/1
  # DELETE /ideas/1.json
  def destroy
    @idea.destroy
    respond_to do |format|
      format.html { redirect_to ideas_url, notice: t('actions.destroy.success') }
      format.json { head :no_content }
    end
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
