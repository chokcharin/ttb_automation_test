*** Settings ***
Resource    ${CURDIR}/../../../../ttb_automation_test/resource/library.robot
Resource    ${CURDIR}/../../../../ttb_automation_test/keyword/mobile/common.robot
Resource    ${CURDIR}/../../../../ttb_automation_test/resource/mobile/locator/minimal/minimal_login.robot
Resource    ${CURDIR}/../../../../ttb_automation_test/resource/mobile/locator/minimal/minimal_reminder_add_page.robot
Resource    ${CURDIR}/../../../../ttb_automation_test/resource/mobile/locator/minimal/minimal_remider_togle_on.robot
Resource    ${CURDIR}/../../../../ttb_automation_test/resource/mobile/locator/minimal/minimal_reminder_select_time_page.robot
Resource    ${CURDIR}/../../../../ttb_automation_test/resource/mobile/locator/minimal/minimal_reminder_select_date.robot
Library    AppiumLibrary

*** Keywords ***
Find Reminder Item
    [Arguments]    ${title}=${NULL}
    Wait Until Element Is Visible    locator=${added_reminder_lists_locator}    timeout=${timeout}
    ${added_reminder_list}    Get WebElements    locator=${added_reminder_lists_locator}
    ${added_reminder_list}    Get Length    ${added_reminder_list}
    FOR    ${counter}    IN RANGE    ${1}    ${added_reminder_list+${1}}  
            ${added_reminder_name_locator}    Set Variable    xpath=//android.view.ViewGroup[@resource-id="com.avjindersinghsekhon.minimaltodo:id/myCoordinatorLayout"]/android.support.v7.widget.RecyclerView/android.widget.LinearLayout[${counter}]/android.widget.RelativeLayout/android.widget.TextView[1]  
            ${added_reminder_date_time_locator}    Set Variable    xpath=//android.view.ViewGroup[@resource-id="com.avjindersinghsekhon.minimaltodo:id/myCoordinatorLayout"]/android.support.v7.widget.RecyclerView/android.widget.LinearLayout[${counter}]/android.widget.RelativeLayout/android.widget.TextView[2]  
            ${assert_title}    Run Keyword And Return Status    Get Element By Attribute And Should Be Equal As Strings    locator=${added_reminder_name_locator}    attribute=text    expected=${title}    timeout=${timeout}
            ${assert_date_time}    Run Keyword And Return Status    Wait Until Element Is Visible    locator=${added_reminder_date_time_locator}    timeout=${timeout}

            Exit For Loop If    '${assert_title}' =='${TRUE}'
    END
    ${added_reminder_date_time_locator}    Set Variable If    '${assert_date_time}' =='${TRUE}'    ${added_reminder_date_time_locator}    ${NULL}
    Run Keyword If    '${assert_title}' =='${FALSE}'    Fail
    RETURN    ${title}    ${added_reminder_name_locator}    ${added_reminder_date_time_locator}

Delete Reminder Item
    [Arguments]    ${title}=${NULL}
        ${title}    ${locator}    ${date_time}    Find Reminder Item    title=${title}
        ${x1}    ${y1}    ${x2}    ${y2}    Get Bounds    locator=${locator}
        Swipe    start_x=${x1}    start_y=${y1}    offset_x=${x2}    offset_y=${y2}

Verify Landing Mininal Reminder Page
    [Arguments]    ${there_is_reminder}=${TRUE}    ${title}=${NULL}    ${added_full_time_reminder}=${NULL}    ${toggle_minial_reminder_on}=${TRUE}
    
    IF    ${there_is_reminder}==${TRUE}
        ${is_string}      Evaluate    $title[0].isalpha()
        ${title}    Run Keyword If    '${is_string}'=='${TRUE}'    Convert To Title Case    ${title}    ELSE    Set Variable    ${title}

        ${title_actual}    ${added_reminder_name_locator}    ${added_reminder_date_time_locator}    Find Reminder Item    title=${title}
        Get Element By Attribute And Should Be Equal As Strings    locator=${added_reminder_name_locator}    timeout=${timeout}    attribute=text    expected=${title}    strp=${TRUE}
        IF    '${added_full_time_reminder}'=='${NULL}'
            Should Be Equal As Strings    ${added_reminder_date_time_locator}    ${NULL}
        ELSE
            Get Element By Attribute And Should Be Equal As Strings    locator=${added_reminder_date_time_locator}    timeout=${timeout}    attribute=text    expected=${added_full_time_reminder}    ignore_case=${TRUE}
        END
    ELSE
        Wait Until Element Is Visible    locator=${application_locator}    timeout=${timeout}
        Wait Until Element Is Visible    locator=${setting_button_locator}    timeout=${timeout}
        Wait Until Element Is Visible    locator=${add_reminder_button_locator}    timeout=${timeout}
    END

