class PermissionsController < ApplicationController
  
  before_filter :signed_in_user, 
                only: [:new, :create :destroy]
  before_filter :correct_user,   only: [:new, :create, :destroy]

  belongs_to :user
  belongs_to :feed

  # GET /permissions
  #def index
  # @permissions = Permission.all
  #end

  # GET /permissions/1
  #def show
  #  @permission = Permission.find(params[:id])
  #end

  # GET /permissions/new
  def new
    @permission = Permission.new
  end

  # GET /permissions/1/edit
  #def edit
  # @permission = Permission.find(params[:id])
  #nd

  # POST /permissions
  def create
    @permission = Permission.new(params[:permission])

    if @permission.save
      redirect_to @permission, notice: 'Permission was successfully created.' 
    else
      render action: "new" 
    end
  end

  # PUT /permissions/1
  #def update
   # @permission = Permission.find(params[:id])

   # if @permission.update_attributes(params[:permission])
    #  redirect_to @permission, notice: 'Permission was successfully updated.' 
    #else
   #   render action: "edit" 
    #end

  #end

  # DELETE /permissions/1
  def destroy
    @permission = Permission.find(params[:id])
    @permission.destroy

    redirect_to permissions_url 
  end

  private

    def correct_user
      @feeds = current_user.feeds.find_by_id(params[:id])
      redirect_to root_url if @feeds.nil?
    end

end
