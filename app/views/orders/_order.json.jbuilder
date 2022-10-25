json.extract! order, :id, :user_id, :link, :print_quantity, :paper_size, :comment, :sticker, :laminated, :printed_by_me, :created_at, :updated_at
json.url order_url(order, format: :json)
