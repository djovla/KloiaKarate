Feature: Sample Feature Definition Hello World

Scenario: Get request
    Given url 'https://www.kloia.com/'
    And path 'blog'
    When method GET
    Then status 200


  Scenario: Hello World
    * print 'Hello World'

  Scenario: Create Variables
    * def firstVar = 12
    * def secondVar = 'cakes'
    * print 'First Variable--> '+firstVar+' Second Variable--> '+secondVar

  Scenario: defining JSON object and print it
    Given def jsonObject =
      """
          [
            {
              "name": "Victoria",
              "age": 5,
              "phone" : 15435667788
              
            },
            {
              "name": "Emmanuel",
              "age": 4,
              "phone" : 13443567234
            }
          ]
      """
    * print jsonObject[1].name, jsonObject[1].age,jsonObject[1].phone

  Scenario: Using the karate-config.js file
    * print baseUrl
    * print myVarName
    