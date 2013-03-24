Feature: Today's order dishes
  As an order participant
  I want to select dishes for today's order
  In order to prepare the order to reflect team choices

  Background:
    Given user "Mikołaj" exists
    And user "Daniel" exists
    And I am logged in as "Mikołaj"
    And restaurant "Phuong Dong" exists
    And restaurant "Phuong Dong" has been selected for today

  Scenario: User who haven't selected any dish yet can see an empty item with his name at the end of the list
    Given nobody has selected any dish for "Mikołaj" for today yet
    When I go to the home page
    Then the last dish should be empty
    And the last dish should be for "Mikołaj"

  # Scenario: User selects an existing dish for himself
  #   Given I am on the home page
  #   When I select dish ""

  # @javascript
  # Scenario: Dish name is suggested
    
  #   When I fill in "restaurant" with "p"
  #   Then I should see "Phuong Dong" within "ul.typeahead"
