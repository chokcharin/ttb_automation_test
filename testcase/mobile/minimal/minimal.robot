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

${timeout}    10s

*** Test Cases ***
minimal001
    [Documentation]    Add reminder case toggle=off
    [Tags]    case_1
    [Setup]    Open Application Set Up
    Verify Landing Mininal Reminder Page    there_is_reminder=${FALSE}
    Add Mininal Reminder    title=Running    next_date=${NULL}     last_date=${NULL}   toggle_minial_reminder_on=${FALSE}    confirm=${TRUE} 
    Verify Landing Mininal Reminder Page    title=Running    there_is_reminder=${TRUE}
    [Teardown]    Close Application
minimal002
    [Documentation]    Add reminder case date=no, time=no, toggle=on
    [Tags]    case_2
    [Setup]    Open Application Set Up
    Verify Landing Mininal Reminder Page    there_is_reminder=${FALSE}
    ${day}    ${month}    ${year}    ${hour_d}    ${minute}    ${calculated_hour}    ${calculated_minute}    ${period}    Add Mininal Reminder    title=Lotion    next_date=${NULL}     last_date=${NULL}   toggle_minial_reminder_on=${TRUE}    confirm=${TRUE} 
    ${added_full_time_reminder}    Set Variable    ${month} ${day}, ${year} ${SPACE}${calculated_hour}:00 ${period}
    Verify Landing Mininal Reminder Page    title=Lotion    there_is_reminder=${TRUE}    added_full_time_reminder=${added_full_time_reminder}

minimal003
    [Documentation]    Add reminder case date=future, time=no, toggle=on
    [Tags]    case_3
    [Setup]    Open Application Set Up
    Verify Landing Mininal Reminder Page    there_is_reminder=${FALSE}
    ${day}    ${month}    ${year}    ${hour_d}    ${minute}    ${calculated_hour}    ${calculated_minute}    ${period}    Add Mininal Reminder    title=Dining    next_date=30 days 0 hours 0 minutes    last_date=${NULL}   toggle_minial_reminder_on=${TRUE}    confirm=${TRUE} 
    ${added_full_time_reminder}    Set Variable    ${month} ${day}, ${year} ${SPACE}${calculated_hour}:00 AM
    Verify Landing Mininal Reminder Page    title=Dining    there_is_reminder=${TRUE}    added_full_time_reminder=${added_full_time_reminder}

minimal004
    [Documentation]    Add reminder case date=no, time=future, toggle=on
    [Tags]    case_4
    [Setup]    Open Application Set Up
    Verify Landing Mininal Reminder Page    there_is_reminder=${FALSE}
    ${day}    ${month}    ${year}    ${hour}    ${minute}    ${calculated_hour}    ${calculated_minute}    ${period}    Add Mininal Reminder    title=Running    next_date=0 days 1 hours 50 minutes    last_date=${NULL}   toggle_minial_reminder_on=${TRUE}    confirm=${TRUE} 
    ${added_full_time_reminder}    Set Variable    ${month} ${day}, ${year} ${SPACE}${hour}:${calculated_minute} ${period}
    Verify Landing Mininal Reminder Page    title=Running    there_is_reminder=${TRUE}    added_full_time_reminder=${added_full_time_reminder}

minimal005
    [Documentation]    Add reminder case date=no, time=past, toggle=on
    [Tags]    case_5
    [Setup]    Open Application Set Up
    Verify Landing Mininal Reminder Page    there_is_reminder=${FALSE}
    ${day}    ${month}    ${year}    ${hour}    ${minute}    ${calculated_hour}    ${calculated_minute}    ${period}    Add Mininal Reminder    title=Running    next_date=${NULL}    last_date=0 days 1 hours 50 minutes   toggle_minial_reminder_on=${TRUE}    confirm=${TRUE} 
    Verify Landing Mininal Reminder Page    there_is_reminder=${False}

minimal006
    [Documentation]    Add reminder case date=past, time=past, toggle=on
    [Tags]    case_6
    [Setup]    Open Application Set Up
    Verify Landing Mininal Reminder Page    there_is_reminder=${FALSE}
    ${day}    ${month}    ${year}    ${hour}    ${minute}    ${calculated_hour}    ${calculated_minute}    ${period}    Add Mininal Reminder    title=Running    next_date=${NULL}    last_date=30 days 1 hours 50 minutes   toggle_minial_reminder_on=${TRUE}    confirm=${TRUE} 
    Verify Landing Mininal Reminder Page    there_is_reminder=${False}

minimal007
    [Documentation]    Update reminder rename, toggle=off
    [Tags]    case_7
    [Setup]    Open Application Set Up
    Verify Landing Mininal Reminder Page    there_is_reminder=${FALSE}
    ${day}    ${month}    ${year}    ${hour}    ${minute}    ${calculated_hour}    ${calculated_minute}    ${period}    Add Mininal Reminder    title=Running    next_date=30 days 1 hours 50 minutes     last_date=${NULL}   toggle_minial_reminder_on=${TRUE}    confirm=${TRUE} 
    ${added_full_time_reminder}    Set Variable    ${month} ${day}, ${year} ${SPACE}${hour}:${calculated_minute} ${period}
    Verify Landing Mininal Reminder Page    title=Running    there_is_reminder=${TRUE}    added_full_time_reminder=${added_full_time_reminder}
    Update Minimal Reminder Item    from_title=Running    new_title=Walking    next_date=${NULL}    last_date=${NULL}    toggle_minial_reminder_on=${FALSE}
    Verify Landing Mininal Reminder Page    title=Walking    there_is_reminder=${TRUE}
    [Teardown]    Close Application

