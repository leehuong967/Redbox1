*** Settings ***
Library           Selenium2Library
Library           RequestsLibrary
Resource          vaiables.robot

*** Keywords ***
Login
    Open browser    ${base_url}    chrome
    Input Text    email-login    ${email_login}
    Input Text    password-login    ${password_login}
    Sleep    1s
    Click button    ${submit_login}
    Sleep    5s
    Wait Until Page Contains Element    ${logo}    timeout=10
    Page Should Contain Element    ${logo}
