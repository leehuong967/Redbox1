*** Settings ***
Library           Selenium2Library
Library           RequestsLibrary
Library           Collections
Library           OperatingSystem
Library           DateTime
Library           String
Resource          vaiables.robot
Resource          Config.robot
Resource          Environment.robot
Library           String

*** Keywords ***
Login
    [Arguments]    ${env}
    Open browser    ${ENVIRONMENT["${env}"]}    chrome
    Maximize Browser Window
    Input Text    email-login    ${email_login["${env}"]}
    Input Text    password-login    ${password_login["${env}"]}
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
    [Arguments]    ${enviroment}    ${reference}
    #${stt}=    Set Variable    5
    #${reference}=    Generate Auto Reference With STT
    ${BODY}    Create Dictionary    reference=${reference}    customer_name=Lee    customer_phone=+84335299001    customer_address=King Saud University King Saud University, 2813 - King Saud University, Riyadh 12372 - 7463, Saudi Arabia    cod_currency=SAR    cod_amount=0    point_id=${point_id["${enviroment}"]}
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
    [Arguments]    ${enviroment}
    ${file_content}    Get File    ${shipment_id_file}
    ${lines}    Split String    ${file_content}
    ${tracking_number} =    Set Variable    ${lines}[3]
    ${timestamp}    Get Time    epoch
    Log    ${timestamp}
    ${BODY}    Create Dictionary    tracking_number=["${tracking_number}"]    warehouse_id=["${warehouse_id}"]    timestamp=${timestamp}
    Log    ${BODY}}
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
    Dictionary Should Contain Key    ${response_body}    tracking_number
    Dictionary Should Contain Key    ${response_body}    shipment_id
    ${tracking_number}=    Get From Dictionary    ${response_body}    tracking_number
    ${shipment_id_from_response}=    Get From Dictionary    ${response_body}    shipment_id
    Log    Tracking Number: ${tracking_number}
    Log    Shipment ID: ${shipment_id_from_response}
    [Return]    ${shipment_id_from_response}    ${tracking_number}

API Customer pickup
    [Arguments]    ${env}
    ${params}=    Create Dictionary    uuid=${uuid}
    ${response}    GET    ${locker_api["${env}"]}/get-locker-token    params=${params}
    ${json}    To Json    ${response.content}
    ${token}    Get From Dictionary    ${json}    token
    ${file_content}    Get File    ${shipment_id_file}
    ${lines}    Split String    ${file_content}
    ${shipment_id} =    Set Variable    ${lines}[1]
    ${timestamp}=    Get Time    epoch
    ${timestamp}    Convert To Integer    ${timestamp}
    ${body}    Create Dictionary    shipment_id=${shipment_id}    timestamp=${timestamp}
    ${headers}    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${token}    locker-id=${locker_id["${env}"]}    point-id=${point_id["${env}"]}
    ${response}    POST    ${customer_api["${env}"]}/sync-shipment-delivered    json=${body}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200
    ${json_data}    Set Variable    ${response.json()}
    ${state}    Get From Dictionary    ${json_data}    state
    Should Be True    ${state}

API Confirm Deposit
    [Arguments]    ${env}
    ${file_content}    Get File    ${shipment_id_file}
    ${lines}    Split String    ${file_content}
    ${shipment_id}=    Set Variable    ${lines}[1]
    ${tracking_number} =    Set Variable    ${lines}[3]
    ${body}    Create Dictionary    shipment_id=${shipment_id}    is_empty=false    tracking_number=${tracking_number}    door_id=${door_id["${env}"]}
    ${headers}    Create Dictionary    Content-Type=application/json    organization-id=5e782d3430892b2a423a0d4e    locker-id=${locker_id["${env}"]}    point-id=${point_id["${env}"]}}    Authorization=${driver_authorization["${env}"]}
    ${response}    POST    ${shipper_api["${env}"]}/confirm-finish-drop-off    json=${body}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200
    ${json_data}    Set Variable    ${response.json()}
    ${return_shipmentId}    Get From Dictionary    ${json_data['data']}    shipmentId
    Log    ${return_shipmentId}
    Should Be Equal As Strings    ${shipment_id}    ${return_shipmentId}

