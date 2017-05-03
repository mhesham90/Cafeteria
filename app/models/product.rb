class Product < ApplicationRecord
  belongs_to :category
  has_many :orderdetails
  has_many :orders, through: :orderdetails
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/uploads/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
end
