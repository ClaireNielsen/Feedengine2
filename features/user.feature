Feature: User testing

	Scenario: Sucessful Signin
		Given valid credentials 
		When they are entered on the signin page
		Then they should be logged in

	Scenario: User can edit their information
		Given a logged in user 
		When they edit their info
		Then their infomation is updated

    Scenario: Sucessful Login
		Given a visitor with a username 
		When they try to login with a valid password
		Then they should be logged in

    Scenario: Unsucessful Login
		Given a visitor with a username 
		When they try to login with an invalid password
		Then they should not be logged in

	Scenario: Sucessful Signout
		Given a logged in user 
		When they click signout
		Then they should not be logged in

	Scenario: Signout link not present for a non logged in user
		Given a visitor with a username
		Then no signout link present

