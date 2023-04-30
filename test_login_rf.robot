*** Settings ***
Library     SeleniumLibrary
Documentation       Suite description #automated tests for scout website

*** Variables ***
${LOGIN URL}        https://scouts-test.futbolkolektyw.pl/en
${BROWSER}      Chrome
${SIGNINBUTTON}     xpath=//*[@type='submit']
${EMAILINPUT}       xpath=//*[@id='login']
${PASSWORDINPUT}        xpath=//*[@id='password']
${PAGELOGO}     xpath=//ul[1]//div[@role='button'][1]
${SIGNOUTBUTTON}          xpath=//ul[2]//div[@role='button'][2]
${LOGINFORM}               xpath=//*[@id='__next']/form
${CHANGELANGUAGEBUTTON}   xpath=//ul[2]//div[@role='button'][1]
${MAINPAGELINK}           xpath=//ul[1]//div[@role='button'][1]
${ADD PLAYER BUTTON}            xpath=//a[contains(@href,'add')]
${FORM TITLE}                   xpath=//form//*[contains(@class, 'h5')]
${PLAYER NAME FIELD}            xpath=//input[@name='name']
${PLAYER SURNAME FIELD}         xpath=//input[@name='surname']
${PLAYER AGE FIELD}             xpath=//input[@name='age']
${PLAYER MAIN POSITION FIELD}   xpath=//input[@name='mainPosition']
${PROGRESS BAR TOASTER}         xpath=//*[@role='alert']

*** Test Cases ***
Login to the system
    Open login page
    Type in mail
    Type in password
    Click on the Submit button
    Assert dashboard
    [Teardown]    Close Browser

Log out from the system
    Open login page
    Type in mail
    Type in password
    Click on the Sign in button
    Click on the Sign out button
    Assert Login page
    [Teardown]    Close Browser

Set language Polish
    Open login page
    Type in mail
    Type in password
    Click on the Sign in button
    Click on the Change language button
    Assert language change
    [Teardown]    Close Browser

Add new player
    Open login page
    Type in mail
    Type in password
    Click on the Sign in button
    Click on the Add player button
    Type in name
    Type in surname
    Type in age
    Type in main position
    Click on the Submit button
    Assert edit player page
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
    Click Element       xpath=//*[@type='submit']
Assert dashboard
    Wait Until Element Is Visible    ${PAGELOGO}
    Title Should Be     Scouts panel
    Capture Page Screenshot     screenshots/login/dashboard-start.png
Click on the Sign in button
    Click Element    ${SIGNINBUTTON}
Click on the Sign out button
    Wait Until Element Is Visible    ${SIGN OUT BUTTON}
    Click Element    ${SIGNOUTBUTTON}
Assert login page
    Wait Until Element Is Visible    ${LOGINFORM}
    Title Should Be     Scouts panel - sign in
    Capture Page Screenshot    screenshots/login/login-page.png
Click on the Change language button
    Wait Until Element Is Visible    ${MAINPAGELINK}
    Click Element    ${CHANGELANGUAGEBUTTON}
Assert language change
    Element Text Should Be      ${CHANGELANGUAGEBUTTON}     English
    Capture Page Screenshot     screenshots/dashboard/language-set-pl.png
Click on the Add player button
    Wait Until Element Is Visible       ${MAINPAGELINK}
    Click Element    ${ADD PLAYER BUTTON}
Type in name
    Wait Until Element Is Visible       ${FORM TITLE}
    Input Text      ${PLAYER NAME FIELD}    Test
Type in surname
    Input Text      ${PLAYER SURNAME FIELD}     Testowski
Type in age
    Input Text      ${PLAYER AGE FIELD}     01/01/1990
Type in main position
    Input Text      ${PLAYER MAIN POSITION FIELD}       Forward
Assert edit player page
    Wait Until Element Is Visible    ${PROGRESS BAR TOASTER}
    Element Should Contain      ${FORM TITLE}   Edit player
    Capture Page Screenshot    screenshots/add-player/player-added.png