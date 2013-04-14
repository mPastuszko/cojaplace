Feature: Today's order payer
  As an order participant
  I want to select payer for today's order
  In order to store this information for the future

  Background:
    Given user "Mikołaj" exists
    And user "Daniel" exists
    And I am logged in as "Mikołaj"
    And restaurant "Phuong Dong" has been selected for today
  
  Scenario: Payer has not been selected yet for today
    Given nobody has chosen payer yet for today
    When I go to the home page
    Then payer should not be selected
  
  Scenario: Payer has been selected already for today
    Given payer "Daniel" has already been selected for today
    When I go to the home page
    Then payer "Daniel" should be selected
  
  Scenario: User selects payer for today
    Given I am on the home page
    When I select "Daniel" as a payer
    And I press "Zapisz zamówienie"
    Then I should be on the home page
    And payer "Daniel" should be selected
