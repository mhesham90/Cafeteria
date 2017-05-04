class OrderRelayJob < ApplicationJob
  queue_as :default

  def perform(data,id)
    ActionCable.server.broadcast "orders:#{id}", data: data
  end
end
