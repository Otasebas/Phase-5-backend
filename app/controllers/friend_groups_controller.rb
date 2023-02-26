class FriendGroupsController < ApplicationController

    def owner
        groups = FriendGroup.where(user: current_user)
        render json: groups
    end

    def create
        group = FriendGroup.create(group_params)
        if group.valid?
          Member.create(user: current_user, friend_group: group, joined: true)
          invites = params[:invites]
          invite_errors = []
          invites.each do |invite|
            member = Member.new(user_id: invite[:id], friend_group: group, joined: false)
            unless member.valid?
              invite_errors << member.errors.full_messages
            end
          end
          if invite_errors.empty?
            invites.each do |invite|
              Member.create!(user_id: invite[:id], friend_group: group, joined: false)
            end
            render json: group, status: :created
          else
            render json: { error: invite_errors.flatten }, status: :unprocessable_entity
          end
        else
          render json: { error: group.errors.full_messages }, status: :unprocessable_entity
        end
      end

    def group_params
        params.permit(:user_id, :group_name)
    end

end
