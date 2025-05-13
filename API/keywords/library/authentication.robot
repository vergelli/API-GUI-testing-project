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
    ${payload}=    Create Dictionary    username=${API_USER}    password=${API_PASS}
    ${response}=    POST On Session    auth    ${AUTH_ENDPOINT}    json=${payload}
    Should Be Equal As Integers    ${response.status_code}    200
    ${json}=    Convert To Dictionary    ${response.json()}
    Set Suite Variable    ${AUTH_TOKEN}    ${json['token']}

Authenticate With Invalid Credentials
    [Documentation]    POST /auth with invalid credentials, expect 403.
    Create Session    auth    ${BASE_URL}
    ${payload}=    Create Dictionary    username=invalid    password=wrong
    ${response}=    POST On Session    auth    ${AUTH_ENDPOINT}    json=${payload}
    Set Suite Variable    ${INVALID_RESPONSE}    ${response}
