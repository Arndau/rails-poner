class UsersController < ApplicationController
  # before_action :set_user, only: [:show, :edit, :update, :destroy, :create]

  # def show
  #   authorize @user
  # end

  # def edit
  #   authorize @user
  # end

  # def create
  #   @user = User.new(user_params)
  #   @politic.user = current_user
  #   authorize @user

  #   if @user.save
  #     redirect_to messages_path(@user)
  #   else
  #     render :new
  #   end
  # end

  # def destroy
  #   @user.destroy
  # end

  # private

  # def set_user
  #   @users = User.find(params[:id])
  #   authorize @user
  # end

  # def user_params
  #   params.require(:user).permit(:first_name, :lastname, :email)
  # end
end
