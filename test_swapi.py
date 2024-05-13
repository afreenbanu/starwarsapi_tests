import pytest
import requests

base_url = "https://swapi.dev/api/people/"

def get_all_people_request():
    response = requests.get(f'{base_url}')
    return response

def get_people_by_id(id):
    response = requests.get(f'{base_url}{id}')
    return response

def get_people_by_name(name):
    response = requests.get(f'{base_url}?search={name}')
    return response

def get_people_by_pages(page_no):
    response = requests.get(f'{base_url}?page={page_no}')
    return response

def test_valid_request_get_all_people():
    response = get_all_people_request()

    # Status code assertion:
    assert response.status_code == 200  # Validation of status code
    data = response.json()
    # Assertion of body response content:
    # checking there are 10 people results per response.
    assert len(data['results']) == 10

    # checking total count of people returned
    assert data['count'] == 82

@pytest.mark.parametrize("people_id,name,dob,gender,total_films,url_id",
                         [(1, 'Luke Skywalker', '19BBY', 'male', 4, 1),
                          (5, 'Leia Organa', '19BBY', 'female', 4, 5)
                            ]
                         )
def test_valid_people_id(people_id, name, dob, gender, total_films, url_id):
    response = get_people_by_id(people_id)

    assert response.status_code == 200
    data = response.json()

    # assert name, dob, gender, total films and url_id is correct for every people id.
    assert data['name'] == name
    assert data['birth_year'] == dob
    assert data['gender'] == gender
    assert len(data['films']) == total_films
    assert data['url'] == f'{base_url}{url_id}/'

def test_invalid_people_id():
    response = get_people_by_id(1000)

    assert response.status_code == 404
    data = response.json()
    assert data['detail'] == 'Not found'

def test_get_people_by_name():
    response = get_people_by_name('Skywalker')

    assert response.status_code == 200
    data = response.json()

    assert data['count'] == 3
    assert len(data['results']) == 3

    # asserting that results list contains only people whose name contains 'search by name' sent in the request.
    for result in data['results']:
        assert 'Skywalker' in result['name']

def test_get_people_by_mismatched_name():
    response = get_people_by_name('no name')
    assert response.status_code == 200
    data = response.json()

    assert data['count'] == 0
    assert len(data['results']) == 0

def test_get_people_pagination():
    response = get_people_by_pages(4)

    assert response.status_code == 200
    data = response.json()
    assert data['previous'] == f'{base_url}?page=3'
    assert data['next'] == f'{base_url}?page=5'

def test_get_people_pagination_boundaries():
    # this test has hardcoded page numbers. I would refactor this by getting response['count'], divide by 10 since
    # there are 10 results per page. This gives the max page count. Use that to test the max boundary condition.

    response = get_people_by_pages(1)
    data = response.json()

    # assert for search by page number = 1, previous page url is None and next is 2
    assert data['previous'] == None
    assert data['next'] == f'{base_url}?page=2'

    response = get_people_by_pages(9)
    data = response.json()

    # assert for search by page number = 9, previous page url is 8 and next is None
    assert data['previous'] == f'{base_url}?page=8'
    assert data['next'] == None

