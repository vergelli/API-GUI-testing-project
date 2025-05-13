*** Settings ***
Library    OperatingSystem
Library    Process

Resource    ../../gui_settings.robot

*** Keywords ***
Start Selenium Container
    [Documentation]    Levanta el contenedor Selenium con navegador y VNC
    Log    ${ENV_DOCKER_FILE_PATH}
    Start Docker container from "${DOCKER_COMPOSE_FILE_PATH}" with environment variables "${ENV_DOCKER_FILE_PATH}"
    Log    Contenedor Selenium iniciado


Stop Selenium Container
    [Documentation]    Detiene y elimina el contenedor Selenium
    Stop docker container from "${DOCKER_COMPOSE_FILE_PATH}"
    Log    Contenedor Selenium detenido


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
    [Documentation]     Detiene todos los servicios definidos en docker-compose.yml.
    ${COMPOSE_PATH_NORMALIZED} =    Normalize Path    ${COMPOSE_PATH}
    ${RESULT}=    Run Process    /usr/bin/docker    compose    -f    ${COMPOSE_PATH_NORMALIZED}    down     shell=${True}
    Should Be Equal As Strings    ${RESULT.rc}    0    Failed to stop Docker Compose: ${RESULT.stderr}