API Driver Pickup Return Shipment
    [Arguments]    ${tracking_number}    ${environment}
    ${tracking_numbers}    Create List    ${tracking_number}
    ${door_id_lists}    Create List    ${door_id["${environment}"]}
    ${timestamp}=    Get Time    epoch
    ${body}=    Create Dictionary    tracking_numbers=${tracking_numbers}    type=return    timestamp=${timestamp}    file_name=${DEFAULT_FILE_NAME}    organization_id=${DEFAULT_ORGANIZATION_ID}    is_empty=${FALSE}    door_id=${door_id_lists}
    ${url}=    Set Variable    ${URL_shipper_open_multiple_door["${environment}"]}
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=${driver_token["${environment}"]}    point-id=${point_id1["${environment}"]}    locker-id=${locker_id1["${environment}"]}    locale=${locale}
    ${response}=    POST    ${url}    json=${body}    headers=${headers}
    Log    Status code: ${response.status_code}
    ${response_body}=    Evaluate    $response.json()
    Log    Response Body: ${response_body}
    Should Be Equal As Integers    ${response.status_code}    200

API Get Locker Token By UUID
    [Arguments]    ${uuid}    ${environment}
    ${headers}=    Create Dictionary    Content-Type=application/json
    Log    Environment in Get Locker Token By UUID: ${environment}
    ${response}=    GET    ${URL_get_locker_token}[${environment}]    headers=${headers}
    Log    Status code: ${response.status_code}
    ${response_body}=    Evaluate    $response.json()
    Log    Response Body: ${response_body}
    Should Be Equal As Integers    ${response.status_code}    200
    ${token}=    Set Variable    ${response_body["token"]}
    [Return]    ${token}

API Customer Deposit Return Shipment
    [Arguments]    ${shipment_id_from_response}    ${door_id}    ${environment}    ${uuid}
    ${token}=    API Get Locker Token By UUID    ${uuid}    ${environment}
    ${timestamp}=    Get Time    epoch
    ${timestamp}=    Convert To String    ${timestamp}
    ${body}=    Create Dictionary    shipment_id=${shipment_id_from_response}    door_id=${door_id["${environment}"]}
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${token}    point_id=${point_id1["${environment}"]}    locker_id=${locker_id1["${environment}"]}    locale=${locale}    timestamp=${timestamp}    accept=application/json
    ${url}=    Set Variable    ${URL_customer_deposit_return}[${environment}]
    ${response}=    POST    ${url}    json=${body}    headers=${headers}
    Log    Status code: ${response.status_code}
    ${response_body}=    Evaluate    $response.json()
    Log    Response body: ${response_body}
    Should Be Equal As Integers    ${response.status_code}    200
    [Return]    ${response_body}

API Driver Scan Dropoff at Merchant
    [Arguments]    ${tracking_number}    ${environment}
    ${headers}=    Create Dictionary    Authorization=${driver_token["${environment}"]}    Content-Type=application/json
    ${tracking_list}=    Create List    ${tracking_number}
    ${payload}=    Create Dictionary    tracking_number=${tracking_list}
    Create Session    return_to_merchant    ${URL_driver_scan_dropoff_at_merchant["${environment}"]}    headers=${headers}
    ${response}=    Post Request    return_to_merchant    ${URL_driver_scan_dropoff_at_merchant["${environment}"]}    json=${payload}
    Log    Status code: ${response.status_code}
    Log    Response body: ${response.content}
    Should Be Equal As Integers    ${response.status_code}    200

