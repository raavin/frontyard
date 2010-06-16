require File.dirname(__FILE__) + '/../test_helper'
require 'frontyard_controller'

# Re-raise errors caught by the controller.
class FrontyardController; def rescue_action(e) raise e end; end

class FrontyardControllerTest < Test::Unit::TestCase
  def setup
    @controller = FrontyardController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
