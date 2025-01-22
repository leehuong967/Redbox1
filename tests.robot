*** Settings ***
Resource          keywords.robot

*** Test Cases ***
Create_shipment
    Login

Access shipment list
    Login
    
Check Shipments list page
    Login
    Access page    ${shipments}    ${shipments_list}
    Check text    ${shipments_list_search_box}    72921971261    pa
