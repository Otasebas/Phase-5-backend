class MembersController < ApplicationController
    skip_before_action :authorize

    def leave
        member = Member.find_by(id: params[:id])
        member.destroy

        head :no_content
    end

    def acceptinvite
        invite = Member.find_by(id: params[:id])
        invite.update(joined: true)

        render json: invite, status: :ok
    end

    def index
        render json: Member.all
    end

    def declineinvite
        member = Member.find_by(id: params[:id])
        member.destroy

        head :no_content
    end

    def invite
        invite = Member.create(member_params)
    
        if invite.valid?
          render json: invite, status: :created
        else
          render json: { error: invite.errors.full_messages }, status: :unprocessable_entity
        end
      end

    private

    def member_params
        params.permit(:user_id, :friend_group_id, :joined)
    end

end
