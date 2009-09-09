Feature: Retrieving a product
  As a user of the Ramazon_advertising_api
  I want to get specific information
  In order to leverage the data provided by the api
  
  Background:
    Given I have a valid access key
    And I have a valid secret key

  Scenario: Finding a DVD
    When I try to find the asin "B000NU2CY4"
    Then I should get a product
    And the product should have the "title" "Gladiator [Blu-ray]"
    And the product should have a "manufacturer"
    And the product should have a "product_group"
    And the product should have a "sales_rank"
    And the product should have a "large_image"
    And the product should have a "list_price"
    And the product should have a "upc"
    And the product should have a "lowest_new_price"
    And the product should have a "new_count"
    And the product should have a "used_count"
  
  Scenario: Finding a Video Game with a deep category tree
    When I try to find the asin "B001COQW14"
    Then I should get a product
    And the product should have a category tree for "Categories"

  Scenario: Finding a Movie with a Genre tree
    When I try to find the asin "B002CMLIJ6"
    Then I should get a product
    And the product should have a category tree for "Genres"
