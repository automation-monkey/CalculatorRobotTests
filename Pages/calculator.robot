*** Settings ***
Library                 String

*** Variables ***
${calculator header locator}    css=h1

# Keys
${result locator}    css=input#result
${clear locator}    css=input#clear
${equal locator}    css=input[value='=']
${dot locator}    css=.dot

# Arithmetic Operations
${add locator}    css=input[value='+']
${subtract locator}    css=input[value='-']
${divide locator}    css=input[value='/']
${multiply locator}    css=input[value='x']

# Numbers
${1 locator}    css=#one
${2 locator}    css=#two
${3 locator}    css=#three
${4 locator}    css=#four
${5 locator}    css=#five
${6 locator}    css=#six
${7 locator}    css=#seven
${8 locator}    css=#eight
${9 locator}    css=#nine
${0 locator}    css=#zero

*** Keywords ***

# Page elements checks
Check Calculator Elements Are Visible
    Element Should Be Visible    ${calculator header locator}
    Element Should Be Visible    ${result locator}
    Element Should Be Visible    ${clear locator}
    Element Should Be Visible    ${equal locator}
    Element Should Be Visible    ${dot locator}
    Element Should Be Visible    ${add locator}
    Element Should Be Visible    ${subtract locator}
    Element Should Be Visible    ${divide locator}
    Element Should Be Visible    ${multiply locator}
    Element Should Be Visible    ${1 locator}
    Element Should Be Visible    ${2 locator}
    Element Should Be Visible    ${3 locator}
    Element Should Be Visible    ${4 locator}
    Element Should Be Visible    ${5 locator}
    Element Should Be Visible    ${6 locator}
    Element Should Be Visible    ${7 locator}
    Element Should Be Visible    ${8 locator}
    Element Should Be Visible    ${9 locator}
    Element Should Be Visible    ${0 locator}

Check Calculator Elements Lables Are Correct
    Element Text Should Be    ${calculator header locator}    Calculator
    Element Attribute Value Should Be    ${clear locator}    value    C
    Element Attribute Value Should Be    ${equal locator}    value    =
    Element Attribute Value Should Be    ${dot locator}    value    .
    Element Attribute Value Should Be    ${add locator}    value    +
    Element Attribute Value Should Be    ${subtract locator}    value    -
    Element Attribute Value Should Be    ${divide locator}    value    /
    Element Attribute Value Should Be    ${multiply locator}    value       x
    Element Attribute Value Should Be    ${1 locator}    value    1
    Element Attribute Value Should Be    ${2 locator}    value    2
    Element Attribute Value Should Be    ${3 locator}    value    3
    Element Attribute Value Should Be    ${4 locator}    value    4
    Element Attribute Value Should Be    ${5 locator}    value    5
    Element Attribute Value Should Be    ${6 locator}    value    6
    Element Attribute Value Should Be    ${7 locator}    value    7
    Element Attribute Value Should Be    ${8 locator}    value    8
    Element Attribute Value Should Be    ${9 locator}    value    9
    Element Attribute Value Should Be    ${0 locator}    value    0

# Actions on Calculator
Click Arithmetic Action
    [Arguments]    ${action}
    Click Element    ${${action} locator}

Select Number
    [Arguments]    ${Number}
    ${decimal}=    Run Keyword And Return Status    Number Is Decimal    ${Number}
    ${negetive}=    Run Keyword And Return Status    Number Is Negitive    ${Number}
    Run Keyword If    ${decimal} and ${negetive}    Select Negitive Decimal Number    ${Number}
    ...    ELSE IF    ${negetive}    Select Negitive Number    ${Number}
    ...    ELSE IF    ${decimal}    Select Decimal Number    ${Number}
    ...    ELSE    Select Integer Number    ${Number}

Punch Number In Calculator
    [Arguments]    ${number}
    ${number}=    Split String To Characters    ${number}
    FOR    ${digit}    IN    @{number}
        Click Element    ${${digit} locator}
    END

Select Dot
    Click Element    ${dot locator}

Select Integer Number
    [Arguments]    ${Number}
    Punch Number In Calculator    ${Number}

Select Decimal Number
    [Arguments]    ${Number}
    ${number_list}=    Split String    ${Number}    .
    Click Element    ${${number_list}[0] locator}
    Click Element    ${dot locator}
    Punch Number In Calculator    ${number_list}[1]

Select Negitive Number
    [Arguments]    ${Number}
    ${Number}=    Get Substring    ${Number}    1
    CLick Element    ${subtract locator}
    Punch Number In Calculator    ${Number}

Select Negitive Decimal Number
    [Arguments]    ${Number}
    ${Number}=    Get Substring    ${Number}    1
    ${number_list}=    Split String    ${Number}    .
    CLick Element    ${subtract locator}
    Punch Number In Calculator    ${number_list}[0]
    Click Element    ${dot locator}
    Punch Number In Calculator    ${number_list}[1]

Number Is Negitive
    [Arguments]    ${Number}
    Should Contain    ${Number}    -

Number Is Decimal
    [Arguments]    ${Number}
    Should Contain    ${Number}    .

Select Result
    Click Element    ${equal locator}

Get Displayed Result
    Click Element    ${equal locator}
    ${result}=    Get Value     ${result locator}
    [Return]    ${result}

Reset Calculator
    Click Element    ${clear locator}

Make Calculation
    [Arguments]    ${action}    ${num1}    ${num2}    ${answer}
    Select Number    ${num1}
    Click Arithmetic Action    ${action}
    Select Number    ${num2}
    Check Calculation Result    ${answer}

Check Calculation Result
    [Arguments]    ${answer}
    ${result}=    Get Displayed Result
    Should Be Equal    ${result}    ${answer}

Input Letters Into Result
    Input Text    ${result locator}    This Is Bad !@#$ 1234567
    ${result}=    Get Displayed Result
    Should Not Be Equal    ${result}    This Is Bad !@#$ 1234567

Make BODMAS calculation
    Select Number    4
    Click Arithmetic Action  multiply
    Select Number    2
    Click Arithmetic Action  divide
    Select Number    8
    Click Arithmetic Action  add
    Select Number    9
    Click Arithmetic Action  divide
    Select Number    100
    Click Arithmetic Action  subtract
    Select Number    77
    Check Calculation Result    -75.91

Get Result And Compare To Expected
    [Arguments]    ${expeted}
    ${result}=    Get Value     ${result locator}
    Should Be Equal    ${result}    ${expeted}

Use Clear Button To Clear Result
    Punch Number In Calculator    1234567890
    Reset Calculator
    Get Result And Compare To Expected    ${EMPTY}

Select Math operator Multiple Times
    Select Number    5
    Click Arithmetic Action    multiply
    Click Arithmetic Action    multiply
    Click Arithmetic Action    multiply
    Select Number  5
    Get Result And Compare To Expected    5*5

Select Dot operator Multiple Times
    Select Number    5
    Select Dot
    Select Number    5
    Select Dot
    Select Number    5
    Get Result And Compare To Expected    5.55

Play Around With Result Button
    Select Result
    Check Calculation Result    Result

Play Around With Result Button When Input Is Partial
    Select Number  7.5
    Click Arithmetic Action    Divide
    Select Result
    Check Calculation Result    7.5/

Play Around With Result Button When Input Is Only Math Operator
    Click Arithmetic Action    Divide
    Select Result
    Check Calculation Result    /

# Happy Path
Make Several Calculations And Check Final Result
    Make Calculation    add    2    2    4
    Make Calculation    add    2    2    4
    Make Calculation    add    2    2    4
    Check Calculation Result    4
