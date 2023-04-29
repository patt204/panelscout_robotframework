*** Settings ***
Library     SeleniumLibrary
Documentation       Suite description #automated tests for scout website

*** Variables ***
${LOGIN URL}        <https://scouts-test.futbolkolektyw.pl/en>
${BROWSER}      Chrome
${SIGNINBUTTON}     xpath=//*[@type='Sign in']
${EMAILINPUT}       xpath=//*[@id='login']
${PASSWORDINPUT}        xpath=//*[@id='password']
${PAGELOGO}     xpath=//*[@id='__next']/div[1]/main/div[3]/div[1]/div/div[1]

*** Test Cases ***
Login to the system
    Open login page
    Type in mail
    Type in password
    Click on the Submit button
    Assert dashboard
    [Teardown]    Close Browser

*** Keywords ***
Open login page
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Title Should Be     Scouts panel - sign in
Type in mail
    Input Text    ${EMAILINPUT}     user01@getnada.com
Type in password
    Input Text    ${PASSWORDINPUT}      Test-1234
Click on the Submit button
    Click Element       xpath=//*[@type='Sign in']
Assert dashboard
    Wait Until Element Is Visible    ${PAGELOGO}
    Title Should Be     Scouts panel
    Capture Page Screenshot     screenshots/login/dashboard-start.png


