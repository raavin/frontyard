# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  # You can move this into a different controller, if you wish.  This module gives you the require_role helpers, and others.
  include RoleRequirementSystem

  before_filter :login_from_cookie
  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_frontyard_session_id'
  
end
