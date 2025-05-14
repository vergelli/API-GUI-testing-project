*** Settings ***
Documentation    Validation keywords.

Resource    ./library/sessions.robot

*** Keywords ***

User is redirected to the product page
    [Documentation]    Validates that the user is redirected to 
    ...                the product page after login.
    Wait Until Page Contains Element    ${XPATH_PRODUCTS_TITLE}    timeout=5s
    Capture screenshot as "final_state"

An error message should be visible
    [Documentation]    Validates that an error message is displayed.
    An error message is shown during login
