class Order < ApplicationRecord
  belongs_to :user
  has_many :orderdetails
  has_many :products, through: :orderdetails

  attr_reader :total

  def total
    sum=0
    self.orderdetails.each{ |x| sum += x.product.price * x.quantity }
    sum
  end

  after_create ->{
    OrderCreateJob.perform_now(self.to_json(:methods => :total,include: {:user=>{include: {:room=>{}}}, :orderdetails=>{include: {:product=>{}} }}))
  }
  after_update_commit ->{
    if self.status == 3
      OrderChangeJob.perform_now(self.to_json(:methods => :total,include: {:user=>{include: {:room=>{}}}, :orderdetails=>{include: {:product=>{}} }}))
    else
      OrderRelayJob.perform_now(self.to_json(:methods => :total,include: {:user=>{include: {:room=>{}}}, :orderdetails=>{include: {:product=>{}} }}), self.user_id)
    end
  }
end