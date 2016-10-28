class StatementsController < ApplicationController
  before_action :authenticate_admin!,
                only: [:new, :create, :edit, :update, :destroy]

  before_action :set_event

  before_action :set_statement,
                only: [:show, :edit, :update, :destroy]

  before_action :set_statements,
                only: [:index]

  # GET /statements
  # GET /statements.json
  def index
    respond_to do |format|
      format.html { render nothing: true }
      format.json { render json: @statements }
    end
  end

  # GET /statements/1.json
  def show
    respond_to do |format|
      format.html { render nothing: true }
      format.json { render json: @statement }
    end
  end

  # POST /statements
  # POST /statements.json
  def create
    @statement = Statement.new(statement_params)

    if @statement.save
      redirect_to edit_event_path(@event), notice: t('actions.save.success')
    else
      set_embeded_models
      flash.now[:error] = t('actions.save.error')
      render 'events/edit'
    end
  end

  # PATCH/PUT /statements/1
  # PATCH/PUT /statements/1.json
  def update
    respond_to do |format|
      if @statement.update(statement_params)
        format.html { redirect_to edit_event_path(@event), notice: t('actions.save.success') }
        format.json { render :show, status: :ok, location: @statement }
      else
        format.html do
          set_embeded_models
          flash.now[:error] = t('actions.save.error')
          render 'events/edit'
        end
        format.json { render json: @statement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /statements/1
  # DELETE /statements/1.json
  def destroy
    @statement.destroy
    respond_to do |format|
      format.html { redirect_to edit_event_path(@event), notice: t('actions.destroy.success') }
      format.json { head :no_content }
    end
  end

  private

  def set_embeded_models
    @picture = Picture.new
    @quote = Statement.new
    @moment = Statement.new
    if params[:statement][:statement_type] == 'quote'
      @quote = @statement
    else
      @moment = @statement
    end
  end

  def set_event
    @event = Event.find(params[:event_id]) if params[:event_id]
  end

  def set_statements
    @statements = Statement.where(event: @event) if @event
    @statements ||= Statement.all
  end

  def set_statement
    @statement = Statement.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def statement_params
    tmp_params = params.require(:statement).permit(
      :question,
      :content,
      :author
    )
    tmp_params[:event] = @event
    tmp_params
  end
end
