*** Settings ***
Library     SeleniumLibrary
Resource    ../../gui_settings.robot

*** Keywords ***
Open Browser in Selenium Container
    Open Browser    ${URL_BASE}    ${BROWSER}    remote_url=${REMOTE_URL}
    Maximize Browser Window

Close Browser in Selenium Container
    Close Browser
