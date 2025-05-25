*** Settings ***

Library    RequestsLibrary
Library    OperatingSystem
Library    Process


Resource    ../../gui_settings.robot

*** Keywords ***

Wait Until Selenium Is Ready
    [Documentation]    Waits until the Selenium container is ready.
    [Arguments]    ${timeout}=20s    ${interval}=18s
    Wait Until Keyword Succeeds    ${timeout}    ${interval}    Create Session And Check

Create Session And Check
    [Documentation]    Creates a session and checks if the Selenium server is ready.
    Create Session    selenium    ${SELENIUM_URL}
    Sleep    4s
    ${response}=    GET On Session     selenium    /wd/hub/status
    Should Be Equal As Strings    ${response.status_code}    200
