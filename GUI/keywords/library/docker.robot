*** Settings ***
Library    OperatingSystem
Library    Process
Library    RequestsLibrary

Resource    ../../gui_settings.robot
Resource    ./utils.robot

*** Keywords ***

Start Selenium Container
    [Documentation]    Starts the Selenium container with browser and VNC
    Log    ${ENV_DOCKER_FILE_PATH}
    Start Docker container from "${DOCKER_COMPOSE_FILE_PATH}" with environment variables "${ENV_DOCKER_FILE_PATH}"
    Wait Until Selenium Is Ready
    Log    Selenium container started and ready


Stop Selenium Container
    [Documentation]    Stops and removes the Selenium container
    Stop docker container from "${DOCKER_COMPOSE_FILE_PATH}"
    Log    Selenium container stopped


Restart Selenium Container
    Stop Selenium Container
    Start Selenium Container


Start Docker container from "${COMPOSE_PATH}" with environment variables "${ENV_PATH}"
    [Documentation]     Starts all services defined in docker-compose.yml using the specified .env file.
    ${COMPOSE_PATH_NORMALIZED} =    Normalize Path    ${COMPOSE_PATH}
    ${ENV_PATH_NORMALIZED} =        Normalize Path    ${ENV_PATH}
    File Should Exist    ${COMPOSE_PATH_NORMALIZED}    Docker Compose file not found
    File Should Exist    ${ENV_PATH_NORMALIZED}        Environment file not found
    Log    \nStarting Docker Compose with compose file: ${COMPOSE_PATH_NORMALIZED} and env file: ${ENV_PATH_NORMALIZED}    console=True
    ${RESULT} =     Run Process    /usr/bin/docker    compose    -f    ${COMPOSE_PATH_NORMALIZED}    --env-file    ${ENV_PATH_NORMALIZED}    up    -d    shell=${True}
    Should Be Equal As Strings    ${RESULT.rc}    0    Failed to start Docker Compose: ${RESULT.stderr}
    RETURN    ${RESULT}

Stop docker container from "${COMPOSE_PATH}"
    [Documentation]     Stops all the services defined in docker-compose.yml.
    ${COMPOSE_PATH_NORMALIZED} =    Normalize Path    ${COMPOSE_PATH}
    ${RESULT}=    Run Process    /usr/bin/docker    compose    -f    ${COMPOSE_PATH_NORMALIZED}    down     shell=${True}
    Should Be Equal As Strings    ${RESULT.rc}    0    Failed to stop Docker Compose: ${RESULT.stderr}
