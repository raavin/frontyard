require File.dirname(__FILE__) + '/../test_helper'
require 'admin_controller'

# Re-raise errors caught by the controller.
class AdminController; def rescue_action(e) raise e end; end

class AdminControllerTest < Test::Unit::TestCase
  fixtures :services

  def setup
    @controller = AdminController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = services(:first).id
  end

  def test_service_name:string
    get :service_name:string
    assert_response :success
    assert_template 'service_name:string'
  end

  def test_service_description:text
    get :service_description:text
    assert_response :success
    assert_template 'service_description:text'
  end

  def test_min_age:integer
    get :min_age:integer
    assert_response :success
    assert_template 'min_age:integer'
  end

  def test_max_age:integer
    get :max_age:integer
    assert_response :success
    assert_template 'max_age:integer'
  end

  def test_index
    get :index
    assert_response :success
    assert_template 'list'
  end

  def test_list
    get :list

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:services)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:service)
    assert assigns(:service).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:service)
  end

  def test_create
    num_services = Service.count

    post :create, :service => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_services + 1, Service.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:service)
    assert assigns(:service).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Service.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Service.find(@first_id)
    }
  end
end
