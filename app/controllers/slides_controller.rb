class SlidesController < ApplicationController

  before_action :authenticate_admin!, only: [:edit, :update, :create, :new, :destroy]
  before_action :set_slide,
                only: [:show, :edit, :update, :destroy]
  def set_slide
    @slide = Slide.find(params[:id])
  end

  # GET /slides
  # GET /slides.json
  def index
    @slides = Slide.all
  end


  # GET /slides/new
  def new
    @slide = Slide.new
  end
  # GET /slides/1
  def show
  end

  def update
    if @slide.update(slide_params)
      redirect_to slides_path, notice: t('actions.save.success')
    else
      flash.now[:error] = t('actions.save.error')
      render :edit
    end
  end

  # POST /slides
  # POST /slides.json
  def create
    @slide = Slide.new(slide_params)
    respond_to do |format|
      if @slide.save
        format.html { redirect_to slides_path, notice: t('actions.save.success') }
        format.json { render :show, status: :ok, location: @slide }
      else
        format.html do
          flash.now[:error] = t('actions.save.error')
          render :new
        end
        format.json { render json: @slide.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /slides/1/edit
  def edit
  end

  # DELETE /slides/1
  # DELETE /slides/1.json
  def destroy
    @slide.destroy
    respond_to do |format|
      format.html { redirect_to slides_path, notice: t('actions.destroy.success') }
      format.json { head :no_content }
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def slide_params
    params.require(:slide).permit(
      :link, :text1, :text2, :picture, :slide_mode
    )
  end
end
