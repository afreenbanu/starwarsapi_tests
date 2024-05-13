*** Settings ***
Library     RequestsLibrary
Library     Process

*** Variables ***
${swapi_people_url}     https://swapi.dev/api/people/

*** Keywords ***

swapi service is up and running
     ${response}=      GET     ${swapi_people_url}     expected_status=any
     should be equal as strings    ${response.status_code}      200

I send request for people
    [Arguments]     ${id}=${EMPTY}
    ${response}=      GET     ${swapi_people_url}/${id}     expected_status=any
    Set suite variable     ${response}

I send request for people by name
    [Arguments]     ${name}=${EMPTY}
    ${response}=      GET     url=${swapi_people_url}?search=${name}     expected_status=any
    Set suite variable     ${response}

I send request for people by page number
    [Arguments]     ${page_no}=${EMPTY}
    ${response}=      GET     url=${swapi_people_url}?page=${page_no}     expected_status=any
    Set suite variable     ${response}

Service should return valid response code
     [Arguments]     ${expected_response_code}
     should be equal as strings     ${response.status_code}      ${expected_response_code}

Service should return a valid error response
    [Arguments]      ${error_message}
    should be equal as strings     ${response.json()['detail']}     ${error_message}

Service should return correct count of results
    [Arguments]     ${results_per_page}
    ${results_count} =     Get length     ${response.json()['results']}
    should be equal as integers     ${results_count}    ${results_per_page}

total count should be correct
    [Arguments]     ${total_count_people}
    should be equal as integers      ${response.json()['count']}     ${total_count_people}

Service should return correct people information
    [Arguments]     ${name}     ${birth_year}     ${gender}      ${total_films}     ${url_id}
    should be equal as strings     ${response.json()['name']}      ${name}
    should be equal as strings     ${response.json()['birth_year']}      ${birth_year}
    should be equal as strings     ${response.json()['gender']}      ${gender}
    ${actual_film_count} =    Get length    ${response.json()['films']}
    should be equal as strings     ${actual_film_count}      ${total_films}
    should be equal as strings     ${response.json()['url']}      ${swapi_people_url}${url_id}/

Service should return results containing searched name
    [Arguments]     ${name}

    ${results_count} =     Get length     ${response.json()['results']}
    FOR    ${item}    IN RANGE  ${results_count}
        Log     ${response.json()['results'][${item}]['name']}
        should contain     ${response.json()['results'][${item}]['name']}     ${name}
    END

Service should return empty results
    should be empty      ${response.json()['results']}

previous and next page urls be correct
     [Arguments]     ${previous_page}=${EMPTY}     ${next_page}=${EMPTY}

    IF    '${previous_page}'=='${EMPTY}'
        should be equal as strings     ${response.json()['previous']}     None
    ELSE
        should be equal as strings     ${response.json()['previous']}     ${swapi_people_url}?page=${previous_page}
    END

    IF    '${next_page}'=='${EMPTY}'
        should be equal as strings     ${response.json()['next']}     None
    ELSE
        should be equal as strings     ${response.json()['next']}     ${swapi_people_url}?page=${next_page}
    END