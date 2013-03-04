class FeedsController < ApplicationController
  
  # GET /feeds
  def index
    @feeds = Feed.all

    @feeds.keep_if{|feed| feed.private == false}

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

    respond_to do |format|
      if @feed.update_attributes(params[:feed])
        format.html { redirect_to @feed, notice: 'Feed was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /feeds/1
  def destroy
    @feed = Feed.find(params[:id])
    @feed.destroy

    redirect_to feeds_url 
  end
end
