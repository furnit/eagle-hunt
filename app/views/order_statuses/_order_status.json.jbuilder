json.extract! order_status, :id, :state, :shipped_at, :delivered_at, :created_at, :updated_at
json.url order_status_url(order_status, format: :json)
