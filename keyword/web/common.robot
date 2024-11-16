*** Settings ***
Resource    ${CURDIR}/../../../ttb_automation_test/resource/library.robot

*** Keywords ***
Open Browser And Go To Destination URL
    [Arguments]    ${url}=${NULL}    ${browser}=googlechrome
    Open Browser    url=${url}    browser=${browser}
    Maximize Browser Window

Wait Element And Assert As String
    [Arguments]    ${locator}=${NULL}    ${expected}=${NULL}    ${timeout}=${timeout}
    Wait Until Element Is Visible    locator=${locator}    timeout=${timeout}
    ${actual}    Get Text    locator=${locator}    
    Should Be Equal As Strings    ${expected}    ${actual}
