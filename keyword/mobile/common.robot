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
    [Arguments]    ${locator}=${NULL}    ${timeout}=5s    ${attribute}=${NULL}    ${expected}=${NULL}    ${ignore_case}=${FALSE}    ${strp}=${FALSE}
    Wait Until Element Is Visible    ${locator}    ${timeout}
    ${actual}    Get Element Attribute    ${locator}    ${attribute}
    IF    '${strp}'=='${TRUE}'
        ${actual}    Set Variable    ${actual.replace(' ', '')}
    ELSE
        ${actual}    Set Variable    ${actual}
    END
    Should Be Equal As Strings    ${expected}    ${actual}    ignore_case=${ignore_case}

Wait And Input Text
    [Arguments]    ${locator}=${NULL}    ${text}=${NULL}    ${timeout}=5s
    Wait Until Element Is Visible    ${locator}    ${timeout}
    Input Text    locator=${locator}    text=${text}

Wait And Click Element
    [Arguments]    ${locator}=${NULL}    ${timeout}=5s
    Wait Until Element Is Visible    ${locator}    ${timeout}
    Click Element    ${locator}
Get Bounds
    [Arguments]    ${locator}=${NULL}
    Wait Until Element Is Visible    locator=${locator}
    ${actual}    Get Element Attribute    locator=${locator}      attribute=bounds
    ${pairs}    Split String    ${actual}    ][    # Split the string by `][`
    ${pair1}    Replace String    ${pairs[0]}    [    ${EMPTY}    # Remove the opening `[`
    ${pair2}    Replace String    ${pairs[1]}    ]    ${EMPTY}    # Remove the closing `]`
    @{coords1}    Split String    ${pair1}    ,    # Split the first pair into components
    @{coords2}    Split String    ${pair2}    ,    # Split the second pair into components

    ${x1}    Set Variable    ${coords1[0]}
    ${y1}    Set Variable    ${coords1[1]}
    ${x2}    Set Variable    ${coords2[0]}
    ${y2}    Set Variable    ${coords2[1]}
    RETURN    ${x1}    ${y1}    ${x2}    ${y2}
