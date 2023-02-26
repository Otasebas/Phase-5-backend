class UsersController < ApplicationController
    skip_before_action :authorize, except: :me

    def index
        user = User.all
        render json: user
    end

    def member
        user = current_user
        member_groups = user.members.includes(:friend_group).map(&:friend_group)
        render json: member_groups
      end

    def show
        user = User.find_by(id: params[:id])
        render json: user
    end

    def create
        user = User.create(user_params)
        if user.valid?
            session[:user_id] = user.id
            render json: user, status: :created
        else
            render json: {error: user.errors.full_messages}, status: :unprocessable_entity
        end
    end
    
    def me
        render json: @current_user, status: :ok
    end

    private 

    def user_params
        params.permit(:username, :password, :phone_number, :email, :nickname, :password_confirmation)
    end
end
