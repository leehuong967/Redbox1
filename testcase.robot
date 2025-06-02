*** Settings ***
Test Teardown     Close Browser
Resource          keywords.robot
Resource          Config.robot
Resource          Environment.robot
Library           Collections
Library           RequestsLibrary
Library           OperatingSystem
Library           String

*** Test Cases ***
API Create shipment
    Create shipment    20251404_005    stage

API Get shipment details
    API details shipment    stage

API create return shipment
    Create Session    redbox    ${BASE_URL1}
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=${AUTH_TOKEN}
    ${payload}=    Create Dictionary    original_shipment_id=67ecf96894f3d9b158badcb4
    ${response}=    POST On Session    redbox    ${ENDPOINT}    json=${payload}    headers=${headers}
    Log    ${response.status_code}
    ${response_body}=    Evaluate    $response.json()
    Log    Response Body (JSON): ${response_body}
    Should Be Equal As Integers    ${response.status_code}    200

API Return shipment
    API Create Return shipments    stage

Dashboard > Sales KPIs Page
    [Tags]    Dashboard
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${dashboard}    ${sale_kpis}
    Wait Until Element Is Visible    ${sale_kpis_new_account}
    Capture Element Screenshot    ${sale_kpis_new_account}

Dashboard > Merchant Data page
    [Tags]    Dashboard
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${dashboard}    ${merchant_data}
    Wait Until Element Is Visible    ${merchant_data_active_account}
    Capture Element Screenshot    ${merchant_data_active_account}

Dashboard > Network page
    [Tags]    Dashboard
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${dashboard}    ${network}
    Wait Until Element Is Visible    ${network_point_status_box}
    Capture Element Screenshot    ${network_point_status_box}

Dashboard > Internal Board page
    [Tags]    Dashboard
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${dashboard}    ${internal_board}
    Wait Until Element Is Visible    ${internal_board_codtype_dropDownList}    timeout=10s
    Click Element    ${internal_board_codtype_dropDownList}
    Sleep    10s
    Click Element    ${internal_board_with_cod_option}

Dashboard > Merchant Performance page
    [Tags]    Dashboard
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${dashboard}    ${merchant_performance}
    Search and check page contains text    ${merchant_performance_search_box}    Ha Ha    PhanhBillOdoo

Organizations > List page
    [Tags]    Organizations
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${organizations}    ${organizations_list}
    Search and check page contains text    ${organizations_list_search_box}    wtfhihi    No data available in table

Organizations > Merchant Notes page
    [Tags]    Organizations
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${organizations}    ${organizations_merchant notes}
    Verify element exits    //button[contains(text(),'Search')]

Organizations > Bank changes tracking page
    [Tags]    Organizations
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${organizations}    ${bank_changes_tracking}
    Search and check page contains text    ${bank_changes_tracking_search_box}    wtfhihi    No matching records found

Organizations > Merchant activities page
    [Tags]    Organizations
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${organizations}    ${merchant_activities}
    Search and check page contains text    ${merchant_activities_search_box}    wtfhihi    No data available in table

Organizations > Suspension page
    [Tags]    Organizations
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${organizations}    ${suspension}
    Search and check page contains text    ${suspension_search_box}    wtfhihi    No data available in table

Organizations > Pending activation page
    [Tags]    Organizations
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${organizations}    ${Pending_activation}
    Search and check page contains text    ${pending_activation_search_box}    wtfhihi    No data available in table

Organizations > RedBox offers page
    [Tags]    Organizations
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${organizations}    ${RedBox_offers}
    Search and check page contains text    ${RedBox_offers_search_box}    wtfhihi    No data available in table

Shipments > List page
    [Tags]    Shipments
    Create shipment    Test_shipment_list_page_dev    ${env}
    ${file_content}    Get File    ${shipment_id_file}
    ${lines}    Split String    ${file_content}    \n
    ${first_line} =    Set Variable    ${lines}[1]
    ${values} =    Split String    ${first_line}
    ${tracking_number}    Set Variable    ${values}[1]
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${shipments}    ${shipments_list}
    Search and check page contains text    ${shipments_list_search_box}    ${tracking_number}    DevSalla4
    Sleep    5s

Shipments > Home Delivery page
    [Tags]    Shipments
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${shipments}    ${home_delivery}
    Search and check page contains text    ${home_delivery_search_box}    WTH    No data available in table

Shipments > Redbox Now page
    [Tags]    Shipments
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${shipments}    ${redbox_now}
    Search and check page contains text    ${redbox_now_search_box}    WTH    No data available in table

