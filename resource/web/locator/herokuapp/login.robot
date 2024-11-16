*** Variables ***
${login_page_title_locator}    xpath:/html/body/div[2]/div/div/h2
${fork_me_img_locator}    xpath:/html/body/div[2]/a/img
${page_description_locator}    xpath:/html/body/div[2]/div/div/h4
${input_username_description_locator}    xpath:/html/body/div[2]/div/div/form/div[1]/div/label
${username_login_locator}    id:username
${input_password_description_locator}    xpath:/html/body/div[2]/div/div/form/div[2]/div/label
${password_login_locator}    id:password
${flash_locator}    id:flash
${login_button_locator}    xpath:/html/body/div[2]/div/div/form/button/i
${logout_button_locator}    xpath:/html/body/div[2]/div/div/a/i
${login_footer_locator}    xpath:/html/body/div[3]/div/div
${secure_area_title_locator}    xpath:/html/body/div[2]/div/div/h2
${login_success_description_locator}   xpath:${/}${/}*[@id="content"]/div/h4