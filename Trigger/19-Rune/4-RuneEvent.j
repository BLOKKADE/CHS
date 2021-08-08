


function CreateRuneAction takes code c returns trigger
    local trigger t = CreateTrigger()
    call TriggerAddCondition(t,Condition(c))
    return t
endfunction

//TriggerEvaluate