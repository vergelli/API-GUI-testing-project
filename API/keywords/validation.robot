*** Settings ***
Documentation    Validation keywords.

Resource    ./library/authentication.robot

*** Keywords ***

The Auth Token Was Stored correctly
    [Documentation]    Verify that the token has been stored correctly.
    Should Not Be Empty    ${AUTH_TOKEN}
    Should Match Regexp    ${AUTH_TOKEN}    ^[a-zA-Z0-9]+$

The login response is invalid
    [Documentation]    Verify that the login response is invalid.
    Verify that the login is not successful

The response is valid
    [Documentation]    Verify that the response is valid.
    The response status code should be "200"
    The response should contain a booking id
    A booking can be retrieved using the returned id

The retrieved booking matches the original
    [Documentation]    Verify that the retrieved booking matches the original payload.
    The retrieved booking equals the original payload

The invalid booking does not exist
    [Documentation]    Verify that the invalid booking does not exist.
    An invalid booking is retrieved using the id "non-existent-id"

The booking data should be updated correctly
    [Documentation]    Validates that the data of the updated booking is as expected.
    Comparing the updated booking data with the original payload

The request headers WITHOUT auth token are created
    [Documentation]    Creates the necessary headers for the PUT request, but without including the token.
    Creates a header without auth token

The response should be "${STATUS_CODE}"
    [Documentation]    Verifies that the API rejects the request without a token with a 403.
    The response status code should be "${STATUS_CODE}"

The update response should be "${STATUS_CODE}"
    [Documentation]    Verifies that the API rejects the request without a token with a 403.
    The update response status code should be "${STATUS_CODE}"

The deleted response should be "${STATUS_CODE}"
    [Documentation]    Verifies that the API rejects the request without a token with a 403.
    The deleted response status code should be "${STATUS_CODE}"

The booking no longer exist on the data base
    [Documentation]    Verifies that the booking was successfully deleted.
    The booking was deleted

Only the modified field should be updated
    [Documentation]    Verifies that only the modified field was updated.
    Compares the updated booking data with the original payload