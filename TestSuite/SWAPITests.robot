*** Settings ***
Documentation      This test suite contains scenarios for validating the swapi service people endpoint.
...                Following use cases are covered:
...                Test people endpoint returns total count of people with 10 results per page.
...                Test people endpoint returns specific people resource per id passed in request.
...                Test people endpoint returns 404 when searched by invalid people id.
...                Test people endpoint returns matching people's resources when searched by name.
...                Test people endpoint returns empty results when searched by missing name from star wars family.


Resource     ../Resources/SWAPIKeywords.robot

*** Test Cases ***

1. Verify swapi /people service returns total count of people and 10 results per page
	[tags]     test1
	[Documentation]    Valid request and response assertion
	Given swapi service is up and running
	When I send request for people     ${EMPTY}
	Then Service should return valid response code     200
	AND Service should return correct count of results     10
	AND total count should be correct      82

2. Verify swapi /people service returns specific people's details when an id is passed in request
	[tags]     test1
	[Documentation]    Valid people id and response assertion
    Given swapi service is up and running
	When I send request for people      1
	Then Service should return valid response code     200
	AND Service should return correct people information     Luke Skywalker    19BBY     male      4     1

3. Verify swapi /people endpoint returns 404 when searched by invalid people id
    [tags]     test1
    [Documentation]    Invalid people id and response assertion
	Given swapi service is up and running
	When I send request for people     1000
	Then Service should return valid response code     404
	AND Service should return a valid error response    Not found

4. Verify swapi /people service returns matching people's resources when searched by name
    [tags]      test1
    [Documentation]    Search by valid people name and response assertion
    Given swapi service is up and running
	When I send request for people by name      Skywalker
	Then Service should return valid response code     200
	AND total count should be correct      3
	AND Service should return results containing searched name     Skywalker

5. Verify swapi /people service returns no matching people when searched by invalid name
    [tags]      test1
    [Documentation]     Search by invalid request and response assertion
    Given swapi service is up and running
	When I send request for people by name      no name
	Then Service should return valid response code     200
	AND total count should be correct      0
    AND Service should return empty results

6. Verify swapi /people service returns correct pagination urls
    [tags]      test1
    Given swapi service is up and running
	When I send request for people by page number      4
	Then Service should return valid response code     200
	AND previous and next page urls be correct      3      5

7. Verify swapi /people service pagination boundaries
    [tags]      test
    Given swapi service is up and running
	When I send request for people by page number      1
	Then Service should return valid response code     200
	AND previous and next page urls be correct      ${EMPTY}      2

	When I send request for people by page number      9
	Then Service should return valid response code     200
	AND previous and next page urls be correct      8     ${EMPTY}

