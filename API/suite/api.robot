*** Settings ***
Documentation     restful-booker API Tests.

#* Resource    

#* Library    

# Test Setup       Run Keywords
# Test Teardown    Run Keywords

*** Test Cases ***
Valid Authentication
    [Documentation]     Ensure a valid token is returned when calling /auth with valid credentials.
    [Tags]              TC 1.1
    Pass

Invalid Authentication
    [Documentation]     Check that invalid credentials to /auth return 403 Forbidden.
    [Tags]              TC 1.2
    Pass

Create Booking
    [Documentation]     Validate that a booking can be created and retrieved with correct data.
    [Tags]              TC 2.1
    Pass

Retrieve Booking Details
    [Documentation]     Ensure that retrieving an existing booking returns correct data.
    [Tags]              TC 2.2
    Pass

Invalid Booking Retrieval
    [Documentation]     Confirm that using a non-existent ID returns 404 Not Found.
    [Tags]              TC 2.3
    Pass

Update Booking
    [Documentation]     Update an existing booking with a valid token and verify the changes.
    [Tags]              TC 3.1
    Pass

Unauthorized Update
    [Documentation]     Ensure that an update attempt without a valid token is denied.
    [Tags]              TC 3.2
    Pass

Delete Booking
    [Documentation]     Delete a booking using a valid token and verify it no longer exists.
    [Tags]              TC 4.1
    Pass

Unauthorized Deletion
    [Documentation]     Ensure that deletion without a valid token is not allowed.
    [Tags]              TC 4.1
    Pass

Partial Update
    [Documentation]     Perform a PATCH request to update a single field in a booking.
    [Tags]              TC 5.1
    Pass
