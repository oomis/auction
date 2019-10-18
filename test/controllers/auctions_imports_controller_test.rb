require 'test_helper'

class AuctionsImportsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get auctions_imports_new_url
    assert_response :success
  end

  test "should get create" do
    get auctions_imports_create_url
    assert_response :success
  end

end
