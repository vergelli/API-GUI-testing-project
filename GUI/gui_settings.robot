*** Settings ***
Documentation    Test suite configuration variables.

Resource    ./resources/web/elements.robot

*** Variables ***

#* ===================================================================
#* Docker
${DOCKER_PATH}                                    ./GUI/resources/docker
${DOCKER_COMPOSE_FILE_NAME}                        docker-compose.yml

${DOCKER_COMPOSE_FILE_PATH}                       ${DOCKER_PATH}/${DOCKER_COMPOSE_FILE_NAME}
${ENV_DOCKER_FILE_PATH}                           ${DOCKER_PATH}/.env

#* ===================================================================
#* Browsers
${SELENIUM_URL}                                   http://localhost:4444
${REMOTE_URL}                                     ${SELENIUM_URL}/wd/hub
${BROWSER}                                        chrome
${URL_BASE}                                       https://www.saucedemo.com/

#* ===================================================================
#* User Information
${CHECKOUT_NAME}                                  John
${CHECKOUT_LASTNAME}                              Doe
${CHECKOUT_POSTAL_CODE}                           5000

${CHECKOUT_INVALID_NAME}                          ${EMPTY}
${CHECKOUT_INVALID_LASTNAME}                      ${EMPTY}
${CHECKOUT_INVALID_POSTAL_CODE}                   ${EMPTY}

#* ==================================================================
#* CONSTANTS

${LOW_TO_HIGH}                                    lohi