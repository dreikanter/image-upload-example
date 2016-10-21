require "test_helper"

class ImagesControllerTest < ActionDispatch::IntegrationTest
  def test_index
    get images_index_url
    assert_response :success
  end

end
