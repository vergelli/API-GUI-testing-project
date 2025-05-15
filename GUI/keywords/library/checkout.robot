*** Settings ***
Library     SeleniumLibrary
Library     Collections
Resource    ../../gui_settings.robot

*** Keywords ***

Proceed to checkout
    [Documentation]    Proceeds to the checkout page.
    Click Button    xpath=${XPATH_CHECKOUT_BUTTON}

Enter valid checkout information
    Input Text    ${ID_CHECKOUT_FIRST_NAME}     ${CHECKOUT_NAME}
    Input Text    ${ID_CHECKOUT_LAST_NAME}      ${CHECKOUT_LASTNAME}
    Input Text    ${ID_CHECKOUT_POSTAL_CODE}    ${CHECKOUT_POSTAL_CODE}

Enter invalid checkout information
    Input Text    ${ID_CHECKOUT_FIRST_NAME}     ${CHECKOUT_INVALID_NAME}
    Input Text    ${ID_CHECKOUT_LAST_NAME}      ${CHECKOUT_INVALID_LASTNAME}
    Input Text    ${ID_CHECKOUT_POSTAL_CODE}    ${CHECKOUT_INVALID_POSTAL_CODE}

Continue to the checkout summary
    Click Button    xpath=${XPATH_CONTINUE_BUTTON}

Click on finish button
    [Documentation]    Clicks on the finish button to complete the checkout process.
    Click Button    id=${ID_CHECKOUT_FINISH_BUTTON}

A confirmation message should be displayed
    [Documentation]    Verifies that a confirmation message is displayed after checkout.
    Page Should Contain    Thank you for your order!

An error message should be displayed
    [Documentation]    Verifies that an error message is displayed when invalid information is entered.
    Page Should Contain    Error: First Name is required


A field validation error should be displayed
    [Documentation]    Verifies that a field validation error is displayed.
    Page Should Contain Element    xpath=${XPATH_CHECHOUT_ERROR}

The total price should match the sum of items and TAX
    [Documentation]    Verifies that the total price matches the sum of item prices and TAX.
    ${ITEM_ELEMENTS} =        Get WebElements    css=.inventory_item_price
    @{ITEM_PRICES} =          Create List

    FOR    ${element}    IN    @{ITEM_ELEMENTS}
        ${text} =        Get Text    ${element}
        ${price} =       Evaluate    float('${text}'.replace('$', ''))
        Append To List   ${ITEM_PRICES}    ${price}
    END

    ${SUBTOTAL} =               Evaluate           sum(${ITEM_PRICES})
    ${TAX} =                    Get Text           css=.summary_tax_label
    ${TAX} =                    Evaluate           float('${TAX}'.replace('Tax: $', ''))
    ${EXPECTED_TOTAL} =         Evaluate           round(${SUBTOTAL} + ${TAX}, 2)
    ${DISPLAYED_TOTAL} =        Get Text           css=.summary_total_label
    ${DISPLAYED_TOTAL} =        Evaluate           float('${DISPLAYED_TOTAL}'.replace('Total: $', ''))

    Capture screenshot as "total_price"
    Should Be Equal As Numbers    ${EXPECTED_TOTAL}    ${DISPLAYED_TOTAL}
