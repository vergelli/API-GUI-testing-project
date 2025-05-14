*** Settings ***
Documentation     restful-booker API Tests.

Resource    ../../common/keywords/testing_environment.robot
Resource    ../keywords/preconditions.robot
Resource    ../keywords/execution.robot
Resource    ../keywords/validation.robot
Resource    ../keywords/library/authentication.robot
Resource    ../keywords/library/ops.robot
Resource    ../keywords/library/utils.robot
Resource    ../api_settings.robot

Library     RequestsLibrary

Test Setup       Run Keywords
    ...                 Configure Test ID
    ...                 Clean temporary working directory
    ...                 Create temporary directory structure
    ...                 Disable SSL Warnings

Test Teardown    Run Keywords
    ...                 Collect Evidences

*** Test Cases ***


Valid Authentication
    [Documentation]     Ensure a valid token is returned when calling /auth with valid credentials.
    [Tags]              TC 1.1 API

    Given the authentication is valid with the given credentials

    Then the auth token was stored correctly


Invalid Authentication
    [Documentation]     Check that invalid credentials to /auth return 403 Forbidden.
    [Tags]              TC 1.2 API

    Given the authentication is invalid with the given credentials

    Then the login response is invalid


Create Booking
    [Documentation]     Validate that a booking can be created and retrieved 
    ...                 with the creation data.
    [Tags]              TC 2.1 API

    Given a valid booking payload is loaded

    When a creation booking request is sent

    Then the response is valid


Retrieve Booking Details
    [Documentation]     Ensure that retrieving an existing booking 
    ...                 returns correct data.
    [Tags]              TC 2.2 API

    Given a valid booking payload is loaded

    When a creation booking request is sent

    Then the response is valid
    And the retrieved booking matches the original


Invalid Booking Retrieval
    [Documentation]     Confirm that using a non-existent ID returns 404 Not Found.
    [Tags]              TC 2.3 API

    The invalid booking does not exist


Update Booking
    [Documentation]     Update an existing booking with a valid token and verify the changes.
    [Tags]              TC 3.1 API

    Given a valid booking payload is loaded

    When a creation booking request is sent
    And the response is valid

    Given the authentication is valid with the given credentials
    Create booking API session

    And a valid update payload is loaded
    And a headers with auth token is created

    When an update booking request is sent

    Then the response status code should be "200"
    And the booking data should be updated correctly


Unauthorized Update
    [Documentation]     Try to update an existing booking without a token and expect 403 Forbidden.
    [Tags]              TC 3.2 API

    Given a valid booking payload is loaded

    When a creation booking request is sent
    And the response is valid
    And a booking API session is created

    And a valid update payload is loaded
    And the request headers WITHOUT auth token are created

    When an update booking request is sent

    Then the update response should be "403"


Delete Booking
    [Documentation]     Delete a booking using a valid token and verify it no longer exists.
    [Tags]              TC 4.1 API

    Given the authentication is valid with the given credentials
    And a valid booking payload is loaded
    And A booking API session is created

    When a creation booking request is sent and the booking id is saved
    And a headers with auth token is created
    And delete a booking

    Then the booking no longer exist on the data base


Unauthorized Deletion
    [Documentation]     Ensure that deletion without a valid token is not allowed.
    [Tags]              TC 4.2 API

    Given a valid booking payload is loaded
    And A booking API session is created

    When a creation booking request is sent and the booking id is saved
    And I delete the booking without an auth token

    Then the deleted response should be "403"


Partial Update
    [Documentation]     Perform a PATCH request to update a single field in a booking.
    [Tags]              TC 5.1 API

    Given the authentication is valid with the given credentials
    And a valid booking payload is loaded
    And A booking API session is created

    When a creation booking request is sent and the booking id is saved
    And a headers with auth token is created
    And i perform a partial update on the booking

    Then only the modified field should be updated