Verify Add Mininal Reminder Page
    [Arguments]    ${reminder_title}=${NULL}    ${date}=${NULL}    ${time}=${NULL}    ${case_first_time}=${TRUE}
    ...    ${ep_title_reminser}=${NULL}

    IF    '${case_first_time}'=='${TRUE}'
        Wait Until Element Is Visible    locator=${close_add_reminder_page_locator}    timeout=${timeout}
        Wait Until Element Is Visible    locator=${input_reminder_header_locator}    timeout=${timeout}
        Wait Until Element Is Visible    locator=${next_add_reminder_button_locator}    timeout=${timeout}
        Wait Until Element Is Visible    locator=${alarm_add_reminder_icon_locator}    timeout=${timeout}
        Wait Until Element Is Visible    locator=${add_reminder_toggle_header_locator}    timeout=${timeout}
        Wait Until Element Is Visible    locator=${add_reminder_toggle_locator}    timeout=${timeout}
        Get Element By Attribute And Should Be Equal As Strings    locator=${input_reminder_title_locator}    attribute=text    expected=${EMPTY}    timeout=${timeout}
        Get Element By Attribute And Should Be Equal As Strings    locator=${add_reminder_toggle_locator}    attribute=checked    expected=${FALSE}    ignore_case=${TRUE}    timeout=${timeout}
    ELSE
        Log    message
    END
    
Add Mininal Reminder
    [Arguments]    ${title}=${NULL}    ${next_date}=${NULL}    ${last_date}=${NULL}    ${confirm}=${TRUE}    ${toggle_minial_reminder_on}=${TRUE}    ${select_time}=${FALSE}
    
    Wait And Click Element    locator=${add_reminder_button_locator}    timeout=${timeout}
    Wait And Input Text    locator=${input_reminder_title_locator}   text=${title}    timeout=${timeout}
    
    IF    '${toggle_minial_reminder_on}'=='${TRUE}'
        Wait And Click Element    locator=${add_reminder_toggle_locator}    timeout=${timeout}
    END        
    
    ${day_d}    ${month}    ${year}    ${hour_d}    ${minute}    ${calculated_hour}    ${calculated_minute}    ${period}    Handle Calculate Date Time    next_date=${next_date}    last_date=${last_date}
    
    IF    '${next_date}'!='${NULL}' and '${last_date}'=='${NULL}'
        ${day}    Set Variable    ${next_date.split()[0]} 
        ${hour}  Set Variable    ${next_date.split()[2]}
        ${minute}    Set Variable    ${next_date.split()[4]}

        ${time}    Set Variable If    '${minute}'=='0' and '${hour}'=='0'   ${NULL}    ${hour_d}:${calculated_minute}:${period}
        ${date}    Set Variable If    '${day}'=='0'   ${NULL}    ${day_d} ${month} ${year}

    ELSE IF    '${last_date}'!='${NULL}' and '${next_date}'=='${NULL}'
        ${day}    Set Variable    ${last_date.split()[0]} 
        ${hour}  Set Variable    ${last_date.split()[2]}
        ${minute}    Set Variable    ${last_date.split()[4]}

        ${time}    Set Variable If    '${minute}'=='0' and '${hour}'=='0'    ${NULL}    ${hour_d}:${calculated_minute}:${period}
        ${date}    Set Variable If    '${day}'=='0'   ${NULL}    ${day_d} ${month} ${year}
    
    ELSE IF    '${last_date}'=='${NULL}' and '${next_date}'=='${NULL}'
        ${time}    Set Variable    ${NULL}
        ${date}    Set Variable    ${NULL}
    END
        

    IF    '${confirm}'=='${TRUE}' and '${date}'=='${NULL}' and '${time}'=='${NULL}' and '${select_time}'=='${FALSE}'
        Wait And Click Element    locator=${next_add_reminder_button_locator}    timeout=${timeout}

    ELSE IF    '${confirm}'=='${TRUE}' and '${date}'=='${NULL}' and '${time}'=='${NULL}' and '${select_time}'=='${TRUE}'
        Wait And Click Element    locator=${minimal_reminder_time_button_locator}    timeout=${timeout}
        Wait And Click Element    locator=${time_ok}    timeout=${timeout}
        Wait And Click Element    locator=${next_add_reminder_button_locator}    timeout=${timeout}
    ELSE IF    '${confirm}'=='${TRUE}' and '${date}'=='${NULL}' and '${time}'!='${NULL}'
        Add Time    time=${time}
        Wait And Click Element    locator=${next_add_reminder_button_locator}    timeout=${timeout}
    ELSE IF    '${confirm}'=='${TRUE}' and '${date}'!='${NULL}' and '${time}'=='${NULL}'
        Add Date    date=${date}
        Wait And Click Element    locator=${next_add_reminder_button_locator}    timeout=${timeout}
    ELSE IF    '${confirm}'=='${TRUE}' and '${date}'!='${NULL}' and '${time}'!='${NULL}'
        Add Date    date=${date}
        Add Time    time=${time}
        Wait And Click Element    locator=${next_add_reminder_button_locator}    timeout=${timeout}
    ELSE IF    '${confirm}'!='${TRUE}'
        Wait And Click Element    locator=${close_add_reminder_page_locator}    timeout=${timeout}
    END
    RETURN    ${day_d}    ${month}    ${year}    ${hour_d}    ${minute}    ${calculated_hour}    ${calculated_minute}    ${period} 

