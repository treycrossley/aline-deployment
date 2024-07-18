"""
Module for handling API requests and authentication.

Functions:
- get_token: Get authentication token for the admin user.
- api_post: Make a POST request to the API with authentication token.
- print_request: Print information about the POST request being sent.
- print_response: Print information about the response received from the POST request.
"""

import requests

API_URL = (
    "http://ab2cb913942f048788e4a60571b7b388-445415390.us-east-1.elb.amazonaws.com/api"
)


def get_token():
    """
    Get authentication token for the admin user.

    Returns:
    str: The authentication token.
    """
    admin_user = {"username": "admin", "password": "Password123!"}
    response = requests.post(f"{API_URL}/login", json=admin_user, timeout=30)
    if 200 <= response.status_code <= 299:
        token = response.headers["Authorization"]
        return token

    print("failed to get token")
    print(response.json())


def api_post(
    endpoint,
    data,
):
    """
    Make a POST request to the API with authentication token.

    Args:
    endpoint (str): The API endpoint to send the request to.
    data (dict): The data to be sent in the request body.

    Returns:
    dict: The JSON response from the API.
    """
    url = f"{API_URL}/{endpoint}"
    try:
        token = get_token()
        headers = {"Authorization": token}
        response = requests.post(url, json=data, headers=headers, timeout=30)
        print_request(url, data)
        print_response(response)
        return response.json()

    except requests.RequestException as e:
        print("Error:", e)


def print_request(url, data):
    """
    Print information about the POST request being sent.

    Args:
    endpoint (str): The API endpoint.
    data (dict): The data being sent in the request body.
    """
    print("Sending POST request to:", url)
    print("Request body:", data)


def print_response(response):
    """
    Print information about the response received from the POST request.

    Args:
    response: The response object from the POST request.
    """
    if 200 <= response.status_code <= 299:
        print("request successful!")
        print("Response status code:", response.status_code)
        print("Response data:", response.json())
    else:
        print("Request Failure.")
        print("Response status code:", response.status_code)
        print("Response data:", response.text)
    print("\n \n")
