class Subscription < ApplicationRecord
  enum status: { cancelled: 0, active: 1}

  validates_presence_of :title
  validates_presence_of :price
  validates :status, presence: true, inclusion: { in: statuses.keys }
  validates_presence_of :frequency

  belongs_to :customer
  belongs_to :tea
end