minimal008
    [Documentation]    Update reminder, update date and time to futre
    [Tags]    case_8
    [Setup]    Open Application Set Up
    Verify Landing Mininal Reminder Page    there_is_reminder=${FALSE}
    ${day}    ${month}    ${year}    ${hour}    ${minute}    ${calculated_hour}    ${calculated_minute}    ${period}    Add Mininal Reminder    title=Running    next_date=1 days 1 hours 50 minutes     last_date=${NULL}   toggle_minial_reminder_on=${TRUE}    confirm=${TRUE} 
    ${added_full_time_reminder}    Set Variable    ${month} ${day}, ${year} ${SPACE}${hour}:${calculated_minute} ${period}
    Verify Landing Mininal Reminder Page    title=Running    there_is_reminder=${TRUE}    added_full_time_reminder=${added_full_time_reminder}
    ${day}    ${month}    ${year}    ${hour}    ${minute}    ${calculated_hour}    ${calculated_minute}    ${period}    Update Minimal Reminder Item    from_title=Running    new_title=Walking    next_date=30 days 2 hours 45 minutes    last_date=${NULL}    toggle_minial_reminder_on=${TRUE}
    ${added_full_time_reminder}    Set Variable    ${month} ${day}, ${year} ${SPACE}${hour}:${calculated_minute} ${period}
    Verify Landing Mininal Reminder Page    title=Walking    there_is_reminder=${TRUE}    added_full_time_reminder=${added_full_time_reminder}
    [Teardown]    Close Application

minimal009
    [Documentation]    Update reminder, update date and time to past
    [Tags]    case_9
    [Setup]    Open Application Set Up
    Verify Landing Mininal Reminder Page    there_is_reminder=${FALSE}
    ${day}    ${month}    ${year}    ${hour}    ${minute}    ${calculated_hour}    ${calculated_minute}    ${period}    Add Mininal Reminder    title=Running    next_date=1 days 1 hours 20 minutes     last_date=${NULL}   toggle_minial_reminder_on=${TRUE}    confirm=${TRUE} 
    ${added_full_time_reminder}    Set Variable    ${month} ${day}, ${year} ${SPACE}${hour}:${calculated_minute} ${period}
    Verify Landing Mininal Reminder Page    title=Running    there_is_reminder=${TRUE}    added_full_time_reminder=${added_full_time_reminder}
    ${day_u}    ${month_u}    ${year_u}    ${hour_u}    ${minute_u}    ${calculated_hour_u}    ${calculated_minute_u}    ${period_u}    Update Minimal Reminder Item    from_title=Running    new_title=Walking    next_date=${NULL}    last_date=30 days 2 hours 15 minutes    toggle_minial_reminder_on=${TRUE}
    ${added_full_time_reminder}    Set Variable    ${month} ${day}, ${year} ${SPACE}${hour_u}:${calculated_minute_u} ${period_u}
    Verify Landing Mininal Reminder Page    title=Walking    there_is_reminder=${TRUE}    added_full_time_reminder=${added_full_time_reminder}
    [Teardown]    Close Application

minimal010
    [Documentation]    Update reminder, update date to future
    [Tags]    case_10
    [Setup]    Open Application Set Up
    Verify Landing Mininal Reminder Page    there_is_reminder=${FALSE}
    ${day}    ${month}    ${year}    ${hour}    ${minute}    ${calculated_hour}    ${calculated_minute}    ${period}    Add Mininal Reminder    title=Ant1    next_date=1 days 1 hours 20 minutes     last_date=${NULL}   toggle_minial_reminder_on=${TRUE}    confirm=${TRUE} 
    ${day}    ${month}    ${year}    ${hour}    ${minute}    ${calculated_hour}    ${calculated_minute}    ${period}    Add Mininal Reminder    title=Bird2    next_date=30 days 2 hours 15 minutes     last_date=${NULL}   toggle_minial_reminder_on=${TRUE}    confirm=${TRUE} 
    ${day}    ${month}    ${year}    ${hour}    ${minute}    ${calculated_hour}    ${calculated_minute}    ${period}    Add Mininal Reminder    title=Cat3    next_date=2 days 3 hours 30 minutes     last_date=${NULL}   toggle_minial_reminder_on=${TRUE}    confirm=${TRUE} 
    
    Delete Reminder Item    title=Ant1
    Delete Reminder Item    title=Bird2
    Delete Reminder Item    title=Cat3
    
    Verify Landing Mininal Reminder Page    there_is_reminder=${False}
    [Teardown]    Close Application
    





