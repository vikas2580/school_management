module Api
  module V1
    class StudentBatchesController < ApplicationController
      def index
        batch = Batch.find(params[:batch_id])
        authorize batch, :view_classmates?

        classmates = batch.students.where.not(id: current_user.id)
        render json: UserSerializer.new(classmates).serializable_hash
      end
    end
  end
end