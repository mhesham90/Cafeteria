class OrderRelayJob < ApplicationJob
  queue_as :default


  def perform(order,id)
    data = {}
    data['order'] = order
    data['status'] = 'update'
    ActionCable.server.broadcast "orders:#{id}", data: data
  end
end
