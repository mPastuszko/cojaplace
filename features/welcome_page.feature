Feature: Welcome Page

    Scenario: Redirect new user to welcome page
        Given I am not logged in
        When I go to the home page
        Then I should be on the welcome page
    
    Scenario: User leaves name field blank
        Given I am not logged in
        And I am on the welcome page
        When I press "No już, dalej!"
        Then I should be on the welcome page
        And I should see error message