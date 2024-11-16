*** Settings ***
Resource    ${CURDIR}/../../../../ttb_automation_test/resource/library.robot
Resource    ${CURDIR}/../../../../ttb_automation_test/keyword/web/common.robot
Resource    ${CURDIR}/../../../../ttb_automation_test/resource/web/localization/herokuapp/login.robot
Resource    ${CURDIR}/../../../../ttb_automation_test/resource/web/locator/herokuapp/login.robot

*** Keywords ***
Verify Login Landing
    Wait Element And Assert As String    locator=${login_page_title_locator}    expected=${login_page_title}[${language}]
    Wait Until Element Is Visible    locator=${fork_me_img_locator}    timeout=${timeout}
    Element Should Not Be Visible    locator=${flash_locator}
    Wait Element And Assert As String    locator=${page_description_locator}    expected=${page_description}[${language}]
    Wait Element And Assert As String    locator=${input_username_description_locator}    expected=${input_username_description}[${language}]
    Wait Until Element Is Visible   locator=${username_login_locator}
    Wait Element And Assert As String    locator=${input_password_description_locator}    expected=${input_password_description}[${language}]
    Wait Until Element Is Visible    locator=${password_login_locator}
    Wait Element And Assert As String    locator=${login_button_locator}    expected=${login_button}[${language}]
    Wait Element And Assert As String    locator=${login_footer_locator}    expected=${login_footer}[${language}]

Input Username And Password
    [Arguments]    ${username}    ${password}    ${pass}=${TRUE}    ${valid_username}=${NULL}    ${valid_password}=${NULL}
        Input Text    locator=${username_login_locator}    text=${username}
        Input Password    locator=${password_login_locator}    password=${password}
        Click Element    locator=${login_button_locator}

    IF    '${pass}'=='${TRUE}'
        Verify Secure Area Page
        Click Element    locator=${logout_button_locator}
        Wait Element And Assert As String    locator=${flash_locator}    expected=${logout_success_flash}[${language}]
    ELSE IF    '${pass}'!='${TRUE}' and '${valid_username}'=='${TRUE}' and '${valid_password}'!='${TRUE}' 
        Wait Element And Assert As String    locator=${flash_locator}    expected=${invalid_password_flash}[${language}]
    ELSE IF    '${pass}'!='${TRUE}' and '${valid_username}'!='${TRUE}'
        Wait Element And Assert As String    locator=${flash_locator}    expected=${invalid_username_flash}[${language}]
    END


Verify Secure Area Page
    Wait Until Element Is Visible    locator=${fork_me_img_locator}    timeout=${timeout}
    Wait Element And Assert As String    locator=${flash_locator}    expected=${login_success_flash}[${language}]
    Wait Element And Assert As String    locator=${secure_area_title_locator}    expected=${secure_area_title}[${language}]
    Wait Element And Assert As String    locator=${login_success_description_locator}    expected=${login_success_description}[${language}]
    Wait Element And Assert As String    locator=${logout_button_locator}    expected=${logout_button}[${language}]
    Wait Element And Assert As String    locator=${login_footer_locator}    expected=${login_footer}[${language}]