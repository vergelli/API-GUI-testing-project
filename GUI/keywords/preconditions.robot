*** Settings ***
Documentation    Precondition keywords.
Resource    ./library/sessions.robot

*** Keywords ***

The user logs in with valid credentials
    [Documentation]    Logs in with valid credentials.
    Start Web Session And Login
