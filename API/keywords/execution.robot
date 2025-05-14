*** Settings ***
Documentation    Precondition keywords.
Resource    ./library/authentication.robot
Resource    ../api_settings.robot

*** Keywords ***

A creation booking request is sent
    [Documentation]    Sends a creation booking request
    Sends a booking request

A creation booking request is sent and the booking id is saved
    [Documentation]    Sends a creation booking request and saves its id
    Sends a booking request
    Save the booking id

A valid update payload is loaded
    [Documentation]    Carga el payload de actualización de booking en la variable suite.
    Set Test Variable    ${BOOKING_PAYLOAD_UPDATE}

A headers with auth token is created
    [Documentation]    Crea los headers necesarios para el request PUT, incluyendo el token de auth.
    Creates a header with auth token

An update booking request is sent
    [Documentation]    Ejecuta el PUT con el payload de actualización y guarda la respuesta.
    Updating the booking with the id "${BOOKING_ID}"

A booking API session is created
    [Documentation]    Create a booking session to use in the tests
    Create booking API session

Delete a booking
    [Documentation]    Delete a booking using a valid token.
    Sends a DELETE request to delete the booking

I delete the booking without an auth token
    [Documentation]    Delete a booking without a token.
    Creates a header without auth token
    Sends a DELETE request to delete the booking

A partial update is performed on the booking
    [Documentation]    Patches the booking with new data.
    The booking is patched with new data