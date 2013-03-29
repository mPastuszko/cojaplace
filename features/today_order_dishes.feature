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

  Scenario: User saves order without selecting anything
    Given I am on the home page
    And nobody has selected any dish for today yet
    When I press "Zapisz zamówienie"
    Then I should be on the home page
    And there should be 1 dish on the list
    And the last dish should be empty
    And the last dish should be for "Mikołaj"

  @javascript
  Scenario: User removes an order item
    Given someone has selected "Kurczak słodko-kwaśny" costing "12.30" for "Daniel" for today
    When I go to the home page
    And I click "Usuń" at the dish for "Daniel"
    And I press "Zapisz zamówienie"
    Then I should be on the home page
    And there should be 1 dish on the list
    And the last dish should be empty

  @javascript
  Scenario: User adds an additional order item
    Given someone has selected "Kurczak słodko-kwaśny" costing "12.30" for "Mikołaj" for today
    When I go to the home page
    And I click "Dopisz kolejną osobę"
    Then there should be 2 dishes on the list
    And the last dish should be empty

  @javascript
  Scenario: Dish name is suggested
    Given restaurant "Phuong Dong" has been selected for yesterday
    And someone has selected "Kurczak słodko-kwaśny" costing "12.30" for "Daniel" for yesterday
    And nobody has selected any dish for today yet
    When I go to the home page
    And I fill in "dish[]" with "k" within ".dishes"
    Then I should see "Kurczak słodko-kwaśny" within "ul.typeahead"
