class UsersController < ApplicationController
  def index
  	@users = User.all
  end

  def new
  end

  def create
  	@user = User.new(user_params)
		if @user.valid?
			@user.save
			flash[:success] = "You are saved in the system"
      redirect_to '/users'
		else
      flash[:errors] = @user.errors.full_messages
      puts @user.errors.full_messages
			redirect_to '/users/new'
		end  
  end

  def show
    @user = User.find(params[:id])
  end

  #renders edit page
  def edit
    @user = User.find(params[:id])
  end

  def update
    puts params
    @user = User.update(User.find(params[:id]),user_params)
    
    puts @user 
    if @user.valid?

      flash[:success] = "Updated successfully in the system"
      redirect_to '/users'
    else
      flash[:errors] = @user.errors.full_messages
      puts @user.errors.full_messages
      redirect_to "/users/#{params[:id]}/edit"
    end
  end

  def destroy
    User.destroy(params[:id])
    redirect_to '/users'
  end

  private
  def user_params
    params.require(:user).permit(:first_name,:last_name,:email_address,:password)
  end

end
