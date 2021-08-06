------------------------------- MODULE Leader -------------------------------
EXTENDS Reals, Bags
-----------------------------------------------------------------------------
CONSTANTS N, Nbrs(_), MsgDelay, TODelay, Period

Node == 1 .. N
-----------------------------------------------------------------------------
VARIABLES
    ldr,    \* ldr[n]: The node that n believes to be its leader.
    dist,   \* dist[n]: What n believes to be its distance to ldr[n].
    timer,  \* A countdown timer for node n's timeout action.
    msgs,   \* the messages in transit
    now     \* the now timer
=============================================================================
\* Modification History
\* Last modified Fri Aug 06 12:00:28 CST 2021 by hengxin
\* Created Fri Aug 06 11:55:18 CST 2021 by hengxin