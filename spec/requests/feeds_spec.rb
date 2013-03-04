require 'spec_helper'


describe "Feeds" do

  describe "GET /feeds" do
    it "should have the content 'Latest Feeds'" do
    	visit '/feeds'
    	page.should have_content('Latest Feeds')
    end
    it  "logged out: should not have the content 'New Feed'" do
    	visit '/feeds'
    	page.should_not have_content('New Feed')
    	page.should_not have_content('Edit')
    	page.should_not have_content('Delete')
    end
  end

  describe "Get /feeds" do
  	it "logged in: should have the content 'New Feed'" do
  		sign_in FactoryGirl.create(:user)
  		visit '/feeds'
    	page.should have_content('New Feed')
    end
    it "logged in: should have the content 'Edit and Delete'" do
  		sign_in FactoryGirl.create(:user)
  		create_feed
  		visit '/feeds'  		
    	page.should have_content('Edit')
    	page.should have_content('Delete')
    end
  end

end


