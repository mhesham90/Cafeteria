class Product < ApplicationRecord
  belongs_to :category
  has_many :orderdetails
  has_many :orders, through: :orderdetails
end
