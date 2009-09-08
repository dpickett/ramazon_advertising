Feature: Search for products
  As a user of the Ramazon_advertising api
  I want to perform a search
  In order to find products my customers will want to purchase

  Background:
    Given I have a valid access key
    And I have a valid secret key

    When I try to search for the "search_index" of "DVD"
    Then I should get a list of products
    And each product should have the "product_group" "DVD"
