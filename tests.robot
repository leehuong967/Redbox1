*** Settings ***
Resource          keywords.robot

*** Test Cases ***
Create_shipment
    [Documentation]    Gửi request để tạo lô hàng mới và kiểm tra response
    ${session}    Create Session    my_api    ${base_url_api}
    ${items}    Set Variable    ${{ [{"name": "Book", "quantity": 2, "description": "Doraemon", "unitPrice": 20, "currency": "AR"}] }}
    ${payload}    Create Dictionary    items=${items}    reference=17022025003    point_id=5d2855e065889422de40f2fe    sender_name=Hoang Anh    sender_email=uynsalla3048923@yopmail.com    sender_phone=+84972786721    sender_address=King Saud University King Saud University    customer_name=Hoang Anh    customer_phone=+84335299001    customer_address=King Saud University King Saud University
    ${response}    POST    ${base_url_api}    json=${payload}    headers=${headers}    cookies=${cookie}
    Log To Console    Response Text: ${response.text}
    ${data}    Set Variable    ${response.json()}
    Run Keyword If    $data.__class__.__name__ == "dict"    Log To Console    Data is a dictionary: ${data}
    Run Keyword If    $data.__class__.__name__ == "str"    Log To Console    Data is a string: ${data}
    ${parsed_data}    Evaluate    json.loads($response.text)    json
    Log To Console    Shipment ID: ${parsed_data["shipment_id"]}
    Should Be Equal As Strings    ${response.status_code}    201

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
    Search and check page contains text    ${reports_at_counter_search_box}    824921435180    Driver reported lost shipment
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
    Access page    ${shipments}    ${link_thirdparty_shipments}
    Verify element exits    //button[contains(text(),'Submit')]
    Sleep    10s
SLA Monitoring page
    Login
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${admin_reports}    ${sla_monitoring}
    Search and check page contains text    ${sla_monitoring_search_box}    Riyadh    Riyadh
    Sleep    10s

Merchant Performance page
    Login
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${admin_reports}    ${merchant_performance}
    Search and check page contains text    ${merchant_performance_search_box}    PhanhBillOdoo    PhanhBillOdoo