*** Settings ***
Documentation     saucedemo GUI Tests.

Resource    ../keywords/preconditions.robot
Resource    ../keywords/execution.robot
Resource    ../keywords/validation.robot

Resource    ../keywords/library/docker.robot
Resource    ../keywords/library/browser.robot
Resource    ../keywords/library/screenshots.robot
Resource    ../../common/keywords/testing_environment.robot

Suite Setup       Run Keywords
    ...                 Start Selenium Container

Test Setup       Run Keywords
    ...                 Configure Test ID
    ...                 Clean temporary working directory
    ...                 Create temporary directory structure

Test Teardown    Run Keywords
    ...                 Close Browser in Selenium Container
    ...                 Collect Evidences
    ...                 Clean temporary working directory

Suite Teardown    Run Keywords
    ...                 Stop Selenium Container


*** Test Cases ***

Valid Login
    [Documentation]     Confirm user can log in with valid credentials and reach product page.
    [Tags]              TC 1.1 GUI

    Given the user logs in with valid credentials

    Then user is redirected to the product page


Invalid Login
    [Documentation]     Verify error message appears when logging in with invalid credentials.
    [Tags]              TC 1.2 GUI

    Given the user logs in with invalid credentials

    Then an error message should be visible


Add Single Product to Cart
    [Documentation]     Add a single product and verify the cart badge shows 1.
    [Tags]              TC 2.1 GUI

    Given the user logs in with valid credentials
    And the products page is displayed

    When a single product is added to the cart

    Then one product should be shown in the cart


Add Multiple Products to Cart
    [Documentation]     Add multiple products and verify the cart badge reflects the count.
    [Tags]              TC 2.2 GUI

    Given the user logs in with valid credentials
    And the products page is displayed

    When "3" products are added to the cart

    Then the correct count should be shown in the cart


Remove Product from Cart
    [Documentation]     Remove a product from the cart and ensure the badge updates.
    [Tags]              TC 3.1 GUI

    Given the user logs in with valid credentials
    And the products page is displayed

    When "3" products are added to the cart

    When the user navigates to the cart page
    And a product is removed from the cart

    Then the cart badge should reflect the updated count


Successful Checkout
    [Documentation]     Complete checkout flow with valid inputs and verify order success.
    [Tags]              TC 4.1 GUI

    Given the user logs in with valid credentials
    And the products page is displayed
    And "3" products are added to the cart

    When the user navigates to the cart page
    And proceeds to the checkout page
    And fills in the checkout information correctly
    And continues to the checkout summary

    Then the total price is calculated correctly
    And a confirmation message is shown


Checkout with Missing Details
    [Documentation]     Attempt checkout with missing fields and verify validation errors.
    [Tags]              TC 4.2 GUI

    Given the user logs in with valid credentials
    And the products page is displayed
    And "3" products are added to the cart

    When the user navigates to the cart page
    And proceeds to the checkout page
    And fills in the checkout information incorrectly
    And continues to the checkout summary

    Then an error message is shown


Sort Products by Price (Low-High)
    [Documentation]    Select 'Price (low to high)' and verify product sort order.
    [Tags]    TC 5.1 GUI

    Given the user logs in with valid credentials
    And the products page is displayed

    When products are ordered by price low to high

    Then the products are sorted


Logout
    [Documentation]    Click logout and verify user is redirected to login screen.
    [Tags]    TC 6.1 GUI

    Given the user logs in with valid credentials

    When the left panel is opened
    And the user logs out

    Then the login page is displayed

