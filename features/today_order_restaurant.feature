Feature: Today's order
  As an order participant
  I want to select restaurant for today's order
  In order to prepare the order to reflect team choices

  Background:
    Given user "Mikołaj" exists
    And restaurant "Phuong Dong" exists
    And I am logged in as "Mikołaj"
    And I am on the home page
  
  Scenario: Restaurant has not been selected yet for today
    When nobody has chosen restaurant yet for today
    Then restaurant should not be selected
  
  Scenario: Restaurant has been selected already for today
    When restaurant "Phuong Dong" has already been selected for today
    Then restaurant "Phuong Dong" should be selected
  
  Scenario: User selects an existing restaurant
    When I fill in "restaurant" with "Phuong Dong"
    And I press "Zapisz zamówienie"
    Then restaurant "Phuong Dong" should be selected
  
  Scenario: User adds a new restaurant
    Given restaurant "Maraton" does not exist
    When I fill in "restaurant" with "Maraton"
    And I press "Zapisz zamówienie"
    Then restaurant "Maraton" should be selected
    And restaurant "Maraton" should exist

  @javascript
  Scenario: Restaurant name is suggested
    When I fill in "restaurant" with "p"
    Then I should see "Phuong Dong" within "input[name=restaurant] ul.typeahead"
