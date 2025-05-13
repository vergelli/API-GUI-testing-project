*** Settings ***
Documentation    Validation keywords.

Resource    ./library/authentication.robot

*** Keywords ***

Validate Auth Token Was Stored
    [Documentation]    Verifica que se haya almacenado el token correctamente.
    Should Not Be Empty    ${AUTH_TOKEN}
    Should Match Regexp    ${AUTH_TOKEN}    ^[a-zA-Z0-9]+$
