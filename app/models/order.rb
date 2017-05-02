class Order < ApplicationRecord
  belongs_to :user
  has_many :orderdetails
  has_many :products, through: :orderdetails
end
