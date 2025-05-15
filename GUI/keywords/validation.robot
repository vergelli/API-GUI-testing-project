*** Settings ***
Documentation    Validation keywords.

Resource    ./library/sessions.robot
Resource    ./library/products.robot
Resource    ./library/checkout.robot

*** Keywords ***

User is redirected to the product page
    [Documentation]    Validates that the user is redirected to 
    ...                the product page after login.
    Wait Until Page Contains Element    ${XPATH_PRODUCTS_TITLE}    timeout=5s
    Capture screenshot as "final_state"

An error message should be visible
    [Documentation]    Validates that an error message is displayed.
    An error message is shown during login

One product should be shown in the cart
    [Documentation]    Validates that one product is shown in the cart.
    One product is visible in the cart badge

The correct count should be shown in the cart
    [Documentation]    Validates that the correct count of products are shown in the cart badge.
    A number of products are visible in the cart badge

Then the cart badge should reflect the updated count
    [Documentation]    Validates that the cart badge reflects the updated count after product removal.
    Verify that the cart badge reflects the updated count

The total price is calculated correctly
    [Documentation]    Validates that the total price is calculated correctly.
    The total price should match the sum of items and TAX

A confirmation message is shown
    [Documentation]    Validates that a confirmation message is displayed.
    Click on finish button
    A confirmation message should be displayed

An error message is shown
    [Documentation]    Validates that an error message is displayed.
    An error message should be displayed

Then the products are sorted
    [Documentation]    Validates that the products are sorted by price low to high.
    Verify that the products are sorted by price low to high

Then the login page is displayed
    [Documentation]    Validates that the login page is displayed.
    The login page should be visible
