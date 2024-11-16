*** Settings ***
Resource    ${CURDIR}/../../../ttb_automation_test/resource/library.robot
Resource    ${CURDIR}/../../../ttb_automation_test/keyword/api/user/get_user.robot

*** Test Cases ***
Get user profile success
    [Documentation]    To verify get user profile api will return correct data when trying to get profile of existing user
    ${response_data}    ${response_code}    Send Get Request For Users    value=${12}
    Log    ${response_data}
    Log    ${response_code}
Get user profile but user not found
    [Documentation]    To verify get user profile api will return 404 not found when trying to get exist profile of not existing user
    ${response_data}    ${response_code}    Send Get Request For Users    value=${1234}
    Log    ${response_data}
    Log    ${response_code}