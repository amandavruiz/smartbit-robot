*** Settings ***
Documentation        Ações e elementos do componente Toast

Library        Browser

*** Keywords ***
Toast should be
    [Arguments]        ${expected_text}

    ${selector}        Set Variable        .Toastify__toast-body

    Wait For Elements State    css=${selector}        
    ...    visible        3
     
    Get Text    css=${selector}        
    ...    equal
    ...    ${expected_text}
  
    Take Screenshot    selector=${selector}