Add Time
    [Arguments]    ${time}=${NULL}    ${time_default}=${TRUE}

    ${day}    ${month}    ${year}    ${hour}    ${minute}    ${calculated_hour}    ${calculated_minute}    ${period}    Handle Calculate Date Time

    IF    '${time_default}'!='${FALSE}'
        ${select_hour}    Set Variable    ${time.split(':')[0].lstrip('0')}
        ${select_minute}    Set Variable    ${time.split(':')[1]}
        ${select_period}    Set Variable    ${time.split(':')[2]}
    ELSE
        ${current_minute}    Set Variable    ${minute}
        ${current_minute}    Convert To Integer    ${minute}
        ${rounded_minute}    Evaluate    (int(${current_minute}) + 4) // 5 * 5
        ${rounded_minute}    Set Variable If    '${rounded_minute}'=='60'    00    ${rounded_minute}
        ${rounded_minute_str}    Evaluate    f"{int(${rounded_minute}):02}"
    
        ${select_hour}    Set Variable    ${hour}
        ${select_minute}    Set Variable    ${rounded_minute_str}
        ${select_period}    Set Variable    ${period}
    END

    Wait And Click Element    locator=${minimal_reminder_time_button_locator}    timeout=${timeout}

    @{am_button}    create list    ${395}    ${1642}
    @{pm_button}    create list    ${902}    ${1642}
    
    IF    '${select_period}'=='AM'
        Tap with Positions    ${1000}    ${am_button}
    ELSE
        Tap with Positions    ${1000}    ${pm_button}
    END

    ${date_time_data}    Load Json From File    file_name=${CURDIR}/../../../../ttb_automation_test/resource/mobile/test_data.json
    ${select_hour}    Set Variable    ${date_time_data["data"]["hours"]["${select_hour}"]}
    ${select_minute}    Set Variable    ${date_time_data["data"]["minute"]["${select_minute}"]}
    
    Tap with Positions    ${1000}    ${select_hour}
    Tap with Positions    ${1000}    ${select_minute}
    Wait And Click Element    locator=${time_ok}    timeout=${timeout}

