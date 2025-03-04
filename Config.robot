*** Settings ***
Resource          Environment.robot

*** Variables ***
${ENV}            stage    # Môi trường mặc định
${BASE_URL1}      \

*** Keywords ***
Set Environment
    ${BASE_URL1}    Set Variable    ${ENVIRONMENT["${ENV}"]}
    Open browser    ${BASE_URL1}    chrome
    Maximize Browser Window
    Input Text    id=email-login    ${email_login}
    Input Text    id=password-login    ${password_login}
    Sleep    1s
    Click button    ${submit_login}
    Wait Until Page Contains Element    ${logo}    timeout=10
    Page Should Contain Element    ${logo}
