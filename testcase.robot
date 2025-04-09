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
    ${BODY}    Create Dictionary    reference=20250312_004    customer_name=Lee    customer_phone=+84335299001    customer_address=King Saud University King Saud University, 2813 - King Saud University, Riyadh 12372 - 7463, Saudi Arabia    cod_currency=SAR    cod_amount=10
    ${HEADERS}    Create Dictionary    Content-Type=application/json    Authorization=Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJvcmdhbml6YXRpb25faWQiOiI2NGZhZDU4MDY1ZWExYjJhNjUxZGIyZDIiLCJrZXkiOiIyMDIzLTA5LTA4VDA4OjA0OjE2LjkzOVoiLCJpYXQiOjE2OTQxNjAyNTZ9.ORJWJt_uwO1dHf4s-5bg_gwTTyawGGBIPuHAKOZvUpI    cookie=connect.sid=s%3AWOAKd-qpcmp6vgEQo6FmIg5AUpEChN9d.8VOl2rP7eV61zNGDDVd1VLSpAP66cTBCmVnt%2B%2FF7AAc
    ${RESPONSE}    POST    ${BASE_API}    json=${BODY}    headers=${HEADERS}
    ${json_data}    Set variable    ${RESPONSE.json()}
    Log    ${RESPONSE.json()}
    ${shipment_id}    Get From Dictionary    ${json_data}    shipment_id
    #Set Suite Variable    ${shipment_id}
    Create File    ${shipment_id_file}    ${shipment_id}
    Should Not Be Empty    ${shipment_id}

API Get shipment details
    ${shipment_id}    Get File    ${shipment_id_file}
    ${header}    Create Dictionary    Content-Type=application/json    Authorization=Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJvcmdhbml6YXRpb25faWQiOiI2NGZhZDU4MDY1ZWExYjJhNjUxZGIyZDIiLCJrZXkiOiIyMDIzLTA5LTA4VDA4OjA0OjE2LjkzOVoiLCJpYXQiOjE2OTQxNjAyNTZ9.ORJWJt_uwO1dHf4s-5bg_gwTTyawGGBIPuHAKOZvUpI
    ${response}    Get    ${BASE_API}/${shipment_id}    headers=${header}
    Should Be Equal As Numbers    ${response.status_code}    200
    ${json_data}    Set Variable    ${response.json()}
    ${succes}    Get From Dictionary    ${json_data}    success
    Should Be True    ${succes}    Message=Shipment retrieval failed!

Check Shipments list page
    Create shipment    Test_shipment_list_page    ${env}
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

Check Home Delivery page
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${shipments}    ${home_delivery}
    Search and check page contains text    ${home_delivery_search_box}    WTH    No data available in table
    Sleep    10s

Check Redbox Now page
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${shipments}    ${redbox_now}
    Search and check page contains text    ${redbox_now_search_box}    WTH    No data available in table
    Sleep    10s

Check Customer Support page
    Create shipment    Test_customer_support_page    ${env}
    ${file_content}    Get File    ${shipment_id_file}
    ${lines}    Split String    ${file_content}    \n
    ${first_line} =    Set Variable    ${lines}[1]
    ${values} =    Split String    ${first_line}
    ${tracking_number}    Set Variable    ${values}[1]
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${shipments}    ${customer_support}
    Search and check page contains text    ${customer_support_search_box}    ${tracking_number}    DevSalla4
    Sleep    10s

Check Auto Pick Fail page
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${shipments}    ${auto_pick_fail}
    Search and check page contains text    ${auto_pick_fail_search_box}    WTH    No data available in table
    Sleep    5s

Check Expired Shipments page
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${shipments}    ${expired_shipments}
    Search and check page contains text    ${expired_shipments_search_box}    WTH    No data available in table
    Sleep    5s

Reports At Locker page
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Wait Until Page Contains Element    ${shipments}    timeout=10
    Access page    ${shipments}    ${reports_at_locker}
    Search and wait page contains text    ${reports_at_locker_search_box}    ${search_text}    No data available in table

Reports At Counter page
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Wait Until Page Contains Element    ${shipments}    timeout=10
    Access page    ${shipments}    ${reports_at_locker}
    Search and wait page contains text    ${reports_at_counter_search_box}    ${search_text}    No data available in table

Changes Tracking page
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Wait Until Page Contains Element    ${shipments}    timeout=10
    Access page    ${shipments}    ${changes_tracking}
    Search and wait page contains text    ${changes_tracking_search_box}    ${search_text}    No data available in table
    
