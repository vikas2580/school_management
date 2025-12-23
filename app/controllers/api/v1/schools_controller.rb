module Api
  module V1
    class SchoolsController < ApplicationController
      before_action :set_school, only: [:update]

      def create
        require_admin!

        school = School.new(school_params.merge(created_by: current_user))
        if school.save
          render json: school, status: :created
        else
          render json: { errors: school.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        require_school_admin!
        return forbidden! unless current_user.school_id == @school.id

        if @school.update(school_params)
          render json: @school
        else
          render json: { errors: @school.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def set_school
        @school = School.find(params[:id])
      end

      def school_params
        params.require(:school).permit(:name, :description)
      end
    end
  end
end
