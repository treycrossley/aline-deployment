import random
from faker import Faker
import requests

from generator_service import api_post, get_token

# Initialize Faker library
fake = Faker()

applicationTypes = [
    "CHECKING",
    "SAVINGS",
    "CHECKING_AND_SAVINGS",
]


def get_dummy_admin():
    """
    Generate dummy admin data.

    Returns:
    dict: A dictionary containing the dummy admin data.
    """
    return {
        "username": fake.user_name(),
        "password": "Password123!",
        "role": "admin",
        "firstName": fake.first_name(),
        "lastName": fake.last_name(),
        "email": fake.email(),
        "phone": fake.numerify(text="###-###-####"),
    }


def get_dummy_members(application=None):
    application = application if application is not None else create_application()
    dummy_members = []
    for index, applicant in enumerate(application["applicants"]):
        dummy = {
            "username": applicant["firstName"] + applicant["lastName"],
            "password": "Password123!",
            "role": "member",
            "lastFourOfSSN": applicant["socialSecurity"][-4:],
            "membershipId": application["createdMembers"][index]["membershipId"],
        }
        dummy_members.append(dummy)
    return dummy_members


def get_dummy_member(application=None):
    """
    Generate dummy member data.

    Args:
    member_details (dict): Dictionary containing member details like last 4 SSN and member ID.

    Returns:
    dict: A dictionary containing the dummy member data.
    """
    application = application if application is not None else create_application()
    applicant = application["applicants"][0]
    return {
        "username": applicant["firstName"] + applicant["lastName"],
        "password": "Password123!",
        "role": "member",
        "lastFourOfSSN": applicant["socialSecurity"][-4:],
        "membershipId": application["createdMembers"][0]["membershipId"],
    }


def get_dummy_applicant():
    """
    Generate dummy applicant data.

    Returns:
    dict: A dictionary containing the dummy applicant data.
    """
    return {
        "firstName": fake.first_name(),
        "middleName": fake.first_name(),
        "lastName": fake.last_name(),
        "dateOfBirth": fake.date_of_birth(minimum_age=18, maximum_age=150).strftime(
            "%Y-%m-%d"
        ),
        "gender": random.choice(["MALE", "FEMALE"]),
        "email": fake.email(),
        "phone": fake.numerify(text="###-###-####"),
        "socialSecurity": fake.ssn(),
        "driversLicense": fake.numerify(text="########"),
        "income": random.randint(10000000, 999999999),
        "address": fake.street_address(),
        "city": fake.city(),
        "state": fake.state(),
        "zipcode": fake.zipcode(),
        "mailingAddress": fake.street_address(),
        "mailingCity": fake.city(),
        "mailingState": fake.state(),
        "mailingZipcode": fake.zipcode(),
    }


def get_dummy_application(applicants):
    """
    Generate dummy application data.

    Args:
    applicants (list): List of applicant data.

    Returns:
    dict: A dictionary containing the dummy application data.
    """
    return {
        "applicationType": random.choice(applicationTypes),
        "applicants": applicants,
    }


def create_applicant():
    """
    Create an applicant.

    Returns:
    JSON: A JSON response containing the created applicant data.
    """
    applicant = get_dummy_applicant()
    print(applicant)
    return api_post("applicants", applicant)


def create_application(applicants=None, num_applicants_per_application=1):
    """
    Create an application with the specified applicants.

    Args:
    applicants (list): List of applicant data. If None, a single applicant is created.

    Returns:
    JSON : A JSON response containing the created application data.
    """
    applicants = (
        [get_dummy_applicant() for _ in range(num_applicants_per_application)]
        if applicants is None
        else applicants
    )
    application = get_dummy_application(applicants)
    return api_post("applications", application)


# Function to create a new user
def create_admin():
    """
    Create a new admin user.

    Returns:
    JSON: A JSON response containing the created admin data.
    """
    data = get_dummy_admin()
    print(data)
    return api_post("users/registration", data)


def create_members(member_data_list=None):
    """
    Create new members with the specified member data.

    Args:
    member_data_list (list): List of member data. If None, a new member application is created.

    Returns:
    list: A list of JSON responses containing the created member data.
    """
    member_data_list = (
        create_application() if member_data_list is None else member_data_list
    )
    dummy_members = get_dummy_members(member_data_list)
    json_responses = []
    for member in dummy_members:
        response = api_post("users/registration", member)
        json_responses.append(response)
    return json_responses


def create_member(member_data=None):
    """
    Create a new member user.

    Args:
    member_data (dict): Dictionary containing member data. If None, a new member application is created.

    Returns:
    JSON: A JSON response containing the created member data.
    """
    member_data = create_application() if member_data is None else member_data
    data = get_dummy_member(member_data)
    return api_post("users/registration", data)


def get_member_accounts(member_id):
    """
    Retrieves the accounts associated with a member identified by the provided member ID.

    Args:
        member_id (str or int): The unique identifier of the member whose accounts are to be retrieved.

    Returns:
        dict: A dictionary containing information about the member's accounts, including account numbers,
              types, balances, and other relevant details.

    Raises:
        requests.RequestException: If an error occurs while attempting to fetch the member's accounts
                                    from the API, such as connection errors, timeouts, or other HTTP
                                    request-related issues.
    """
    url = f"http://localhost:8080/api/members/{member_id}/accounts"
    try:
        token = get_token()
        headers = {"Authorization": token}
        response = requests.get(url, headers=headers, timeout=30)
        return response.json()

    except requests.RequestException as e:
        print("Error:", e)


def get_member_by_id(member_id):
    """
    Retrieves information about a member identified by the provided member ID.

    Args:
        member_id (str or int): The unique identifier of the member whose information is to be retrieved.

    Returns:
        dict: A dictionary containing information about the member, including name, email, and other relevant details.

    Raises:
        requests.RequestException: If an error occurs while attempting to fetch the member's information
                                    from the API, such as connection errors, timeouts, or other HTTP
                                    request-related issues.
    """
    url = f"http://localhost:8080/api/users/{member_id}"
    try:
        token = get_token()
        headers = {"Authorization": token}
        response = requests.get(url, headers=headers, timeout=30)
        return response.json()
    except requests.RequestException as e:
        print("Error:", e)
