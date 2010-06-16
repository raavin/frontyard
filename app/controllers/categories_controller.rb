class CategoriesController < ApplicationController
  layout "admin"
  if User.count > 0
    require_role :admin, :for_all_except => :list
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
    @services = Service.find(:all, :order => "service_name")
    @categories = Category.paginate :page => params[:page], :per_page => 10, :order => "service_id, name"
  end

  def show
    @services = Service.find(:all, :order => "service_name")
    @category = Category.find(params[:id])
  end

  def new
    @services = Service.find(:all, :order => "service_name")
    @category = Category.new
  end

  def create
    @services = Service.find(:all, :order => "service_name")
    @category = Category.new(params[:category])
    if @category.save
      flash[:notice] = 'Category was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @services = Service.find(:all, :order => "service_name")
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(params[:category])
      flash[:notice] = 'Category was successfully updated.'
      redirect_to :action => 'show', :id => @category
    else
      render :action => 'edit'
    end
  end

  def delete
    Category.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
