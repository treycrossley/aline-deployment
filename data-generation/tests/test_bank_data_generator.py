from unittest.mock import patch
from bank_data_generator import (
    get_dummy_bank,
    create_bank,
    get_dummy_branch,
    create_branch,
)


def test_get_dummy_bank():
    """
    Test the get_dummy_bank function.

    Ensures that the function returns a dictionary with the expected keys.
    """
    # Call the get_dummy_bank function
    bank_data = get_dummy_bank()

    # Assertions
    assert isinstance(bank_data, dict)
    assert "routingNumber" in bank_data
    assert "address" in bank_data
    assert "city" in bank_data
    assert "state" in bank_data
    assert "zipcode" in bank_data


@patch("bank_data_generator.get_dummy_bank")
@patch("bank_data_generator.api_post")
def test_create_bank(mock_api_post, mock_get_dummy_bank):
    """
    Test the create_bank function.

    Ensures that the function calls api_post with the correct bank data and
    returns the expected response from the API.
    """
    # Define the expected bank data
    expected_bank_data = {
        "routingNumber": "123456789",
        "address": "123 Main St",
        "city": "Anytown",
        "state": "CA",
        "zipcode": "12345",
    }

    # Define the expected response from the API
    expected_response = {"id": "test_bank_id"}

    # Mock the response from api_post
    mock_api_post.return_value.json.return_value = expected_response
    mock_api_post.return_value.status_code = 200

    # Mock the get_dummy_bank function
    mock_get_dummy_bank.return_value = expected_bank_data

    # Call the create_bank function
    create_bank()

    # Get the JSON response from the mock
    response = mock_api_post.return_value.json()

    # Assertions
    assert response == expected_response
    mock_api_post.assert_called_once_with("banks", expected_bank_data)
    mock_api_post.assert_called_once()  # Ensure api_post is called exactly once


def test_get_dummy_branch():
    """
    Test the get_dummy_branch function.

    Ensures that the function returns a dictionary with the expected keys and values.
    """
    # Define the bank ID for the branch
    bank_id = "test_bank_id"

    # Call the get_dummy_branch function
    branch_data = get_dummy_branch(bank_id)

    # Assertions
    assert isinstance(branch_data, dict)
    assert "name" in branch_data
    assert "address" in branch_data
    assert "city" in branch_data
    assert "state" in branch_data
    assert "zipcode" in branch_data
    assert "phone" in branch_data
    assert "bankID" in branch_data
    assert branch_data["bankID"] == bank_id


@patch("bank_data_generator.get_dummy_branch")
@patch("bank_data_generator.create_bank")
@patch("bank_data_generator.api_post")
def test_create_branch(mock_api_post, mock_create_bank, mock_get_dummy_branch):
    """
    Test the create_branch function.

    Ensures that the function calls api_post with the correct branch data and
    returns the expected response from the API.
    """
    # Define the bank ID and expected branch data
    bank_id = "test_bank_id"
    expected_branch_data = {
        "name": "Test Branch",
        "address": "456 Oak St",
        "city": "Smallville",
        "state": "NY",
        "zipcode": "54321",
        "phone": "123-456-7890",
        "bankID": bank_id,
    }

    # Define the expected response from the API
    expected_response = {"id": "test_branch_id"}

    # Mock the response from api_post
    mock_api_post.return_value.json.return_value = expected_response
    mock_api_post.return_value.status_code = 200

    # Mock the get_dummy_branch function
    mock_get_dummy_branch.return_value = expected_branch_data

    # Mock the create_bank function
    mock_create_bank.return_value = bank_id

    # Call the create_branch function
    create_branch()

    # Get the JSON response from the mock
    response = mock_api_post.return_value.json()

    # Assertions
    assert response == expected_response
    mock_api_post.assert_called_once_with("branches", expected_branch_data)
    mock_api_post.assert_called_once()  # Ensure api_post is called exactly once
