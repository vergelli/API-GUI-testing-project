*** Settings ***
Documentation    Test suite configuration variables.

*** Variables ***

#* ===================================================================
#* Testing Environment


#* ===================================================================
#* Testing Environment
${TEST_IDENTIFIER_BEGINNING}                   TC 

${ABS_ROOT_PATH}                               ${CURDIR}
${EVIDENCES_FOLDER_PATH}                       ${ABS_ROOT_PATH}/results
${GUI_SUITES_FOLDER_PATH}                      ${ABS_ROOT_PATH}/GUI
${API_SUITES_FOLDER_PATH}                      ${ABS_ROOT_PATH}/API
${COMMON_FOLDER_PATH}                          ${ABS_ROOT_PATH}/common

#* ===================================================================
#* Temporary Directories

${TESTS_TEMP_WORKING_DIR}                      ${ABS_ROOT_PATH}/tmpWorkdir
@{TMP_FOLDERS_LIST}
    ...    /logs
    ...    /config
    ...    /screenshots

${TMP_LOGS_DIR}                                ${TESTS_TEMP_WORKING_DIR}/logs
${TMP_CONFIG_DIR}                              ${TESTS_TEMP_WORKING_DIR}/config
${TMP_SCREENSHOT_DIR}                          ${TESTS_TEMP_WORKING_DIR}/screenshots

${GUI_ENV_FILE_PATH}                           ${GUI_SUITES_FOLDER_PATH}/resources/.env
${API_ENV_FILE_PATH}                           ${API_SUITES_FOLDER_PATH}/resources/.env
${COMMON_ENV_FILE_PATH}                        ${COMMON_FOLDER_PATH}/.env

