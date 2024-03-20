*** Settings ***				
Library     Collections			
Library     RequestsLibrary

*** Variables ***
${BASE_URL}    https://jsonplaceholder.org

*** Test Cases ***				
Get User by ID - Verify Status Code 200 and Success	
    [Documentation]    This test verifies that the API returns a successful response for a specific user ID.
    Create Session    JsonPlaceholder    ${BASE_URL}    disable_warnings=1
    ${resp}    GET On Session    JsonPlaceholder    url=/users?id=1
    Should Be Equal As Strings    ${resp.status_code}    200    Status code should be 200
    Should Be True    ${resp.ok}    Response should be successful
    ${user_data}    Set Variable    ${resp.json()}
		&{result}=    Convert To Dictionary    ${user_data}
		Should Be Equal As Strings    ${result.firstname}    John    First name should be John
    