class OrdersChannel < ApplicationCable::Channel
  def subscribed
    if current_user.admin == "1"
      stream_from "orders:admin"
    end
    stream_from "orders:#{current_user.id}"
  end

  def unsubscribed
    stop_all_streams
  end
end
