class OrderChangeJob < ApplicationJob
  queue_as :default

  def perform(data)
    ActionCable.server.broadcast "orders:admin", data: data
  end
end
