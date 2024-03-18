*** Settings ***

Documentation        Cenários de testes de pré-cadastro de clientes

Resource        ../resources/Base.resource
Resource        ../resources/pages/Welcome.resource

Test Setup        Start session
Test Teardown     Take Screenshot

*** Test Cases ***
Deve iniciar o cadastro do cliente
    [Tags]    smoke

    ${account}  Create Dictionary    
    ...    name=Amanda
    ...    email=amanda@smartbit.com
    ...    cpf=12541276079
    
    Delete Account By Email    ${account}[email]
    
    Submit signup form    ${account}
    Verify welcome message
      
Campo nome deve ser obrigatório
    [Tags]    required

    ${account}        Create Dictionary
    ...    name=${EMPTY}
    ...    email=amanda@test.com
    ...    cpf=12541276079
  
    Submit signup form    ${account}
    Notice should be    Por favor informe o seu nome completo

Campo email deve ser obrigatório
    [Tags]    required

    ${account}        Create Dictionary
    ...    name=Amanda Ruiz
    ...    email=${EMPTY}
    ...    cpf=12541276079
  
    Submit signup form    ${account}
    Notice should be    Por favor, informe o seu melhor e-mail

Campo cpf deve ser obrigatório
    [Tags]    required

    ${account}        Create Dictionary
    ...    name=Amanda Ruiz
    ...    email=amanda@test.com
    ...    cpf=${EMPTY}
  
    Submit signup form    ${account}
    Notice should be    Por favor, informe o seu CPF

Email no formato inválido
    [Tags]    inv

    ${account}        Create Dictionary
    ...    name=Amanda Ruiz
    ...    email=amanda*test.com
    ...    cpf=12541276079
  
    Submit signup form    ${account}
    Notice should be    Oops! O email informado é inválido

CPF no formato inválido
    [Tags]    inv

    ${account}        Create Dictionary
    ...    name=Amanda Ruiz
    ...    email=amanda@test.com
    ...    cpf=1254127607a
  
    Submit signup form    ${account}
    Notice should be    Oops! O CPF informado é inválido

Tentativa de pré-cadastro
    [Template]        Attempt signup
    ${EMPTY}    amanda@test.com    12541276079    Por favor informe o seu nome completo
    Amanda Ruiz    ${EMPTY}    12541276079    Por favor, informe o seu melhor e-mail
    Amanda Ruiz    amanda@test.com    ${EMPTY}    Por favor, informe o seu CPF
    Amanda Ruiz    amanda*test.com    12541276079    Oops! O email informado é inválido
    Amanda Ruiz    amanda@test.com    1254127607a    Oops! O CPF informado é inválido

*** Keywords ***
Attempt signup
    [Arguments]    ${name}    ${email}    ${cpf}    ${output_message}
    
    ${account}        Create Dictionary
    ...    name=${name}
    ...    email=${email}
    ...    cpf=${cpf}
  
    Submit signup form    ${account}
    Notice should be    ${output_message}