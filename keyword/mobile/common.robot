*** Settings ***
Resource    ${CURDIR}/../../../ttb_automation_test/resource/library.robot
Library    AppiumLibrary

*** Keywords ***
Open Application Set Up
...    Open Application    ${appium_server}
    ...    platformName=${platform_name}
    ...    platformVersion=${platform_version} 
    ...    deviceName=${device_name}
    ...    app=${app_name}
    ...    automationName=${automation_name}
    ...    autoGrantPermissions=true
    ...    autoAcceptAlerts=true
    ...    allowTestPackages=true
    ...    newCommandTimeout=0

Get Element By Attribute And Should Be Equal As Strings
    [Arguments]    ${locator}=${NULL}    ${timeout}=5s    ${attribute}=${NULL}    ${expected}=${NULL}    ${ignore_case}=${FALSE}
    Wait Until Element Is Visible    ${locator}    ${timeout}
    ${actual}    Get Element Attribute    ${locator}    ${attribute}
    Should Be Equal As Strings    ${expected}    ${actual}    ignore_case=${ignore_case}

Wait And Input Text
    [Arguments]    ${locator}=${NULL}    ${text}=${NULL}    ${timeout}=5s
    Wait Until Element Is Visible    ${locator}    ${timeout}
    Input Text    locator=${locator}    text=${text}

Wait And Click Element
    [Arguments]    ${locator}=${NULL}    ${timeout}=5s
    Wait Until Element Is Visible    ${locator}    ${timeout}
    Click Element    ${locator}


