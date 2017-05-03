class OrderRelayJob < ApplicationJob
  queue_as :default

  def perform(data)
    ActionCable.server.broadcast "orders:1", data: data
  end
end
