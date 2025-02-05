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
    [Arguments]    ${title}    ${subtitle}
    [Documentation]    To access any page under the main operation tab
    Click Element    ${title}
    Sleep    5s
    Click Element    ${subtitle}

Check text
    [Arguments]    ${locator}    ${text}    ${expected_text}
    [Documentation]    To check the page coontains text or not
    Input Text    ${locator}    ${text}
    Press Keys    None     RETURN
    Sleep    5s
    Page Should Contain    expected_text

