*** Settings ***
Library    SeleniumLibrary
Resource    ../Config/SuiteKeywords.robot
Resource    ../Pages/calculator.robot

Suite Setup     Setup Test
Test Teardown    Reset Calculator And Screenshot On Failure
Suite Teardown    Close Calculator

*** Variables ***
${BROWSER}              Chrome

*** Test Cases ***

Check all calculator elements are visible with corret lables
    Check Calculator Elements Are Visible
    Check Calculator Elements Lables Are Correct

Check the addition of two integer numbers
    Make Calculation    add    1250003424    2400    1250005824

Check the addition of two negative numbers
    Make Calculation    add    -354.634    -492.9874    -847.6214

Check the addition of one positive and one negative number
        Make Calculation    add    -3293.873298    43894729    43891435.126702

Check the subtraction of two negative numbers
    Make Calculation    subtract    -3333    -9999    6666

Check the subtraction of one negative and one positive number
    Make Calculation    subtract    -5.5    9.4444    -14.9444

Check the multiplication of two integer numbers
    Make Calculation    multiply    5324242342342    9    47918181081078

Check the multiplication of two negative numbers
    Make Calculation    multiply    -1.2    -7.7    9.24

Check the multiplication of one negative and one positive number
    Make Calculation    multiply    -8.8    7    -61.6

Check the division of two integer numbers
    Make Calculation    divide    7    7    1

Check the division of two negative numbers
    Make Calculation    divide    -7.7    -7.7    1

Check the division of one positive number and one integer number
    Make Calculation    divide    -5    2.5    -2

Check the division of a number by zero
    Make Calculation    divide    4    0    Infinity

Check the division of a number by a negative number
    Make Calculation    divide    8.5    -2    -4.25

Check the division of zero by any number
    Make Calculation    divide    0    -9.88881    0

Check that BODMAS is applied
    Make BODMAS calculation

Check result field accepts only numbers as input
    Input Letters Into Result

Check if the clear key is working
    Use Clear Button To Clear Result

Check Math operator can be selected once between numbers
    Select Math operator Multiple Times

Check clicking Result without input
    Play Around With Result Button

Check clicking Result with partial input
    Play Around With Result Button When Input Is Partial

Check clicking Result with math operator as only input
    Play Around With Result Button When Input Is Only Math Operator

Check after selecting result previous actions are cleared
    Make Several Calculations And Check Final Result