Shipments > Expired Shipments page
    [Tags]    Shipments
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${shipments}    ${expired_shipments}
    Search and check page contains text    ${expired_shipments_search_box}    WTH    No data available in table

Shipments > Changes Tracking page
    [Tags]    Shipments
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Wait Until Page Contains Element    ${shipments}    timeout=10
    Access page    ${shipments}    ${changes_tracking}
    Search and wait page contains text    ${changes_tracking_search_box}    ${search_text}    No data available in table

Shipments > MAWB Monitoring page
    [Tags]    Shipments
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Wait Until Page Contains Element    ${shipments}    timeout=10
    Access page    ${shipments}    ${mawb_monitoring}
    Verify element exits    //button[contains(text(),'Import MAWB')]

Shipments > Shipment Transfer page
    [Tags]    Shipments
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Wait Until Page Contains Element    ${shipments}    timeout=10
    Access page    ${shipments}    ${shipment_transfer}
    Search and wait page contains text    ${shipment_transfer_search_box}    ${search_text}    No data available in table
    Create shipment    Test_WH_Shipment_Scan_Tracking_1    ${env}
    Wait Until Page Contains Element    ${shipments}    timeout=10
    Access page    ${shipments}    ${shipment_transfer}
    Search and wait page contains text    ${shipment_transfer_search_box}    ${search_text}    No data available in table

Operations > Shipment Scan Tracking
    [Tags]    operations
    Create shipment    Test_WH_Shipment_Scan_Tracking_1    ${env}
    ${file_content}    Get File    ${shipment_id_file}
    ${lines}    Split String    ${file_content}    \n
    ${first_line} =    Set Variable    ${lines}[1]
    ${values} =    Split String    ${first_line}
    ${tracking_number}    Set Variable    ${values}[1]
    API Driver picks up shipment from business    ${env}
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Click Element    ${operations}
    Sleep    5s
    Click Link    ${operations_shipment_scan_tracking}
    Search and check page contains text    ${operations_shipment_scan_tracking_search_box}    ${tracking_number}    Driver submit pick up shipment

Operations > SLA Monitoring page
    [Tags]    operations
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${operations_tab}    ${sla_monitoring}
    Search and check page contains text    ${sla_monitoring_search_box}    Riyadh    Riyadh

Operations > Returning Shipment
    [Tags]    operations
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Click Element    ${operations}
    Sleep    5s
    Click Link    ${operations_returning_shipment}
    Search and check page contains text    ${operations_returning_shipment_seach_box}    ${operations_returning_shipment_search_data}[${ENV}]    ${operations_returning_shipment_compared_data}[${ENV}]

Operations > Reports At Locker page
    [Tags]    operations
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Wait Until Page Contains Element    ${operations}    timeout=10
    Access page    ${operations}    ${reports_at_locker}
    Search and wait page contains text    ${reports_at_locker_search_box}    ${search_text}    No data available in table

Operations > Reports At Counter page
    [Tags]    operations
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Wait Until Page Contains Element    ${operations}    timeout=10
    Access page    ${operations}    ${reports_at_locker}
    Search and wait page contains text    ${reports_at_counter_search_box}    ${search_text}    No data available in table

Operations > Door Issue page
    [Tags]    operations
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Wait Until Page Contains Element    ${operations}    timeout=10
    Access page    ${operations}    ${door_issue}
    Search and wait page contains text    ${door_issue_search_box}    ${search_text}    No data available in table

Customer Support > Note Tracking page
    [Tags]    Customer support
    Create shipment    Test_customer_support_page    ${env}
    ${file_content}    Get File    ${shipment_id_file}
    ${lines}    Split String    ${file_content}    \n
    ${first_line} =    Set Variable    ${lines}[1]
    ${values} =    Split String    ${first_line}
    ${tracking_number}    Set Variable    ${values}[1]
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${customer_support}    ${note_tracking}
    Search and check page contains text    ${customer_support_search_box}    ${tracking_number}    DevSalla4

Customer Support > Auto Pick Fail page
    [Tags]    Customer support
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${customer_support}    ${note_tracking}
    Search and check page contains text    ${auto_pick_fail_search_box}    WTH    No data available in table

Express > Shipments page
    [Tags]    Express
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${express_tab}    ${express_shipments_list}
    Search and check page contains text    ${express_shipmentList_searchBox}    ${search_text}    No data available in table
    Sleep    10s

Express > Locker to Door page
    [Tags]    Express
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${express_tab}    ${express_locker_to_door}
    Search and check page contains text    ${express_ltd_searchBox}    693320129221    693320129221
    Sleep    10s

