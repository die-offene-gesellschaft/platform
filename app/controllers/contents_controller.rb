class ContentsController < ApplicationController
  # GET /contents
  # GET /contents.json
  def index
    @contents = Content.all
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @contents }
    end
  end

  # GET /contents/1.json
  def show
    @content = Content.find(params[:id])
    respond_to do |format|
      format.html { render nothing: true }
      format.json { render json: @content }
    end
  end
end
