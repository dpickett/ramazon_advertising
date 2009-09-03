Feature: Retrieving a product
  As a user of the Ramazon_advertising_api
  I want to get specific information
  In order to leverage the data provided by the api
  
  Background:
    Given I have a valid access key
    And I have a valid secret key

    When I try to find the asin "B000NU2CY4"
    Then I should get a product
    And the product should have the "name" "Gladiator [Blu-ray]"
    And the product should have a "price"

  
