*** Settings ***
Documentation   Utility keywords for the API test suite.

Resource   ../../api_settings.robot

*** Keywords ***

Disable SSL Warnings
    [Documentation]    Disables SSL warnings for insecure requests.
    IF     ${SSL_WARNINGS}
        Evaluate    __import__('urllib3').disable_warnings(__import__('urllib3').exceptions.InsecureRequestWarning)
    END
