*** Settings ***
Resource          keywords.robot
Resource          Config.robot
Resource          Environment.robot
Library           Collections
Library           RequestsLibrary
Library           OperatingSystem

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
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${shipments}    ${shipments_list}
    Search and check page contains text    ${shipments_list_search_box}    WTH    No data available in table
    Sleep    10s

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
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${shipments}    ${customer_support}
    Search and check page contains text    ${customer_support_search_box}    WTH    No data available in table
    Sleep    10s

Check Auto Pick Fail page
    Login
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${shipments}    ${auto_pick_fail}
    Search and check page contains text    ${auto_pick_fail_search_box}    WTH    No data available in table
    Sleep    5s

Check Expired Shipments page
    Login
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${shipments}    ${expired_shipments}
    Search and check page contains text    ${expired_shipments_search_box}    WTH    No data available in table
    Sleep    10s

Reports At Locker page
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${shipments}    ${reports_at_locker}
    Search and check page contains text    ${reports_at_locker_search_box}    QA_TEST    No data available in table
    Sleep    10s

Reports At Counter page
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${shipments}    ${reports_at_locker}
    Search and check page contains text    ${reports_at_counter_search_box}    QA_TEST    No data available in table
    Sleep    10s

Changes Tracking page
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${shipments}    ${changes_tracking}
    Search and check page contains text    ${changes_tracking_search_box}    QA_TEST    No data available in table
    Sleep    10s

Shipment Transfer page
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${shipments}    ${shipment_transfer}
    Search and check page contains text    ${shipment_transfer_search_box}    QA_TEST    No data available in table
    Sleep    10s

Door Issue page
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${shipments}    ${door_issue}
    Search and check page contains text    ${door_issue_search_box}    QA_TEST    No data available in table
    Sleep    10s

MAWB Monitoring page
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${shipments}    ${mawb_monitoring}
    Verify element exits    //button[contains(text(),'Import MAWB')]
    Sleep    10s

Link thirdparty shipments page
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${shipments}    ${link_thirdparty_shipments}
    Verify element exits    //button[contains(text(),'Submit')]
    Sleep    10s

Sales KPIs Page
    Login
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${admin_reports}    ${sale_kpis}
    Wait Until Element Is Visible    ${sale_kpis_new_account}
    Capture Element Screenshot    ${sale_kpis_new_account}
    Sleep    10s

Merchant Data page
    Login
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${admin_reports}    ${merchant_data}
    Wait Until Element Is Visible    ${merchant_data_active_account}
    Capture Element Screenshot    ${merchant_data_active_account}
    Sleep    10s

Network page
    Login
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${admin_reports}    ${network}
    Wait Until Element Is Visible    ${network_point_status_box}
    Capture Element Screenshot    ${network_point_status_box}
    Sleep    10s

SLA Monitoring page
    Login
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${admin_reports}    ${sla_monitoring}
    Search and check page contains text    ${sla_monitoring_search_box}    Riyadh Riyadh
    Sleep    10s

Merchant Performance page
    Login
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

Login
    Set Environment

Storage Shipments page
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${storage}    ${storage_shipments}
    Search and check page contains text    ${storage_shipments_search_box}    LAnk    No data available in table
    Sleep    10s

Storage Settings page
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${storage}    ${storage_settings}
    Search and check page contains text    ${storage_settings_search_box}    Panda Market    RedBox RUH-103
    Sleep    10s

Organizations List page
    Set Environment
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${organizations}    ${organizations_list}
