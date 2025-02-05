*** Settings ***
Library           Selenium2Library
Library           RequestsLibrary
Resource          vaiables.robot

*** Keywords ***
Login
    Open browser    ${base_url}    chrome
    Maximize Browser Window
    Input Text    email-login    ${email_login}
    Input Text    password-login    ${password_login}
    Sleep    1s
    Click button    ${submit_login}
    Sleep    5s
    Wait Until Page Contains Element    ${logo}    timeout=10
    Page Should Contain Element    ${logo}

Access page
    id1    id2
    Login
    Click Element    id1
    Sleep    5s
    Click Element    id2

Check text
    locator    text    expected_text
    Input Text locator    text
    Press Key    None    \13
    Sleep    5s
    Page Should Contain    expected_text
