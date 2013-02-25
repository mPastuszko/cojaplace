Feature: Welcome Page

    Background:
      Given I am not logged in

    Scenario: Redirect new user to welcome page
      When I go to the home page
      Then I should be on the welcome page
    
    Scenario: User leaves name field blank
      Given I am on the welcome page
      When I press "No już, dalej!"
      Then I should be on the welcome page
      And I should see error message
    
    Scenario: User logs in as an existing user
      Given I am on the welcome page
      And user "Daniel" exists
      When I fill in "username" with "Daniel"
      And I press "No już, dalej!"
      Then I should be on the home page
      And I should see "Daniel" within ".page-header h3"
        
    Scenario: User logs in as a new user
      Given I am on the welcome page
      And user "TestUserWhoDoesn'tExist" does not exist
      When I fill in "username" with "TestUserWhoDoesn'tExist"
      And I press "No już, dalej!"
      Then I should be on the home page
      And I should see "TestUserWhoDoesn'tExist" within ".page-header h3"
        
    @javascript
    Scenario: Exisitng user's name is suggested on the welcome page
      Given user "Daniel" exists
      And I am on the welcome page
      When I fill in "username" with "d"
      Then I should see "Daniel" within "ul.typeahead"
    
    @javascript
    Scenario: Non-exisitng user's name is not suggested on the welcome page
      Given user "TestUserWhoDoesn'tExist" does not exist
      And I am on the welcome page
      When I fill in "username" with "t"
      Then I should not see "TestUserWhoDoesn'tExist"
