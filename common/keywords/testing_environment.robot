*** Settings ***
Documentation       Keywords for handling environment variables, settings
...                 and other actions regarding the tests execution.

Library     python/envloader.py
Library     OperatingSystem
Library     Process

Resource    ../../settings.robot

*** Keywords ***

Configurar ID del Test
    [Documentation]    Searches for a tag that starts
    ...                with the specified substring and
    ...                sets it as a global variable for
    ...                test management purposes.
    ${TEST_ID}=    Set Variable    UNDEFINED_TEST
    @{TEST_TAGS_LIST}=    Get Variable Value    ${TEST_TAGS}
    # Verify presence of Tags
    Should Not Be Empty    ${TEST_TAGS_LIST}    No Tags have been defined for the test. At least one identifier is required.
    # Search for identifier tag
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
    Log To Console    Preparando estructura limpia de directorios
    Remove Directory    ${MAIN_FOLDER_PATH}    recursive=True
    Create Directory    ${MAIN_FOLDER_PATH}
    FOR    ${REQ_FOLDER}    IN    @{INNER_FOLDER_NAMES}
        Create Directory    ${MAIN_FOLDER_PATH}/${REQ_FOLDER}
    END

Crear estructura de directorios temporales
    [Documentation]    Generates the necessary directory 
    ...                structure within the temporary directory for each test.
    Prepare a Clean Directory Structure    ${TESTS_TEMP_WORKING_DIR}    ${TMP_FOLDERS_LIST}

Recolectar las evidencias
    [Documentation]    Moves the temporary working 
    ...                directory of the unit to an evidence folder 
    ...                based on the previously configured TestID.
    ${TEST_EVIDENCES_FOLDER} =    Set Variable    ${EVIDENCES_FOLDER_PATH}/${TEST_ID}
    Remove Directory    ${TEST_EVIDENCES_FOLDER}    recursive=True
    Create Directory    ${TEST_EVIDENCES_FOLDER}
    Move Directory    ${TESTS_TEMP_WORKING_DIR}    ${TEST_EVIDENCES_FOLDER}
    Log To Console    Evidences collected.

Delete Directories
    [Documentation]    Cleans the specified working directory.
    [Arguments]    ${MAIN_FOLDER_PATH}
    Log To Console    Limpiando directorio "${MAIN_FOLDER_PATH}"...
    Remove Directory    ${ABS_ROOT_PATH}/${MAIN_FOLDER_PATH}    recursive=True

Clean Temporary Working Directory
    [Documentation]    Removes the temporary working directories.
    Delete Directories    /tmpWorkdir

Limpiar directorio de trabajo temporal
    [Documentation]    Limpia el directorio de trabajo temporal a ser usado en la ejecucion de un test.
    Remove Directory    ${TESTS_TEMP_WORKING_DIR}    recursive=True

Load Shared Environment Variables
    [Documentation]    Loads environment variables from the shared/common .env 
    ...                file defined in ${COMMON_ENV_FILE_PATH}.
    ${msg}=    Load Env File    ${COMMON_ENV_FILE_PATH}
    Log    ${msg}

Load API Test Environment Variables
    [Documentation]    Loads environment variables specific to API tests from the .env 
    ...                file defined in ${API_ENV_FILE_PATH}.
    ${msg}=    Load Env File    ${API_ENV_FILE_PATH}
    Log    ${msg}

Load GUI Test Environment Variables
    [Documentation]    Loads environment variables specific to GUI tests from the .env 
    ...                file defined in ${GUI_ENV_FILE_PATH}.
    ${msg}=    Load Env File    ${GUI_ENV_FILE_PATH}
    Log    ${msg}

Set User Credentials From Env File
    [Documentation]    Loads the GUI test environment variables for credentials.
    Load GUI Test Environment Variables
    ${SAUCEDEMO_USERNAME}=    Get Env Variable    SAUCEDEMO_USERNAME
    ${SAUCEDEMO_PASSWORD}=    Get Env Variable    SAUCEDEMO_PASSWORD
    Set Test Variable    ${SAUCEDEMO_USERNAME}    ${SAUCEDEMO_USERNAME}
    Set Test Variable    ${SAUCEDEMO_PASSWORD}    ${SAUCEDEMO_PASSWORD}