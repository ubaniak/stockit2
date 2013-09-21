class UsersController < ApplicationController
    def create
        @user = User.new(user_params)
        if @user.validate?
            @user.save
            redirect_to manage_users_path, notice: "User successfully created"
        else
            redirect_to manage_users_path, notice: "Could not create user."
        end
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        redirect_to manage_users_path
    end


    private
    def user_params
      params.require(:user).permit(:email, :password, :can_sell, :can_manage, :can_report)
    end
end
