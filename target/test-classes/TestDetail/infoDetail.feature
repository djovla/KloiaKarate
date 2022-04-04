@product
  Feature: Test the products API for LF.

    Background:
      *url GatewayURL

      *def valueSchema =
      """
      {
      "values": '##[]',
      "name": '#string'
      }
      """
      *def availabilityInfoSchema =
      """
      {
      "message": "#string",
      "status": "string",
      "helpMessage": "#string"
      }
      """
      *def salesPriceSchema =
      """
      {
      "amount": "#number? _ > 0",
      "currency":"string? -.length ==3"
      }
      """
      *def monthlyPriceSchema =
      """
      {
      amount": "#number? _ > 0",
      "currency":"string? -.length ==3"
      }
      """
      *def productSchema =
      """
      {
      "apr":"#number",
      "contractType":"#string",
      "salesPrice":"#(salesPriceSchema)",
      "description":"#string",
      "availabilityInfo":"#(availabilityInfoSchema)",
      "monthlyPrice":"#(monthlyPriceSchema)",
      "duration":"#number? _ >= 0",
      "categoryIds":"##[] #string",
      "paymentsToUpgrade":"#number? _ > 0",
      "deepLink":"#string",
      "assetUpl":"#string",
      "overviewList":"##[] #string",
      "availabilityStatus":"#string?_.length >0",
      "title":"#string? _.length >0",
      "productId":"#string?_.length >0",
      "specifications":"##[] valueSchema"
      }
      """

      *def productResponse =
      """
      {
      "offset":'#number? _ >=0',
      "limit": '#number? _ > 0',
      "product":'#(productSchema)',
      "totalRecords": '#number? - > 0'
      }
      """
      *def productRecommendations =
      """
      {
      "appleProducts":"##[]",
      "appleAccessories":"##[] productSchema",
      "appleCareProducts":"##[] productSchema"
      }
      """
      Scenario Outline: test getting all products for a merchant
        *def query ={limit:<limit>,offset:<offset>}
        Given path '/<merchant>/products'
        And params query
        When method GET
        Then status 200
        And def count = (response.products.length)
        And match response.products =='#[] productSchema'
        And match response.limit == query.limit
        And match response.offset == query.offset
        And match count == <productCount>
        And match response.totalRecords == '#number? _ >0'

        Examples:
        |merchant|limit|offset|productCount|
        |jumpplus|1    |0     |1           |
        |jumpplus|10   |10    |10          |
        |Jumpplus|100  |1     |100         |
        |jumpplus|1    |100000|0           |

        Scenario Outline: Test getting all product categories
          Given path '/<merchant>/products/categories/all'
          When method GET
          Then status 200
          And match each response contains {id: '#notnull', name: '#notnull', sortId: '#notnull'}

          Examples:
          |merchant|
          |jumpplus|
          
          Scenario Outline: Test getting products by category
            *def query ={limit: <limit>, offset: <offset>}
          Given path '/<merchant>/categories/<category>/products'
            And params query
            When method GET
            And def count = (response.products.length)
            And match response.products == '#[] productSchema'
            And match response.limit = query.limit
            And match response.offset = query.offset
            And match count == <productionCount>
            And match response.totalRecords == '#number? _ >=0'
            And def titles = $response.products[*].title
            And match each titles contains '<productName>'
            
            Examples: 
            |merchant|limit|offset|productCount|category|productName|
            |jumpplus|1    |0     |1           |jumpplus-isub-ca-iphone_13_pro|Apple iPhone 13 Pro|
            |jumpplus|10   |1     |10          |jumpplus-isub-ca-macbook_pro  |MackBook Pro       |
            |jumpplus|20   |10    |20          |jumpplus-isub-ca-apple_watch  |Apple Watch        |
            |jumpplus|1    |0     |0           |non-existent-product-category |                   |
            
            Scenario Outline: Test getting product data by product Id
              Given path '/<merchant>/products/<productId>'
              When method GET
              Then status 200
              And  match response == '#(productSchema)'
              And match response.productId= '<productId>'
              And match response.title == '#notnull'

              Examples:
              |merchant|productId|
              |jumpplus|jumpplus-isub-ca-20723|
              |jumpplus|jumpplus-isub-ca-21039|

              Scenario Outline: Test the product recommendation API
                Given path '/<merchant>/products/<productId>/recommendations'
                When method Get
                Then status 200
                And match response.appleProducts =='#[] productSchema'
                And match response.appleAccesssories == '#[] productSchema'
                And match response.appleCareProducts =='#[] productSchema'

                Examples:
                  |merchant|productId|
                  |jumpplus|jumpplus-isub-ca-20723|
                  |jumpplus|jumpplus-isub-ca-21039|

                ####################################################
                #####Negative Testing Bellow this line
                ###################################################

  Scenario Outline: Not passing limit or offset int the product request should return error
    *def query = { limit: 12 }
    Given  path '/<merchant>/products'
    And params query
    When method GET
    Then status 400
    And match response.error == <error>

    Examples:
    |merchant|query|error|
    |jumpplus|{ limit: 12 }|'offset cannot be empty'|
    |jumpplus|{ limit: 0 }|'offset cannot be empty'|
    |jumpplus|''|'offset cannot be empty'|


    Scenario Outline: Getting product with incalid product id should return error
      Given  path '/<merchant>/products/badproductId'
      When method GET
      Then status 400
      And match response.error == "Record Not found"

      Examples:
      |merchant|
      |jumpplus|

      Scenario Outline: Getting recommendation for invalid product id should return empty data
        Given  path '/<merchant>/products/badproductId123/recommendations'
        When method GET
        Then status 200
        And match response.appleProducts == '#[0]'
        And match response.appleAccessories == '#[0]'
        And match response.appleCareProducts == '#[0]'

        Examples:
        |merchant|
        |jumpplus|