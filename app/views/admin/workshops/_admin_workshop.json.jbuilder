json.extract! admin_workshop, :id, :name, :state_id, :address, :user_id, :phone_number, :comment, :created_at, :updated_at
json.url admin_workshop_url(admin_workshop, format: :json)
