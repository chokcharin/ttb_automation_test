*** Settings ***
Resource    ${CURDIR}/../../../../ttb_automation_test/resource/library.robot
Resource    ${CURDIR}/../../../../ttb_automation_test/keyword/mobile/common.robot
Resource    ${CURDIR}/../../../../ttb_automation_test/resource/mobile/locator/minimal/minimal_login.robot
Resource    ${CURDIR}/../../../../ttb_automation_test/resource/mobile/locator/minimal/minimal_reminder_add_page.robot
Resource    ${CURDIR}/../../../../ttb_automation_test/resource/mobile/locator/minimal/minimal_remider_togle_on.robot
Resource    ${CURDIR}/../../../../ttb_automation_test/resource/mobile/locator/minimal/minimal_reminder_select_time_page.robot

Library    AppiumLibrary
*** Variables ***
${start_x}    ${259}
${start_y}    ${1100}    # Bottom of the bounds
${end_x}    ${1021}
${end_y}    ${1800}

*** Keywords ***
Find Reminder Item
    [Arguments]    ${added_full_time_reminder}=${NULL}    ${title}=${NULL}
    Wait Until Element Is Visible    locator=${added_reminder_lists_locator}    timeout=${timeout}
    ${added_reminder_list}    Get WebElements    locator=${added_reminder_lists_locator}
    ${added_reminder_list}    Get Length    ${added_reminder_list}
    FOR    ${counter}    IN RANGE    ${1}    ${added_reminder_list+${1}}  
            ${added_reminder_name_locator}    Set Variable    xpath=//android.view.ViewGroup[@resource-id="com.avjindersinghsekhon.minimaltodo:id/myCoordinatorLayout"]/android.support.v7.widget.RecyclerView/android.widget.LinearLayout[${counter}]/android.widget.RelativeLayout/android.widget.TextView[1]  
            ${added_reminder_date_time_locator}    Set Variable    xpath=//android.view.ViewGroup[@resource-id="com.avjindersinghsekhon.minimaltodo:id/myCoordinatorLayout"]/android.support.v7.widget.RecyclerView/android.widget.LinearLayout[${counter}]/android.widget.RelativeLayout/android.widget.TextView[2]  
            ${assert_title}    Run Keyword And Return Status    Get Element By Attribute And Should Be Equal As Strings    locator=${added_reminder_name_locator}    attribute=text    expected=${title}    timeout=${timeout}
            IF    '${added_full_time_reminder}'=='${TRUE}'
                ${assert_date_time}    Run Keyword And Return Status    Get Element By Attribute And Should Be Equal As Strings    locator=${added_reminder_date_time_locator}    attribute=text    expected=${added_full_time_reminder}    timeout=${timeout}
                Exit For Loop If    '${assert_date_time}' =='${TRUE}'
            ELSE
                ${assert_date_time}    Run Keyword And Return Status    Page Should Not Contain Element    locator=${added_reminder_date_time_locator}
                Exit For Loop If    '${assert_date_time}' =='${TRUE}'
            END 
        END

Verify Landing Mininal Reminder Page
    [Arguments]    ${there_is_reminder}=${TRUE}    ${title}=${NULL}    ${added_full_time_reminder}=${NULL}    ${toggle_minial_reminder_on}=${TRUE}
    
    IF    ${there_is_reminder}==${TRUE}
        ${is_string}      Evaluate    $title[0].isalpha()
        ${title}    Run Keyword If    '${is_string}'=='${TRUE}'    Convert To Title Case    ${title}    ELSE    Set Variable    ${title}

        Find Reminder Item    added_full_time_reminder=${added_full_time_reminder}    title=${title}
        
    ELSE
        ${test}    Get Text    locator=${login_page_title_locator}
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
    [Arguments]    ${title}=${NULL}    ${date}=${NULL}    ${time}=${NULL}    ${confirm}=${TRUE}    ${toggle_minial_reminder_on}=${TRUE}
    Log    ${toggle_minial_reminder_on}
    Wait And Click Element    locator=${add_reminder_button_locator}    timeout=${timeout}
    Wait And Input Text    locator=${input_reminder_title_locator}   text=${title}    timeout=${timeout}
    
    IF    '${toggle_minial_reminder_on}'=='${TRUE}'
        Wait And Click Element    locator=${add_reminder_toggle_locator}    timeout=${timeout}
    END        
    
    ${day}    ${month}    ${year}    ${hour}    ${minute}    ${period}    Handle Calculate Date Time
    
    IF    '${confirm}'=='${TRUE}' and '${date}'=='${NULL}' and '${time}'=='${NULL}'
        Wait And Click Element    locator=${next_add_reminder_button_locator}    timeout=${timeout}

        ${added_full_time_reminder}    Set Variable    ${month} ${day}, ${year} ${hour}:${minute} ${period}
        Verify Landing Mininal Reminder Page    title=${title}    added_full_time_reminder=${added_full_time_reminder}    toggle_minial_reminder_on=${toggle_minial_reminder_on}

    ELSE IF    '${confirm}'=='${TRUE}' and '${date}'=='${NULL}' and '${time}'!='${NULL}'
        Add Time    date=${date}    time=${time}
    ELSE IF    '${confirm}'=='${TRUE}' and '${date}'!='${NULL}' and '${time}'=='${NULL}'
        Log    message
    ELSE IF    '${confirm}'!='${TRUE}'
        Add Time    date=${date}    time=${time}
        Wait And Click Element    locator=${close_add_reminder_page_locator}    timeout=${timeout}
    END

