class BlogpostsController < ApplicationController
  before_action :authenticate_admin!,
                only: [:new, :create, :edit, :update, :destroy]

  before_action :set_blogpost,
                only: [:show, :edit, :update, :destroy]

  # GET /blogposts
  # GET /blogposts.json
  def index
    @blogposts = Blogpost.where(published: true)
                         .where('date <= ?', Time.zone.now)
                         .order(date: :desc)
    @blogposts = Blogpost.all
                         .order(date: :desc) if admin_signed_in?

    respond_to do |format|
      format.html { render :index }
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
  def create
    @blogpost = Blogpost.new(blogpost_params)
    if @blogpost.save
      redirect_to blogposts_path, notice: t('actions.save.success')
    else
      flash.now[:error] = t('actions.save.error')
      render :new
    end
  end

  # PATCH/PUT /blogposts/1
  def update
    if @blogpost.update(blogpost_params)
      redirect_to blogposts_path, notice: t('actions.save.success')
    else
      flash.now[:error] = t('actions.save.error')
      render :edit
    end
  end

  # DELETE /blogposts/1
  # DELETE /blogposts/1.json
  def destroy
    @blogpost.destroy
    redirect_to blogposts_url, notice: t('actions.destroy.success')
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_blogpost
    @blogpost = Blogpost.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def blogpost_params
    tmp_params = params.require(:blogpost).permit(
      :title,
      :author,
      :blogpost_type,
      :introduction,
      :content,
      :hero,
      :thumbnail,
      :reference,
      :date,
      :published
    )
    tmp_params
  end
end