Create express shipment
    [Arguments]    ${env}
    ${point_from_id}    Get From Dictionary    ${point_id}    ${env}
    ${point_to_id}    Get From Dictionary    ${point_to_id}    ${env}
    ${BODY}    Create Dictionary
    ...    service_type=LockerToLocker
    ...    point_from_id=${point_from_id}
    ...    point_to_id=${point_to_id}
    ...    receiver_name=LA
    ...    receiver_phone=+84375684357
    ...    shipment_note=Notes
    ...    item_description=Items 1
    ...    declared_value=12
    ...    sender_name=LAnk
    ...    sender_phone=+84335299002
    ${auth_token}    Get From Dictionary    ${express_authorization}    ${env}
    ${url}    Get From Dictionary    ${express_create_shipment_api}    ${env}
    ${HEADERS}    Create Dictionary
    ...    Content-Type=application/json
    ...    Authorization=${auth_token}
    ${response}    POST    ${url}    json=${BODY}    headers=${HEADERS}
    Log    Status Code: ${response.status_code}
    Log    Response Content: ${response.content}
    Should Be Equal As Numbers    ${response.status_code}    200
    ${json_data}    Set Variable    ${response.json()}
    ${shipment_id}    Get From Dictionary    ${json_data}    shipment_id
    ${tracking_number}    Get From Dictionary    ${json_data}    tracking_number
    Log    Shipment ID (raw): ${shipment_id}
    Log    Tracking Number (raw): ${tracking_number}
    # Kiểm tra dữ liệu không được rỗng
    Run Keyword If    '${shipment_id}' == '' or '${tracking_number}' == ''    Fail    Invalid response: Shipment ID or Tracking Number is missing
    Create File    ${shipment_id_file}    shipment_id: ${shipment_id}\ntracking_number: ${tracking_number}

Customer Confirm Deposit Express
    [Arguments]    ${shipment_id}    ${tracking_number}    ${env}
    Log    Confirming deposit with Shipment ID: ${shipment_id}, Tracking Number: ${tracking_number}
    #${deposit_url}    Set Variable    https://dev.redboxsa.com/v3/api/customer/confirm-deposit-express
    ${deposit_url}    Get From Dictionary    ${express_deposit_shipment_api}    ${env}
    ${locker_id}    Get From Dictionary    ${locker_id}    ${env}
    ${point_to_id} Get From Dictionary    ${point_to_id}    ${env}
    ${door_id}    Get From Dictionary    ${door_id}    ${env}
    ${auth_token}    Get From Dictionary    ${get_token_locker_authen}    ${env}
    ${headers}    Create Dictionary
    ...    Content-Type=application/json
    ...    locker_id=${locker_id}
    ...    point_to_id=${point_to_id}
    ...    Authorization=${auth_token}
    ${payload}    Create Dictionary
    ...    shipment_id=${shipment_id}
    ...    tracking_number=${tracking_number}
    ...    door_id=${door_id}
    ...    is_empty=False
    #${deposit_url}    Get From Dictionary    ${express_deposit_shipment_api}    ${env}
    ${response}    POST    ${deposit_url}    json=${payload}    headers=${headers}
    Log    Status Code: ${response.status_code}
    Log    Response Content: ${response.content}
    Should Be Equal As Numbers    ${response.status_code}    200
    ${is_invalid}    Evaluate    "${shipment_id}" == "" or "${tracking_number}" == ""
    Run Keyword If    ${is_invalid}    Fail    Invalid response: Shipment ID or Tracking Number is missing

