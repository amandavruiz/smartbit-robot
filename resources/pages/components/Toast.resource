*** Settings ***
Documentation        Ações e elementos do componente Toast

Library        Browser

*** Keywords ***
Toast should be
    [Arguments]        ${expected_text}

    Wait For Elements State    css=.Toastify__toast-body        
    ...    visible        3
     
    Get Text    css=.Toastify__toast-body        
    ...    equal
    ...    ${expected_text}