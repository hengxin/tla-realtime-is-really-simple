-------------------------- MODULE FischerPrefaceMC --------------------------
(*
FischerPreface modified to be model checked.
- Reals: replaced with Naturals
- Real: replaced with Nat
- Infinity: adding a CONSTANT Infinity (a model value)
*)
EXTENDS Naturals

Max(a, b) == IF a >= b THEN a ELSE b
-----------------------------------------------------------------------------
CONSTANTS Thread, Delta, Epsilon, Infinity

ASSUME
    /\ Delta \in Nat
    /\ Epsilon \in Nat
    /\ 0 < Delta
    /\ Delta <= Epsilon

NotAThread == CHOOSE t : t \notin Thread
-----------------------------------------------------------------------------
VARIABLES x, pc, ubTimer, lbTimer, now, counter

vars == <<x, pc, ubTimer, lbTimer, now, counter>>

TypeOK ==
    /\ x \in Thread \cup {NotAThread}
    /\ pc \in [Thread -> {"ncs", "a", "b", "c", "cs", "d"}]
    /\ ubTimer \in [Thread -> Nat \cup {Infinity}]
    /\ lbTimer \in [Thread -> Nat \cup {Infinity}]
\*    /\ now \in Nat   \* now is unbounded
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
\* Last modified Sat Aug 07 17:09:34 CST 2021 by hengxin
\* Created Sat Aug 07 15:53:10 CST 2021 by hengxin