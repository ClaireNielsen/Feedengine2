Feature: User testing
	In order to use a feeder
	As a user
	I want to be able to see some feeds

	Scenario: See the feed listings
		Given a visitor 
		And a feed listing
		When that a visitor views the feed listing
		Then they see a list of all public feeds

		Given a visitor
		And a feed listing
		When that user selects a public feed
		Then they see that feed

		Given a visitor with a login
		When they try to log in and the information validates
		Then they should be logged in

		Given a visitor and a username 
		When that user requests a password reset
		Then the user receives an email with the new password


		Given a visitor viewing a public feed
		When they like the feed
		Then they are prompted to log in

		Given a logged in user
		When the user views the feed listing
		Then they see a list of all public feeds 
		And they see a list of all private feeds they have access to

		Given a logged in user
		When that user selects a feed
		And they have access to view that feed
		Then they see that feed
