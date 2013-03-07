Feature: Feed testing

    Scenario: Create a feed
		Given a logged in user
		When they click new feed
		And the correct information is filled out
		Then they see that feed page

	Scenario: Click on public feed 
		Given a visitor with a username
		And a feed listing
		When they click on a public feed
		Then they see that feed page

	Scenario: Edit a feed
		Given a logged in user
		And their own feed
		When they edit feed
		Then they see that feed page

	Scenario: Logged out user feed listings
		Given a visitor with a username
		And a feed listing
		When they view the feed listing
		Then they see a list of all public feeds

	Scenario: Logged in user feed listings
		Given a feed listing
		And a signed in user with permission to the private feed
		When they view the feed listing
		Then they see a list of all public feed and private feeds with permission

    Scenario: Click on private feed with permissions
		Given a feed listing
		And a signed in user with permission to the private feed
		When they click on a private feed
		Then they see that feed page

	Scenario: Click on private feed without permissions
		Given a feed listing
		And a signed in user without permission to the private feed
		When they go to the URL
		Then they are not taken to the feed page

	