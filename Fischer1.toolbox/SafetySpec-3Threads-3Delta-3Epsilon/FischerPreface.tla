--------------------------- MODULE FischerPreface ---------------------------
EXTENDS Reals

Max(a, b) == IF a >= b THEN a ELSE b
-----------------------------------------------------------------------------
CONSTANTS  Thread, Delta, Epsilon

ASSUME
    /\ Delta \in Real
    /\ Epsilon \in Real
    /\ 0 < Delta
    /\ Delta <= Epsilon

NotAThread == CHOOSE t : t \notin Thread
-----------------------------------------------------------------------------
VARIABLES x, pc, ubTimer, lbTimer, now, counter

vars == <<x, pc, ubTimer, lbTimer, now, counter>>

TypeOK ==
    /\ x \in Thread \cup {NotAThread}
    /\ pc \in [Thread -> {"ncs", "a", "b", "c", "cs", "d"}]
    /\ ubTimer \in [Thread -> Real \cup {Infinity}]
    /\ lbTimer \in [Thread -> Real \cup {Infinity}]
\*    /\ now \in Real   \* now is unbounded
    /\ counter \in [Thread -> Nat]
-----------------------------------------------------------------------------
Init ==
    /\ x = NotAThread
    /\ pc = [t \in Thread |-> "ncs"]
    /\ ubTimer = [t \in Thread |-> Infinity]
    /\ lbTimer = [t \in Thread |-> 0]
    /\ now = 0
    /\ counter = [t \in Thread |-> 0]
-----------------------------------------------------------------------------
At(t, loc) == pc[t] = loc

GoTo(t, loc) == pc' = [pc EXCEPT ![t] = loc]

GoFromTo(t, loc1, loc2) ==
    /\ At(t, loc1)
    /\ GoTo(t, loc2)

TimedOut(t, timer) == timer[t] = 0
-----------------------------------------------------------------------------
MutualExclusion ==
  \A t1, t2 \in Thread: (t1 # t2) => ~At(t1, "cs") \/ ~At(t2, "cs")
=============================================================================
\* Modification History
\* Last modified Fri Aug 06 10:20:52 CST 2021 by hengxin
\* Created Wed Aug 04 15:47:49 CST 2021 by hengxin