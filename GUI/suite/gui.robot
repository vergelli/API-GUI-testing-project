*** Settings ***
Documentation     saucedemo GUI Tests.

Resource    ../keywords/library/docker.robot
Resource    ../keywords/library/browser.robot
Resource    ../keywords/library/screenshots.robot
Resource    ../resources/web/elements.robot
Resource    ../../common/keywords/testing_environment.robot

#* Resource
# Library

Test Setup       Run Keywords
    ...                 Start Selenium Container
    ...                 Configurar ID del Test
    ...                 Limpiar directorio de trabajo temporal
    ...                 Crear estructura de directorios temporales

Test Teardown    Run Keywords
    ...                 Close Browser in Selenium Container
    ...                 Recolectar las evidencias
#     ...                 Stop Selenium Container

*** Test Cases ***

Valid Login
    [Documentation]     Confirm user can log in with valid credentials and reach product page.
    [Tags]              TC 1.1

    Open Browser in Selenium Container
    Set User Credentials From Env File

    Input Text    ${ID_USERNAME_INPUT}     ${SAUCEDEMO_USERNAME}
    Input Text    ${ID_PASSWORD_INPUT}     ${SAUCEDEMO_PASSWORD}
    Capture screenshot as "login_filled"

    Click Button  ${ID_LOGIN_BUTTON}
    Capture screenshot as "after_login"

    Wait Until Page Contains Element    ${XPATH_PRODUCTS_TITLE}    timeout=5s
    Capture screenshot as "final_state"


Invalid Login
    [Documentation]     Verify error message appears when logging in with invalid credentials.
    [Tags]              TC 1.2
    Pass Execution    Mensaje

Add Single Product to Cart
    [Documentation]     Add a single product and verify the cart badge shows 1.
    [Tags]              TC 2.1
    Pass Execution    Mensaje

Add Multiple Products to Cart
    [Documentation]     Add multiple products and verify the cart badge reflects the count.
    [Tags]              TC 2.2
    Pass Execution    Mensaje

Remove Product from Cart
    [Documentation]     Remove a product from the cart and ensure the badge updates.
    [Tags]              TC 3.1
    Pass Execution    Mensaje

Successful Checkout
    [Documentation]     Complete checkout flow with valid inputs and verify order success.
    [Tags]              TC 4.1
    Pass Execution    Mensaje

Checkout with Missing Details
    [Documentation]     Attempt checkout with missing fields and verify validation errors.
    [Tags]              TC 4.2
    Pass Execution    Mensaje

Sort Products by Price (Low-High)
    [Documentation]     Select 'Price (low to high)' and verify product sort order.
    [Tags]              TC 5.1
    Pass Execution    Mensaje

Logout
    [Documentation]     Click logout and verify user is redirected to login screen.
    [Tags]              TC 6.1
    Pass Execution    Mensaje
