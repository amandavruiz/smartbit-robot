*** Settings ***
Documentation        Suite de testes de adesões de planos

Resource        ../resources/Base.resource

Test Setup        Start session
Test Teardown     Take Screenshot

*** Test Cases ***
Deve permitir realizar uma nova adesão
    
    ${data}        Get json fixture        memberships        create
 
    Delete Account By Email    ${data}[account][email]
    Insert Account    ${data}[account]

    Signin admin
    Go to memberships
    Create new membership    ${data}
    Toast should be    Matrícula cadastrada com sucesso.

    ${html}    Get Page Source
    Log    ${html}
    Sleep    5

Não deve realizar adesão duplicada
    [Tags]        dup
    ${data}        Get json fixture        memberships        duplicate

    Delete Account By Email    ${data}[account][email]
    Insert Account    ${data}[account]

    Signin admin
    Go to memberships
    Create new membership    ${data}
    Sleep    8
    Create new membership    ${data}
    Toast should be    O usuário já possui matrícula.