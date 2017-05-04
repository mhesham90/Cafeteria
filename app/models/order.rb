class Order < ApplicationRecord
  belongs_to :user
  has_many :orderdetails
  has_many :products, through: :orderdetails

  after_create ->{
    OrderCreateJob.perform_now(self)
  }
  after_update_commit ->{
    if self.status == 3
      OrderChangeJob.perform_now(self)
    else
      OrderRelayJob.perform_now(self, self.user_id)
    end
  }
end