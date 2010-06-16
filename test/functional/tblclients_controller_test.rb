require File.dirname(__FILE__) + '/../test_helper'
require 'tblclients_controller'

# Re-raise errors caught by the controller.
class TblclientsController; def rescue_action(e) raise e end; end

class TblclientsControllerTest < Test::Unit::TestCase
  fixtures :tblclients

  def setup
    @controller = TblclientsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = tblclients(:first).id
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

    assert_not_nil assigns(:tblclients)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:tblclient)
    assert assigns(:tblclient).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:tblclient)
  end

  def test_create
    num_tblclients = Tblclient.count

    post :create, :tblclient => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_tblclients + 1, Tblclient.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:tblclient)
    assert assigns(:tblclient).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Tblclient.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Tblclient.find(@first_id)
    }
  end
end
