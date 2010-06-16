class MessagesController < ApplicationController
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
    @users = params[:message]
    @services = params[:message]
    @messages = Message.paginate :page => params[:page], :per_page => 10, :order => "created_at DESC"
    @services = Service.find(:all)
  end

  def show
    @message = Message.find(params[:id])
  end

  def new
    @services = Service.find(:all)
    @message = Message.new
  end

  def create
        @message = Message.create(
          :user_id  => current_user.id,
          :service_id => current_user.service_id,
          :subject => params[:message][:subject],
          :body => params[:message][:body],
          :created_at => Time.now,
          :updated_at => Time.now)
    if @message.save
      flash[:notice] = 'Message was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @message = Message.find(params[:id])
  end

  def update
    @message = Message.find(params[:id])
    if @message.update_attributes(params[:message])
      flash[:notice] = 'Message was successfully updated.'
      redirect_to :action => 'show', :id => @message
    else
      render :action => 'edit'
    end
  end

  def destroy
    Message.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
