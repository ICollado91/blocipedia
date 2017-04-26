json.extract! wiki, :id, :title, :body, :private, :user_id, :created_at, :updated_at
json.url wiki_url(wiki, format: :json)
