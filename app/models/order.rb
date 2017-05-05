class Order < ApplicationRecord
  belongs_to :user
  has_many :orderdetails
  has_many :products, through: :orderdetails

  before_destroy ->{ OrderRelayJob.perform_later(self)}
  after_commit ->{ OrderRelayJob.perform_later(self)}
end