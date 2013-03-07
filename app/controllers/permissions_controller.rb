class PermissionsController < ApplicationController
  
  before_filter :signed_in_user, 
                only: [:index, :new, :create, :destroy]

  # GET /permissions
  def index
   @permissions = Permission.all
  end

  # GET /permissions/1
  #def show
  #  @permission = Permission.find(params[:id])
  #end

  # GET /permissions/new
  def new
    @user = User.all
    @feed = Feed.find(:all, :conditions => {:user_id => current_user})
    @permission = Permission.new
  end

  # GET /permissions/1/edit
  #def edit
  # @permission = Permission.find(params[:id])
  #end

  # POST /permissions
  def create
    @permission = Permission.new(params[:permission])

    if @permission.save
      redirect_to permissions_path, notice: 'Permission was successfully created.' 
    else
      render action: "new" 
    end
  end

  # PUT /permissions/1
  #def update
  #  @permission = Permission.find(params[:id])

  #  if @permission.update_attributes(params[:permission])
   #   redirect_to @permission, notice: 'Permission was successfully updated.' 
  #  else
  #    render action: "edit" 
  #  end

  #end

  # DELETE /permissions/1
  def destroy
    @permission = Permission.find(params[:id])
    @permission.destroy

    redirect_to permissions_url 
  end

end
