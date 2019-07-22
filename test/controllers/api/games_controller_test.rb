require 'test_helper'

module Api
  class GamesControllerTest < ActionDispatch::IntegrationTest
    test 'get index' do
      AuthToken.create_user_token(User.first.id)
      get api_games_url(subdomain: :api), headers: { 'Authorization' => User.first.auth_token.token }, as: :json
      assert_response :success
      assert_equal expected_json, JSON.parse(response.body, symbolize_names: true)
    end

    test 'get index when unauthenticated' do
      get api_games_url(subdomain: :api), headers: { 'Authorization' => '' }, as: :json
      assert_response :unauthorized
    end

    private

    def expected_json
      [
        {
          id: 418_230_605,
          title: 'League of Legends',
          slug: 'lol'
        },
        {
          id: 475_801_831,
          title: "PlayerUnknown's Battlegrounds",
          slug: 'pubg'
        },
        {
          id: 50_017_330,
          title: 'World of Warcraft',
          slug: 'wow'
        }
      ]
    end
  end
end
