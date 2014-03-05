object(:current_user)

attributes(:id, :username, :email, :has_avatar)
node(:avatar_url) do |user|
  user.avatar_url || image_path("default-avatar-small.png")
end
node(:is_external) do |user|
  current_user.external?
end