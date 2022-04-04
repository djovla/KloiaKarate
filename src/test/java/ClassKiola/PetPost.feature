Feature: Post Method using file json

Scenario: Post Request using file
 Given url 'https://petstore.swagger.io/v2'
 And path 'pet'
 And def jsonBody = read('classpath:Utilities/modelFile.json')
 And request jsonBody
 When method POST
 Then status 200
 And print response
 
 Scenario: Test Browser
  Given driver 'https://google.com'
  And driver.fullscreen()
  And input('input[name=q]', 'karate dsl')
  * delay(5000)
  When submit().click('input[name=btnI]')
  Then match driver.url == 'https://github.com/intuit/karate'
  #the folowing is for a new test
  #will be add
 