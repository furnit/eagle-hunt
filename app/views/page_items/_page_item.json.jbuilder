json.extract! page_item, :id, :controller, :action, :details, :created_at, :updated_at
json.url page_item_url(page_item, format: :json)
