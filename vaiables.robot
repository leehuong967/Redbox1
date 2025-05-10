*** Variables ***
${base_url}       https://app.redboxsa.com/login
${BASE_API}       https://dev.api.redboxsa.com/v3
${submit_login}    submit-login
${otp_login}      submit-confirm-otp
${logo}           logo
${redbox_dashboard_href}    /redbox
${shipments}      menu-shipments
${shipments_list}    menu-link-list
${shipments_list_search_box}    customSearchShipment
${home_delivery}    menu-link-home-delivery
${home_delivery_search_box}    customSearch
${redbox_now}     menu-link-door-to-door
${redbox_now_search_box}    customSearch
${customer_support}    xpath=//*[text()='Customer Support']
${note_tracking}    xpath=//*[text()='Note tracking']
${customer_support_search_box}    customSearch
${expired_shipments}    menu-link-expired-shipments
${expired_shipments_search_box}    customSearch
${auto_pick_fail}    xpath=//*[text()='Auto Pick Fail']
${auto_pick_fail_search_box}    customSearch
${reports_at_locker}    menu-link-reports-locker-tracking
${reports_at_locker_search_box}    customSearch
${reports_at_counter}    menu-link-reports-counter-tracking
${reports_at_counter_search_box}    customSearch
${changes_tracking}    menu-link-tracking-change
${changes_tracking_search_box}    customSearch
${shipment_transfer}    menu-link-shipment-transfer
${shipment_transfer_search_box}    customSearch
${door_issue}     menu-link-door-issue
${door_issue_search_box}    customSearch
${mawb_monitoring}    menu-link-mawb-monitoring
${link_thirdparty_shipments}    menu-link-link-thirdparty-shipments
${dashboard}      xpath=//*[text()='Dashboard']
${sale_kpis}      xpath=//*[text()='Sales KPIs']
${sale_kpis_new_account}    new-acount
${merchant_data}    xpath=//*[text()='Merchant data']
${merchant_data_active_account}    active-account
${network}        xpath=//*[text()='Network']
${network_point_status_box}    chartTop10Cities
${sla_monitoring}    menu-link-sla-monitoring
${sla_monitoring_search_box}    customSearch
${merchant_performance}    menu-link-merchant-performance
${merchant_performance_search_box}    customSearchShipment
${internal_board}    xpath=//*[text()='Internal board']
${internal_board_codtype_dropDownList}    cod-type
${internal_board_with_cod_option}    op-with-cod
${shipment_id_file}    shipment_id.txt
${storage}        menu-storage
${storage_shipments}    menu-link-storage-shipments
${storage_shipments_search_box}    customSearch
${storage_settings}    menu-link-storage-settings
${storage_settings_search_box}    customSearch
${organizations}    xpath=//*[text()='Organizations']
${organizations_list}    xpath=//*[text()='List']
${warehouses}     xpath=//*[text()='Warehouses']
${warehouses_list}    /redbox/warehouse-management/redbox-warehouse
${operations}     xpath=//*[text()='Operations']
${operations_shipment_scan_tracking}    xpath=//*[text()='Shipment Scan Tracking']
${operations_shipment_scan_tracking_search_box}    customSearch
${operations_returning_shipment}    /redbox/warehouse-management/returning-shipment
${operations_returning_shipment_seach_box}    customSearch
${warehouse_id}    67162398f4064122f9697b1e
${express_tab}    menu-express
${express_shipments_list}    menu-link-express-shipments
${express_shipmentList_searchBox}    customSearchShipment
${express_shipmentList_dropdown_moreFilter}    //*[text()='More filter']
${order_date}     //*[text()='Ordered date']
${date_picker}    //input[@class='date-range start-time with-border']
${date_picker_table}    //div[@class='daterangepicker ltr show-calendar opensright']
${START_DATE_FIELD}    //td[@class='weekend active start-date available in-range']
${END_DATE_FIELD}    //td[contains(@class, 'weekend') and contains(@class, 'available') and contains(@class, 'in-range')][normalize-space()='16']
${START_DATE}     2025-03-09
${END_DATE}       2025-03-16
${Apply_button}    //*[text()='Apply']
${Filter_button}    filter-shipment-button
${express_locker_to_door}    menu-link-express-ltd
${express_ltd_searchBox}    customSearchShipment
${express_settings}    menu-link-express-settings
${express_settings_domesticPrice}    domesticPrice
${search_text}    NOT_EXIST_9999
${organizations}    xpath=//*[text()='Organizations']
${organizations_list}    xpath=//*[text()='List']
${organizations_list_search_box}    customSearch
${organizations_merchant notes}    xpath=//*[text()='Merchant Notes']
${bank_changes_tracking}    xpath=//*[text()='Bank Changes Tracking']
${bank_changes_tracking_search_box}    customSearch
${merchant_activities}    xpath=//*[text()='Merchant activities']
${merchant_activities_search_box}    customSearch
${suspension}     xpath=//*[text()='Suspension']
${suspension_search_box}    customSearch
${Pending_activation}    xpath=//*[text()='Pending activation']
${pending_activation_search_box}    customSearch
${RedBox_offers}    xpath=//*[text()='RedBox offers']
${RedBox_offers_search_box}    customSearch
${Global_box}     xpath=//*[text()='Global Box']
${Global_box_shipments}    //li[*[text()='Global Box']]//li[*[text()='Shipments']]
${shipment_search_mainifest_box}    customSearchShipment
${Packages}       xpath=//*[text()='Packages']
${Global_MAWB Monitoring}    //li[*[text()='Global Box']]//li[*[text()='MAWB Monitoring']]
${BASE_URL1}      https://dev.api.redboxsa.com
${ENDPOINT}       /v3/shipments/returns
${AUTH_TOKEN}     Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJvcmdhbml6YXRpb25faWQiOiI2NGJlMmZjNTdiMzVlYTQ4YmRlY2IwNzAiLCJrZXkiOiIyMDIzLTEwLTE5VDExOjA2OjUwLjc1MloiLCJpYXQiOjE2OTc3MTM2MTB9.5L_YOpJtrfPMUR2wQvFCT9rNCsvSQkSqMTX3f-klUuk
${Packages_seach_box}    customSearchShipment
${operations_tab}    xpath=//*[text()='Operations']
${operations}     xpath=//*[text()='Operations']
${support_tools}    xpath=//*[text()='Support Tools']
${point_id}       5d2855e065889422de40f2fe
${locker_id}      65aa37553a403d2b4b366b47
${uuid}           866732032337033
