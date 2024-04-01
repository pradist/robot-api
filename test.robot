*** Settings ***
Library     Collections
Library     RequestsLibrary

*** Variables ***
${BASE_URL}    https://jsonplaceholder.org

*** Test Cases ***
Get User by ID - Verify Status Code 200 and Success
    Create Session    JsonPlaceholder    ${BASE_URL}    disable_warnings=1
    ${resp}    GET On Session    JsonPlaceholder    url=/users?id=1
    ${resp_data}    Set Variable    ${resp.json()}
    &{result}    Convert To Dictionary    ${resp_data}
    Should Be True    ${resp.ok}    Response should be successful
    Should Be Equal As Strings    ${resp.status_code}    200    Status code should be 200
    Run Keyword And Continue On Failure    Should Be Equal As Strings    ${result.firstname}    John    First name should be John

Create User - Verify Status Code 201 and Success
    Create Session    JsonPlaceholder    ${BASE_URL}    disable_warnings=1
    ${data}    Create Dictionary    firstname=John    lastname=johndoe

Update User - Verify Status Code 200 and Success
    Create Session    JsonPlaceholder    ${BASE_URL}    disable_warnings=1
    ${data}    Create Dictionary    firstname=John    lastname=johndoe
    ${resp}    PUT On Session    JsonPlaceholder    url=/users/1    json=${data}
    ${resp_data}    Set Variable    ${resp.json()}
    &{result}    Convert To Dictionary    ${resp_data}
    Should Be True    ${resp.ok}    Response should be successful
    Should Be Equal As Strings    ${resp.status_code}    200    Status code should be 200
    Run Keyword And Continue On Failure    Should Be Equal As Strings    ${result.firstname}    John    First name should be John
    