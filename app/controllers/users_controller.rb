class UsersController < ApplicationController
	before_action :authenticate_user!
    before_action :correct_user, only:[:edit]

  def index
  	@users = User.all
  	@book = Book.new
  	@user = current_user
  end

  def show
  	@user = User.find(params[:id])
  	@book = Book.new
  	@books = @user.books
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
  	flash[:notice] = 'You have updated user successfully.'
  	redirect_to user_path(@user.id)
  else
  	flash[:notice] = 'updated error'
  	render "edit"
    end
   end
end

private
  def user_params
  	params.require(:user).permit(:name, :profile_image, :introduction)
  end

def correct_user
	@user = User.find(params[:id])
	if @user != current_user
		redirect_to user_path(current_user)
	end
end
