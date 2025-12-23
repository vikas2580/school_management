class School < ApplicationRecord
  belongs_to :created_by, class_name: 'User'
  has_many :courses
  has_many :users

  validates :name, presence: true
end
