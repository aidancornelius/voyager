json.extract! message, :id, :user_id, :from_user_id, :from_thread_id, :title, :body, :link, :read, :created_at, :updated_at
json.url message_url(message, format: :json)