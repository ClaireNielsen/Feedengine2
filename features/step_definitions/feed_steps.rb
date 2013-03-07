
Given /^a feed listing$/ do ||
	@user1 = Fabricate(:user, name: "#{Faker::Name.name}1")
	@feed1 =Fabricate(:feed, user_id: @user1.id, private: false, title: "One_apple", body: @user1.name)
	@user2 = Fabricate(:user, name: "#{Faker::Name.name}2")
	@feed2 =Fabricate(:feed, user_id: @user2.id, private: false, title: "Two_oranges", body: @user2.name)
	@user3 = Fabricate(:user, name: "#{Faker::Name.name}3")
	@feed3 =Fabricate(:feed, user_id: @user3.id, private: true, title: "Three_grapes", body: @user3.name)
end

Given /^their own feed$/ do ||
    @title = Faker::Lorem.word
	@body = Faker::Lorem.sentence
	visit new_feed_path	
    fill_in 'feed_title', :with => @title
    fill_in 'feed_body', :with => @body
    click_button "Create Feed"
end

Given /^a signed in user with permission to the private feed/ do ||
	Fabricate(:permission, user_id: @user1.id, feed_id: @feed3.id)
	visit signin_path
	fill_in 'session_email', :with => @user1.email
	fill_in 'session_password', :with => @user1.password
	click_button "Sign in"
end
	

Given /^a signed in user without permission to the private feed/ do ||
	Fabricate(:permission, user_id: @user2.id, feed_id: @feed3.id)
	visit signin_path
	fill_in 'session_email', :with => @user1.email
	fill_in 'session_password', :with => @user1.password
	click_button "Sign in"
end


######################################################################################

When /^they click new feed$/ do||
    visit new_feed_path	
end

When /^they view the feed listing$/ do||
	visit feeds_path	
end

When /^they click on a public feed$/ do ||
	visit feeds_path
	@feed_title = @feed1.title
	@feed_body = @feed1.body
	click_link @feed_title
end

When /^they click on a private feed$/ do ||
	visit feeds_path
	@feed_title = @feed3.title
	@feed_body = @feed3.body
	click_link @feed_title
end

When /^the correct information is filled out$/ do ||
	@title = Faker::Lorem.word
	@body = Faker::Lorem.sentence
    fill_in 'feed_title', :with => @title
    fill_in 'feed_body', :with => @body
    click_button "Create Feed"
end

When /^they edit feed$/ do ||
   click_link "Edit"
   @title = "AA"
   @body = "AA"
   fill_in 'feed_title', :with => @title
   fill_in 'feed_body', :with => @body
   click_button "Update Feed"
end

When /^they go to the URL$/ do ||
   visit feed_path(@feed3.id)
   @feed_title = @feed3.title
   @feed_body = @feed3.body
end


###################################################################

Then /^they see that feed page$/ do ||
   page.should have_content("#{@feed_title}")
   page.should have_content("#{@feed_body}")
end

Then /^they are not taken to the feed page$/ do ||
   page.should_not have_content("#{@feed_title}")
   page.should_not have_content("#{@feed_body}")
end


Then /^they see a list of all public feeds$/ do||
	feeds = Feed.all

	feeds.each do |feed| 
		if feed.private == false
			page.should have_content("#{feed.title}")
		end
		if feed.private == true
			page.should_not have_content("#{feed.title}")
		end
	end
end

Then /^they see a list of all public feed and private feeds with permission$/ do||
	feeds = Feed.all
	permission = Permission.find(1)

	feeds.each do |feed| 
		if feed.private == false
			page.should have_content("#{feed.title}")
		end
		if (feed.private == true) && (feed.id == permission.feed_id)
			page.should have_content("#{feed.title}")
		end
	end
end


