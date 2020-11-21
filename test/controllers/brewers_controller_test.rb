require 'test_helper'

class BrewersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get brewers_index_url
    assert_response :success
  end

end
