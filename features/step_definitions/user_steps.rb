Given /^a visitor$/ do ||
    @user = User.new()
end

Given /^a visitor with a login$/ do ||
	visit sign_up_path
	@username = Faker::Name.name
    @password = Faker::Lorem.word
    @email = Faker::Internet.email

	fill_in 'user_username', :with => @username
	fill_in 'user_password', :with => @password
	fill_in 'user_password_confirmation', :with => @password
	fill_in 'user_email', :with => @email
	click_button "Create User"

	visit log_out_path
	page.should have_content("Logged out")
end

Given /^a feed listing$/ do ||
	user1 = Fabricate(:user, name: "#{Faker::Name.name}1")
	Fabricate(:feed, user_id: user1.id)
	user2 = Fabricate(:user, name: "#{Faker::Name.name}2")
	Fabricate(:feed, user_id: user2.id)
	user3 = Fabricate(:user, name: "#{Faker::Name.name}3")
	Fabricate(:feed, user_id: user3.id)
end

When /^they try to log in and the information validates$/ do||
	visit log_in_path
	fill_in 'username', :with => @username
	fill_in 'password', :with => @password
	click_button "Log in"
end

When /^enters an invalid password in the password signup field$/ do||
	@username = Faker::Name.name
    password = Faker::Lorem.word
    @email = Faker::Internet.email

	fill_in 'user_username', :with => @username
	fill_in 'user_password', :with => password
	fill_in 'user_password_confirmation', :with => "#{password}A"
	fill_in 'user_email', :with => @email
	click_button "Create User"
end

When /^enters an invalid email address in the email signup field$/ do||
	@username = Faker::Name.name
    password = Faker::Lorem.word

	fill_in 'user_username', :with => @username
	fill_in 'user_password', :with => password
	fill_in 'user_password_confirmation', :with => password
	fill_in 'user_email', :with => 'me'
	click_button "Create User"
end

When /^enters a username that already exists into the username signup field$/ do||
	user = Fabricate(:user)
	fill_in 'user_username', :with => user.username
	fill_in 'user_password', :with => 'test'
	fill_in 'user_password_confirmation', :with => 'test'
	fill_in 'user_email', :with => user.email
	click_button "Create User"
end

When /^that user visits the signup page$/ do||
	visit sign_up_path
end

When /^enters valid data into the signup fields$/ do||
	@username = Faker::Name.name
    password = Faker::Lorem.word
    @email = Faker::Internet.email

	fill_in 'user_username', :with => @username
	fill_in 'user_password', :with => password
	fill_in 'user_password_confirmation', :with => password
	fill_in 'user_email', :with => @email
	click_button "Create User"
end 

When /^that user views the feed listing$/ do||
	visit feeds_path	
end

When /^that user selects a public feed$/ do ||
	visit feeds_path
	@link = first(:link, "Show")
	@link.click
end

Then /^they see that feed$/ do ||
	split_link = @link[:href].split("/")
	author = Feed.find(split_link[2]).user
	page.should have_content(author.username)
	feeds = Feed.find(:all, :conditions => {:user_id => author.id})
	feeds.each { |f|
		page.should have_content(f.body)
	}
end

Then /^their account should be created$/ do||
	user_record = User.last
	user_record.username.should eq(@username)
	user_record.email.should eq(@email)
	page.should have_content('Signed up!')
end

Then /^they should be logged in$/ do||
	page.should have_content("Logged in as #{@username}")
end

Then /^they should see a username alert$/ do||
	page.should have_content("Username has already been taken")
end

Then /^their account should not be created$/ do||
	page.should have_content("1 error prohibited this user from being saved:")
end

Then /^they should see an email alert$/ do||
	page.should have_content("Email is invalid")
end

Then /^they should see an password alert$/ do||
	page.should have_content("Password doesn't match confirmation")
end


Then /^they see a list of all public feeds$/ do||
	public_users = User.all

	public_users.each do |public_user| 
		puts public_user.username
		puts public_user.is_private
		if public_user.is_private == false
			page.should have_content("#{public_user.username}")
		end
		if public_user.is_private == true
			page.should_not have_content("#{public_user.username}")
		end
	end
end



