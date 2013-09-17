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


    private
    def user_params
      params.require(:user).permit(:email, :password, :sales, :admin, :reports)
    end
end
