"""
This module contains functions to interact with an API for creating dummy bank and branch information.

Functions:
- get_dummy_bank: Generate dummy bank information.
- create_bank: Create a bank using dummy bank information.
- get_dummy_branch: Generate dummy branch information.
- create_branch: Create a branch using dummy branch information.
"""

from faker import Faker
from generator_service import api_post

API_URL = "http://localhost:8080/api"

fake = Faker()


def get_dummy_bank():
    """
    Generate dummy bank information using Faker library.

    Returns:
    dict: Dummy bank information.
    """
    return {
        "routingNumber": fake.aba(),
        "address": fake.street_address(),
        "city": fake.city(),
        "state": fake.state(),
        "zipcode": fake.zipcode(),
    }


def create_bank():
    """
    Create a bank by making a POST request to the '/banks' endpoint.

    Returns:
    dict: JSON response from the API after creating the bank.
    """
    bank = get_dummy_bank()
    return api_post("banks", bank)


def get_dummy_branch(bank_id):
    """
    Generate dummy branch information using Faker library.

    Args:
    bank_id (str): The ID of the bank to which the branch belongs.

    Returns:
    dict: Dummy branch information.
    """
    return {
        "name": fake.company(),
        "address": fake.street_address(),
        "city": fake.city(),
        "state": fake.state(),
        "zipcode": fake.zipcode(),
        "phone": fake.numerify(text="###-###-####"),
        "bankID": bank_id,
    }


def create_branch(bank_id=None):
    """
    Create a branch by making a POST request to the '/branches' endpoint.

    Args:
    bank_id (str): The ID of the bank to which the branch belongs. If None, a bank will be created first.

    Returns:
    dict: JSON response from the API after creating the branch.
    """
    bank_id = create_bank() if bank_id is None else bank_id
    branch = get_dummy_branch(bank_id)
    return api_post("branches", branch)
