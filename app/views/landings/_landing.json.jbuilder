json.extract! landing, :id, :title, :slug_before, :slug_after, :body_before, :body_after, :mailchimp_list, :created_at, :updated_at
json.url landing_url(landing, format: :json)