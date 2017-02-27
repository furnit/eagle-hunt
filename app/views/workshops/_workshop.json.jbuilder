json.extract! workshop, :id, :name, :manager, :address, :contact, :comment, :workshop_type, :created_at, :updated_at
json.url workshop_url(workshop, format: :json)
