Feature: Today's order payment
  As an order participant
  I want to enter payment info for today's order
  In order to store this information for the future

  Background:
    Given user "Mikołaj" exists
    And user "Daniel" exists
    And I am logged in as "Mikołaj"
    And restaurant "Phuong Dong" has been selected for today
  
  Scenario: Payer and payment has not been specified yet for today
    Given nobody has chosen payer yet for today
    When I go to the home page
    Then payer should not be selected
    And payment should not be set
  
  Scenario: Payer and payment has been specified already for today
    Given "Daniel" paid "50.00" for today
    When I go to the home page
    Then payer "Daniel" should be selected
    And payment should be set to "50.00"
  
  Scenario: User selects payer and payment for today
    Given I am on the home page
    When I select "Daniel" as a payer
    And I set payment to "50.99"
    And I press "Zapisz zamówienie"
    Then I should be on the home page
    And payer "Daniel" should be selected
    And payment should be set to "50.99"
