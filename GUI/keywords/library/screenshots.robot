*** Settings ***
Library    OperatingSystem
Library    Process

Resource    ../../gui_settings.robot
Resource    ../../../settings.robot

*** Keywords ***
Capture screenshot as "${NAME}"
    [Documentation]    Captures a screenshot of the current page and saves it with the specified name.
    ${TS} =    Get Time    format=%Y%m%d-%H%M%S
    ${FULL_PATH} =    Catenate    SEPARATOR=/    ${TMP_SCREENSHOT_DIR}    ${NAME}-${TS}.png
    Capture Page Screenshot    ${FULL_PATH}