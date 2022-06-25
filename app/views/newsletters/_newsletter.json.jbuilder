json.extract! newsletter, :id, :user_id, :title, :body, :publish_at, :created_at, :updated_at
json.url newsletter_url(newsletter, format: :json)
