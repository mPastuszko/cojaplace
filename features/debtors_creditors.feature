Feature: Debtors and creditors calculator
  As an order participant
  I want to see who I owe money and who owes me
  In order to control my debits and credits

  Background:
    Given user "Mikołaj" exists
    And user "Daniel" exists
  
  Scenario: User has no creditors
    Given I am logged in as "Mikołaj"
    When I go to the home page
    Then I should have no creditors

  Scenario: User has no debtors
    Given I am logged in as "Mikołaj"
    When I go to the home page
    Then I should have no debtors

  Scenario: User has a debtor
    Given I am logged in as "Mikołaj"
    And restaurant "Phuong Dong" has been selected for today
    And I am on the home page
    When I select "Kurczak chrupiący" costing "13.50" for "Daniel" for today
    And I select "Mikołaj" as a payer
    And I set payment to "13.50"
    And I press "Zapisz zamówienie"
    Then I should have no creditors
    And "Daniel" should be my debtor for "13.50"
    When I am logged in as "Daniel"
    Then "Mikołaj" should be my creditor for "13.50"
    And I should have no debtors

  @javascript
  Scenario: User pays back his debt
    Given I am logged in as "Mikołaj"
    And restaurant "Phuong Dong" has been selected for today
    And I am on the home page
    When I select "Kurczak chrupiący" costing "13.50" for "Daniel" for today
    And I select "Mikołaj" as a payer
    And I set payment to "13.50"
    And I press "Zapisz zamówienie"
    And I hover debtor "Daniel"
    And I click "Oddał..." by debtor "Daniel"
    And I press "Zapisz" within "#paybackModal"
    Then I should have no debtors
  