API get token driver
    [Arguments]    ${env}    ${driver_name}
    [Documentation]    Call API to get driver list, find driver by name, and write token to driver_token.txt
    ${headers}=    Create Dictionary    Cookie=connect.sid=s%3Ac-C8Ua7JWn_dy3gvH5PC8rUIzj6DPUIz.CtE1ied8oMyXJFLbnHY6zTUAx5ueftByHLPjL8tJMH4
    ${response}    GET    ${shipper_api["${env}"]}/get-list-driver    headers=${headers}
    ${json}=    To Json    ${response.content}
    ${json_str}=    Convert To String    ${json}
    Create File    list_driver.txt    ${json_str}
    ${list_drivers}=    Get From Dictionary    ${json}    data
    ${found}=    Set Variable    False
    FOR    ${driver}    IN    @{list_drivers}
        ${name}=    Get From Dictionary    ${driver}    name
        Log    Found driver name: "${name}"
        Log    Target driver name: "${driver_name}"
        Run Keyword If    "${name}" == "${driver_name}"    Set Test Variable    ${found}    True
        Run Keyword If    "${name}" == "${driver_name}"    Set Suite Variable    ${driver_token}    ${driver['token']}
        Run Keyword If    "${name}" == "${driver_name}"    Append To File    driver_token.txt    ${driver['token']}\n
    END
    Should Be True    ${found}    Driver with name "${driver_name}" not found in response
    [Return]    ${driver_token}

API get token locker
    [Arguments]    ${env}    ${locker_uuid}
    [Documentation]    Call API to get token of locker
    ${headers}=    Create Dictionary    Cookie=connect.sid=s%3Ac-C8Ua7JWn_dy3gvH5PC8rUIzj6DPUIz.CtE1ied8oMyXJFLbnHY6zTUAx5ueftByHLPjL8tJMH4
    ${params}=    Create Dictionary    uuid=${locker_uuid}
    ${response}    GET    ${locker_api["${env}"]}/get-locker-token?uuid=${locker_id}    headers=${headers}
    ${json}=    To Json    ${response.content}
    ${locker_token}=    Get From Dictionary    ${json}    token
    Run Keyword If    '${locker_token}' == ''    Fail    Token not found for locker ID "${locker_uuid}"
    Append To File    locker_token.txt    ${locker_token}\n
    [Return]    ${locker_token}

API Driver picks up Express shipments from Locker
    [Arguments]    ${env}    ${driver_token}
    [Documentation]    Authorization token of driver, locker id, point id, organization id of Redbox are required in Headers
    ${timestamp}=    Get Time    epoch
    ${timestamp}=    Evaluate    int(${timestamp} * 1000)
    ${BODY}    Create Dictionary
    ...    door_id=${door_id["${env}"]}
    ...    organization_id=${organization_redbox_id["${env}"]}
    ...    locker_id=${locker_id["${env}"]}
    ...    timestamp=${timestamp}
    ${HEADERS}    Create Dictionary
    ...    Content-Type=application/json
    ...    Authorization=Bearer ${driver_token}
    ...    organization-id=${organization_redbox_id["${env}"]}
    ...    locker-id=${locker_id["${env}"]}
    ...    point-id=${point_id["${env}"]}
    ...    cookie=connect.sid=s%3AWOAKd-qpcmp6vgEQo6FmIg5AUpEChN9d.8VOl2rP7eV61zNGDDVd1VLSpAP66cTBCmVnt%2B%2FF7AAc
    ${RESPONSE}    POST    ${shipper_api["${env}"]}/open-multiple-door-express    json=${BODY}    headers=${HEADERS}
    ${json_data}    Set variable    ${RESPONSE.json()}
    ${doors}    Get From Dictionary    ${json_data}    doors
    Log    ${doors}
    Should Be Equal As Strings    ${door_id["${env}"]}    ${doors}

