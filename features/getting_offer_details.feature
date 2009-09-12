Feature: Retrieving offer details
  As a user of the Ramazon_advertising api
  I want to get offer details
  In order to get pricing information about a given product

  Background:
    Given I have a valid access key
    And I have a valid secret key

  Scenario: Getting offers on a DVD
    Given I am searching with the "item_id" of "B000NTPDSW"
    And I am searching with the "condition" of "Used"
    And I am searching with the "response_group" of "Medium,OfferListings"
    And I am searching with the "merchant_id" of "All"
    When I perform the product search
    Then I should get a product
    And the product should have "offers"
    And each of the product's "offers" should have a "price"
    And each of the product's "offers" should have a "condition"
    And each of the product's "offers" should have a "sub_condition"
    And the product should have "used_offers"
    And each of the product's "used_offers" should have a "condition" of "Used"

  Scenario: Getting offers by subcondition hash
    Given I am searching with the "item_id" of "B000NTPDSW"
    And I am searching with the "response_group" of "Medium,OfferListings"
    When I perform the product search
    Then I should get a product
    And the product should have "offers_by_condition"
    And the product should have "lowest_offers"
