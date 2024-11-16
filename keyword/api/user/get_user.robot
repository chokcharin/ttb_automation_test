*** Settings ***
Resource    ${CURDIR}/../../../../ttb_automation_test/resource/library.robot
Resource    ${CURDIR}/../../../../ttb_automation_test/keyword/api/common.robot
Resource    ${CURDIR}/../../../../ttb_automation_test/resource/api/endpoint.robot
Resource    ${CURDIR}/../../../../ttb_automation_test/resource/api/url.robot


*** Keywords ***
Send Get Request For Users
    [Arguments]    ${value}
    ${response_data}    ${response_code}    Send Get Request    url=${reqres_url}    endpoint=${users_endpoint}    value=${value} 
    RETURN    ${response_data}    ${response_code}
