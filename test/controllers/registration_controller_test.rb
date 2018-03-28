require 'test_helper'

class RegistrationControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get registration_new_url
    assert_response :success
  end

  test "should get good" do
    get registration_good_url
    assert_response :success
  end

end
