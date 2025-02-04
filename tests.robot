*** Settings ***
Resource          keywords.robot

*** Test Cases ***
Create_shipment
    Login

Access shipment list
    Login

Check Shipments list page
    Login
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${shipments}    ${shipments_list}
    Check text    ${shipments_list_search_box}    WTH   No data available in table
    Sleep    10s

Check Home Delivery page
    Login
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${shipments}    ${home_delivery}
    Check text    ${home_delivery_search_box}    WTH  No data available in table
    Sleep    10s


Check Redbox Now page
    Login
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${shipments}    ${redbox_now}
    Check text    ${redbox_now_search_box}    WTH   No data available in table
    Sleep    10s

Check Customer Support page
    Login
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${shipments}    ${customer_support}
    Check text    ${customer_support_search_box}    WTH   No data available in table
    Sleep    10s

Check Expired Shipments page
    Login
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${shipments}    ${expired_shipments}
    Check text    ${expired_shipments_search_box}    WTH   No data available in table
    Sleep    10s

Check Auto Pick Fail page
    Login
    Click Link    ${redbox_dashboard_href}
    Sleep    5s
    Access page    ${shipments}    ${auto_pick_fail}
    Check text    ${auto_pick_fail_search_box}    WTH   No data available in table
    Sleep    10s


Test
    Login
    #Open Redbox Dashboard
    Click Link    /redbox
    Sleep    5s
    #Open shipment page
    Click Element    ${shipments}
    Sleep    5s
    Click Link    /redbox/shipments
    Sleep    5s
    Check text    ${shipments_list_search_box}    WTF    No data available in table
    Sleep    5s

Test2
    Login
    #Open Redbox Dashboard
    Click Link    /redbox
    Sleep    5s
    #Open shipment page
    Click Element    menu-link-list
    Sleep    10s
    Check text    ${shipments_list_search_box}    72921971261    pa
    Sleep    5s
