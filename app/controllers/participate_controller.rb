class ParticipateController < ApplicationController
  before_action :set_users, only: [:show]

  # GET /participate
  def show
  end

  private

  def set_users
    @users = User.all.sample(12)
  end
end
