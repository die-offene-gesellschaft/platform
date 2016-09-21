class ParticipateController < ApplicationController
  before_action :set_users, only: [:show]

  # GET /participate
  def show
  end

  # POST /participate
  def create
    render nothing: true
  end

  private

  def set_users
    @users = User.all.sample(12)
  end
end
