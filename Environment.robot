*** Settings ***
Resource          Config.robot

*** Variables ***
&{ENVIRONMENT}    dev=https://dev.redboxsa.com/login    stage=https://stage.redboxsa.com/login    prod=https://app.redboxsa.com/login
&{driver_authorization}    dev=Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2OTRhYTI4M2Y1ZTE0MGM1ZjU4ZDVjNSIsImtleSI6IjIwMjUtMDQtMjNUMDk6NTc6MDEuNjcxWiIsImlhdCI6MTc0NTQwMjIyMX0.joCFkEqnjuKgY1cvD1GclnYqN71maNc5o2aNEUqCYG0    stage=Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2OThiNzQ2ZjE0ZWE3NGE4YThiMDY1MyIsImtleSI6IjIwMjUtMDMtMjRUMTA6MzA6MDIuNDk3WiIsImlhdCI6MTc0MjgxMjIwMn0.K78-BTC2WnUsc1fv2d7HJyqG0YwT174N8cL83iCTkO8    prod=Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2OWIyNWE4NzNlNGFjMjkyMjYxYTQ5NSIsImtleSI6IjIwMjUtMDMtMjRUMDk6MzA6MDEuODE4WiIsImlhdCI6MTc0MjgwODYwMX0.6yF5fmgtjRXFIzW4Ld7z6YbjySa5gD7cNUeRTeMRFNg
&{driver_api}     dev=https://dev.redboxsa.com/api/app/shipper    stage=https://stage.redboxsa.com/api/app/shipper    prod=https://app.redboxsa.com/api/app/shipper
&{shipments_api}    dev=https://dev.api.redboxsa.com/v3/shipments    stage=https://stage.api.redboxsa.com/v3/shipments    prod=https://app.api.redboxsa.com/v3/shipments
&{email_login}    dev=anhth58.it.uet@gmail.com    stage=anhth58.it.uet@gmail.com    prod=lehuong16.17@gmail.com
&{password_login}    dev=Re@@Bo2025    stage=Re@@Bo2025    prod=Redboxsa@123
&{shipper_api}    dev=https://dev.redboxsa.com/v3/api/shipper    stage=https://stage.redboxsa.com/v3/api/shipper    prod=https://dev.redboxsa.com/v3/api/shipper
&{customer_api}    dev=https://dev.redboxsa.com/v3/api/customer    stage=https://stage.redboxsa.com/v3/api/customer    prod=https://dev.redboxsa.com/v3/api/customer
&{locker_api}     dev=https://dev.redboxsa.com/v3/api    stage=https://stage.redboxsa.com/v3/api
&{door_id}        dev=65aa377b3a403d2b4b366b5c    stage=65aa377b3a403d2b4b366b4c
&{operations_returning_shipment_search_data}    dev=84972786721    stage=84972786721    prod=966549737894	
&{operations_returning_shipment_compared_data}    dev=DLEEL    stage=Redbox store    prod=318520
&{organization_redbox_id}    dev=5d2853e265889422de40f2f3    stage=5d2853e265889422de40f2f3    prod=5e1080621cbabf0a2c0a0298
&{locker_id}    dev=65aa37553a403d2b4b366b47    stage=65aa37553a403d2b4b366b47    prod=[]
&{point_id}    dev=5d2855e065889422de40f2fe    stage=5d2855e065889422de40f2fe    prod=[]
&{locker_authorization}    dev=Bearer eyJhbGciOi
&{point_from_id}    dev=6087d7cb25cf0a31292245f7
&{point_to_id}      dev=5d2855e065889422de40f2fe
&{express_create_shipment_api}    dev=https://dev.redboxsa.com/api/business/v1/shipments/express
&{express_authorization}
...    dev=Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJvcmdhbml6YXRpb25faWQiOiI2NDA4NmQ0NzYwOTMyMzc1OTY3NjEyMDIiLCJrZXkiOiIyMDIzLTAzLTA4VDExOjE0OjEwLjE3OVoiLCJpYXQiOjE2NzgyNzQwNTB9.e4HrRLDPjdWZo6DCmKM9RMWHS2DtIryeGN1Y15j_DLA
...    stage=[]
&{get_token_locker_authen}    dev=Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiODY2NzMyMDMyMzM3MDMzIiwidG9rZW5JZCI6ImE5ZGZkYWRmLTljN2MtNDI4My04YmNmLTM3MDY1Zjg5NmIwNiIsImlhdCI6MTc0ODMzOTA0OH0.MvPAYfxMAHiiVjw0EkIM58CPOtX-ZKD-QrtKq7vSuMo
&{express_deposit_shipment_api}    dev=https://dev.redboxsa.com/v3/api/customer/confirm-deposit-express
