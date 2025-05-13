*** Settings ***
Documentation    Test suite configuration variables.

*** Variables ***

#* ===================================================================
#* Docker
${DOCKER_PATH}                                    ./GUI/resources/docker
${DOCKER_COMPOSE_FILE_NAME}                        docker-compose.yml

${DOCKER_COMPOSE_FILE_PATH}                       ${DOCKER_PATH}/${DOCKER_COMPOSE_FILE_NAME}
${ENV_DOCKER_FILE_PATH}                           ${DOCKER_PATH}/.env

#* ===================================================================
#* Browsers
${REMOTE_URL}    http://localhost:4444/wd/hub
${BROWSER}       chrome
${URL_BASE}      https://www.saucedemo.com/