Add Date
    [Arguments]    ${date}=${NULL}
    ${current_date}    Get Current Date    result_format=%d %B %Y
    ${date}    Convert Date    ${date}    date_format=%d %b %Y    result_format=%d %B %Y
    ${date}    Set Variable If    '${date}'=='${NULL}'    ${current_date}    ${date}
    Wait And Click Element    locator=${minimal_reminder_date_button_locator}    timeout=${timeout}

    ${x1}    ${y1}    ${x2}    ${y2}    Get Bounds    locator=${calendat}
    ${x1}    Convert To Integer    ${x1}
    ${y1}    Convert To Integer    ${y1}
    ${x2}    Convert To Integer    ${x2}
    ${y2}    Convert To Integer    ${y2}
    
    ${find_date}    Set Variable    ${FALSE}
    ${date_compare}    Convert Date    ${date}    date_format=%d %B %Y  
    ${current_date_compare}    Convert Date    ${current_date}    date_format=%d %B %Y
    ${date_compare}    Convert Date    ${date_compare}    result_format=epoch
    ${current_date_compare}    Convert Date    ${current_date_compare}    result_format=epoch
   
    WHILE    '${find_date}'=='${FALSE}'
        IF    $current_date_compare == $date_compare
                ${find_date}    Run Keyword And Return Status    Wait Until Element Is Visible    locator=xpath=//android.view.View[@content-desc="${date} selected"]   timeout=${timeout}
            ELSE IF    $current_date_compare > $date_compare
                ${find_date}    Run Keyword And Return Status    Wait Until Element Is Visible    locator=xpath=//android.view.View[@content-desc="${date}"]   timeout=${timeout}
                Run Keyword If    '${find_date}'=='${FALSE}'    Swipe    start_x=${x1}    start_y=${y1}    offset_x=${x2}    offset_y=${y2}
                Run Keyword If    '${find_date}'=='${TRUE}'    Wait And Click Element    locator=xpath=//android.view.View[@content-desc="${date}"]   timeout=${timeout}
            ELSE IF    $current_date_compare < $date_compare
                ${y2_cal}    Evaluate    (${50}/${y2})*100
                ${y2}    Evaluate   ${y2} - ${y2}*(${y2_cal}/100)
                ${find_date}    Run Keyword And Return Status    Wait Until Element Is Visible    locator=xpath=//android.view.View[@content-desc="${date}"]   timeout=${timeout}
                Run Keyword If    '${find_date}'=='${FALSE}'    Swipe    start_x=${x1}    start_y=${y2}    offset_x=${x2}    offset_y=${y1}
                Run Keyword If    '${find_date}'=='${TRUE}'    Wait And Click Element    locator=xpath=//android.view.View[@content-desc="${date}"]   timeout=${timeout}
            END
            Exit For Loop If    '${find_date}'=='${TRUE}'
    END
    Wait And Click Element    locator=${time_ok}   timeout=${timeout}

Handle Calculate Date Time
    [Arguments]    ${next_date}=${NULL}    ${last_date}=${NULL}
    ${date_time}    Get Current Date    result_format=%d %b %Y %I %M %p
    IF    '${next_date}'!='${NULL}'
        ${future_date_time}    Get Current Date    result_format=%Y-%m-%d %H:%M:%S.%f
        ${date_time}    Add Time To Date    date=${future_date_time}    time=${next_date}    result_format=%d %b %Y %I %M %p
    ELSE IF    '${last_date}'!='${NULL}'
        ${last_date_time}    Get Current Date    result_format=%Y-%m-%d %H:%M:%S.%f
        ${date_time}    Subtract Time From Date    date=${last_date_time}    time=${last_date}   result_format=%d %b %Y %I %M %p
    END
    
    ${day}    Set Variable    ${date_time.split()[0]} 
    ${month}  Set Variable    ${date_time.split()[1]}
    ${year}   Set Variable    ${date_time.split()[2]}
    ${hour}    Set Variable    ${date_time.split()[3].lstrip('0')}
    ${calculated_hour}    Set Variable    ${date_time.split()[3].lstrip('0')}
    ${calculated_hour}    Convert To Integer    ${calculated_hour}
    ${calculated_hour}    Set Variable If   '${calculated_hour}' =='12'    ${0}    ${calculated_hour}
    ${calculated_hour}    Evaluate    ${calculated_hour}+${1}
    ${minute}    Set Variable    ${date_time.split()[4]}
    ${period}    Set Variable    ${date_time.split()[5]}


    ${current_minute}    Set Variable    ${minute}
    ${current_minute}    Convert To Integer    ${minute}
    ${rounded_minute}    Evaluate    (int(${current_minute}) + 4) // 5 * 5
    ${rounded_minute}    Set Variable If    '${rounded_minute}'=='60'    00    ${rounded_minute}
    ${rounded_minute_str}    Evaluate    f"{int(${rounded_minute}):02}"

    ${select_hour}    Set Variable    ${hour}
    ${select_minute}    Set Variable    ${rounded_minute_str}
    ${select_period}    Set Variable    ${period}
    ${calculated_minute}    Set Variable    ${select_minute}

    IF    '${calculated_minute}'=='00'
        ${calculated_minute}    Convert To Integer    ${calculated_minute}
        ${calculated_minute}    Evaluate    ${calculated_minute}+${5}     
        ${calculated_minute}    Evaluate    f"{int(${calculated_minute}):02}"   
    END
    
    RETURN    ${day}    ${month}    ${year}    ${hour}    ${minute}    ${calculated_hour}    ${calculated_minute}    ${period}

