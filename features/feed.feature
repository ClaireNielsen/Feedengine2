Feature: Feed testing

    Scenario: Create a feed
		Given a logged in user
		When they click new feed
		And the correct information is filled out
		Then they see that feed page

	Scenario: Click on public feed 
		Given a visitor with a username
		And a feed listing
		When they click on a feed
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
		Given a logged in user
		And a feed listing
		When they view the feed listing
		Then they see a list of all public feeds 
	#   And the private feed with permission

    #Scenario: Click on private feed with permissions
	#	Given a logged in user
	#	And one private feed with permission
	#	When they click on a feed
	#	Then they are taken to the feed page

	#Scenario: Click on private feed without permissions
	#	Given a logged in user
	#	And one private feed without permission
	#	When they click on a feed
	#	Then they are not taken to the feed page

	