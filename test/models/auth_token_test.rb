require 'test_helper'

class AuthTokenTest < ActiveSupport::TestCase
  before(:all) do
    @user = User.first
    @auth_token = AuthToken.create_user_token(@user.id)
  end

  test 'valid auth token' do
    assert @auth_token.valid?
  end

  test 'revoke access' do
    auth_token = AuthToken.revoke_access(@user.id)
    assert auth_token.first.active == false
  end

  test 'give access' do
    auth_token = AuthToken.give_access(@user.id)
    assert auth_token.first.active
  end
end
