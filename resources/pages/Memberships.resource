*** Settings ***
Documentation        Ações e elementos da página de matrículas

Library        Browser

*** Keywords ***
Create new membership
    [Arguments]        ${data}
    Go to memberships form
    Select account           ${data}[account][name]        ${data}[account][cpf]
    Select Plan              ${data}[plan]
    Fill payment card        ${data}[credit_card] 
    Click    css=button[type=submit] >> text=Cadastrar
Go to memberships form
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
    [Arguments]    ${card}
    Fill Text    css=input[name=card_number]    ${card}[number]
    Fill Text    css=input[name=card_holder]    ${card}[holder]
    Fill Text    css=input[name=card_month]     ${card}[month]
    Fill Text    css=input[name=card_year]      ${card}[year]
    Fill Text    css=input[name=card_cvv]       ${card}[cvv]