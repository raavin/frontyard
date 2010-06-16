require File.dirname(__FILE__) + '/../test_helper'
require 'waiting_lists_controller'

# Re-raise errors caught by the controller.
class WaitingListsController; def rescue_action(e) raise e end; end

class WaitingListsControllerTest < Test::Unit::TestCase
  fixtures :waiting_lists

  def setup
    @controller = WaitingListsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = waiting_lists(:first).id
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

    assert_not_nil assigns(:waiting_lists)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:waiting_list)
    assert assigns(:waiting_list).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:waiting_list)
  end

  def test_create
    num_waiting_lists = WaitingList.count

    post :create, :waiting_list => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_waiting_lists + 1, WaitingList.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:waiting_list)
    assert assigns(:waiting_list).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      WaitingList.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      WaitingList.find(@first_id)
    }
  end
end
