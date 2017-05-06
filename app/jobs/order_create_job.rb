class OrderCreateJob < ApplicationJob
  queue_as :default

  def perform(order)
    data['type'] = 'create'
    data['order'] = order
    ActionCable.server.broadcast "orders:admin", data
  end
end
