json.extract! profile, :id, :user_id_id, :first_name, :last_name, :contact, :address, :avatar, :created_at, :updated_at
json.url profile_url(profile, format: :json)
