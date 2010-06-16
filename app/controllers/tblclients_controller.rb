class TblclientsController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @tblclient_pages, @tblclients = paginate :tblclients, :per_page => 10
  end

  def show
    @tblclient = Tblclient.find(params[:id])
  end

  def new
    @tblclient = Tblclient.new
  end

  def create
    @tblclient = Tblclient.new(params[:tblclient])
    if @tblclient.save
      flash[:notice] = 'Tblclient was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @tblclient = Tblclient.find(params[:id])
  end

  def update
    @tblclient = Tblclient.find(params[:id])
    if @tblclient.update_attributes(params[:tblclient])
      flash[:notice] = 'Tblclient was successfully updated.'
      redirect_to :action => 'show', :id => @tblclient
    else
      render :action => 'edit'
    end
  end

  def migrate
    @tblclient_pages, @tblclients = paginate :tblclients, :per_page => 5000
    @clients = Client.find(:all)
    for tblclient in @tblclients
      test = Country.find(:first, :conditions => ["printable_name LIKE ?", "%#{tblclient.Ethnicity}%"])
          @client = Client.create(
          :first_name  => tblclient.Firstname,
          :last_name => tblclient.Surname,
          :dob => if !tblclient.DOB.nil?
                      tblclient.DOB
                  else
                    "01/01/1900"
                    end,
          :country_id => if !test.nil?
                          test.id
                      else
                        12
                        end,
          :gender => if tblclient.Gender == 'Male' 
                     0
                   elsif tblclient.Gender == 'Female' 
                     1
                    end,
          :created_at => Time.now,
          :updated_at => Time.now)           
     end
  end

  def destroy
    Tblclient.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
