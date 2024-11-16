*** Settings ***
Resource    ${CURDIR}/../../../ttb_automation_test/resource/library.robot
Resource    ${CURDIR}/../../../ttb_automation_test/keyword/web/herouapp/herokuapp.robot

*** Variables ***
${destination_url}    https://the-internet.herokuapp.com/login
${language}    EN
${timeout}    3s

*** Test Cases ***
Login success
    [Documentation]    To verify that users can login successfully when put a correct username and password.
    [Setup]    Open Browser And Go To Destination URL    url=${destination_url} 
    Verify Login Landing
    Input Username And Password    username=tomsmith    password=SuperSecretPassword!    pass=${TRUE}
    [Teardown]    Close Browser

Login failed - Password incorrect
    [Documentation]    To verify that users can login unsuccessfully when they put a correct username but wrong password.
    [Setup]    Open Browser And Go To Destination URL    url=${destination_url}
    Verify Login Landing
    Input Username And Password    username=tomsmith    password=Password!    pass=${FALSE}    valid_username=${TRUE}    valid_password=${FALSE}
    [Teardown]    Close Browser

Login failed - Username not found
    [Documentation]    To verify that users can login unsuccessfully when they put a username that did
    [Setup]    Open Browser And Go To Destination URL    url=${destination_url}
    Verify Login Landing
    Input Username And Password    username=tomholland    password=Password!    pass=${FALSE}    valid_username=${FALSE}    valid_password=${FALSE}
    [Teardown]    Close Browser

