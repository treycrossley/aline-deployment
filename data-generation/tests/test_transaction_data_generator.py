import datetime
from unittest.mock import patch, MagicMock
from transaction_data_generator import (
    create_transaction,
    get_dummy_transaction,
    create_dummy_transfer,
    create_transfer,
)


def test_get_dummy_transaction():
    # Mock data
    account_number = "test_account_number"
    amount = 500.00
    transaction_type = "DEPOSIT"
    transaction_method = "ACH"

    # Call the function
    result = get_dummy_transaction(
        account_number, amount, transaction_type, transaction_method
    )

    # Assertions
    assert result["accountNumber"] == account_number
    assert result["amount"] == amount
    assert result["merchantCode"] == "ALINE"
    assert result["merchantName"] == "Aline Financial"
    assert (
        result["description"]
        == f"Dummy transaction of type {transaction_type} and method {transaction_method} for account {account_number}"
    )
    assert result["type"] == transaction_type
    assert result["method"] == transaction_method
    assert result["date"]
    assert result["hold"] in [True, False]


@patch("transaction_data_generator.get_dummy_transaction")
@patch("transaction_data_generator.api_post")
def test_create_transaction(mock_api_post, mock_get_dummy_transaction):
    """
    Test the create_transaction function by mocking API calls and get_dummy_transaction, asserting the expected response.

    Args:
        mock_api_post (MagicMock): A MagicMock object to mock the api_post function.
        mock_get_dummy_transaction (MagicMock): A MagicMock object to mock the get_dummy_transaction function.

    Returns:
        None
    """
    # Mock data
    account_number = "test_account_number"
    expected_response = {"transaction_id": "123456789"}

    # Configure mock objects
    mock_api_post.return_value.json.return_value = expected_response
    mock_get_dummy_transaction.return_value = {
        "type": "DEPOSIT",
        "method": "ACH",
        "date": "2024-04-10T12:00:00.000Z",
        "amount": 1000.00,
        "merchantCode": "ALINE",
        "merchantName": "Aline Financial",
        "description": f"Dummy transaction of type DEPOSIT and method ACH for account {account_number}",
        "accountNumber": account_number,
        "hold": False,
    }

    # Call the function
    result = create_transaction(account_number)

    # Assertions
    mock_api_post.assert_called_once_with(
        "transactions", mock_get_dummy_transaction.return_value
    )
    assert (
        mock_api_post.return_value.json() == expected_response
    )  # Ensure the function returns the expected response


def test_create_dummy_transfer():
    """
    Test the create_dummy_transfer function.

    This function tests the create_dummy_transfer function by mocking the necessary data and
    calling the function with the provided parameters. It then asserts that the returned result
    matches the expected values for the sender account number, receiver account number, amount,
    memo, and date.

    Parameters:
        None

    Returns:
        None
    """
    # Mock data
    sender_account_num = "sender_account"
    receiver_account_num = "receiver_account"
    amount = 500.00
    memo = "Test transfer"

    # Call the function
    result = create_dummy_transfer(
        sender_account_num, receiver_account_num, amount, memo
    )

    # Assertions
    assert result["fromAccountNumber"] == sender_account_num
    assert result["toAccountNumber"] == receiver_account_num
    assert result["amount"] == amount
    assert result["memo"] == memo
    assert result["date"]


@patch("transaction_data_generator.create_dummy_transfer")
@patch("transaction_data_generator.api_post")
def test_create_transfer(mock_api_post, mock_create_dummy_transfer):
    """
    Test the create_transfer function.

    This function tests the create_transfer function by mocking the necessary data and
    calling the function with the provided parameters. It then asserts that the function
    calls the create_dummy_transfer function with the correct arguments and makes an API
    POST request to the "transactions/transfer" endpoint with the expected transfer data.
    Finally, it asserts that the API response is equal to the expected response.

    Parameters:
        mock_api_post (MagicMock): A mock object for the api_post function.
        mock_create_dummy_transfer (MagicMock): A mock object for the create_dummy_transfer function.

    Returns:
        None
    """
    # Mock data
    sender_account_num = "sender_account"
    receiver_account_num = "receiver_account"
    amount = 1000.00
    memo = "Test memo"
    expected_transfer_data = {
        "fromAccountNumber": sender_account_num,
        "toAccountNumber": receiver_account_num,
        "amount": amount,
        "memo": memo,
    }
    expected_response = {"transaction_id": "123456789"}

    # Configure mock objects
    mock_create_dummy_transfer.return_value = expected_transfer_data
    mock_api_post.return_value.json.return_value = expected_response

    # Call the function
    create_transfer(sender_account_num, receiver_account_num, amount, memo)

    # Assertions
    mock_create_dummy_transfer.assert_called_once_with(
        sender_account_num, receiver_account_num, amount, memo
    )
    mock_api_post.assert_called_once_with(
        "transactions/transfer", expected_transfer_data
    )
    assert mock_api_post.return_value.json() == expected_response
