from unittest.mock import MagicMock, patch, call

import requests
from user_data_generator import (
    get_dummy_admin,
    get_dummy_members,
    get_dummy_member,
    get_dummy_applicant,
    get_dummy_application,
    create_application,
    create_applicant,
    create_member,
    create_members,
    get_member_accounts,
    create_admin,
)
import user_data_generator

applicationTypes = [
    "CHECKING",
    "SAVINGS",
    "CHECKING_AND_SAVINGS",
]


@patch("user_data_generator.fake")
def test_get_dummy_admin(mock_fake):
    """
    Test the get_dummy_admin function.
    """
    # Set up mock values for Faker
    mock_fake.user_name.return_value = "test_username"
    mock_fake.first_name.return_value = "Test"
    mock_fake.last_name.return_value = "Admin"
    mock_fake.email.return_value = "test@example.com"
    mock_fake.numerify.return_value = "123-456-7890"

    # Call the function
    admin_data = get_dummy_admin()

    # Assertions
    assert admin_data == {
        "username": "test_username",
        "password": "Password123!",
        "role": "admin",
        "firstName": "Test",
        "lastName": "Admin",
        "email": "test@example.com",
        "phone": "123-456-7890",
    }


@patch("user_data_generator.create_application")
def test_get_dummy_members(mock_create_application):
    """
    Test the get_dummy_members function.
    """
    # Mock the create_application function to return sample application data
    mock_create_application.return_value = {
        "applicants": [
            {
                "firstName": "John",
                "lastName": "Doe",
                "socialSecurity": "123-45-6789",
            },
            {
                "firstName": "Jane",
                "lastName": "Smith",
                "socialSecurity": "987-65-4321",
            },
        ],
        "createdMembers": [
            {"membershipId": "member_1"},
            {"membershipId": "member_2"},
        ],
    }

    # Call the function
    dummy_members = get_dummy_members()

    # Assertions
    assert dummy_members == [
        {
            "username": "JohnDoe",
            "password": "Password123!",
            "role": "member",
            "lastFourOfSSN": "6789",
            "membershipId": "member_1",
        },
        {
            "username": "JaneSmith",
            "password": "Password123!",
            "role": "member",
            "lastFourOfSSN": "4321",
            "membershipId": "member_2",
        },
    ]


@patch("user_data_generator.create_application")
def test_get_dummy_member(mock_create_application):
    """
    Test the get_dummy_member function.
    """
    # Mock the create_application function to return sample application data
    mock_create_application.return_value = {
        "applicants": [
            {
                "firstName": "John",
                "lastName": "Doe",
                "socialSecurity": "123-45-6789",
            }
        ],
        "createdMembers": [
            {"membershipId": "member_1"},
        ],
    }

    # Call the function
    dummy_member = get_dummy_member()

    # Assertions
    assert dummy_member == {
        "username": "JohnDoe",
        "password": "Password123!",
        "role": "member",
        "lastFourOfSSN": "6789",
        "membershipId": "member_1",
    }


def test_get_dummy_applicant():
    """
    Test the get_dummy_applicant function.
    """
    # Define the expected keys in the generated dummy applicant data
    expected_keys = [
        "firstName",
        "middleName",
        "lastName",
        "dateOfBirth",
        "gender",
        "email",
        "phone",
        "socialSecurity",
        "driversLicense",
        "income",
        "address",
        "city",
        "state",
        "zipcode",
        "mailingAddress",
        "mailingCity",
        "mailingState",
        "mailingZipcode",
    ]

    # Call the function
    dummy_applicant = get_dummy_applicant()

    # Assertions
    assert isinstance(dummy_applicant, dict)
    for key in expected_keys:
        assert key in dummy_applicant


def test_get_dummy_application():
    """
    Test the get_dummy_application function.
    """
    # Define the list of applicant data for the test
    applicants = [
        {"firstName": "John", "lastName": "Doe", "socialSecurity": "123-45-6789"},
        {"firstName": "Jane", "lastName": "Doe", "socialSecurity": "987-65-4321"},
    ]

    # Call the function
    dummy_application = get_dummy_application(applicants)

    # Assertions
    assert isinstance(dummy_application, dict)
    assert "applicationType" in dummy_application
    assert dummy_application["applicationType"] in applicationTypes
    assert "applicants" in dummy_application
    assert dummy_application["applicants"] == applicants


