class AccountController < ApplicationController
  if User.count > 0
    require_role :admin, :except => [:login, :logout, :list], :unless => "current_user.id == (params[:id])"
  end
  
  #before_filter :login_required
  layout "admin"
  # Be sure to include AuthenticationSystem in Application Controller instead
  #include AuthenticatedSystem
  # If you want "remember me" functionality, add this before_filter to Application Controller
  # before_filter :login_from_cookie
 
  # say something nice, you goof!  something sweet.
  def index
    redirect_to(:action => 'signup') unless logged_in? || User.count > 0

  end
  def list
    
    @users = User.paginate :page => params[:page], :per_page => 10
    @services = Service.find(:all, :order => "service_name")
  end
  def login
    @services = Service.find(:all)
    return unless request.post?
    self.current_user = User.authenticate(params[:login], params[:password])
    if logged_in?
      if params[:remember_me] == "1"
        self.current_user.remember_me
        cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
      end
      redirect_back_or_default(:controller => :frontyard, :action => :list)
      flash[:notice] = current_user.login + " has logged in successfully"
    end
  end

  def signup
    @services = Service.find(:all, :order => "service_name")
    @user = User.new(params[:user])
    return unless request.post?
    @user.save!
    #self.current_user = @user #comment out so that admins can sign up users only
    redirect_back_or_default(:controller => 'frontyard', :action => 'list')
    flash[:notice] = "Thanks for signing up!"
  rescue ActiveRecord::RecordInvalid
    render :action => 'signup'
  end
  
  def logout
    
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = current_user.login + " has been logged out."
    redirect_back_or_default(:controller => 'frontyard', :action => 'list')
  end
  
  def edit
    @services = Service.find(:all, :order => "service_name")
    @user = User.find(params[:id])
  end
  
  def update
    params[:user][:role_ids] ||=[]
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = 'User details were successfully updated.'
      redirect_to :action => 'list'
    else
      render :action => 'edit'
    end
  end
end
