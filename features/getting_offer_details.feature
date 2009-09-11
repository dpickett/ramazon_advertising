Feature: Retrieving offer details
  As a user of the Ramazon_advertising api
  I want to get offer details
  In order to get pricing information about a given product

  Background:
    Given I have a valid access key
    And I have a valid secret key

  Scenario: Getting offers on a DVD
    Given I am searching with the "item_id" of "B000NTPDSW"
    And I am searching with the "response_group" of "Medium,Offers"
    And I am searching with the "merchant_id" of "All"
    When I perform the product search
    Then I should get a product
    And the product should have "offers"
    And each of the product's "offers" should have a "price"
    And each of the product's "offers" should have a "condition"
    And each of the product's "offers" should have a "sub_condition"
