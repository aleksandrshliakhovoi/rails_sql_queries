class Branch < ApplicationRecord
  belongs_to :organization
  has_many :feedbacks, dependent: :destroy
end
