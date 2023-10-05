json.extract! funky_text, :id, :title, :content, :created_at, :updated_at
json.url funky_text_url(funky_text, format: :json)
json.content funky_text.content.to_s
