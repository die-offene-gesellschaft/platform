class ActiveMembersController < ApplicationController
  before_action :set_active_member, only: [:show, :update, :destroy]

  # GET /active_members.json
  def index
    @active_members = ActiveMember.all
    respond_to do |format|
      format.html { render nothing: true }
      format.json { render json: @active_members.to_json }
    end
  end

  # GET /active_members/1.json
  def show
    respond_to do |format|
      format.html { render nothing: true }
      format.json { render json: @active_members.to_json }
    end
  end

  # POST /active_members
  # POST /active_members.json
  def create
    @active_member = ActiveMember.new(active_member_params)

    respond_to do |format|
      if @active_member.save
        format.html { redirect_to @active_member, notice: 'Member was successfully created.' }
        format.json { render :show, status: :created, location: @active_member }
      else
        format.html { render :new }
        format.json { render json: @active_member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /active_members/1
  # PATCH/PUT /active_members/1.json
  def update
    respond_to do |format|
      if @active_member.update(active_member_params)
        format.html { redirect_to @active_member, notice: 'Member was successfully updated.' }
        format.json { render :show, status: :ok, location: @active_member }
      else
        format.html { render :edit }
        format.json { render json: @active_member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /active_members/1
  # DELETE /active_members/1.json
  def destroy
    @active_member.destroy
    respond_to do |format|
      format.html do
        redirect_to active_members_url, notice: 'Active member was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_active_member
    @active_member = ActiveMember.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def active_member_params
    params.require(:active_member).permit(:forename, :surname, :role)
  end
end
