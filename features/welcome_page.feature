Feature: Welcome Page

    Scenario: Redirect new user to welcome page
        Given I am not logged in
        When I go to the home page
        Then I should be on the welcome page
    