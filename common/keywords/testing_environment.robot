*** Settings ***
Documentation       Keywords for handling environment variables, settings
...                 and other actions regarding the tests execution.

Library     python/envloader.py
Library     OperatingSystem
Library     Process

Resource    ../../settings.robot

*** Keywords ***

Configure Test ID
    [Documentation]    Searches for a tag that starts
    ...                with the specified substring and
    ...                sets it as a global variable for
    ...                test management purposes.
    ${TEST_ID} =    Set Variable    UNDEFINED_TEST
    @{TEST_TAGS_LIST} =    Get Variable Value    ${TEST_TAGS}
    Should Not Be Empty    ${TEST_TAGS_LIST}    No Tags have been defined for the test. At least one identifier is required.
    FOR    ${TAG}    IN    @{TEST_TAGS_LIST}
        ${TAG_IS_KEY_CODE}=    Tag Starts With    ${TAG}    ${TEST_IDENTIFIER_BEGINNING}
        Run Keyword If    ${TAG_IS_KEY_CODE}    Log To Console    Test identifier tag found: "${TAG}".
        ${TEST_ID}=    Set Variable If    ${TAG_IS_KEY_CODE}    ${TAG}
        Run Keyword If    ${TAG_IS_KEY_CODE}    Set Global Variable    ${TEST_ID}
        Run Keyword If    ${TAG_IS_KEY_CODE}    Exit For Loop
    END
    Run Keyword If    '${TEST_ID}' == 'UNDEFINED_TEST'    Log To Console    Failed to identify a test identifier tag.

Tag Starts With
    [Arguments]    ${TAG_TO_CHECK}    ${TAG_BEGINNING}
    [Documentation]    Checks if a tag starts with 
    ...                a specific substring.
    ${TAG_IS_IDENTIFIER}=    Run Keyword And Return Status    Should Start With    ${TAG_TO_CHECK}    ${TAG_BEGINNING}
    RETURN    ${TAG_IS_IDENTIFIER}

Prepare a Clean Directory Structure
    [Documentation]    Cleans the temporary working 
    ...                directory and creates new folders.
    [Arguments]    ${MAIN_FOLDER_PATH}    ${INNER_FOLDER_NAMES}
    Log To Console    Preparing clean directory structure
    Remove Directory    ${MAIN_FOLDER_PATH}    recursive=True
    Create Directory    ${MAIN_FOLDER_PATH}
    FOR    ${REQ_FOLDER}    IN    @{INNER_FOLDER_NAMES}
        Create Directory    ${MAIN_FOLDER_PATH}/${REQ_FOLDER}
    END

Create temporary directory structure
    [Documentation]    Generates the necessary directory 
    ...                structure within the temporary directory for each test.
    Prepare a Clean Directory Structure    ${TESTS_TEMP_WORKING_DIR}    ${TMP_FOLDERS_LIST}

Collect Evidences
    [Documentation]    Moves the contents of the temporary working 
    ...                directory of the unit to an evidence folder 
    ...                based on the previously configured TestID.
    ${TEST_EVIDENCES_FOLDER} =    Set Variable    ${EVIDENCES_FOLDER_PATH}/${TEST_ID}
    Remove Directory    ${TEST_EVIDENCES_FOLDER}    recursive=True
    Create Directory    ${TEST_EVIDENCES_FOLDER}

    ${ITEMS}=    List Directory    ${TESTS_TEMP_WORKING_DIR}
    FOR    ${ITEM}    IN    @{ITEMS}
        ${SOURCE}=    Set Variable    ${TESTS_TEMP_WORKING_DIR}/${ITEM}
        ${DEST}=      Set Variable    ${TEST_EVIDENCES_FOLDER}/${ITEM}
        Run Keyword And Ignore Error    Move File    ${SOURCE}    ${DEST}
        Run Keyword And Ignore Error    Move Directory    ${SOURCE}    ${DEST}
    END

    Log To Console    \nEvidences collected.

Clean temporary working directory
    [Documentation]    Cleans the temporary working directory to be used in the test execution.
    Remove Directory    ${TESTS_TEMP_WORKING_DIR}    recursive=True

#* ====================================================================================
Load Shared Environment Variables
    [Documentation]    Loads environment variables from the shared/common .env 
    ...                file defined in ${COMMON_ENV_FILE_PATH}.
    ${msg}=    Load Env File    ${COMMON_ENV_FILE_PATH}
    Log    ${msg}

#* ====================================================================================

Set API User Credentials From Env File
    [Documentation]    Attempts to use API environment variables if they already exist. 
    ...                If not, it loads them from a file.
    ${API_USER}=    Get Env Variable    API_USER    ${API_ENV_FILE_PATH}
    ${API_PASS}=    Get Env Variable    API_PASS    ${API_ENV_FILE_PATH}
    Set Test Variable    ${API_USER}    ${API_USER}
    Set Test Variable    ${API_PASS}    ${API_PASS}

#* ====================================================================================

Set GUI User Credentials From Env File
    [Documentation]    Attempts to use  GUI environment variables if they already exist. 
    ...                If not, it loads them from a file.
    ${SAUCEDEMO_USERNAME}=    Get Env Variable    SAUCEDEMO_USERNAME    ${GUI_ENV_FILE_PATH}
    ${SAUCEDEMO_PASSWORD}=    Get Env Variable    SAUCEDEMO_PASSWORD    ${GUI_ENV_FILE_PATH}
    Set Test Variable    ${SAUCEDEMO_USERNAME}    ${SAUCEDEMO_USERNAME}
    Set Test Variable    ${SAUCEDEMO_PASSWORD}    ${SAUCEDEMO_PASSWORD}

#* ====================================================================================
