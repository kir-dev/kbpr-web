json.extract! link, :id, :title, :slug, :url, :enabled, :created_at, :updated_at
json.url link_url(link, format: :json)
