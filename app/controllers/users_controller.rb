      class UsersController < ApplicationController
      before_action :user_data , only: [:show,:update,:destroy,:edit]
  def index
     @users = User.all
     @current_user = User.find_by_id(session[:current_user_id])
    
  end
  def show
    
  end
  def new
      @user=User.new
  end
  def create
       @user = User.new(user_params)
      # @user = User.new
     if @user.save
      redirect_to users_path
     else render "new"
     end

  end
  def edit
  end
  def update
      if @user.update(user_params)
            redirect_to users_path
      else render "edit"
      end
  end
  def destroy
       
       @user.destroy
       redirect_to users_path
  end
  def user_params
      
    params.require(:user).permit(:first_name, :email, :password,:last_name, :room_id, :admin,:image,:ext)
  end
 def user_data
      @user = User.find(params[:id])
      
    
 end
     
 end