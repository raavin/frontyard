class WaitingListsController < ApplicationController
  layout "frontyard"
  before_filter :login_required
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @waiting_lists = WaitingList.paginate :page => params[:page],
      :per_page => 50,
 #     :conditions => 
 #     if !params[:id].nil?
 #     ['service_id=? AND referral_date LIKE ?', params[:id], Date.today.to_s + '%']
 #   else
 #     ['referral_date LIKE ?', Date.today.to_s + '%']
 #     end,
 
 :conditions => 
      if !params[:id].nil?
      ['service_id=?', params[:id]]
 end,
      :order => "completed_date, accepted_date, referral_date, service_id ASC" #,
      #:conditions => ['referral_date LIKE ?', Date.today.to_s + '%']
      
    @services = Service.find(:all, :order => "service_name")

  end

  def show
    @waiting_list = WaitingList.find(params[:id])
  end

  def new
    @waiting_list = WaitingList.new
  end

  def create
    @waiting_list = WaitingList.new(params[:waiting_list])
    if @waiting_list.save
      flash[:notice] = 'WaitingList was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @waiting_list = WaitingList.find(params[:id])
  end

  def update
    @waiting_list = WaitingList.find(params[:id])
    if @waiting_list.update_attributes(params[:waiting_list])
      flash[:notice] = 'WaitingList was successfully updated.'
      redirect_to :action => 'show', :id => @waiting_list
    else
      render :action => 'edit'
    end
  end
  
  def accept
    @waiting_list = WaitingList.find(params[:id])
    if @waiting_list.update_attributes(
          :accepted_date => Time.now)
      flash[:notice] = 'Client has been accepted.'
      redirect_to :action => 'list'
    else
      render :action => 'edit'
    end
  end

  def complete
    @waiting_list = WaitingList.find(params[:id])
    if @waiting_list.update_attributes(
          :completed_date => Time.now)
      flash[:notice] = 'Client contact completed.'
      # redirect_to :action => 'show', :id => @waiting_list
      redirect_to :action => 'list'
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    WaitingList.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
end
