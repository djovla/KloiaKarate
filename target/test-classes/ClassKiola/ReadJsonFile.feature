Feature: Read File JSON

Scenario: Read JSON model from file
    * def jsonModel = read('classpath:Utilities/modelFile.json')
    * print jsonModel