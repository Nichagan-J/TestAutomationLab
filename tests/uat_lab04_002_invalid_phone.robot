*** Settings ***
Library    SeleniumLibrary    run_on_failure=Capture Page Screenshot
Suite Teardown    Close All Browsers

*** Variables ***
${CHROME_BROWSER_PATH}    ${EXECDIR}${/}ChromeForTesting${/}chrome-win64${/}chrome.exe
${CHROME_DRIVER_PATH}     ${EXECDIR}${/}ChromeForTesting${/}chromedriver-win64${/}chromedriver.exe
${URL}                    http://localhost:7272/Registration.html

*** Test Cases ***
UAT-Lab04-002 Invalid Phone Number
    Open Registration Page
    Input Text    id=firstname      Somyod
    Input Text    id=lastname       Sodsai
    Input Text    id=organization   CS KKU
    Input Text    id=email          somyod@kkumail.com
    Input Text    id=phone          1234
    Click Register
    Verify Stay On Registration Page With Error    Please enter a valid phone number!!

*** Keywords ***
Open Chrome For Testing
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    modules=sys
    Call Method    ${chrome_options}    add_argument    --start-maximized
    ${chrome_options.binary_location}=    Set Variable    ${CHROME_BROWSER_PATH}

    ${service}=    Evaluate    sys.modules['selenium.webdriver.chrome.service'].Service(executable_path=r'''${CHROME_DRIVER_PATH}''')    modules=sys
    Create Webdriver    Chrome    options=${chrome_options}    service=${service}

Open Registration Page
    Open Chrome For Testing
    Go To    ${URL}
    Title Should Be    Registration
    Page Should Contain Element    xpath=//h1[normalize-space(.)="Workshop Registration"]

Click Register
    Click Button    id=registerButton

Verify Stay On Registration Page With Error
    [Arguments]    ${expected_error}
    Title Should Be    Registration
    Element Text Should Be    id=errors    ${expected_error}
