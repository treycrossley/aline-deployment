"""
High-level functions to generate dummy data for the application.
"""

import random
from user_data_generator import (
    create_admin,
    create_applicant,
    create_application,
    create_member,
    create_members,
    get_member_accounts,
    get_member_by_id,
)
from bank_data_generator import create_bank, create_branch
from transaction_data_generator import create_transaction, create_transfer


def generate_admin():
    "Generate dummy admin data."
    print("creating admins")
    admin = create_admin()
    return admin


def generate_applicant():
    "Generate dummy applicant data."
    print("creating applicants")
    applicant = create_applicant()
    return applicant


def generate_application(applicants=None, num_applicants_per_application=1):
    "Generate dummy application data."
    print("creating applications")
    application = create_application(applicants, num_applicants_per_application)
    return application


def generate_member(application=None):
    "Generate dummy member data."
    print("creating members")
    member = create_member(application)
    return member


def generate_members_by_application(application=None):
    "Generate a list of members from the specified application."
    members = create_members(application)
    return members


def generate_bank():
    "Generate dummy bank data."
    print("creating banks")
    bank = create_bank()
    return bank


def generate_branch(bank):
    "Generate dummy branch data."
    print("creating branches")
    branch = create_branch(bank["id"])
    return branch


def generate_transaction(
    account_number, amount=1000.00, transaction_type=None, transaction_method=None
):
    "Generate dummy transaction data."
    transaction = create_transaction(
        account_number, amount, transaction_type, transaction_method
    )
    return transaction


def get_accounts_by_member(member_id=11):
    "Get an account number of the member with the specified ID."
    accounts = get_member_accounts(member_id)["content"]
    return accounts


def get_account_id(account):
    "Get the ID of the specified account."
    return account["accountNumber"]


def init_funds(account_number):
    "Initialize a large sum of funds for the specified account number to ensure transaction success."
    _ = (
        generate_transaction(
            account_number,
            amount=100000000,
            transaction_type="DEPOSIT",
            transaction_method="ACH",
        ),
    )


def generate_transaction_by_account_number(account_number, num_transactions=1):
    "Generate dummy transaction for the specified account number."
    init_funds(account_number)
    for _ in range(num_transactions):
        _ = (
            generate_transaction(
                account_number,
                amount=random.randint(0, 10000),
            ),
        )


def generate_transactions_by_member(member_id=11, num_transactions=1):
    "Generate dummy transactions for every account owned by the specified member ID."
    accounts = get_accounts_by_member(member_id)
    account_numbers = list(map(get_account_id, accounts))
    for account_number in account_numbers:
        generate_transaction_by_account_number(account_number, num_transactions)


def generate_transactions(member_ids, num_transactions=1):
    "Generate dummy transactions for the specified member IDs."
    print("generating transactions")
    print(member_ids)
    for member_id in member_ids:
        generate_transactions_by_member(member_id, num_transactions)


def generate_admins(num_admins):
    "Generate dummy admins."
    admins = [generate_admin() for _ in range(num_admins)]
    return admins


def generate_applications(num_applications, num_applicants_per_application):
    "Generate dummy applications."
    applications = [
        generate_application(
            num_applicants_per_application=num_applicants_per_application
        )
        for _ in range(num_applications)
    ]
    return applications


def generate_members(applications):
    "Generate dummy members."
    members = []
    for app in applications:
        members.extend(generate_members_by_application(app))
    return members


def generate_banks(num_banks):
    "Generate dummy banks."
    banks = [generate_bank() for _ in range(num_banks)]
    return banks


def generate_branch_by_bank(bank, num_branches):
    "Generate dummy branch data."
    branches = [generate_branch(bank) for _ in range(num_branches)]
    return branches


def generate_branches(banks, num_branches):
    "Generate dummy branches."
    branches = []
    for bank in banks:
        branches.extend(generate_branch_by_bank(bank, num_branches))
    return branches


def generate_transfer(member1, member2, num_transactions=1):
    "Generate dummy transactions between the specified members."
    for _ in range(num_transactions):
        account_number1 = get_account_id(get_accounts_by_member(member1)[0])
        account_number2 = get_account_id(get_accounts_by_member(member2)[0])
        create_transfer(account_number1, account_number2, random.randint(0, 100))


def generate_transfers(member_ids, num_transactions=1):
    "Generate dummy transactions for the specified member IDs."
    print("generating transfers")
    if len(member_ids) < 2:
        return
    for i in range(0, len(member_ids), 2):
        if i + 1 < len(member_ids):  # Make sure we don't go out of bounds
            member1 = member_ids[i]
            member2 = member_ids[i + 1]
            generate_transfer(member1, member2, num_transactions)


def get_member_ids(members):
    "Get the IDs of the specified members."
    ids = [member["id"] for member in members]
    member_list = [get_member_by_id(id) for id in ids]
    member_ids = [member["memberId"] for member in member_list]
    return member_ids


def main():
    "Generate dummy data."

    num_admins = 1
    num_applications = 2
    num_applicants_per_application = 2
    num_banks = 1
    num_branches_per_bank = 1
    num_transactions_per_account = 1

    generate_admins(num_admins)

    applications = generate_applications(
        num_applications, num_applicants_per_application
    )

    members = generate_members(applications)
    member_ids = get_member_ids(members)

    banks = generate_banks(num_banks)
    generate_branches(banks, num_branches_per_bank)

    generate_transactions(member_ids, num_transactions_per_account)
    generate_transfers(member_ids, num_transactions_per_account)


def demo_main():
    "Generate dummy data based on user input"
    # Ask the user for input on variable values
    num_admins = int(input("Enter the number of admins: "))

    generate_admins(num_admins)

    num_applications = int(input("Enter the number of applications: "))
    num_applicants_per_application = int(
        input("Enter the number of applicants per application: ")
    )

    applications = generate_applications(
        num_applications, num_applicants_per_application
    )

    members = generate_members(applications)
    member_ids = get_member_ids(members)

    num_banks = int(input("Enter the number of banks: "))
    num_branches_per_bank = int(input("Enter the number of branches per bank: "))

    banks = generate_banks(num_banks)
    generate_branches(banks, num_branches_per_bank)

    num_transactions_per_account = int(
        input("Enter the number of transactions per account: ")
    )

    generate_transactions(member_ids, num_transactions_per_account)
    generate_transfers(member_ids, num_transactions_per_account)


if __name__ == "__main__":
    demo_main()
