class UsersController < ApplicationController

    skip_before_action :authenticate_request, only: [:create]

    def create
        user = User.new(user_params)
    
        if user.save
            render json: {
                status: "success",
                message: "User created successfully",
                payload: { user_id: user.id }
            }, status: :created
        else
            render json: {
                status: "error",
                message: "User could not be created",
                payload: { errors: user.errors.full_messages }
            }, status: :unprocessable_entity
        end
    end

    private
    def user_params
        params.permit(:user_type, :email, :first_name, :last_name)
    end
end
