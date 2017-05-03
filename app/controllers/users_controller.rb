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
      @user = User.new(params[:user].permit(:name, :email, :password))
 
     if @user.save
      redirect_to @user
     else render "new"
     end

  end
  def edit
  end
  def update
      if @user.update(user_params)
            redirect_to @user
      else render "edit"
      end
  end
  def destroy
       
       @user.destroy
       redirect_to users_path
  end
  def user_params
      
    params.require(:user).permit(:name, :email, :password)
  end
 def user_data
      @user = User.find(params[:id])
      
    
 end
     
 end