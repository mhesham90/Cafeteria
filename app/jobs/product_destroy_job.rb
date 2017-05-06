class ProductDestroyJob < ApplicationJob
  queue_as :default

  def perform(product)
    data = {}
    data['product'] = product
    data['type'] = 'delete'
    ActionCable.server.broadcast "products", data
  end
end
