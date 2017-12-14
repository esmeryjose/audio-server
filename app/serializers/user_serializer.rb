class UserSerializer < ActiveModel::Serializer
  attributes :id, :display_name, :spotify_url, :profile_img_url
end
