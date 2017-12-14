class SpotifyAdaptor
  def self.authorize(code)
    body = {
      grant_type: "authorization_code",
      code: code,
      redirect_uri: ENV['REDIRECT_URI'],
      client_id: ENV['CLIENT_ID'],
      client_secret: ENV["CLIENT_SECRET"]
    }
    auth_response = RestClient.post('https://accounts.spotify.com/api/token', body)
    JSON.parse(auth_response.body)
  end

  def self.getUserData(access_token)
    header = {
      Authorization: "Bearer #{access_token}"
    }

    user_response = RestClient.get("https://api.spotify.com/v1/me", header)

    JSON.parse(user_response.body)
  end
end
