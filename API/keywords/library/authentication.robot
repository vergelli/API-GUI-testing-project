*** Settings ***
Library    RequestsLibrary
Library    Collections
Resource   ../../api_settings.robot
Resource   ../../../common/keywords/testing_environment.robot


*** Keywords ***
Authenticate With Valid Credentials
    [Documentation]    POST /auth with valid credentials, store token.
    Set API User Credentials From Env File
    Create Session    auth    ${API_BASE_URL}
    ${PAYLOAD}=    Create Dictionary    username=${API_USER}    password=${API_PASS}
    ${RESPONSE}=    POST On Session    auth    ${AUTH_ENDPOINT}    json=${PAYLOAD}
    Should Be Equal As Integers    ${RESPONSE.status_code}    200
    ${json}=    Convert To Dictionary    ${RESPONSE.json()}
    Set Test Variable    ${AUTH_TOKEN}    ${json['token']}

Authenticate With Invalid Credentials
    [Documentation]    POST /auth with invalid credentials, expect 403.
    Create Session    auth    ${API_BASE_URL}
    ${payload}=    Create Dictionary    username=invalid    password=wrong
    ${response}=    POST On Session    auth    ${AUTH_ENDPOINT}    json=${payload}
    Set Test Variable     ${INVALID_RESPONSE}   ${response}

Create booking API session
    [Documentation]    Create a persistent session to use in the tests
    Create Session    ${BOOKING_SESSION}    ${API_BASE_URL}    verify=false

Get Valid Token
    [Documentation]    Returns a valid token, authenticating if necessary.
    ${EXIST}=    Run Keyword And Return Status    Variable Should Exist    ${AUTH_TOKEN}
        Run Keyword If    not ${EXIST}    Authenticate With Valid Credentials
