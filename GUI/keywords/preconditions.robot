*** Settings ***
Documentation    Precondition keywords.
Resource    ./library/sessions.robot

*** Keywords ***

The user logs in with valid credentials
    [Documentation]    Logs in with valid credentials.
    Start Web Session And Login

The user logs in with invalid credentials
    [Documentation]    Logs in with invalid credentials.
    start Web Session And Login With Invalid Credentials

The products page is displayed
    Page Should Contain Element    ${XPATH_INVENTORY_LIST}
    Capture screenshot as "products_page"