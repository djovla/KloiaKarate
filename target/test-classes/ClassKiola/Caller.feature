Feature: Feature Caller

Background:
* def baseURL = 'https://reqres.in/'
* def req = '/api/users/'
#* def id = 2

Scenario: Get request first to do the Put request
Given url baseURL
And path req,id
When method GET
Then status 200
And print 'after get', response

#Examples:
#|id|
#|1|

