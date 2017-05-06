class ProductChangeJob < ApplicationJob
  queue_as :default

  def perform(product)
    data = {}
    data['product'] = product
    data['type'] = 'update'
    ActionCable.server.broadcast "products", data
  end
end
