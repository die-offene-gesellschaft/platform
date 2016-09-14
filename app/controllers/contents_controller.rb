class ContentsController < ApplicationController
  before_action :set_content, only: [:show]

  # GET /contents.json
  def index
    @contents = Content.all
    respond_to do |format|
      format.html { render :nothing }
      format.json { render json: @contents }
    end
  end

  # GET /contents/1.json
  def show
    respond_to do |format|
      format.html { render :nothing }
      format.json { render json: @content }
    end
  end

  private

  def set_content
    @content = Content.find(params[:id])
  end
end
