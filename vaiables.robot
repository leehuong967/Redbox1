*** Variables ***
${base_url}       https://dev.redboxsa.com/login
${email_login}    anhth58.it.uet@gmail.com
${password_login}    Re@@Bo2025
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
${customer_support}    menu-link-customer-support
${customer_support_search_box}    customSearch
${expired_shipments}    menu-link-expired-shipments
${expired_shipments_search_box}    customSearch
${auto_pick_fail}    menu-link-auto-pick-fail
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
${base_url_api}    https://dev.api.redboxsa.com
${endpoint}       /v3/shipments
${auth_token}     Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJvcmdhbml6YXRpb25faWQiOiI2NGZhZDU4MDY1ZWExYjJhNjUxZGIyZDIiLCJrZXkiOiIyMDIzLTA5LTA4VDA4OjA0OjE2LjkzOVoiLCJpYXQiOjE2OTQxNjAyNTZ9.ORJWJt_uwO1dHf4s-5bg_gwTTyawGGBIPuHAKOZvUpI
@{headers}        Content-Type    application/json    Authorization    ${AUTH_TOKEN}
${cookie}         connect.sid=s%3AWOAKd-qpcmp6vgEQo6FmIg5AUpEChN9d.8VOl2rP7eV61zNGDDVd1VLSpAP66cTBCmVnt%2B%2FF7AAc
${hearders}       Content-Type=application/json    Authorization=${AUTH_TOKEN}
