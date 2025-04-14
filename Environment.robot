*** Settings ***
Resource          Config.robot

*** Variables ***
&{ENVIRONMENT}    dev=https://dev.redboxsa.com/login    stage=https://stage.redboxsa.com/login    prod=https://app.redboxsa.com/login
&{driver_authorization}    dev=Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2OTRhYTI4M2Y1ZTE0MGM1ZjU4ZDVjNSIsImtleSI6IjIwMjUtMDEtMjJUMTA6NDc6MDYuMTA0WiIsImlhdCI6MTczNzU0MjgyNn0.uLAYQ1Yr771DOQl2F7HqkaeGLn9FZkHb2gung9Ep9Wo    stage=Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2OThiNzQ2ZjE0ZWE3NGE4YThiMDY1MyIsImtleSI6IjIwMjUtMDMtMjRUMTA6MzA6MDIuNDk3WiIsImlhdCI6MTc0MjgxMjIwMn0.K78-BTC2WnUsc1fv2d7HJyqG0YwT174N8cL83iCTkO8    prod=Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2OWIyNWE4NzNlNGFjMjkyMjYxYTQ5NSIsImtleSI6IjIwMjUtMDMtMjRUMDk6MzA6MDEuODE4WiIsImlhdCI6MTc0MjgwODYwMX0.6yF5fmgtjRXFIzW4Ld7z6YbjySa5gD7cNUeRTeMRFNg
&{driver_api}     dev=https://dev.redboxsa.com/api/app/shipper    stage=https://stage.redboxsa.com/api/app/shipper    prod=https://app.redboxsa.com/api/app/shipper
&{business_authorization}    dev=Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJvcmdhbml6YXRpb25faWQiOiI2NGZhZDU4MDY1ZWExYjJhNjUxZGIyZDIiLCJrZXkiOiIyMDIzLTA5LTA4VDA4OjA0OjE2LjkzOVoiLCJpYXQiOjE2OTQxNjAyNTZ9.ORJWJt_uwO1dHf4s-5bg_gwTTyawGGBIPuHAKOZvUpI    stage=Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJvcmdhbml6YXRpb25faWQiOiI2NmFiNGExNjlkZDNkZTMxZWEwZDMyMjgiLCJrZXkiOiIyMDI0LTA4LTEzVDA0OjMyOjIyLjYyOVoiLCJpYXQiOjE3MjM1MjM1NDJ9.oG0HcYCBqkdV-cjPowe2w0CeMlLbR56OlfeRrZ7V4Pc    prod=Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJvcmdhbml6YXRpb25faWQiOiI1ZTc4NmFhMmJkYjI4YjBjZGY5NWU2ZmMiLCJrZXkiOiIyMDIwLTA2LTI2VDA5OjE0OjI4LjAyOFoiLCJpYXQiOjE1OTMxNjI4Njh9.xIPr8GmSMIvwhgTiVqIi-qUKmTVI7UZ-YNv61HwE8pw
&{shipments_api}    dev=https://dev.api.redboxsa.com/v3/shipments    stage=https://stage.api.redboxsa.com/v3/shipments    prod=https://app.api.redboxsa.com/v3/shipments
&{email_login}    dev=anhth58.it.uet@gmail.com    stage=anhth58.it.uet@gmail.com    prod=lehuong16.17@gmail.com
&{password_login}    dev=Re@@Bo2025    stage=Re@@Bo2025    prod=Redboxsa@123
&{point_id}       dev=5d2855e065889422de40f2fe    stage=5d2855e065889422de40f2fe    prod=5d2855e065889422de40f2fe