Shipment Transfer page
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Wait Until Page Contains Element    ${shipments}    timeout=10
    Access page    ${shipments}    ${shipment_transfer}
    Search and wait page contains text    ${shipment_transfer_search_box}    ${search_text}    No data available in table

Door Issue page
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Wait Until Page Contains Element    ${shipments}    timeout=10
    Access page    ${shipments}    ${door_issue}
    Search and wait page contains text    ${door_issue_search_box}    ${search_text}    No data available in table

MAWB Monitoring page
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Wait Until Page Contains Element    ${shipments}    timeout=10
    Access page    ${shipments}    ${mawb_monitoring}
    Verify element exits    //button[contains(text(),'Import MAWB')]

Link thirdparty shipments page
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Wait Until Page Contains Element    ${shipments}    timeout=10
    Access page    ${shipments}    ${link_thirdparty_shipments}
    Verify element exits    //button[contains(text(),'Submit')]

Sales KPIs Page
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${admin_reports}    ${sale_kpis}
    Wait Until Element Is Visible    ${sale_kpis_new_account}
    Capture Element Screenshot    ${sale_kpis_new_account}
    Sleep    10s

Merchant Data page
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${admin_reports}    ${merchant_data}
    Wait Until Element Is Visible    ${merchant_data_active_account}
    Capture Element Screenshot    ${merchant_data_active_account}
    Sleep    10s

Network page
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${admin_reports}    ${network}
    Wait Until Element Is Visible    ${network_point_status_box}
    Capture Element Screenshot    ${network_point_status_box}
    Sleep    10s

SLA Monitoring page
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${admin_reports}    ${sla_monitoring}
    Search and check page contains text    ${sla_monitoring_search_box}    Riyadh    Riyadh
    Sleep    10s

Merchant Performance page
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${admin_reports}    ${merchant_performance}
    Search and check page contains text    ${merchant_performance_search_box}    PhanhBillOdoo    PhanhBillOdoo
    Sleep    10s

Internal Board page
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${admin_reports}    ${internal_board}
    Wait Until Element Is Visible    ${internal_board_codtype_dropDownList}    timeout=10s
    Click Element    ${internal_board_codtype_dropDownList}
    Sleep    10s
    Click Element    ${internal_board_with_cod_option}
    Sleep    10s

Check WH Shipment Scan Tracking
    Create shipment    Test_WH_Shipment_Scan_Tracking_1    ${env}
    ${file_content}    Get File    ${shipment_id_file}
    ${lines}    Split String    ${file_content}    \n
    ${first_line} =    Set Variable    ${lines}[1]
    ${values} =    Split String    ${first_line}
    ${tracking_number}    Set Variable    ${values}[1]
    API Driver picks up shipment from business    ${tracking_number}    ${warehouse_id}    ${env}
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Click Element    ${warehouses}
    Sleep    5s
    Click Link    ${warehouses_shipment_scan_tracking}
    Search and check page contains text    ${warehouses_shipment_scan_tracking_search_box}    ${tracking_number}    Driver submit pick up shipment
    Sleep    5s

Check Warehouse List
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Click Element    ${warehouses}
    Sleep    5s
    Click Link    ${warehouses_list}
    Page Should Contain    966534502300
    Sleep    5s

Check WH Returning Shipment
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Click Element    ${warehouses}
    Sleep    5s
    Click Link    ${warehouses_returning_shipment}
    Search and check page contains text    ${warehouses_returning_shipment_seach_box}    670662016672    966508981797
    Sleep    5s

Storage Shipments page
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Click Element    ${warehouses}
    Sleep    5s
    Click Link    ${warehouses_returning_shipment}
    Search and check page contains text    ${warehouses_returning_shipment_seach_box}    670662016672    966508981797
    Sleep    5s

Express shipments page
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${express_tab}    ${express_shipments_list}
    Search and check page contains text    ${express_shipmentList_searchBox}    357831985482    357831985482
    Sleep    10s

Express Locker to Door page
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${express_tab}    ${express_locker_to_door}
    Search and check page contains text    ${express_ltd_searchBox}    693320129221    693320129221
    Sleep    10s

Express Settings page
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${organizations}    ${organizations_list}
    Access page    ${express_tab}    ${express_settings}
    Wait Until Element Is Visible    ${express_settings_domesticPrice}
    Capture Element Screenshot    ${express_settings_domesticPrice}
    Sleep    10s
