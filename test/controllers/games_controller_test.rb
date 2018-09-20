require 'test_helper'

class GamesControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = users(:ken)
    sign_in @user, scope: :user
  end

  test 'get index' do
    get games_url
    assert_response :success
  end

  test 'post add' do
    skip 'todo'
  end

  test 'post remove' do
    skip 'todo'
  end

end
