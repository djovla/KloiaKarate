Feature: Post information in the database

#Scenario: Post request_1
 #* def users = { name:'Victoria',salary:'5000',age:'5'}
 #Given url 'http://dummy.restapiexample.com/api/v1/create'
 #And request users
 #When method POST
 #Then status 200
 
 Scenario: Post request_2
 * def user = { email: "eve.holt@reqres.in",password: "pistol"}
 Given url 'https://reqres.in/api/register'
 And request user
 When method POST
 Then status 200

