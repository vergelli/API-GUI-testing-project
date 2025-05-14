*** Settings ***
Documentation    Precondition keywords.
Resource    ./library/authentication.robot
Resource    ../api_settings.robot

*** Keywords ***

A creation booking request is sent
    [Documentation]    Sends a creation booking request
    Sends a booking request

A valid update payload is loaded
    [Documentation]    Carga el payload de actualización de booking en la variable suite.
    Set Suite Variable    ${BOOKING_PAYLOAD_UPDATE}

The request headers with auth token are created
    [Documentation]    Crea los headers necesarios para el request PUT, incluyendo el token de auth.
    Creates a header with auth token

An update booking request is sent
    [Documentation]    Ejecuta el PUT con el payload de actualización y guarda la respuesta.
    Updating the booking with the id "${BOOKING_ID}"

A booking API session is created
    [Documentation]    Create a booking session to use in the tests
    Create booking API session
