*** Settings ***
Library    RequestsLibrary
Library    Collections
Resource   ../../api_settings.robot
Resource   ../../../common/keywords/testing_environment.robot

*** Keywords ***
Load valid booking payload
    Log    ${BOOKING_PAYLOAD}
    Set Test Variable    ${VALID_PAYLOAD}    &{BOOKING_PAYLOAD}

Sends a booking request
    [Documentation]    Sends a creation booking request
    ${RESPONSE}=    POST    ${BOOKING_ENDPOINT}    json=${VALID_PAYLOAD}
    Set Test Variable    ${RESPONSE}    ${RESPONSE}

Save the booking id
    [Documentation]    Saves the booking id from the response
    ${BOOKING_ID}=    Set Variable    ${RESPONSE.json()['bookingid']}
    Set Test Variable    ${BOOKING_ID}    ${BOOKING_ID}

The response status code should be "${STATUS_CODE}"
    [Documentation]    Validates that the response status code is as expected.
    Should Be Equal As Integers    ${RESPONSE.status_code}    ${STATUS_CODE}

The update response status code should be "${STATUS_CODE}"
    [Documentation]    Validates that the update response status code is as expected.
    Should Be Equal As Integers    ${RESPONSE_PUT.status_code}    ${STATUS_CODE}

The deleted response status code should be "${STATUS_CODE}"
    [Documentation]    Validates that the update response status code is as expected.
    Should Be Equal As Integers    ${DELETE_RESPONSE.status_code}    ${STATUS_CODE}

The response should contain a booking id
    Dictionary Should Contain Key    ${RESPONSE.json()}    bookingid
    Set Test Variable    ${BOOKING_ID}    ${RESPONSE.json()['bookingid']}

Get booking by id "${BOOKING_ID}"
    [Documentation]    Get a booking by its ID
    ${RESPONSE}=    GET On Session    ${BOOKING_SESSION}    ${BOOKING_ENDPOINT}/${BOOKING_ID}    expected_status=any
    Log    ${RESPONSE}
    RETURN    ${RESPONSE}

Get booking with id "${BOOKING_ID}" and expect "${STATUS_CODE}"
    ${RESPONSE} =     Get booking by id "${BOOKING_ID}"
    Log    ${RESPONSE}
    Should Be Equal As Integers    ${RESPONSE.status_code}    ${STATUS_CODE}
    RETURN     ${RESPONSE}

# =========================================================================
A booking can be retrieved using the returned id
    Create booking API session
    ${RESPONSE} =     Get booking with id "${BOOKING_ID}" and expect "200"
    Log    ${RESPONSE}
    Set Test Variable    ${RETRIEVED_BOOKING}    ${RESPONSE.json()}

An invalid booking is retrieved using the id "${A_BOOKING_ID}"
    Create booking API session
    ${RESPONSE} =     Get booking with id "${A_BOOKING_ID}" and expect "404"

The retrieved booking equals the original payload
    Dictionaries Should Be Equal    ${RETRIEVED_BOOKING}    ${VALID_PAYLOAD}
# =========================================================================

Comparing the updated booking data with the original payload
    [Documentation]    Validates that the data of the updated booking is as expected.
    ${BODY}=    Convert To Dictionary    ${RESPONSE.json()}
    Should Be Equal    ${BODY["booking"]['firstname']}    Jim
    Should Be Equal    ${BODY["booking"]['lastname']}     Brown

Creates a header without auth token
    ${HEADERS}=    Create Dictionary
    ...    Content-Type=application/json
    ...    Accept=application/json
    Set Test Variable    ${HEADERS}

Updating the booking with the id "${BOOKING_ID}"
    [Documentation]    Updates the booking with the given id
    ${RESPONSE_PUT}=    PUT On Session
    ...    ${BOOKING_SESSION}
    ...    /booking/${BOOKING_ID}
    ...    json=${BOOKING_PAYLOAD_UPDATE}
    ...    headers=${HEADERS}
    ...    expected_status=any
    Log    ${RESPONSE_PUT}
    Set Test Variable    ${RESPONSE_PUT}

Creates a header with auth token
    [Documentation]    Creates a header with the auth token for the request.
    ${HEADERS}=    Create Dictionary
    ...    Content-Type=application/json
    ...    Accept=application/json
    ...    Cookie=token=${AUTH_TOKEN}
    Set Test Variable    ${HEADERS}

Sends a DELETE request to delete the booking
    [Documentation]    Sends a DELETE request to delete the booking
    ${DELETE_RESPONSE}=    RequestsLibrary.Delete On Session    ${BOOKING_SESSION}    ${BOOKING_ENDPOINT}/${BOOKING_ID}    headers=${HEADERS}    expected_status=any
    Log    ${DELETE_RESPONSE}
    Set Test Variable    ${DELETE_RESPONSE}

The booking was deleted
    [Documentation]    Verifies that the booking was deleted successfully.
    ${GET_RESPONSE}=    RequestsLibrary.Get On Session    ${BOOKING_SESSION}    /booking/${BOOKING_ID}    expected_status=any
    Should Be Equal As Integers    ${GET_RESPONSE.status_code}    404

The booking is patched with new data
    [Documentation]    Patches the booking with new data
    ${RESPONSE}=    PATCH On Session    ${BOOKING_SESSION}    ${BOOKING_ENDPOINT}/${BOOKING_ID}    headers=${HEADERS}    json=${PATCH_BODY}
    Set Test Variable    ${PATCH_RESPONSE}    ${RESPONSE}

Compares the updated booking data with the original payload
    [Documentation]    Validates that the data of the updated booking is as expected.
    Should Be Equal As Integers    ${PATCH_RESPONSE.status_code}    200
    ${BODY}=    Convert To Dictionary    ${PATCH_RESPONSE.json()}
    Should Be Equal    ${BODY['firstname']}    Fede
    Should Be Equal    ${BODY['lastname']}    ${BOOKING_PAYLOAD['lastname']}
    Should Be Equal    ${BODY['totalprice']}    ${BOOKING_PAYLOAD['totalprice']}

Verify that the login is not successful
    [Documentation]    Verify that the login is not successful by checking the status code and reason.
    Should Be Equal As Integers    ${INVALID_RESPONSE.status_code}    403    
    ...    Failure: Expected status code 403\nGot ${INVALID_RESPONSE.status_code} instead
    ${BODY}=    Convert To Dictionary    ${INVALID_RESPONSE.json()}
    Should Be Equal    ${BODY['reason']}    Bad credentials