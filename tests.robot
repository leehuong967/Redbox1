*** Settings ***
Resource          keywords.robot

*** Test Cases ***
Create_shipment
    Login

Access shipment list
    Login
    
Check Shipments list page
    Login
    Access page ${shipments} ${shipments_list}
    Check text ${shipments_list_search_box} 729219712617 pa
