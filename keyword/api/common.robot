*** Settings ***
Resource    ${CURDIR}/../../../ttb_automation_test/resource/library.robot

*** Keywords ***
Send Get Request
    [Arguments]    ${url}=${NULL}    ${endpoint}=${NULL}   ${headers}=${NULL}    ${params}=${NULL}    ${value}=${NULL}    ${header_value}=${NULL}
    Create Session    alias=get_data    url=${url}

    ${endpoint}    Set Variable If    '${params}'=='${NULL}'    ${endpoint}/${value}    ${endpoint}

    ${resp_google}    GET On Session    alias=get_data    url=${endpoint}    params=${params}    headers=${headers}    expected_status=anything 
    ${response_data}    Set Variable    ${resp_google.json()}
    ${response_code}    Set Variable    ${resp_google.status_code}

    RETURN    ${response_data}    ${response_code}