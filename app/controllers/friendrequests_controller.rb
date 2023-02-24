class FriendrequestsController < ApplicationController
    skip_before_action :authorize

    def index
        friend = Friendrequest.all
        render json: friend
    end

    #sending a friend request
    def create
        receiver = User.find_by(username: params[:username])
        if receiver.nil?
          render json: { error: "User not found" }, status: :unprocessable_entity
          return
        end
      
        if params[:requestor_id] == receiver.id
          render json: { error: "You Cannot Request Yourself" }, status: :unprocessable_entity
          return
        end
      
        friend_request_exists = Friendrequest.exists?(requestor_id: params[:requestor_id], receiver_id: receiver.id)
        if friend_request_exists
          render json: { error: "Friend request already sent" }, status: :unprocessable_entity
          return
        end
      
        friend_request = Friendrequest.new(friend_params)
        friend_request.receiver_id = receiver.id
        if friend_request.save
          render json: friend_request, status: :created
        else
          render json: { error: "Error creating friend request" }, status: :unprocessable_entity
        end
    end

    #accepting a friend request
    def update
        friend_request = Friendrequest.find_by(id: params[:id])
        friend_request.update(friends?: true)

        render json: friend_request, status: :ok
    end

    #declining a request
    # def decline
    #     friend_request = Friendrequest.find_by(id: params[:id])
    #     friend_request.destroy

    #     head :no_content
    # end

    def remove
        friend_request = Friendrequest.find_by(id: params[:id])
        friend_request.destroy

        head :no_content
    end

    private 

    def friend_params
        params.permit(:requestor_id, :receiver_id, :friends?)
    end
    
end
