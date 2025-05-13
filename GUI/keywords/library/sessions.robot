*** Settings ***
Library     SeleniumLibrary
Resource    ../../gui_settings.robot

*** Keywords ***

Start Web Session And Login
    [Arguments]    ${USERNAME}    ${PASSWORD}
    [Documentation]    Starts a web session and logs in with the provided credentials.
    Open Browser in Selenium Container
    Set User Credentials From Env File
    Input Text    ${ID_USERNAME_INPUT}     ${SAUCEDEMO_USERNAME}
    Input Text    ${ID_PASSWORD_INPUT}     ${SAUCEDEMO_PASSWORD}
    Capture screenshot as "login_filled"
    Click Button  ${ID_LOGIN_BUTTON}
    Capture screenshot as "after_login"