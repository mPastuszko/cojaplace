Feature: Today's order restaurant
  As an order participant
  I want to select restaurant for today's order
  In order to prepare the order to reflect team choices

  Background:
    Given user "Mikołaj" exists
    And restaurant "Phuong Dong" exists
    And I am logged in as "Mikołaj"
  
  @javascript
  Scenario: Restaurant has not been selected yet for today
    Given nobody has chosen restaurant yet for today
    When I go to the home page
    Then restaurant should not be selected
    And all fields within ".dishes" should be disabled
    And all fields within ".payer" should be disabled
    And "Zapisz zamówienie" button should be disabled
  
  Scenario: Restaurant has been selected already for today
    Given restaurant "Phuong Dong" has already been selected for today
    When I go to the home page
    Then restaurant "Phuong Dong" should be selected
  
  Scenario: User selects an existing restaurant
    Given I am on the home page
    When I fill in "restaurant" with "Phuong Dong"
    And I press "Zapisz zamówienie"
    Then I should be on the home page
    And restaurant "Phuong Dong" should be selected
  
  Scenario: User adds a new restaurant
    Given restaurant "Maraton" does not exist
    And I am on the home page
    When I fill in "restaurant" with "Maraton"
    # At least one dish has to be selected in order to remember restaurant
    And I select "Kurczak chrupiący" costing "13.50" for "Mikołaj" for today
    And I press "Zapisz zamówienie"
    Then I should be on the home page
    And restaurant "Maraton" should be selected
    And restaurant "Maraton" should exist

  @javascript
  Scenario: Restaurant name is suggested
    Given I am on the home page
    When I fill in "restaurant" with "p"
    Then I should see "Phuong Dong" within "ul.typeahead"
