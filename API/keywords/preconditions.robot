*** Settings ***
Documentation    Precondition keywords.
Resource    ./library/authentication.robot

*** Keywords ***

The authentication is valid with the given credentials
    [Documentation]    Verifies that the authentication
    ...                is valid with the given credentials.
    Authenticate With Valid Credentials

The authentication is invalid with the given credentials
    [Documentation]    Verifies that the authentication
    ...                is invalid with the given credentials.
    Authenticate With Invalid Credentials

A valid booking payload is loaded
    [Documentation]    Loads a valid booking payload.
    Load valid booking payload
