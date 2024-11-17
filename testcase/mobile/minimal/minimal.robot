*** Settings ***
Resource    ${CURDIR}/../../../../ttb_automation_test/resource/library.robot
Resource    ${CURDIR}/../../../../ttb_automation_test/keyword/mobile/minimal/minimal.robot
Resource    ${CURDIR}/../../../../ttb_automation_test/resource/mobile/locator/minimal/minimal_login.robot
Library    AppiumLibrary

*** Variables ***
${appium_server}     http://localhost:4723/wd/hub
${platform_name}     Android
${platform_version}     13
${device_name}     Pixel 9 Pro
${app_name}     /Users/513007542/Downloads/Minimal-Todo-master/app/app-release.apk
${automation_name}     Uiautomator2

${timeout}    30s

*** Test Cases ***
SAA
    [Tags]    case_1
    ${day}    ${month}    ${year}    ${hour}    ${minute}    ${period}    Handle Calculate Date Time

    Open Application Set Up
    Verify Landing Mininal Reminder Page    there_is_reminder=${FALSE}
    Add Mininal Reminder    title=1ๅนสน    date=${NULL}    time=11:45:AM   toggle_minial_reminder_on=${TRUE}    confirm=${TRUE}  
    # Add Mininal Reminder    title=1ๅนสนdd    date=${NULL}    time=${NULL}   toggle_minial_reminder_on=${FALSE}    confirm=${TRUE}     
    

    




