class ContentsController < ApplicationController
  before_action :set_content, only: [:show, :edit, :update]
  before_action :authenticate_admin!, only: [:edit, :update]

  # GET /contents
  # GET /contents.json
  def index
    @contents = Content.all
    respond_to do |format|
      format.html do
        authenticate_admin!
        render :index
      end
      format.json { render json: @contents }
    end
  end

  # GET /contents/1.json
  def show
    respond_to do |format|
      format.html { render nothing: true }
      format.json { render json: @content }
    end
  end

  # GET /contents/1/edit
  def edit
  end

  # PATCH /contents/1
  def update
    @content.value = params[:contents][@content.key]
    @content.save!
    flash[:success] = t('contents.update.success')
    redirect_to contents_path
  end

  private

  def set_content
    @content = Content.find(params[:id])
  end
end
