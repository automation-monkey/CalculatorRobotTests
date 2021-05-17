*** Settings ***
Resource    ../Pages/calculator.robot

*** Keywords ***

Setup Test
    Register Keyword To Run On Failure    Reset Calculator And Screenshot On Failure
    Open Calculator
    Set Selenium Timeout    8
    Set Selenium Implicit Wait    8

Screenshot On Failure
    ${time}    Evaluate    str(time.time())    time
    Capture Page Screenshot    SCREENSHOT_${time}.png

Reset Calculator And Screenshot On Failure
    Run Keyword If Test Failed    Screenshot On Failure
    Reset Calculator

Open Calculator
    Open Browser    https://talentry-qa-take-home-exercise.s3.eu-central-1.amazonaws.com/index.html    ${BROWSER}
    Maximize Browser Window

Close Calculator
    Close Browser
