json.extract! admin_contact, :id, :name, :phone_numbers, :address, :comment, :created_at, :updated_at
json.url admin_contact_url(admin_contact, format: :json)
