
Given /^a feed listing$/ do ||
	user1 = Fabricate(:user, name: "#{Faker::Name.name}1")
	Fabricate(:feed, user_id: user1.id, private: false, title: "One", body: user1.name)
	user2 = Fabricate(:user, name: "#{Faker::Name.name}2")
	Fabricate(:feed, user_id: user2.id, private: false, title: "Two", body: user2.name)
	user3 = Fabricate(:user, name: "#{Faker::Name.name}3")
	Fabricate(:feed, user_id: user3.id, private: true, title: "Three", body: user3.name)
end

Given /^their own feed$/ do ||
    @title = Faker::Lorem.word
	@body = Faker::Lorem.sentence
	visit new_feed_path	
    fill_in 'feed_title', :with => @title
    fill_in 'feed_body', :with => @body
    click_button "Create Feed"
end


######################################################################################

When /^they click new feed$/ do||
    visit new_feed_path	
end

When /^they view the feed listing$/ do||
	visit feeds_path	
end

When /^they click on a feed$/ do ||
	visit feeds_path
	click_link "One"
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


###################################################################

Then /^they see that feed page$/ do ||
   page.should have_content("#{@title}")
   page.should have_content("#{@body}")
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



