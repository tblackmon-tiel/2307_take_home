class Customer < ApplicationRecord
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates :email, presence: true, uniqueness: true
  validates_presence_of :address

  has_many :subscriptions
end