Express > Settings page
    [Tags]    Express
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${organizations}    ${organizations_list}
    Access page    ${express_tab}    ${express_settings}
    Wait Until Element Is Visible    ${express_settings_domesticPrice}
    Capture Element Screenshot    ${express_settings_domesticPrice}
    Sleep    10s

Storage > Storage
    [Tags]    Storage
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Wait Until Page Contains Element    ${storage}    timeout=10
    Access page    ${storage}    ${storage_shipments}
    Search and wait page contains text    ${storage_shipments_search_box}    ${search_text}    No data available in table

Storage > Settings page
    [Tags]    Storage
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Wait Until Page Contains Element    ${storage}    timeout=10
    Access page    ${storage}    ${storage_settings}
    Search and wait page contains text    ${storage_settings_search_box}    ${search_text}    No matching records found

Global Box > Shipments page
    [Tags]    Global box
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${Global_box}    ${Global_box_shipments}
    Wait Until Element Is Visible    //button[contains(text(),'Export Manifest')]    timeout=10s
    Click Element    //button[contains(text(),'Export Manifest')]
    Sleep    10s
    Search and check page contains text    ${shipment_search_mainifest_box}    wtfhihi    No matching records found

Global Box > Packages page
    [Tags]    Global box
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${Global_box}    ${Packages}
    Search and check page contains text    ${Packages_seach_box}    wtfhihi    No data available in table

Global Box > MAWB Monitoring
    [Tags]    Global box
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${Global_box}    ${Global_MAWB Monitoring}
    Verify element exits    //button[contains(text(),'Import MAWB')]
    Sleep    5s

Warehouse List
    [Tags]    Warehouses
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Click Link    ${warehouses_list}
    Page Should Contain    966534502300

Support tools > Link thirdparty shipments page
    [Tags]    Support Tools
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Wait Until Page Contains Element    ${support_tools}    timeout=10
    Access page    ${support_tools}    ${link_thirdparty_shipments}
    Verify element exits    //button[contains(text(),'Submit')]

Delivery Flow
    Create shipment    Auto_230425010    dev
    API Driver picks up shipment from business    dev
    API Confirm Deposit    dev
    API Customer pickup    dev

Express Flow
    ${env}    Set Variable    dev
    #create shipment
    Create express shipment    ${env}
    #đọc file chứa shipment_id và tracking_number
    ${file_content}    Get File    ${shipment_id_file}
    ${lines}    Split To Lines    ${file_content}
    ${shipment_id_line}    Set Variable    ${lines}[0]
    ${tracking_number_line}    Set Variable    ${lines}[1]
    ${shipment_id}    Replace String    ${shipment_id_line}    shipment_id:    ${EMPTY}
    ${shipment_id}    Strip String    ${shipment_id}
    ${tracking_number}    Replace String    ${tracking_number_line}    tracking_number:    ${EMPTY}
    ${tracking_number}    Strip String    ${tracking_number}
    Log    Shipment ID: ${shipment_id}
    Log    Tracking Number: ${tracking_number}
    #customer deposit
    Customer Confirm Deposit Express    ${shipment_id}    ${tracking_number}    ${env}
    #driver picks up shipment
    ${driver_token}=    API get token driver    ${env}    Ha driver dev
    API Driver picks up Express shipments from Locker    ${env}    ${driver_token}
    #Log-in shipments
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${operations}    ${Logi-in shipment}
    Input Text    ${enter tracking number}    ${tracking_number}
    Log    Tracking Number: ${tracking_number}
    Click Element    ${Scan button}
    Wait Until Element Is Visible    ${in-transit label}
    Click Element    ${submit button}
    Wait Until Element Is Visible    ${Choose warehouse}    timeount=10s
    Click Element    ${Choose warehouse}
    Wait Until Element Is Visible    ${Choose warehouse}[2]
    Click Element    ${Choose warehouse}[2]
    Click Element    ${OK button}
    #Scan Outbound
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${operations}    ${Scan Outbound}
    Wait Until Page Contains Element    ${Choose driver}
    Click Element    ${Choose driver}[1]
    Wait Until Element Is Visible    ${Choose driver}[3]    timeout=10s
    Click Element ${Choose driver}[3]
    Input Text    ${enter tracking number}    ${tracking_number}
    Log    Nhập Tracking Number ${tracking_number}
    Click Element    ${Scan button}
    Wait Until Element Is Visible    ${in-transit label}
    Click Element    ${submit button}
    #driver confirm deposit
    API Driver deposits Express shipments    ${env}    ${driver_token}
    #customer pickup
    ${locker_token}=    API get token locker    ${env}    866732032337033
    API Customer pickup Express shipments from Locker    ${env}    ${locker_token}
