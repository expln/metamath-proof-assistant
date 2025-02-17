open MM_substitution
open MM_context
open MM_parenCounter
open MM_unification_debug

type applyAssertionResult = {
    newVars: array<int>,
    newVarTypes: array<int>,
    frame: frame,
    subs: subs,
    err:option<unifErr>,
}

let applyAssertionResultEq: (applyAssertionResult, applyAssertionResult) => bool

let applyAssertionResultHash: applyAssertionResult => int

module ApplyAssertionResultHash: {
    type identity
    type t = applyAssertionResult
    let hash: Belt_Id.hash<t, identity>
    let eq: Belt_Id.eq<t, identity>
}

let applyAssertions: (
    ~maxVar:int,
    ~frms:frms,
    ~frmsToUse:array<string>=?,
    ~isFrameAllowed:frame=>bool,
    ~isDisjInCtx:(int,int)=>bool,
    ~statements:array<expr>,
    ~exactOrderOfStmts:bool=?,
    ~allowEmptyArgs:bool=?,
    ~allowNewVars:bool=?,
    ~result:expr=?,
    ~parenCnt:parenCnt,
    ~allowNewDisjForExistingVars:bool=?,
    ~combCntMax:int=?,
    ~onMatchFound:applyAssertionResult=>contunieInstruction,
    ~debugLevel:int=?,
    ~onProgress:float=>unit=?
) => unit


// ------ TEST ----------------------

let iterateCombinations: (
    ~numOfStmts:int,
    ~numOfHyps:int,
    ~stmtCanMatchHyp:(int,int)=>bool,
    ~combCntMax:int,
    ~debugLevel:int,
    ~combinationConsumer:array<int>=>contunieInstruction,
    ~errConsumer:unifErr=>contunieInstruction,
) => contunieInstruction

let getNextHypIdxToMatch: (int, array<int>) => int