Feature: Use of table id to get data

  Scenario Outline: Get Request usin id- <names>
    Given url 'https://api.agify.io/'
    And param name = names
    When method GET
    Then status 200

    Examples: 
      | names  |
      | jean |
      | meel |
      | virgo |

 Scenario Outline: Get Request usin name- <names>
    Given url 'https://api.agify.io/'
    And param name = names
    When method GET
    Then status 200

    Examples: 
      |read('classpath:Utilities/names.csv')|
      