@patch("user_data_generator.api_post")
@patch("user_data_generator.get_dummy_applicant")
def test_create_applicant(mock_get_dummy_applicant, mock_api_post):
    """
    Test the create_applicant function.
    """
    # Define the expected applicant data and response from the API
    expected_applicant_data = {
        "firstName": "John",
        "lastName": "Doe",
        "email": "john.doe@example.com",
        # Add other fields as needed
    }
    expected_response = {"id": "test_applicant_id"}

    # Mock the response from api_post
    mock_api_post.return_value.json.return_value = expected_response
    mock_api_post.return_value.status_code = 200

    # Mock the get_dummy_applicant function
    mock_get_dummy_applicant.return_value = expected_applicant_data

    # Call the function
    create_applicant()

    # Assertions
    mock_get_dummy_applicant.assert_called_once()
    mock_api_post.assert_called_once_with("applicants", expected_applicant_data)


@patch("user_data_generator.api_post")
@patch("user_data_generator.get_dummy_applicant")
@patch("user_data_generator.get_dummy_application")
def test_create_application(
    mock_get_dummy_application, mock_get_dummy_applicant, mock_api_post
):
    """
    Test the create_application function.
    """
    # Define the expected applicant data and application data
    expected_applicant_data = {
        "firstName": "John",
        "lastName": "Doe",
        "email": "john.doe@example.com",
        # Add other fields as needed
    }
    expected_application_data = {
        "applicationType": "application_type",
        "applicants": [expected_applicant_data],
    }

    # Mock the response from api_post
    mock_api_post.return_value.json.return_value = {"id": "test_application_id"}
    mock_api_post.return_value.status_code = 200

    # Mock the get_dummy_applicant and get_dummy_application functions
    mock_get_dummy_applicant.return_value = expected_applicant_data
    mock_get_dummy_application.return_value = expected_application_data

    # Call the function
    create_application()

    # Assertions
    mock_get_dummy_applicant.assert_called_once()
    mock_get_dummy_application.assert_called_once_with([expected_applicant_data])
    mock_api_post.assert_called_once_with("applications", expected_application_data)
    assert mock_api_post.return_value.json() == {"id": "test_application_id"}


@patch("user_data_generator.get_dummy_admin")
@patch("user_data_generator.api_post")
def test_create_admin(mock_api_post, mock_get_dummy_admin):
    """
    Test the create_admin function.
    """
    # Define the expected admin data and response from the API
    expected_admin_data = get_dummy_admin()
    expected_response = {"id": "test_admin_id"}

    # Mock the response from api_post
    mock_api_post.return_value.json.return_value = expected_response
    mock_api_post.return_value.status_code = 200

    # Mock get_dummy_admin
    mock_get_dummy_admin.return_value = expected_admin_data

    # Call the function
    create_admin()

    # Assertions
    mock_get_dummy_admin.assert_called_once()  # Ensure get_dummy_admin is called
    mock_api_post.assert_called_once_with("users/registration", expected_admin_data)


@patch("user_data_generator.api_post")
@patch("user_data_generator.get_dummy_members")
@patch("user_data_generator.create_application")
def test_create_members(mock_create_application, mock_get_dummy_members, mock_api_post):
    """
    Test the create_members function.
    """
    # Define mock data
    member_data_list = [{"username": "user1"}, {"username": "user2"}]
    expected_responses = [{"id": "test_member_id_1"}, {"id": "test_member_id_2"}]

    # Mock create_application
    mock_create_application.return_value = member_data_list

    # Mock get_dummy_members
    mock_get_dummy_members.return_value = member_data_list

    # Mock api_post
    mock_api_post.side_effect = expected_responses

    # Call the function
    responses = create_members()

    # Assertions
    assert responses == expected_responses  # Ensure correct responses are returned
    mock_create_application.assert_called_once()  # Ensure create_application is called when member_data_list is None
    mock_get_dummy_members.assert_called_once_with(
        member_data_list
    )  # Ensure get_dummy_members is called
    mock_api_post.assert_has_calls(
        [call("users/registration", member) for member in member_data_list]
    )  # Ensure api_post is called with correct data


