------------------------------ MODULE Fischer1 ------------------------------
EXTENDS FischerPreface
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
    \E d \in Real:
        /\ d > 0
        /\ \A t \in Thread :
            \/ ubTimer[t] = Infinity
            \/ ubTimer[t] > d
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
    /\ \A r \in Real : <>(now > r)

FSpec1 == SafetySpec /\ Liveness

Progress ==
    (\E t \in Thread : At(t, "a") \/ At(t, "b") \/ At(t, "c")) ~>
        (\E t \in Thread : At(t, "cs"))

THEOREM FSpec1 => Progress        
=============================================================================
\* Modification History
\* Last modified Fri Aug 06 10:24:40 CST 2021 by hengxin
\* Created Wed Aug 04 16:13:33 CST 2021 by hengxin