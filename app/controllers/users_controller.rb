class UsersController < ApplicationController
  before_action :set_user, only: [ :show, :update, :destroy ]
  def index
    # binding.pry
    @users = User.all

    render json: @users
  end

  def show
    # binding.pry
    # @user = User.find(params[:id])
  end

  def create
    # @user = User.new(
    #   name: params[:name],
    #   account: params[:account],
    #   email: params[:email],
    # )
    # binding.pry
    @user = User.new(user_params)

    @user.save!

    render :show
  end

  def update
    #userを探す
    # @user = User.find(params[:id])
    #レコードに対して変更を加える
    @user.update!(user_params)
    #jsonとして値を返す
    render :show

  end

  def destroy
    # @user = User.find(params[:id])
    @user.destroy!
    render :show
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    # binding.pry
    params.require(:user).permit(:name, :account, :email)
  end
end
