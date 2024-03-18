*** Settings ***
Documentation        Suite de testes de adesões de planos

Resource        ../resources/Base.resource

Test Setup        Start session
Test Teardown     Take Screenshot

*** Test Cases ***
Deve permitir realizar uma nova adesão
    Go to login page
    Submit login form    sac@smartbit.com    pwd123
    User is logged in    sac@smartbit.com

    Go to enrolls
    Go to enrolls form
    Select account    Amanda    12541276079
    Select Plan    Plano Black
    Fill payment card    4242424242424242
    ...    Amanda
    ...    12
    ...    2030
    ...    123
    
    Sleep    5

    ${html}    Get Page Source

    Log    ${html}

    Sleep    5

*** Keywords ***
Go to enrolls
    Click    css=a[href="/memberships"]
    Wait For Elements State    css=h1 >> text=Matrículas
    ...    visible    5
    ...    
Go to enrolls form
    Click    css=a[href="/memberships/new"]
    Wait For Elements State    css=h1 >> text=Nova matrícula
    ...    visible    5

Select account
    [Arguments]    ${name}    ${cpf}
    Fill Text    css=input[aria-label=select_account]   ${name}
    Click        css=[data-testid="${cpf}"]

Select Plan
    [Arguments]    ${plan_name}
    Fill Text    css=input[aria-label=select_plan]    Plano Black
    Click    css=div[class$=option] >> text=Plano Black

Fill payment card
    [Arguments]    ${number}    ${holder}    ${month}    ${year}    ${cvv}
    Fill Text    css=input[name=card_number]    ${number}
    Fill Text    css=input[name=card_holder]    ${holder}
    Fill Text    css=input[name=card_month]     ${month}
    Fill Text    css=input[name=card_year]      ${year}
    Fill Text    css=input[name=card_cvv]       ${cvv}