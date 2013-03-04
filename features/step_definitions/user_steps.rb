Given /^valid credentials$/ do ||
    @name = Faker::Name.name
    @password = Faker::Lorem.word
    @email = Faker::Internet.email
end

Given /^a visitor with a username$/ do ||
	visit signup_path
	@name = Faker::Name.name
    @password = Faker::Lorem.word
    @email = Faker::Internet.email

	fill_in 'user_name', :with => @name
	fill_in 'user_password', :with => @password
	fill_in 'user_email', :with => @email
	click_button "Create User"

	click_link "Sign out"
	page.should have_content("Sign in")
end

Given /^a logged in user$/ do ||
    visit signup_path
	@name = Faker::Name.name
    @password = Faker::Lorem.word
    @email = Faker::Internet.email

	fill_in 'user_name', :with => @name
	fill_in 'user_password', :with => @password
	fill_in 'user_email', :with => @email
	click_button "Create User"

	page.should have_content("Signed in as: ")
end

######################################################################################
When /^they are entered on the signin page$/ do||
    visit signup_path
	fill_in 'user_name', :with => @name
	fill_in 'user_email', :with => @email
	fill_in 'user_password', :with => @password
	click_button "Create User"
end

When /^they edit their info$/ do||
    click_link "Edit"
	fill_in 'user_name', :with => ("A" + @name)
	fill_in 'user_email', :with => ("A" + @email)
	fill_in 'user_password', :with => ("A" + @password)
	click_button "Save changes"
end


When /^they try to login with a valid password$/ do||
	visit signin_path
	fill_in 'session_email', :with => @email
	fill_in 'session_password', :with => @password
	click_button "Sign in"
end


When /^they try to login with an invalid password$/ do||
	visit signin_path
	fill_in 'session_email', :with => @email
	fill_in 'session_password', :with => ("aa" + @password + "aa")
	click_button "Sign in"
end

When /^they click signout$/ do||
	click_link "Sign out"
end

###################################################################

Then /^they should be logged in$/ do||
    page.should have_content("Signed in as: #{@name}")
end

Then /^they should not be logged in$/ do||
    page.should_not have_content("Signed in as: #{@name}")
end

Then /^no signout link present$/ do||
	page.should_not have_content("Sign out")
end

Then /^their infomation is updated/ do||
	page.should have_content("Signed in as: A#{@name}")
end
