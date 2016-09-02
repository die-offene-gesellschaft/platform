json.extract! blogpost,
              :id, :title, :blogpost_type, :introduction, :content, :created_at, :updated_at
json.url blogpost_url(blogpost, format: :json)
