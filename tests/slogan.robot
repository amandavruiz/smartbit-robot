*** Settings ***
Documentation        Teste para verificar o slogan da Smartbit na web app

Library        Browser

*** Test Cases ***

Deve mostrar o slogan na landing page
    New Browser    browser=chromium    headless=False
    New Page    http://localhost:3000/
    Get Text    css=.headline h2    equal    Sua Jornada Fitness Começa aqui!   