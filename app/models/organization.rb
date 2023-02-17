class Organization < ApplicationRecord
  has_many :branches, dependent: :destroy
end
