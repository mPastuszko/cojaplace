Feature: Debtors and creditors calculator
  As an order participant
  I want to see who I owe money and who owes me
  In order to control my debits and credits

  Background:
    Given user "Mikołaj" exists
    And user "Daniel" exists
    And I am logged in as "Mikołaj"
  
  Scenario: User has no creditors
    When I go to the home page
    Then I should have no creditors

  Scenario: User has no debtors
    When I go to the home page
    Then I should have no debtors
