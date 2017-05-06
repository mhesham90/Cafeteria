class ProductCreateJob < ApplicationJob
  queue_as :default

  def perform(product)
    data = {}
    data['product'] = product
    data['type'] = 'create'
    ActionCable.server.broadcast "products", data
  end
end
