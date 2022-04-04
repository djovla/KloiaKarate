Feature: Delete Request

Scenario: delete request
Given url 'https://reqres.in/api/'
And path 'users',2
And method DELETE
Then status 204