require 'spec_helper'

describe "Feeds" do

  before do
    @user1 = User.new(name: "User1", email: "user1@example.com", password: "User1")
    @user1.save
    @user2 = User.new(name: "User2", email: "user2@example.com", password: "User2")
    @user2.save
    @feed1 = Feed.new(title: "Feed One", body: "Feed One Text", user_id: 1, private: false)
    @feed1.save    
    @feed2 = Feed.new(title: "Feed Two", body: "Feed Two Text", user_id: 1, private: true)
    @feed2.save
    @feed3 = Feed.new(title: "Feed Three", body: "Feed Three Text", user_id: 1, private: true)
    @feed3.save
    @permission = Permission.new(feed_id: 2, user_id: 2)
    @permission.save
  end

  describe "GET /feeds" do
    it  "logged out: should not have the content 'New Feed'" do
    	visit '/feeds'
      page.should have_content('Latest Feeds')
    	page.should_not have_content('New Feed')
    	page.should_not have_content('Edit')
    	page.should_not have_content('Delete')
      page.should have_content('Sign in')
      page.should have_content('Sign up')
    end
  end

  describe "Get /feeds" do
  	it "logged in: should have the content 'New Feed'" do
  		sign_in @user2
  		visit '/feeds'
      page.should have_content('Latest Feeds')
    	page.should have_content('New Feed')
      page.should have_content('Home')
      page.should have_content('Account')
      page.should have_content("Signed in as: #{@user2.name}")
      page.should have_content("#{@feed1.title}")
      page.should have_content("#{@feed2.title}")
      page.should_not have_content("#{@feed3.title}")
    end
    it "logged in: should have the content 'Edit and Delete'" do
  		sign_in @user1
  		visit '/feeds'  		
    	page.should have_content('Edit')
    	page.should have_content('Delete')
      page.should have_content("#{@feed1.title}")
      page.should have_content("#{@feed2.title}")
      page.should have_content("#{@feed3.title}")
    end    
  end

  describe "GET /feeds/id" do
    it  "logged out: should be able to visit a public feed" do
      visit "/feeds/#{@feed1.id}"
      page.should have_content("#{@feed1.title}")
      page.should have_content("#{@feed1.body}")
      page.should_not have_content("Edit")
    end
    it "logged in: should be able to visit a private feed with permission" do
      sign_in @user2
      visit "/feeds/#{@feed2.id}"    
      page.should have_content("#{@feed2.title}")
      page.should have_content("#{@feed2.body}")
      page.should_not have_content("Edit")
    end  
    it "logged in: should not be able to visit a private feed without permission" do
      sign_in @user2
      visit "/feeds/#{@feed3.id}"    
      page.should_not have_content("#{@feed3.title}")
      page.should_not have_content("#{@feed3.body}")
      page.should_not have_content("Edit")
    end  

  end

end