API Driver deposits Express shipments
    [Arguments]    ${env}    ${driver_token}
    [Documentation]    Authorization token of driver, locker id, point id, organization id of Redbox are required in Headers
    ${file_content}    Get File    ${shipment_id_file}
    ${lines}    Split String    ${file_content}
    ${shipment_id_line}    Set Variable    ${lines}[0]
    ${tracking_number_line}    Set Variable    ${lines}[1]
    ${shipment_id}    Split String    ${shipment_id_line}    :    strip=True
    ${shipment_id}    Set Variable    ${shipment_id}[1]
    ${tracking_number}    Split String    ${tracking_number_line}    :    strip=True
    ${tracking_number}    Set Variable    ${tracking_number}[1]
    ${body}    Create Dictionary
    ...    shipment_id=${shipment_id}
    ...    tracking_number=${tracking_number}
    ...    door_id=${door_id["${env}"]}
    ...    is_empty=false
    ${headers}    Create Dictionary
    ...    Content-Type=application/json
    ...    organization-id=${organization_redbox_id["${env}"]}
    ...    locker-id=${locker_id["${env}"]}
    ...    point-id=${point_id["${env}"]}
    ...    Authorization=Bearer ${driver_token}
    ...    cookie=connect.sid=s%3AWOAKd-qpcmp6vgEQo6FmIg5AUpEChN9d.8VOl2rP7eV61zNGDDVd1VLSpAP66cTBCmVnt%2B%2FF7AAc
    ${response}    POST    ${shipper_api["${env}"]}/confirm-finish-drop-off    json=${body}    headers=${headers}
    ${state}    Get From Dictionary    ${response.json()}    state
    Should Be True    ${state}    Message=Deposit shipment failed!

API Customer pickup Express shipments from Locker
    [Arguments]    ${env}    ${locker_token}
    [Documentation]    Authorization token of locker, locker id, point id are required in Headers
    ${file_content}    Get File    ${shipment_id_file}
    ${lines}    Split String    ${file_content}
    ${shipment_id_line}    Set Variable    ${lines}[0]
    ${shipment_id}    Split String    ${shipment_id_line}    :    strip=True
    ${shipment_id}    Set Variable    ${shipment_id}[1]
    ${timestamp}=    Get Time    epoch
    ${timestamp} =    Evaluate    int(${timestamp} * 1000)
    ${body}    Create Dictionary
    ...    shipment_id=${shipment_id}
    ...    timestamp=${timestamp}
    ...    pickup_code_number="1"
    ${headers}    Create Dictionary
    ...    Content-Type=application/json
    ...    Authorization=Bearer ${locker_token}
    ...    locker-id=${locker_id["${env}"]}
    ...    point-id=${point_id["${env}"]}
    ...    cookie=connect.sid=s%3AWOAKd-qpcmp6vgEQo6FmIg5AUpEChN9d.8VOl2rP7eV61zNGDDVd1VLSpAP66cTBCmVnt%2B%2FF7AAc
    ${response}    POST    ${locker_api["${env}"]}/sync-shipment-delivered    json=${body}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200
    ${json_data}    Set Variable    ${response.json()}
    ${state}    Get From Dictionary    ${response.json()}    state
    Should Be True    ${state}    Message=Call API failed!

Generate Auto Reference With STT
    [Arguments]    ${file_path}=stt.txt
    # Kiểm tra xem file có tồn tại không và đọc nội dung
    ${exists}=    Run Keyword And Return Status    File Should Exist    ${file_path}
    Run Keyword Unless    ${exists}    Create File    ${file_path}    1
    ${stt_text}=    Get File    ${file_path}
    # Nếu file rỗng hoặc không phải số hợp lệ, gán STT = 1
    Run Keyword If    '${stt_text}' == ''    Set Variable    ${stt_text}    1
    Run Keyword If    '${stt_text}' == ' '    Set Variable    ${stt_text}    1
    Run Keyword If    '${stt_text}' == '0'    Set Variable    ${stt_text}    1
    Run Keyword If    '${stt_text}' != '1'    Set Variable    ${stt_text}}    ${stt_text}
    # Tạo Reference theo định dạng: Auto_ddmmyySTT
    ${reference}=    Evaluate    '"Auto_" + __import__("datetime").datetime.now().strftime("%d%m%y") + "{:03d}".format(${stt_text})'
    Log To Console    ✅ Reference: ${reference}
    # Tăng STT và ghi lại vào file
    ${next_stt}=    Evaluate    ${stt_text} + 1
    ${next_stt_str}=    Convert To String    ${next_stt}
    Create File    ${file_path}    ${next_stt}
    [Return]    ${reference}
