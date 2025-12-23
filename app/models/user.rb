class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: {
    admin: 0,
    school_admin: 1,
    student: 2
  }

  after_initialize :set_default_role, if: :new_record?
  belongs_to :school  

  private

  def set_default_role
    self.role ||= 'student'
  end
end
