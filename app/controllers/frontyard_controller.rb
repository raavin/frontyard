class FrontyardController < ApplicationController
  before_filter :login_required
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @countries  = params[:client]
    @categories = Category.find(:all,:order => "service_id, name") 
    if params[:searchclients]
    @clients = Client.paginate :per_page => 100, :page => params[:page], :order => 'first_name, last_name', :conditions => ['first_name LIKE ? OR last_name LIKE ?',"%#{params[:searchclients]}%","%#{params[:searchclients]}%"] 
    @case_notes  = CaseNote.find(:first, :conditions => ['client_id = ?',@client])
  else
    @clients = Client.paginate :per_page => 3, :page => params[:page], :order => 'last_name, first_name'
    # @case_notes  = CaseNote.find(:first, :conditions => ['client_id = ?',"#{4}"])
    end
    @services = Service.find(:all, :order => "service_name")
    @waiting_lists = WaitingList.find(:all)
    @messages = Message.find(:all,:order => "created_at DESC") 
  end

  def show
    @services = Service.find(:all, :order => "service_name")
    @client = Client.find(params[:id])
  end

  def new_client
    @client = Client.new
    @services = Service.find(:all, :order => "service_name")
  end

  def create
    @services = Service.find(:all, :order => "service_name")
    @client = Client.new(params[:client])
    if @client.save
      flash[:notice] = 'Client was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new_client'
    end
  end

  def edit
    @services = Service.paginate :page => params[:page]
    @client = Client.find(params[:id])
  end

  def update
    @services = Service.paginate :page => params[:page]
    @client = Client.find(params[:id])
    if @client.update_attributes(params[:client])
      flash[:notice] = 'Client was successfully updated.'
      redirect_to :action => 'show', :id => @client
    else
      render :action => 'edit'
    end
  end

  def delete
    Client.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  def waiting
    @services = Service.paginate :page => params[:page]
    @waiting_lists = WaitingList.paginate :page => params[:page], :per_page => 50
    if request.post?
      
      for service in @services
        if params[service.service_name + "dd"]
          @waiting_list = WaitingList.create(
          :client_id  => params[:radio],
          :service_id => service.id,
          :category_id => params[service.service_name][:id],
          :referral_date => Time.now
          )
          
          # TODO Need to do the verification Flash notice properly
            
          flash[:notice] = 'Client was successfully added to waiting list.'
          
        else
          flash[:notice] = 'Client was not successfully added to waiting list.'
          @waiting_list = 0
        end
      end
        if @waiting_list
          redirect_to :action => 'list'
        else
          render :action => 'list'
        end
    end
  end
end
