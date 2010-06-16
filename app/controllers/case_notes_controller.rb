class CaseNotesController < ApplicationController
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
    @users = params[:case_note]
    @services = params[:case_note]
    @clients = params[:case_note]
    @services = Service.find(:all)
    @case_notes = CaseNote.paginate :page => params[:page], :per_page => 10, :conditions => ['client_id = ?',"#{params[:id]}"]
  end

  def show
    @services = Service.find(:all)
    @case_note = CaseNote.find(params[:id])
  end

  def new
    @services = Service.find(:all)
    @case_note = CaseNote.new
    @client = Client.find(params[:id]) # needed to add this...
  end

  def create
    @services = Service.find(:all)
    @client = Client.find(params[:id]) # ...and this so that the params[:id] would carry over to the create method
    @case_note = CaseNote.create(
          :user_id  => current_user.id,
          :client_id => params[:id],
          :service_id => current_user.service_id,
          :subject => params[:case_note][:subject],
          :body => params[:case_note][:body],
          :created_at => Time.now,
          :updated_at => Time.now)          
    
    if @case_note.save
      flash[:notice] = 'CaseNote was successfully created.'
      redirect_to :action => 'list', :id => params[:id]
    else
      render :action => 'new'
    end
  end

  def edit
    @services = Service.find(:all)
    @case_note = CaseNote.find(params[:id])
  end

  def update
    @case_note = CaseNote.find(params[:id])
    if @case_note.update_attributes(params[:case_note])
      flash[:notice] = 'CaseNote was successfully updated.'
      redirect_to :action => 'show', :id => @case_note
    else
      render :action => 'edit', :id => params[:id]
    end
  end

  def destroy
    CaseNote.find(params[:id]).destroy
    redirect_to :action => 'list', :id => params[:id]
  end
end
