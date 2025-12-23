module Api
  module V1
    class SchoolAdminsController < ApplicationController
      def create
        require_admin!

        user = User.new(school_admin_params)
        user.role = 'school_admin'

        if user.save
          render json: {
            message: 'School Admin created successfully',
            id: user.id,
            email: user.email,
            role: user.role,
            school_id: user.school_id
          }, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def school_admin_params
        params.require(:user).permit(:email, :password, :school_id)
      end
    end
  end
end


# module Api
#   module V1
#     class SchoolAdminsController < ApplicationController
#       before_action :require_admin!

#       def create
#         user = User.new(user_params)
#         user.role = :school_admin

#         if user.save
#           render json: {
#             message: 'School Admin created successfully',
#             id: user.id,
#             email: user.email,
#             school_id: user.school_id
#           }, status: :created
#         else
#           render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
#         end
#       end

#       private

#       def user_params
#         params.require(:user).permit(:email, :password, :school_id)
#       end
#     end
#   end
# end
