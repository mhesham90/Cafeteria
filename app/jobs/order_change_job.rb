class OrderChangeJob < ApplicationJob
  queue_as :default

  def perform(order)
    data = {}
    data['type'] = 'cancel'
    data['order'] = order
    ActionCable.server.broadcast "orders:admin", data
  end

end
