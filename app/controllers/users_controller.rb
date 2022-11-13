class UsersController < ApplicationController
  def index
    binding.pry
    @users = User.all

    render json: @users
  end

  def show
    # binding.pry
    @user = User.find(params[:id])
  end
end
