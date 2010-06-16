class AdminController < ApplicationController
  if User.count > 0
    require_role :admin#, :except => :list
    before_filter :login_required
  end
  
  
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @services = Service.paginate :page => params[:page], :order => "service_name"
  end

  def show
    @service = Service.find(params[:id])
    @services = Service.find(:all,:order => "service_name") 
  end

  def new
    @service = Service.new
    @services = Service.paginate :page => params[:page], :order => "service_name"
  end

  def create
    @services = Service.paginate :page => params[:page], :order => "service_name"
    @service = Service.new(params[:service])
    if @service.save
      flash[:notice] = 'Service was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @services = Service.paginate :page => params[:page], :order => "service_name"
    @service = Service.find(params[:id])
  end

  def update
    @service = Service.find(params[:id])
    if @service.update_attributes(params[:service])
      flash[:notice] = 'Service was successfully updated.'
      redirect_to :action => 'show', :id => @service
    else
      render :action => 'edit'
    end
  end

  def delete
    Service.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
