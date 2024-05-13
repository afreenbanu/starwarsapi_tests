# swapi_test
Repository contains files needed to test the Star Wars API. The service endpoint is https://swapi.dev/api/

# Implementation:
Test Suite is implemented in python using [Robotframework](https://robotframework.org/) and python requests are used to test the service endpoint. Test Cases are written in BDD format using Gherkin style. 

# Requirements:
1. Python v3.10+
2. pip

# Installation for Mac and Linux:
1. From root of this repository, run the following command:
     > pip install -r requirements.txt
2. To confirm installation, run below command. Result should include, requests, robotframework, robotframework-requests
     > pip list
  
# How to run tests:
1. Make sure Star Wars API service is up and running.
2. From root of this repository, run below command:
   > robot -d TestResults TestSuite
3. TestResults are saved into TestResults directory. Following files are available for report parsing.Failed tests have the bug id tagged for reference. 
   - log.html
   - report.html
   - output.xml

