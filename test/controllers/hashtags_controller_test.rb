require "test_helper"

class HashtagsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get hashtags_index_url
    assert_response :success
  end

  test "should get show" do
    get hashtags_show_url
    assert_response :success
  end
end
