*** Settings ***
Library     SeleniumLibrary
Resource    ../../gui_settings.robot


*** Keywords ***

Start Web Session
    [Documentation]    Starts a web session.
    Open Browser in Selenium Container
    Set GUI User Credentials From Env File
    Capture screenshot as "start_web_session"

The login page should be visible
    [Documentation]    Verifies that the login page is visible.
    Wait Until Page Contains Element    css=${CSS_INPUT_USERNAME}
    Element Should Be Visible           css=${CSS_INPUT_USERNAME}
    Element Should Be Visible           css=${CSS_INPUT_PASSWORD}
    Element Should Be Visible           css=${CSS_INPUT_SUBMIT}

Enter valid credentials
    [Documentation]    Enters valid credentials into the login form.
    Input Text    ${ID_USERNAME_INPUT}     ${SAUCEDEMO_USERNAME}
    Input Text    ${ID_PASSWORD_INPUT}     ${SAUCEDEMO_PASSWORD}
    Capture screenshot as "login_filled"
    Click Button  ${ID_LOGIN_BUTTON}
    Capture screenshot as "after_login"

Enter invalid credentials
    [Documentation]    Enters invalid credentials into the login form.
    Input Text    ${ID_USERNAME_INPUT}     invalid
    Input Text    ${ID_PASSWORD_INPUT}     wrong
    Capture screenshot as "login_filled"
    Click Button  ${ID_LOGIN_BUTTON}
    Capture screenshot as "after_login"

Start Web Session And Login
    [Documentation]    Starts a web session and logs in with the provided credentials.
    Start Web Session
    Enter valid credentials

Start Web Session And Login With Invalid Credentials
    [Documentation]    Starts a web session and logs in with invalid credentials.
    Start Web Session
    Enter invalid credentials

An error message is shown during login
    [Documentation]    Verifies that an error message is displayed.
    Wait Until Page Contains Element    ${XPATH_ERROR_AT_LOGIN}
    Element Should Contain    ${XPATH_ERROR_AT_LOGIN}    do not match
    Capture screenshot as "error_message_at_login"

Click on the left panel button
    Click Element     css=#${CSS_BURGER_MENU_BUTTON}

Click on logout button
    Wait Until Page Contains Element    css=#${CSS_LOGOUT_BUTTON}
    Click Element     css=#${CSS_LOGOUT_BUTTON}
