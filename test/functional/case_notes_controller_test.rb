require File.dirname(__FILE__) + '/../test_helper'
require 'case_notes_controller'

# Re-raise errors caught by the controller.
class CaseNotesController; def rescue_action(e) raise e end; end

class CaseNotesControllerTest < Test::Unit::TestCase
  fixtures :case_notes

  def setup
    @controller = CaseNotesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = case_notes(:first).id
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

    assert_not_nil assigns(:case_notes)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:case_note)
    assert assigns(:case_note).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:case_note)
  end

  def test_create
    num_case_notes = CaseNote.count

    post :create, :case_note => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_case_notes + 1, CaseNote.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:case_note)
    assert assigns(:case_note).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      CaseNote.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      CaseNote.find(@first_id)
    }
  end
end
