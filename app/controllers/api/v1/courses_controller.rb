class Api::V1::CoursesController < ApplicationController
   before_action :require_school_admin!

  def create
    course = current_user.school.courses.new(course_params)

    if course.save
      render json: course, status: :created
    else
      render json: { errors: course.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def course_params
    params.require(:course).permit(:name)
  end
end
