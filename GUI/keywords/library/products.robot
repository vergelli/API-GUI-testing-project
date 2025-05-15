*** Settings ***
Library     SeleniumLibrary
Resource    ../../gui_settings.robot

*** Keywords ***


One product is visible in the cart badge
    [Documentation]    Validates that one product is visible in the cart badge.
    Wait Until Page Contains Element    class=shopping_cart_badge
    Element Text Should Be              class=shopping_cart_badge    1
    Capture screenshot as "cart_badge"


A number of products are visible in the cart badge
    [Documentation]    Validates that a number of products are visible in the cart badge.
    Wait Until Page Contains Element    class=shopping_cart_badge
    Element Text Should Be              class=shopping_cart_badge    ${NUMBER_OF_PRODUCTS}


Adding "${NUMBER_OF_PRODUCTS}" products to the cart
    [Documentation]    Adds "${NUMBER_OF_PRODUCTS}" products to the cart.
    ${NUMBER_OF_PRODUCTS_INT}    Evaluate    int(${NUMBER_OF_PRODUCTS})
    FOR    ${index}    IN RANGE    1    ${NUMBER_OF_PRODUCTS_INT + 1}
        Click Button    xpath=(//button[contains(text(), 'Add to cart')])[${index}]
    END
    Set Test Variable    ${NUMBER_OF_PRODUCTS}    ${NUMBER_OF_PRODUCTS_INT}
    Capture screenshot as "objs_added_to_cart"

Click on the shopping cart icon
    [Documentation]    Clicks on the shopping cart icon.
    Click Element    class=shopping_cart_link
    Wait Until Page Contains Element    ${XPATH_CART_PROD_LIST}

Click to remove a product from the cart
    [Documentation]    Clicks to remove a product from the cart.
    Click Button    ${XPATH_REMOVE_PRODUCT}

Verify that the cart badge reflects the updated count
    [Documentation]    Validates that the cart badge reflects the updated count.
    ${EXPECTED_PRODUCT_COUNT} =    Evaluate    ${NUMBER_OF_PRODUCTS} - 1
    Element Text Should Be    class=shopping_cart_badge    ${EXPECTED_PRODUCT_COUNT}
    Capture screenshot as "cart_badge_after_removal"

Sort products by price low to high
    [Documentation]    Sorts products by price from low to high.
    Wait Until Page Contains Element    class=${CLASS_PRODUCTS_SORT_CONTAINER} 
    Select From List By Value           class=${CLASS_PRODUCTS_SORT_CONTAINER}     ${LOW_TO_HIGH}

Verify that the products are sorted by price low to high
    [Documentation]    Validates that the products are sorted by price from low to high.
    ${PRICES_ELEMENTS}=    Get WebElements    css=${CSS_SELECTOR_ITEM_PRICE}
    @{PRICES}=             Create List

    FOR    ${el}    IN    @{PRICES_ELEMENTS}
        ${text}=           Get Text    ${el}
        ${price}=          Evaluate    float('${text}'.replace('$', ''))
        Append To List     ${PRICES}    ${price}
    END

    ${SORTED_PRICES}=      Evaluate    sorted(${PRICES})
    Should Be Equal        ${PRICES}    ${SORTED_PRICES}