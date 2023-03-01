class CalendarDatesController < ApplicationController
    skip_before_action :authorize

    def createpersonal
        event = CalendarDate.create(calendar_params)
      
        if event.valid?
          user = EventUser.create(user: current_user, calendar_date: event, creator: true, attendance: "accepted", friend_group: nil, invite_sent: true)
          
          if user.valid?
            render json: event, status: :created
          else
            render json: {errors: user.errors.full_messages}, status: :unprocessable_entity
          end
        else
          render json: {errors: event.errors.full_messages}, status: :unprocessable_entity
        end
    end

    def personal
        calendar_dates = current_user.event_users.select{ |eu| eu.attendance == "accepted" }.map(&:calendar_date)
      
        render json: calendar_dates
    end

    def destroypersonal
        calendar = CalendarDate.find_by(id: params[:id])
      
        if calendar.event_users.where(creator: true).first.user == current_user
          calendar.destroy
          head :no_content
        else
          render json: { error: "not found" }, status: :unprocessable_entity
        end
    end

    def event
        # grab both arrays of invitees

        friends = []
        group_members = []
        friends = params[:invites_friends]
        group_members = params[:invites_groups]
        
        # create the event
        event = CalendarDate.create(date: params[:date], start_time: "08:00", end_time: "16:00")

        # byebug
        
        if event.valid?
          # creator gets created in join table
          user = EventUser.create(user: current_user, calendar_date: event, creator: true, attendance: "accepted", friend_group: nil, invite_sent: true)
        
          # remove friends that match any members
          friends.reject! { |friend| group_members.any? { |member| member[:id] == friend[:id] } }
          
          # remove the current_user from members
          group_members.reject! { |member| member[:id] == current_user[:id] }
        
          # combine both arrays
          combined_invites = friends + group_members
      
          invite_errors = []
        
          # for each invite create a join table instance
          combined_invites.each do |invite|
              user_event = EventUser.create(user_id: invite[:id], calendar_date: event, creator: false, attendance: "pending", friend_group_id: invite[:friend_group_id], invite_sent: false)
              invite_errors << user_event.errors.full_messages unless user_event.valid?
          end
        
          if invite_errors.empty?
            render json: event, status: :created
          else
            render json: { error: invite_errors.flatten }, status: :unprocessable_entity
          end
        else
          render json: { errors: event.errors.full_messages }, status: :unprocessable_entity
        end
    end
      
    def grab
        event = CalendarDate.find_by(id: params[:id])

        if event.event_users.where(creator: true).first.user == current_user              
            render json: event
        end
    end

    def plan
        event = CalendarDate.find_by(id: params[:id])

        if event.event_users.where(creator: true).first.user == current_user              
            event.update(calendar_params)

            render json: event
        end
    end

    def sendinvites

        ##grab eventusers
        event = CalendarDate.find_by(id: params[:id])
        invitees = params[:available]
      
        # byebug

        event.event_users.each do |rsvp|
          invitees.each do |invite|
            if rsvp.user_id == invite[:id]
              rsvp.update(invite_sent: true)
            end
          end
        end
      
        render json: event
    end

    def user_events
        creator_event_users = current_user.event_users.where(creator: true).select{ |eu| eu.attendance == "accepted" }
        attendee_event_users = current_user.event_users.where(creator: false).select{ |eu| eu.attendance == "accepted" }
      
        creator_calendar_dates = creator_event_users.select{ |eu| eu.calendar_date.event_users.where.not(user_id: current_user.id).any? }.map(&:calendar_date)
        attendee_calendar_dates = attendee_event_users.map(&:calendar_date)
      
        response = {
          creator_calendar_dates: creator_calendar_dates,
          attendee_calendar_dates: attendee_calendar_dates
        }
      
        render json: response
    end

    def user_event
        event = CalendarDate.find_by(id: params[:id])

        render json: event
    end

    def accepteventinvite
        event = CalendarDate.find_by(id: params[:id])

        invite = event.event_users.where(user: current_user).first

        invite.update(attendance: "accepted")

        render json: invite
    end

    def declineeventinvite
        event = CalendarDate.find_by(id: params[:id])

        invite = event.event_users.where(user: current_user).first

        invite.update(attendance: "declined")

        render json: invite
    end
      
    private

    def calendar_params
        params.permit(:date, :name_of_event, :start_time, :end_time, :description)
    end

end