Verify Reminder Toggle On
    [Arguments]    ${date}=${NULL}    ${time}=${time}

    IF    '${date}'!='${NULL}'
        Wait Until Element Is Visible    locator=${minimal_reminder_date_button_locator}    timeout=${timeout}
    ELSE IF    '${date}'!='${NULL}'
        Wait Until Element Is Visible    locator=${minimal_reminder_date_button_locator}    timeout=${timeout}
    END

Verify Time Date
    
    Wait Until Element Is Visible    locator=${minimal_reminder_date_button_locator}    timeout=${timeout}
    Wait Until Element Is Visible    locator=${minimal_reminder_at_sigh_locator}    timeout=${timeout}
    Wait Until Element Is Visible    locator=${minimal_reminder_time_button_locator}    timeout=${timeout}
    Wait Until Element Is Visible    locator=${minimal_reminder_date_time_description_locator}    timeout=${timeout}
    
    ${day}    ${month}    ${year}    ${hour}    ${minute}    ${period}    Handle Calculate Date Time
    ${minimal_remider_schesdule_decription}    Set Variable    Reminder set for ${day} ${month}, ${year}, ${hour}:00 ${period}
    Get Element By Attribute And Should Be Equal As Strings    locator=${minimal_reminder_date_time_description_locator}    attribute=text    expected=${minimal_remider_schesdule_decription}
    


Add Time
    [Arguments]    ${date}=${NULL}    ${time}=${NULL}    ${past}=${TRUE}

    ${day}    ${month}    ${year}    ${hour}    ${minute}    ${period}    Handle Calculate Date Time

    IF    '${past}'=='${FALSE}'
        ${select_hour}    Set Variable    ${time.split(':')[0].lstrip('0')}
        ${select_minute}    Set Variable    ${time.split(':')[1]}
        ${select_period}    Set Variable    ${time.split(':')[2]}
    ELSE
         ${current_minute}    Set Variable    ${minute}
        ${rounded_minute}    Evaluate    (int(${current_minute}) + 4) // 5 * 5  # Round up to nearest 5
        ${rounded_minute_str}    Evaluate    f"{int(${rounded_minute}):02}"  # Format as two digits
    
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

    
   

    # IF    '${time}'!='${NULL}'
    #     Log    message
    # ELSE IF    '${date}'=='${NULL}' and '${time}'=='${NULL}'
    #     Wait Until Element Is Visible    locator=${minimal_reminder_date_button_locator}    timeout=${timeout}
    #     Wait Until Element Is Visible    locator=${minimal_reminder_at_sigh_locator}    timeout=${timeout}
    #     Wait Until Element Is Visible    locator=${minimal_reminder_time_button_locator}    timeout=${timeout}
    #     Wait Until Element Is Visible    locator=${minimal_reminder_date_time_description_locator}    timeout=${timeout}
        
    #     ${day}    ${month}    ${year}    ${hour}    ${minute}    ${period}    Handle Calculate Date Time
    #     ${minimal_remider_schesdule_decription}    Set Variable    Reminder set for ${day} ${month}, ${year}, ${hour}:00 ${period}
    #     Get Element By Attribute And Should Be Equal As Strings    locator=${minimal_reminder_date_time_description_locator}    attribute=text    expected=${minimal_remider_schesdule_decription}
    # END

    # Wait And Click Element    locator=xpath=//android.widget.EditText[@resource-id="com.avjindersinghsekhon.minimaltodo:id/newTodoTimeEditText"]    
    # @{firstFinger}    create list    ${400}    ${1238}
    # Tap with Positions    ${1000}    ${firstFinger}

    # @{firstFinger2}    create list    ${868}    ${1355}
    # Tap with Positions    ${1000}    ${firstFinger2}


    # Wait And Click Element    locator=${minimal_reminder_date_button_locator}
    # ${minimal_reminder_date_locator}    Set Variable    xpath=//android.view.View[@content-desc="18 November 2024"]
    # Wait And Click Element    locator=${minimal_reminder_date_locator}
    

    
    # ${actual}    Get Element Attribute    locator=xpath=//android.widget.ListView    attribute=bounds
    # Swipe    start_x=${start_x}    start_y=${start_y}    offset_x=${end_x}    offset_y=${end_y}
    # Swipe    start_x=${start_x}    start_y=${start_y}    offset_x=${end_x}    offset_y=${end_y}
    # Swipe    start_x=${start_x}    start_y=${start_y}    offset_x=${end_x}    offset_y=${end_y}


    # Wait And Click Element    locator=xpath=//android.view.View[@content-desc="01 August 2024"]
   
    # ${actual}    Get Element Attribute    locator=xpath=//android.view.View[@content-desc="01 August 2024 selected"]    attribute=content-desc
    

Handle Calculate Date Time
    ${current_date_time}    Get Current Date    result_format=%d %b %Y %I %M %p
    ${day}    Set Variable    ${current_date_time.split()[0]} 
    ${month}  Set Variable    ${current_date_time.split()[1]}
    ${year}   Set Variable    ${current_date_time.split()[2]}
    ${hour}    Set Variable    ${current_date_time.split()[3].lstrip('0')}
    ${hour}    Convert To Integer    ${hour}
    ${hour}    Evaluate    ${hour}+${1}
    ${minute}    Set Variable    ${current_date_time.split()[4]}
    ${period}    Set Variable    ${current_date_time.split()[5]}
    
    RETURN    ${day}    ${month}    ${year}    ${hour}    ${minute}    ${period}

