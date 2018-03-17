json.extract! user, :id, :first_name, :last_name, :email, :zip_code, :birthday, :registered_to_vote, :created_at, :updated_at
json.url user_url(user, format: :json)
