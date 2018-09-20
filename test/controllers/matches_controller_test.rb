require 'test_helper'

class MatchesControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = users(:ken)
    sign_in @user, scope: :user
  end

  test 'get index' do
    get matches_url
    assert_response :success
  end

end
