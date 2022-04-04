#sample to implement PUT to update database
Feature: Update information using the put method

Scenario: Put Request
* def user = { name: "Virgo",job: "QA Engineer"}
 Given url 'https://reqres.in/api/'
 And path 'users',2
 And request user
 When method PUT
 Then status 200
 And print response