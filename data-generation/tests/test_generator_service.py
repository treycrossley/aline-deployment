import pytest
from unittest.mock import MagicMock, patch
from generator_service import (
    get_token,
    api_post,
    print_request,
    print_response,
)


@patch("generator_service.requests.post")
def test_get_token(mock_requests_post):
    # Configure the mock response object
    mock_response = MagicMock()
    mock_response.status_code = 200
    mock_response.headers = {"Authorization": "test_token"}
    mock_requests_post.return_value = mock_response

    # Call the get_token function
    token = get_token()

    # Assertions
    assert token == "test_token"
    mock_requests_post.assert_called_once()


@patch("generator_service.get_token", return_value="test_token")
@patch("generator_service.requests.post")
@patch("generator_service.print_request")
@patch("generator_service.print_response")
def test_api_post(
    mock_print_response, mock_print_request, mock_requests_post, mock_get_token
):
    endpoint = "example_endpoint"
    data = {"key": "value"}

    # Configure the mock response object
    mock_response = MagicMock()
    mock_response.status_code = 200
    mock_response.json.return_value = {"message": "Success"}
    mock_requests_post.return_value = mock_response

    # Call the api_post function
    response = api_post(endpoint, data)

    # Assertions
    assert response == {"message": "Success"}
    mock_print_request.assert_called_once_with(
        "http://localhost:8080/api/example_endpoint", data
    )
    mock_print_response.assert_called_once_with(mock_response)
    mock_get_token.assert_called_once()
    mock_requests_post.assert_called_once_with(
        "http://localhost:8080/api/example_endpoint",
        json=data,
        headers={"Authorization": "test_token"},
        timeout=30,
    )


def test_print_request():
    # Create a MagicMock object for the url and data
    mock_url = "http://example.com/api"
    mock_data = {"key": "value"}

    # Call the print_request function
    print_request(mock_url, mock_data)

    # Assertions
    assert mock_url == "http://example.com/api"
    assert mock_data == {"key": "value"}


def test_print_response():
    # Create a MagicMock object for the response object
    mock_response = MagicMock()
    mock_response.status_code = 200
    mock_response.json.return_value = {"message": "Success"}

    # Call the print_response function
    print_response(mock_response)

    # Assertions
    assert mock_response.status_code == 200
    assert mock_response.json.called
    assert mock_response.json.return_value == {"message": "Success"}
