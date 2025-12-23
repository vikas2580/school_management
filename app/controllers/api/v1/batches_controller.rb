class Api::V1::BatchesController < ApplicationController
  def create
    require_school_admin!

    batch = Batch.new(batch_params)
    if batch.save
      render json: batch, status: :created
    else
      render json: { errors: batch.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def batch_params
    params.require(:batch).permit(:name, :course_id)
  end
end
