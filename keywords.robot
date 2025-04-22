*** Settings ***
Library           Selenium2Library
Library           RequestsLibrary
Library           Collections
Library           OperatingSystem
Resource          vaiables.robot

*** Keywords ***
Login
    [Arguments]    ${env}
    Open browser    ${ENVIRONMENT["${env}"]}    chrome
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

Search and check page contains text
    [Arguments]    ${locator}    ${text}    ${expected_text}
    [Documentation]    To search and check the page coontains text or not
    Input Text    ${locator}    ${text}
    Press Keys    None    RETURN
    Sleep    5s
    Page Should Contain    ${expected_text}

Search and wait page contains text
    [Arguments]    ${locator}    ${text}    ${expected_text}
    [Documentation]    To search and check the page contains expected text without using fixed sleep time.
    Input Text    ${locator}    ${text}
    Press Keys    None    RETURN
    Wait Until Page Contains    ${expected_text}    timeout=20

Verify element exits
    [Arguments]    ${element_locator}
    [Documentation]    Verify that the given element exists on the page
    Wait Until Element Is Visible    ${element_locator}    timeout=20
    Element Should Be Visible    ${element_locator}

Create shipment
    [Arguments]    ${reference_id}    ${enviroment}
    ${BODY}    Create Dictionary    reference=${reference_id}    customer_name=Lee    customer_phone=+84335299001    customer_address=King Saud University King Saud University, 2813 - King Saud University, Riyadh 12372 - 7463, Saudi Arabia    cod_currency=SAR    cod_amount=10
    ${HEADERS}    Create Dictionary    Content-Type=application/json    Authorization=${business_authorization["${enviroment}"]}    cookie=connect.sid=s%3AWOAKd-qpcmp6vgEQo6FmIg5AUpEChN9d.8VOl2rP7eV61zNGDDVd1VLSpAP66cTBCmVnt%2B%2FF7AAc
    ${RESPONSE}    POST    ${shipments_api["${enviroment}"]}    json=${BODY}    headers=${HEADERS}
    ${json_data}    Set variable    ${RESPONSE.json()}
    Log    ${RESPONSE.json()}
    ${shipment_id}    Get From Dictionary    ${json_data}    shipment_id
    ${tracking_number}    Get From Dictionary    ${json_data}    tracking_number
    #Set Suite Variable    ${shipment_id}
    Create File    ${shipment_id_file}    shipment_id: ${shipment_id}\ntracking_number: ${tracking_number}
    Should Not Be Empty    ${shipment_id}

API Driver picks up shipment from business
    [Arguments]    ${tracking_number}    ${warehouse_id}    ${enviroment}
    ${BODY}    Create Dictionary    tracking_number=["${tracking_number}"]    warehouse_id=["${warehouse_id}"]
    ${driver_authorization_base}    Set Variable    ${driver_authorization["${enviroment}"]}
    ${HEADERS}    Create Dictionary    Content-Type=application/json    Authorization=${driver_authorization_base}    cookie=connect.sid=s%3AWOAKd-qpcmp6vgEQo6FmIg5AUpEChN9d.8VOl2rP7eV61zNGDDVd1VLSpAP66cTBCmVnt%2B%2FF7AAc
    ${RESPONSE}    POST    ${driver_api["${enviroment}"]}/assign-shipment    json=${BODY}    headers=${HEADERS}
    ${json_data}    Set variable    ${RESPONSE.json()}
    Log    ${RESPONSE.json()}

API details shipment
    [Arguments]    ${enviroment}
    ${file_content}    Get File    ${shipment_id_file}
    ${lines}    Split String    ${file_content}
    ${shipment_id} =    Set Variable    ${lines}[1]
    ${header}    Create Dictionary    Content-Type=application/json    Authorization=${business_authorization["${enviroment}"]}
    ${response}    Get    ${shipments_api["${enviroment}"]}/${shipment_id}    headers=${header}
    Should Be Equal As Numbers    ${response.status_code}    200
    ${json_data}    Set Variable    ${response.json()}
    ${succes}    Get From Dictionary    ${json_data}    success
    Should Be True    ${succes}    Message=Shipment retrieval failed!

API Create Return shipments
    [Arguments]    ${enviroment}
    ${file_content}    Get File    ${shipment_id_file}
    ${lines}    Split String    ${file_content}
    ${shipment_id}    Set Variable    ${lines}[1]
    ${body}    Create Dictionary    original_shipment_id=${shipment_id}
    ${headers}    Create Dictionary    Content-Type=application/json    Authorization=${business_authorization["${enviroment}"]}
    ${response}    POST    ${shipments_api["${enviroment}"]}/returns    json=${body}    headers=${headers}
    Log    ${response.status_code}
    ${response_body}=    Evaluate    $response.json()
    Log    Response Body (JSON): ${response_body}
    Should Be Equal As Integers    ${response.status_code}    200
