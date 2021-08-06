------------------------------ MODULE Fischer2 ------------------------------
EXTENDS FischerPreface
-----------------------------------------------------------------------------
CONSTANTS Gamma
ASSUME Epsilon < Gamma
-----------------------------------------------------------------------------
NCS(t) ==
    /\ GoFromTo(t, "ncs", "a")
    /\ UNCHANGED x

StmtA(t) ==
    /\ x = NotAThread
    /\ GoFromTo(t, "a", "b")
    /\ UNCHANGED x

StmtB(t) ==
    /\ x' = t
    /\ GoFromTo(t, "b", "c")

StmtC(t) ==
    /\ At(t, "c")
    /\ TimedOut(t, lbTimer)
    /\ IF x # t THEN GoTo(t, "a") ELSE GoTo(t, "cs")
    /\ UNCHANGED x

CS(t) ==
    /\ GoFromTo(t, "cs", "d")
    /\ UNCHANGED x

StmtD(t) ==
    /\ x' = NotAThread
    /\ GoFromTo(t, "d", "ncs")

TNext(t) ==
    \/ NCS(t)
    \/ StmtA(t) \/ StmtB(t) \/ StmtC(t)
    \/ CS(t)
    \/ StmtD(t)        
-----------------------------------------------------------------------------
Tick ==
    \E d \in Real:
        /\ d > 0
        /\ \A t \in Thread :
            ubTimer[t] # Infinity => ubTimer[t] > d
        /\ now' = now + d   \* Where is now used in the spec?
        /\ ubTimer' = [t \in Thread |->
                        IF ubTimer[t] = Infinity THEN Infinity
                                                 ELSE ubTimer[t] - d]
        /\ lbTimer' = [t \in Thread |-> Max(0, lbTimer[t] - d)]
        /\ UNCHANGED <<x, pc, counter>>

SetTimer(t) ==
    /\ lbTimer' = [lbTimer EXCEPT ![t] = IF At(t, "b") THEN Epsilon
                                                       ELSE 0]
    /\ ubTimer' = [s \in Thread |->
                    IF s = t THEN IF \/ GoTo(s, "b")
                                     \/ GoTo(s, "d")
                                     \/ GoTo(s, "a") /\ x' = NotAThread
                                  THEN Delta
                                  ELSE IF GoTo(s, "c") THEN Gamma
                                                       ELSE Infinity
                             ELSE IF At(s, "a") THEN IF x' = NotAThread THEN Delta
                                                                        ELSE Infinity
                                                ELSE ubTimer[s]]                                                      
    /\ UNCHANGED now

Next ==
    \/ Tick
    \/ \E t \in Thread :
        /\ TNext(t)
        /\ SetTimer(t)

FSpec2 == Init /\ [][Next]_vars
-----------------------------------------------------------------------------
THEOREM FSpec2 => []MutualExclusion
=============================================================================
\* Modification History
\* Last modified Fri Aug 06 11:23:27 CST 2021 by hengxin
\* Created Fri Aug 06 10:48:41 CST 2021 by hengxin