@patch("user_data_generator.create_application")
@patch("user_data_generator.get_dummy_member")
@patch("user_data_generator.api_post")
def test_create_member(mock_api_post, mock_get_dummy_member, mock_create_application):
    """
    Test the create_member function.

    This test function mocks the create_application, get_dummy_member, and api_post functions to test the create_member function.

    Parameters:
        mock_api_post (MagicMock): A mock object for the api_post function.
        mock_get_dummy_member (MagicMock): A mock object for the get_dummy_member function.
        mock_create_application (MagicMock): A mock object for the create_application function.

    Returns:
        None

    Side Effects:
        - Calls the create_member function.
        - Asserts that the create_application function is called once.
        - Asserts that the get_dummy_member function is called once with the return value of create_application.
        - Asserts that the api_post function is called once with the expected member data.

    Notes:
        - The test function uses the patch decorator to mock the create_application, get_dummy_member, and api_post functions.
        - The mock_api_post object is configured to return a MagicMock object with a json method that returns the expected response.
        - The mock_get_dummy_member object is configured to return the expected member data.
        - The create_member function is called without any arguments.
        - The test function asserts that the create_application function is called once.
        - The test function asserts that the get_dummy_member function is called once with the return value of create_application.
        - The test function asserts that the api_post function is called once with the expected member data.
        - The test function does not return any value.

    """
    # Mock data
    expected_member_data = {
        "username": "test_user",
        "password": "Password123!",
        "email": "test@example.com",
        "phone": "123-456-7890",
        "address": "123 Main St",
    }
    expected_response = {"id": "test_member_id"}

    # Configure mock objects
    mock_get_dummy_member.return_value = expected_member_data
    mock_api_post.return_value.json.return_value = expected_response

    # Call the function
    create_member()

    # Assertions
    mock_create_application.assert_called_once()  # Ensure create_application is called
    mock_get_dummy_member.assert_called_once_with(mock_create_application.return_value)
    mock_api_post.assert_called_once_with("users/registration", expected_member_data)

    patch("user_data_generator.get_token")


@patch("user_data_generator.requests.get")
@patch("user_data_generator.get_token")
def test_get_member_accounts_success(mock_get_token, mock_get):
    """
    Test case for the `get_member_accounts` function when the request is successful.

    This test case mocks the `requests.get` and `get_token` functions to simulate a successful request. It verifies that the `get_member_accounts` function returns the expected response when called with a valid member ID.

    Parameters:
    - `mock_get_token`: A mock object for the `get_token` function.
    - `mock_get`: A mock object for the `requests.get` function.

    Returns:
    - None

    Raises:
    - AssertionError: If the function does not return the expected response.
    """
    # Mock data
    member_id = "test_member_id"
    expected_response = {"accounts": [{"accountNumber": "123456789", "balance": 1000}]}

    # Configure mock objects
    mock_response = MagicMock()
    mock_response.json.return_value = expected_response
    mock_get.return_value = mock_response
    mock_get_token.return_value = "test_token"

    # Call the function
    result = get_member_accounts(member_id)

    # Assertions
    mock_get.assert_called_once_with(
        f"http://localhost:8080/api/members/{member_id}/accounts",
        headers={"Authorization": "test_token"},
        timeout=30,
    )
    assert result == expected_response


@patch("user_data_generator.requests.get")
@patch("user_data_generator.get_token")
def test_get_member_accounts_failure(mock_get_token, mock_requests_get):
    """
    Test case for the `get_member_accounts` function when there is a connection error.

    This test case mocks the `requests.get` and `get_token` functions to simulate a connection error. It verifies that the `get_member_accounts` function returns `None` when a connection error occurs.

    Parameters:
    - `mock_get_token`: A mock object for the `get_token` function.
    - `mock_requests_get`: A mock object for the `requests.get` function.

    Returns:
    - None

    Raises:
    - AssertionError: If the function does not return `None` on error.
    """
    # Mock data
    member_id = "test_member_id"
    expected_error_message = "Connection error occurred"

    # Configure mock objects
    mock_get_token.return_value = "test_token"
    mock_requests_get.side_effect = requests.RequestException(expected_error_message)

    # Call the function
    result = get_member_accounts(member_id)

    # Assertions
    assert result is None  # Ensure the function returns None on error
    mock_requests_get.assert_called_once_with(
        f"http://localhost:8080/api/members/{member_id}/accounts",
        headers={"Authorization": "test_token"},
        timeout=30,
    )


@patch("user_data_generator.requests.get")
@patch("user_data_generator.get_token")
def test_get_member_by_id_success(mock_get_token, mock_requests_get):
    """
    A test function for getting a member by ID successfully using mock data.
    """
    # Mock data
    member_id = "test_member_id"
    expected_response = {
        "id": member_id,
        "name": "John Doe",
        "email": "john.doe@example.com",
    }

    # Configure mock objects
    mock_get_token.return_value = "test_token"
    mock_response = mock_requests_get.return_value
    mock_response.json.return_value = expected_response

    # Call the function
    result = user_data_generator.get_member_by_id(member_id)

    # Assertions
    assert (
        result == expected_response
    )  # Ensure the function returns the expected response
    mock_requests_get.assert_called_once_with(
        f"http://localhost:8080/api/users/{member_id}",
        headers={"Authorization": "test_token"},
        timeout=30,
    )
