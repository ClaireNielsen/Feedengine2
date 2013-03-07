class FeedsController < ApplicationController

  before_filter :signed_in_user, 
                only: [:edit, :update, :destroy, :create, :new]
  before_filter :permission_user, only: [:show]
  before_filter :correct_user,   only: [:destroy, :edit]
  

  # GET /feeds
  def index

    @feeds = Feed.all    
       
    if signed_in? 
      @permissions = Permission.find(:all, :conditions => {:user_id => current_user})
      @feeds.keep_if{ |feed| 
       (feed.private == false) ||
       (feed.user_id == current_user.id) ||
       (Permission.find(:all, :conditions => {:user_id => current_user, :feed_id => feed.id}) != [])
      }
    else
      @feeds.keep_if{|feed| feed.private == false}
    end
  end

  # GET /feeds/1
  def show
    @feed = Feed.find(params[:id])
  end

  # GET /feeds/new
  def new
    @feed = Feed.new
  end

  # GET /feeds/1/edit
  def edit
    @feed = Feed.find(params[:id])
  end

  # POST /feeds
  def create
    @feed= current_user.feeds.create(params[:feed])

    @feed.save

    redirect_to feed_path(@feed)
  end

  # PUT /feeds/1
  def update
    @feed = Feed.find(params[:id])

    if @feed.update_attributes(params[:feed])
      redirect_to @feed, notice: 'Feed was successfully updated.' 
    else
      render action: "edit" 
    end
  end

  def permission
     @permission = User.permission.find(params[:user_id])
  end

  # DELETE /feeds/1
  def destroy
    @feed = Feed.find(params[:id])
    @feed.destroy

    redirect_to feeds_url 
  end

  private

    def correct_user
      @feeds = current_user.feeds.find_by_id(params[:id])
      redirect_to root_url if @feeds.nil?
    end

    def permission_user 
      @premission_granted = false
      
      #All public feeds permission is granted
      @premission_granted = true if( Feed.find(params[:id]).private == false)

      #if user is logged in check other conditions     
      if current_user != nil 
        #if user owns feed grant permission 
        @premission_granted = true if( Feed.find(params[:id]).user_id == current_user.id) 

        #if user has matching record in permissions table, grant permission
        @permissions = Permission.find(:all, :conditions => {:user_id => current_user, :feed_id => params[:id]})
        @premission_granted = true if( @permissions != [] ) 
      end
      
      #redirect anyone without permission
     redirect_to root_url if( @premission_granted == false )
    end
end
