*** Settings ***
Library           Selenium2Library
Resource          Environment.robot
Resource          vaiables.robot

*** Variables ***
${ENV}            prod    # Môi trường mặc định
${ENV}            stage    # Môi trường mặc định
>>>>>>> Stashed changes
${BASE_URL1}      \

*** Keywords ***
Set Environment
    ${BASE_URL1}    Set Variable    ${ENVIRONMENT["${ENV}"]}
    Open Browser    ${BASE_URL1}    chrome
    Maximize Browser Window
    Input Text    id=email-login    ${email_login["${ENV}"]}
    Input Text    id=password-login    ${password_login["${ENV}"]}
    Sleep    1s
    Click button    ${submit_login}
    Wait Until Page Contains Element    ${logo}    timeout=10
    Page Should Contain Element    ${logo}
