--------------------------- MODULE UntimedFischer ---------------------------
(*
The specification of the untimed version of the Fisher's Mutual Exclusion algorithm.
See Section 2.2 of the paper "Real Time is Really Simple" by Leslie Lamport, 2005.
*)
CONSTANTS
    Thread  \* the set of threads, ranged over by t \in Thread

NotAThread == CHOOSE t : t \notin Thread
------------------------------------------------------------------------------
VARIABLES
    x,  \* whose turn \in Thread \cup {NotAThread} is it now
    pc  \* pc[t] \in {"ncs", "a", "b", "c", "cs", "d"}: program counter of thread t \in Thread

vars == <<x, pc>>
------------------------------------------------------------------------------
TypeOK ==
    /\ x \in Thread \cup {NotAThread}
    /\ pc \in [Thread -> {"ncs", "a", "b", "c", "cs", "d"}]
------------------------------------------------------------------------------
At(t, loc) == pc[t] = loc

GoTo(t, loc) == pc' = [pc EXCEPT ![t] = loc]

GoFromTo(t, loc1, loc2) ==
    /\ At(t, loc1)
    /\ GoTo(t, loc2)
------------------------------------------------------------------------------
Init ==
    /\ x = NotAThread
    /\ pc = [t \in Thread |-> "ncs"]

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
    /\ IF x # t THEN GoTo(t, "a") ELSE GoTo(t, "cs")
    /\ UNCHANGED x

CS(t) ==
    /\ GoFromTo(t, "cs", "d")
    /\ UNCHANGED x

StmtD(t) ==
    /\ x = NotAThread
    /\ GoFromTo(t, "d", "ncs")
    /\ UNCHANGED x

Next ==
    \E t \in Thread:
        \/ NCS(t)
        \/ StmtA(t) \/ StmtB(t) \/ StmtC(t)
        \/ CS(t)
        \/ StmtD(t)        

Spec == Init /\ [][Next]_vars
------------------------------------------------------------------------------
ME == ~(\E t1, t2 \in Thread: t1 # t2 /\ At(t1, "cs") /\ At(t2, "cs"))
=============================================================================
\* Modification History
\* Last modified Wed Aug 04 14:30:46 CST 2021 by hengxin
\* Created Tue Aug 03 20:17:02 CST 2021 by hengxin