Update Minimal Reminder Item
    [Arguments]    ${from_title}=${NULL}    ${new_title}=${NULL}    ${next_date}=${NULL}    ${last_date}=${NULL}    ${toggle_minial_reminder_on}=${TRUE}

    ${title}    ${added_reminder_name_locator}    ${added_reminder_date_time_locator}    Find Reminder Item    title=${from_title}
    ${date_time}    Get Element Attribute    locator=${added_reminder_name_locator}    attribute=text
    Wait And Click Element    locator=${added_reminder_name_locator}    timeout=${timeout}
    
    Wait Until Element Is Visible    locator=${input_reminder_title_locator}    timeout=${timeout}


    ${check_toggle}    Get Element Attribute    ${add_reminder_toggle_locator}    attribute=checked
    ${day_d}    ${month}    ${year}    ${hour_d}    ${minute}    ${calculated_hour}    ${calculated_minute}    ${period}    Handle Calculate Date Time    next_date=${next_date}    last_date=${last_date}
    

    IF    '${next_date}'!='${NULL}' and '${last_date}'=='${NULL}'
        ${day}    Set Variable    ${next_date.split()[0]} 
        ${hour}  Set Variable    ${next_date.split()[2]}
        ${minute}    Set Variable    ${next_date.split()[4]}

        ${time}    Set Variable If    '${minute}'=='0' and '${hour}'=='0'   ${NULL}    ${hour_d}:${calculated_minute}:${period}
        ${date}    Set Variable If    '${day}'=='0'   ${NULL}    ${day_d} ${month} ${year}

    ELSE IF    '${last_date}'!='${NULL}' and '${next_date}'=='${NULL}'
        ${day}    Set Variable    ${last_date.split()[0]} 
        ${hour}  Set Variable    ${last_date.split()[2]}
        ${minute}    Set Variable    ${last_date.split()[4]}

        ${time}    Set Variable If    '${minute}'=='0' and '${hour}'=='0'    ${NULL}    ${hour_d}:${calculated_minute}:${period}
        ${date}    Set Variable If    '${day}'=='0'   ${NULL}    ${day_d} ${month} ${year}
    ELSE IF    '${last_date}'=='${NULL}' and '${next_date}'=='${NULL}'
        ${time}    Set Variable    ${NULL}
        ${date}    Set Variable    ${NULL}
    END

    IF    '${new_title}'!='${NULL}'
        Clear Text    locator=${input_reminder_title_locator}
        Wait And Input Text    locator=${input_reminder_title_locator}   text=${new_title}    timeout=${timeout}
    END

    IF   '${check_toggle}'=='true' and '${toggle_minial_reminder_on}'=='${FALSE}'
        Wait And Click Element    locator=${add_reminder_toggle_locator}    timeout=${timeout}
        Wait And Click Element    locator=${next_add_reminder_button_locator}    timeout=${timeout}
    END
    
    IF    '${date}'!='${NULL}' and '${time}'!='${NULL}' and '${toggle_minial_reminder_on}'=='${TRUE}'
        Add Date    date=${date}
        Add Time    time=${time}
        Wait And Click Element    locator=${next_add_reminder_button_locator}    timeout=${timeout}
    ELSE IF    '${date}'!='${NULL}' and '${time}'=='${NULL}' and '${toggle_minial_reminder_on}'=='${TRUE}'
        Add Date    date=${date}
        Wait And Click Element    locator=${next_add_reminder_button_locator}    timeout=${timeout}
    ELSE IF    '${date}'=='${NULL}' and '${time}'!='${NULL}' and '${toggle_minial_reminder_on}'=='${TRUE}'
        Add Time    time=${time}
        Wait And Click Element    locator=${next_add_reminder_button_locator}    timeout=${timeout}
    END
    
    RETURN    ${day_d}    ${month}    ${year}    ${hour_d}    ${minute}    ${calculated_hour}    ${calculated_minute}    ${period}    
    
    

