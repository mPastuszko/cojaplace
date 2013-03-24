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
    Given someone has selected "Kurczak słodko-kwaśny" costing "12.30" for "Daniel" for today
    And nobody has selected any dish for "Mikołaj" for today yet
    When I go to the home page
    Then the last dish should be empty
    And the last dish should be for "Mikołaj"

  Scenario: User selects a dish for himself
    Given I am on the home page
    And nobody has selected any dish for "Mikołaj" for today yet
    When I select "Kurczak chrupiący" costing "13.50" for "Mikołaj" for today
    And I press "Zapisz zamówienie"
    Then I should be on the home page
    And "Kurczak chrupiący" costing "13.50" should be selected for "Mikołaj" for today

  # @javascript
  # Scenario: Dish name is suggested
    
  #   When I fill in "restaurant" with "p"
  #   Then I should see "Phuong Dong" within "ul.typeahead"
