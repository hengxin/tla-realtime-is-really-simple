----------------------------- MODULE Fischer1MC -----------------------------
(*
Fischer1.tla modified to be model checked.
- EXTENDS FischerPreface: replaced by EXTENDS FischerPrefaceMC
- Tick: increase now by 1
- Liveness: replace "\A r \in Real : <>(now > r)" by "SF_vars(Tick)"
*)
EXTENDS FischerPrefaceMC
-----------------------------------------------------------------------------
SetTimer(t, timer, tau) ==
    timer' = [timer EXCEPT ![t] = tau]

ResetUBTimer(t, timer) ==
    SetTimer(t, timer, Infinity)
-----------------------------------------------------------------------------
NCS(t) ==
    /\ GoFromTo(t, "ncs", "a")
    /\ UNCHANGED <<x, now, lbTimer, ubTimer, counter>>

StmtA(t) ==
    /\ x = NotAThread
    /\ GoFromTo(t, "a", "b")
    /\ SetTimer(t, ubTimer, Delta)
    /\ UNCHANGED <<x, now, lbTimer, counter>>

StmtB(t) ==
    /\ x' = t
    /\ GoFromTo(t, "b", "c")
    /\ ResetUBTimer(t, ubTimer)
    /\ SetTimer(t, lbTimer, Epsilon)
    /\ UNCHANGED <<now, counter>>

StmtC(t) ==
    /\ At(t, "c")
    /\ TimedOut(t, lbTimer)
    /\ IF x # t THEN GoTo(t, "a") ELSE GoTo(t, "cs")
    /\ UNCHANGED <<x, now, lbTimer, ubTimer, counter>>

CS(t) ==
    /\ GoFromTo(t, "cs", "d")
    /\ counter' = [counter EXCEPT ![t] = @ + 1] 
    /\ UNCHANGED <<x, now, lbTimer, ubTimer>>

StmtD(t) ==
    /\ x' = NotAThread
    /\ GoFromTo(t, "d", "ncs")
    /\ UNCHANGED <<now, lbTimer, ubTimer, counter>>

Tick ==
    LET d == 1
     IN /\ \A t \in Thread :
            ubTimer[t] # Infinity => ubTimer[t] > d
        /\ now' = now + d   \* Where is now used in the spec?
        /\ ubTimer' = [t \in Thread |->
                        IF ubTimer[t] = Infinity THEN Infinity
                                                 ELSE ubTimer[t] - d]
        /\ lbTimer' = [t \in Thread |-> Max(0, lbTimer[t] - d)]
        /\ UNCHANGED <<x, pc, counter>>
-----------------------------------------------------------------------------
Next ==
    \/ Tick
    \/ \E t \in Thread:
          \/ NCS(t)
          \/ StmtA(t) \/ StmtB(t) \/ StmtC(t)
          \/ CS(t)
          \/ StmtD(t)        
-----------------------------------------------------------------------------
SafetySpec == Init /\ [][Next]_vars

THEOREM SafetySpec => []MutualExclusion
-----------------------------------------------------------------------------
Liveness ==
    /\ \A t \in Thread : WF_vars(StmtA(t) \/ StmtC(t) \/ StmtD(t))
    /\ SF_vars(Tick)

FSpec1 == SafetySpec /\ Liveness

Progress ==
    (\E t \in Thread : At(t, "a") \/ At(t, "b") \/ At(t, "c")) ~>
        (\E t \in Thread : At(t, "cs"))

THEOREM FSpec1 => Progress        
=============================================================================
\* Modification History
\* Last modified Sat Aug 07 16:13:28 CST 2021 by hengxin
\* Created Sat Aug 07 15:47:31 CST 2021 by hengxin