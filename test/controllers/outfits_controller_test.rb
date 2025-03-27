require "test_helper"

class OutfitsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get outfits_index_url
    assert_response :success
  end

  test "should get show" do
    get outfits_show_url
    assert_response :success
  end
end
