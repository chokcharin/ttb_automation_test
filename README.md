# ttb_automation_test

## dependencies
* python==3.12
* Appium-Python-Client==3.2.1
* robotframework==7.1
* robotframework-appiumlibrary==2.1.0
* robotframework-jsonlibrary==0.5
* robotframework-requests==0.9.7
* obotframework-seleniumlibrary==6.6.1


### command ข้อ 2
```
python3 -m robot your_path/ttb_automation_test/testcase/web/herokuapp.robot
```
### command ข้อ 3
```
python3 -m robot your_path/ttb_automation_test/testcase/api/get_user.robot
```
### command ข้อ 4
```
python3 -m robot your_path/ttb_automation_test/testcase/mobile/minimal/minimal.robot
```


## Variable
* ${appium_server}	http://localhost:4723/wd/hub
* ${platform_name}	Android
* ${platform_version}	13
* ${device_name}	Pixel 9 Pro
* ${app_name}	/Users/513007542/Downloads/Minimal-Todo-master/app/app-release.apk
* ${automation_name}	Uiautomator2
