*** Settings ***
Resource    ${CURDIR}/../../../../ttb_automation_test/resource/library.robot
Resource    ${CURDIR}/../../../../ttb_automation_test/keyword/api/common.robot
Resource    ${CURDIR}/../../../../ttb_automation_test/resource/api/endpoint.robot
Resource    ${CURDIR}/../../../../ttb_automation_test/resource/api/url.robot


*** Keywords ***
Send Get Request For Get Users
    [Arguments]    ${value}
    ${response_data}    ${response_code}    Send Get Request    url=${reqres_url}    endpoint=${users_endpoint}    value=${value} 
    RETURN    ${response_data}    ${response_code}

Verify Response For Get Users
    [Arguments]    ${response_data}    ${response_code}    ${expected_code}    
    ...    ${id}=${NULL}    
    ...    ${email}=${NULL}
    ...    ${first_name}=${NULL}
    ...    ${last_name}=${NULL}
    ...    ${avatar}=${NULL}
    ...    ${error_case}=${FALSE}
    Should Be Equal As Strings    ${response_code}    ${expected_code}
    
    IF    '${error_case}'=='${FALSE}'
        Log    ${response_data}[data][id]
        Should Not Be Empty   ${response_data}
        Should Be Equal As Strings    ${response_data}[data][id]    ${id}
        Should Be Equal As Strings    ${response_data}[data][email]    ${email}
        Should Be Equal As Strings    ${response_data}[data][first_name]    ${first_name}
        Should Be Equal As Strings    ${response_data}[data][last_name]    ${last_name}
        Should Be Equal As Strings    ${response_data}[data][avatar]    ${avatar}
    ELSE
        Should Be Empty   ${response_data}
    END

    
    
