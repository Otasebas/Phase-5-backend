class PersonalCalendarsController < ApplicationController
    skip_before_action :authorize

    def index
        calendar = PersonalCalendar.where(user: current_user)
        render json: calendar
    end

    def create
        calendar = PersonalCalendar.create(calendar_params)
        if calendar.valid?
            render json: calendar, status: :created
        else
            render json:{errors: calendar.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def destroy
        calendar = PersonalCalendar.find_by(id: params[:id])
        calendar.destroy

        head :no_content
    end

    private

    def calendar_params
        params.permit(:date, :name_of_event, :start_time, :end_time, :description, :user_id)
    end
    
end
