class OrderRelayJob < ApplicationJob
  queue_as :default


  def perform(order,id)
    data = {}
    data['order'] = order
    data['type'] = 'update'
    ActionCable.server.broadcast "orders:#{id}", data
  end
end
