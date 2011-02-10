Feature: Shared URL Descriptions
	So that I can find full urls
	As a url viewer
	I want to see accurate urls
	
	@wip
	Scenario: Show full url
		Given a url
		When I set the full url to "http://www.betfair.com"
		Then the full url should be "http://www.betfair.com"
	
	