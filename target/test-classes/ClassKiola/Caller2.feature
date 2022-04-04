@debug
Feature: Feature That Invoke the Caller Feature

Background:
* def baseURL = 'https://reqres.in'
* def req = '/api/users/'


Scenario Outline: Put request that get info from the GET request Caller Name = <names>
Given url baseURL
And def getFeature = call read('classpath:ClassKiola/Caller.feature'){id: <values>}
And getFeature.response.data.last_name = names
And request getFeature.response
And path req
When method PUT
Then status 200
And print 'After put', response

Examples:
|values|names|
|4     |Virgo|
|3     |Joseph|
