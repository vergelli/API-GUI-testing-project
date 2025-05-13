*** Settings ***
Documentation     saucedemo GUI Tests.


Resource    ../keywords/validation.robot
Resource    ../keywords/preconditions.robot

Resource    ../resources/web/elements.robot
Resource    ../keywords/library/docker.robot
Resource    ../keywords/library/browser.robot
Resource    ../keywords/library/screenshots.robot
Resource    ../../common/keywords/testing_environment.robot

Test Setup       Run Keywords
    ...                 Start Selenium Container
    ...                 Configure Test ID
    ...                 Clean temporary working directory
    ...                 Create temporary directory structure


Test Teardown    Run Keywords
    ...                 Close Browser in Selenium Container
    ...                 Collect Evidences
#     ...                 Stop Selenium Container

*** Test Cases ***

Valid Login
    [Documentation]     Confirm user can log in with valid credentials and reach product page.
    [Tags]              TC 1.1 GUI

    Given the user logs in with valid credentials

    Then user is redirected to the product page

Invalid Login
    [Documentation]     Verify error message appears when logging in with invalid credentials.
    [Tags]              TC 1.2 GUI
    Pass Execution    Mensaje

Add Single Product to Cart
    [Documentation]     Add a single product and verify the cart badge shows 1.
    [Tags]              TC 2.1 GUI
    Pass Execution    Mensaje

Add Multiple Products to Cart
    [Documentation]     Add multiple products and verify the cart badge reflects the count.
    [Tags]              TC 2.2 GUI
    Pass Execution    Mensaje

Remove Product from Cart
    [Documentation]     Remove a product from the cart and ensure the badge updates.
    [Tags]              TC 3.1 GUI
    Pass Execution    Mensaje

Successful Checkout
    [Documentation]     Complete checkout flow with valid inputs and verify order success.
    [Tags]              TC 4.1 GUI
    Pass Execution    Mensaje

Checkout with Missing Details
    [Documentation]     Attempt checkout with missing fields and verify validation errors.
    [Tags]              TC 4.2 GUI
    Pass Execution    Mensaje

Sort Products by Price (Low-High)
    [Documentation]     Select 'Price (low to high)' and verify product sort order.
    [Tags]              TC 5.1 GUI
    Pass Execution    Mensaje

Logout
    [Documentation]     Click logout and verify user is redirected to login screen.
    [Tags]              TC 6.1 GUI
    Pass Execution    Mensaje
