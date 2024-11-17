*** Settings ***
Resource    ${CURDIR}/../../../ttb_automation_test/resource/library.robot
Resource    ${CURDIR}/../../../ttb_automation_test/keyword/api/user/get_user.robot

*** Test Cases ***
Get user profile success
    [Documentation]    To verify get user profile api will return correct data when trying to get profile of existing user
    ${response_data}    ${response_code}    Send Get Request For Get Users    value=${12}
    Verify Response For Get Users    response_data=${response_data}    response_code=${response_code}    
    ...    expected_code=${200}    
    ...    id=${12}
    ...    email=rachel.howell@reqres.in
    ...    first_name=Rachel
    ...    last_name=Howell
    ...    avatar=https://reqres.in/img/faces/12-image.jpg
    ...    error_case=${FALSE}

Get user profile but user not found
    [Documentation]    To verify get user profile api will return 404 not found when trying to get exist profile of not existing user
    ${response_data}    ${response_code}    Send Get Request For Get Users    value=${1234}
    Verify Response For Get Users    response_data=${response_data}    response_code=${response_code}    expected_code=${404}    error_case=${TRUE}