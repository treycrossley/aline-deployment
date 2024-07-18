import random
from faker import Faker
from generator_service import api_post

API_URL = "http://localhost:8080/api"

fake = Faker()

transactionTypes = [
    "DEPOSIT",
    "WITHDRAWAL",
    "TRANSFER_IN",
    "TRANSFER_OUT",
    "PURCHASE",
    "PAYMENT",
    "REFUND",
    "VOID",
]

transactionMethods = ["ACH", "ATM", "CREDIT_CARD", "DEBIT_CARD", "APP"]


def get_dummy_transaction(
    account_number, amount=1000.00, transaction_type=None, transaction_method=None
):
    """
    Generate a dummy transaction data with the specified account number and amount.

    Args:
    account_number (str): The account number for the transaction.
    amount (float): The amount for the transaction. Default is 1000.00.

    Returns:
    dict: A dictionary containing the dummy transaction data.
    """
    transaction_type = transaction_type or fake.random_element(
        elements=transactionTypes
    )
    transaction_method = transaction_method or fake.random_element(
        elements=transactionMethods
    )
    return {
        "type": transaction_type,
        "method": transaction_method,
        "date": fake.date_object().strftime("%Y-%m-%dT%H:%M:%S.%fZ"),
        "amount": amount,
        "merchantCode": "ALINE",
        "merchantName": "Aline Financial",
        "description": f"Dummy transaction of type {transaction_type} and method {transaction_method} for account {account_number}",
        "accountNumber": account_number,
        "hold": random.choice([True, False]),
    }


def create_transaction(
    account_number, amount=1000.00, transaction_type=None, transaction_method=None
):
    """
    Create a transaction using the specified account number and amount.

    Args:
    account_number (str): The account number for the transaction.
    amount (float): The amount for the transaction. Default is 1000.00.

    Returns:
    JSON: A JSON response containing the created transaction.
    """
    transaction = get_dummy_transaction(
        account_number, amount, transaction_type, transaction_method
    )
    return api_post("transactions", transaction)


def create_dummy_transfer(
    sender_account_num, receiver_account_num, amount=1000.00, memo=""
):
    """
    Create a transfer transaction between two accounts.

    Parameters:
        sender_account_num (str): The account number of the sender.
        receiver_account_num (str): The account number of the receiver.
        amount (float, optional): The amount to transfer. Defaults to 1000.00.
        memo (str, optional): A memo to include with the transfer. If not provided, a random sentence will be generated as the memo. Defaults to "".

    Returns:
        dict: A dictionary containing information about the transfer transaction.
    """
    memo = memo or fake.sentence()
    transfer = {
        "fromAccountNumber": sender_account_num,
        "toAccountNumber": receiver_account_num,
        "amount": amount,
        "memo": memo,
        "date": fake.date_object().strftime("%Y-%m-%dT%H:%M:%S.%fZ"),
    }
    return transfer


def create_transfer(sender_account_num, receiver_account_num, amount=1000.00, memo=""):
    """
    Create a transfer transaction between two accounts.

    Parameters:
        sender_account_num (str): The account number of the sender.
        receiver_account_num (str): The account number of the receiver.
        amount (float, optional): The amount to transfer. Defaults to 1000.00.
        memo (str, optional): A memo to include with the transfer. If not provided, a random sentence will be generated as the memo. Defaults to "".

    Returns:
        dict: A dictionary containing information about the transfer transaction.
    """
    transfer = create_dummy_transfer(
        sender_account_num, receiver_account_num, amount, memo
    )
    return api_post("transactions/transfer", transfer)
