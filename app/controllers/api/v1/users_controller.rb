class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def create
    auth_params = SpotifyAdapter.login(params[:code])
    user_data = SpotifyAdapter.getUserData(auth_params["access_token"])

    user = User.find_or_create_by(user_params(user_data))

    img_url = user_data["images"][0] ? user_data["images"][0]["url"] : nil

    encodedAccess = issue_token({token: auth_params["access_token"]})
    encodedRefresh = issue_token({token: auth_params["refresh_token"]})

    user.update(profile_img_url: img_url,access_token: encodedAccess,refresh_token: encodedRefresh)

    render json: user_with_token(user)
  end


  private

  def user_with_token(user)
    payload = {user_id: user.id}
    token = issue_token(payload)
    newUser = UserSerializer.new(user).attributes
    { token: token, currentUser: newUser }
  end

  def user_params(user_data)
    params = {
      display_name: user_data["display_name"],
      spotify_id: user_data["id"],
      spotify_url: user_data["external_urls"]["spotify"],
      uri: user_data["uri"]
    }
  end
end
