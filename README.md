# swapi_test
Repository contains files needed to test the Star Wars API. The service endpoint is https://swapi.dev/api/

# Option 1 - Implementation using RobotFramework:
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

Sample log html report:
![swapitest_report](https://github.com/afreenbanu/starwarsapi_tests/assets/8961608/f915df39-7d2e-479b-aac8-77e2d0ddb30a)

# Option 2 - Implementation using pytest library to run api tests. Read about pytest here https://docs.pytest.org/en/8.2.x/

# Requirements:
1. Python v3.10+
2. pip
3. pytest

# Installation for Mac and Linux:
1. From root of this repository, run the following command:
     > pip install -r requirements.txt
2. To confirm installation, run below command. Result should include, requests, pytest
     > pip list

# How to run tests:
1. Make sure Star Wars API service is up and running.
2. From root of this repository, run below command:
   > pytest test_swapi.py -v
   
Sample report:

![pytest report](https://github.com/afreenbanu/starwarsapi_tests/assets/8961608/f5ad14c5-4367-4885-86a5-f5746c839d91)
