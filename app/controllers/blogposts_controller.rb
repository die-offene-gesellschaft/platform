class BlogpostsController < ApplicationController
  before_action :authenticate_admin!,
                only: [:new, :create, :edit, :update, :destroy]

  before_action :set_blogpost,
                only: [:show, :edit, :update, :destroy]

  # GET /blogposts
  # GET /blogposts.json
  def index
    @blogposts = Blogpost.all
    respond_to do |format|
      format.html do
        @blogposts = @blogposts.to_a
        @hero_blogpost = @blogposts.shift
        render :index
      end
      format.json { render json: @blogposts }
    end
  end

  # GET /blogposts/1
  # GET /blogposts/1.json
  def show
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @blogpost }
    end
  end

  # GET /blogposts/new
  def new
    @blogpost = Blogpost.new
  end

  # GET /blogposts/1/edit
  def edit
  end

  # POST /blogposts
  # POST /blogposts.json
  def create
    @blogpost = Blogpost.new(blogpost_params)

    respond_to do |format|
      if @blogpost.save
        format.html { redirect_to @blogpost, notice: 'Blogpost was successfully created.' }
        format.json { render :show, status: :created, location: @blogpost }
      else
        format.html { render :new }
        format.json { render json: @blogpost.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogposts/1
  # PATCH/PUT /blogposts/1.json
  def update
    respond_to do |format|
      if @blogpost.update(blogpost_params)
        format.html { redirect_to @blogpost, notice: 'Blogpost was successfully updated.' }
        format.json { render :show, status: :ok, location: @blogpost }
      else
        format.html { render :edit }
        format.json { render json: @blogpost.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogposts/1
  # DELETE /blogposts/1.json
  def destroy
    @blogpost.destroy
    respond_to do |format|
      format.html { redirect_to blogposts_url, notice: 'Blogpost was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_blogpost
    @blogpost = Blogpost.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def blogpost_params
    params.require(:blogpost).permit(:title, :blogpost_type, :introduction, :content)
    blogpost_params[:admin] = current_admin
    blogpost_params
  end
end
