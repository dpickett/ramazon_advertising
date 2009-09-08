Feature: Search for products
  As a user of the Ramazon_advertising api
  I want to perform a search
  In order to find products my customers will want to purchase

  Background:
    Given I have a valid access key
    And I have a valid secret key

    Given I am searching with the "search_index" of "DVD"
    And I am searching with the "browse_node" of "130"
    When I perform the product search
    Then I should get a list of products
    And each product should have the "product_group" "DVD"
