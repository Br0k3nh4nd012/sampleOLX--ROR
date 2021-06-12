json.extract! product, :id, :name, :category, :description, :price, :buyerId, :soldOut, :user_id, :created_at, :updated_at
json.url product_url(product, format: :json)
