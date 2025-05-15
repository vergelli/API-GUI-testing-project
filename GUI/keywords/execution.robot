*** Settings ***
Documentation    Precondition keywords.
Resource    ./library/sessions.robot
Resource    ./library/checkout.robot


*** Keywords ***

A single product is added to the cart
    [Documentation]    Adds a single product to the cart.
    Click Button    ${XPATH_ADD_TO_CART_BUTTON}
    Capture screenshot as "add_to_cart"

"${NUMBER_OF_PRODUCTS}" products are added to the cart
    [Documentation]    Adds "${NUMBER_OF_PRODUCTS}" products to the cart.
    Adding "${NUMBER_OF_PRODUCTS}" products to the cart

The user navigates to the cart page
    [Documentation]    Navigates to the cart page.
    click on the shopping cart icon

A product is removed from the cart
    [Documentation]    Removes a product from the cart.
    Click to remove a product from the cart

Proceeds to the checkout page
    [Documentation]    Proceeds to the checkout page.
    Proceed to checkout

Fills in the checkout information correctly
    [Documentation]    Fills in the checkout information.
    Enter valid checkout information

Fills in the checkout information incorrectly
    [Documentation]    Fills in the checkout information incorrectly.
    Enter invalid checkout information

Continues to the checkout summary
    [Documentation]    Continues to the checkout summary.
    Continue to the checkout summary

Products are ordered by price low to high
    [Documentation]    Sorts products by price from low to high.
    Sort products by price low to high

The left panel is opened
    [Documentation]    Opens the left panel.
    Click on the left panel button
    Capture screenshot as "left_panel"

The user logs out
    [Documentation]    Logs out the user.
    Click on logout button
    Capture screenshot as "logout"



