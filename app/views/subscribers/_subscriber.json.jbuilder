json.extract! subscriber, :id, :name, :email, :source, :created_at, :updated_at
json.url subscriber_url(subscriber, format: :json)
