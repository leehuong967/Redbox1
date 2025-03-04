*** Settings ***
Resource          keywords.robot

*** Test Cases ***
Create_shipment
    Create shipment    20250304_002

Access shipment list
    Login

Check Shipments list page
    Login
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${shipments}    ${shipments_list}
    Search and check page contains text    ${shipments_list_search_box}    WTH    No data available in table
    Sleep    10s

Check Home Delivery page
    Login
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${shipments}    ${home_delivery}
    Search and check page contains text    ${home_delivery_search_box}    WTH    No data available in table
    Sleep    10s

Check Redbox Now page
    Login
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${shipments}    ${redbox_now}
    Search and check page contains text    ${redbox_now_search_box}    WTH    No data available in table
    Sleep    10s

Check Customer Support page
    Login
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${shipments}    ${customer_support}
    Search and check page contains text    ${customer_support_search_box}    WTH    No data available in table
    Sleep    10s

Check Expired Shipments page
    Login
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${shipments}    ${expired_shipments}
    Search and check page contains text    ${expired_shipments_search_box}    WTH    No data available in table
    Sleep    10s

Check Auto Pick Fail page
    Login
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${shipments}    ${auto_pick_fail}
    Search and check page contains text    ${auto_pick_fail_search_box}    WTH    No data available in table
    Sleep    5s

Check Reports At Locker page
    Login
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${shipments}    ${reports_at_locker}
    Search and check page contains text    ${reports_at_locker_search_box}    629503965859    629503965859
    Sleep    10s

Check Reports At Counter page
    Login
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${shipments}    ${reports_at_locker}
    Search and check page contains text    ${reports_at_counter_search_box}    ABC    No data available in table
    Sleep    10s

Check Changes Tracking page
    Login
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${shipments}    ${changes_tracking}
    Search and check page contains text    ${changes_tracking_search_box}    ABC    No data available in table
    Sleep    10s

Check Shipment Transfer page
    Login
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${shipments}    ${shipment_transfer}
    Search and check page contains text    ${shipment_transfer_search_box}    ABC    No data avaiable in table
    Sleep    10s

Check Door Issue page
    Login
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${shipments}    ${door_issue}
    Search and check page contains text    ${door_issue_search_box}    ABC    No data available in table
    Sleep    10s

Check MAWB Monitoring page
    Login
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${shipments}    ${mawb_monitoring}
    Verify element exits    //button[contains(text(),'Import MAWB')]
    Sleep    10s

Check Link thirdparty shipments page
    Login
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${shipments} ${link_thirdparty_shipments}
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
    Access page    ${admin_reports} ${merchant_performance}
    Search and check page contains text    ${merchant_performance_search_box}    PhanhBillOdoo PhanhBillOdoo
    Sleep    10s

Internal Board page
    Login
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${admin_reports} ${internal_board}
    Wait Until Element Is Visible    ${internal_board_codtype_dropDownList}    timeout=10s
    Click Element    ${internal_board_codtype_dropDownList}
    Sleep    10s
    Click Element    ${internal_board_with_cod_option}
    Sleep    10s
