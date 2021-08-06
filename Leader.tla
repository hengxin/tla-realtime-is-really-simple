------------------------------- MODULE Leader -------------------------------
EXTENDS Reals, Bags
-----------------------------------------------------------------------------
CONSTANTS
    N,        \* number of nodes
    Nbrs(_),  \* Nbrs(n): the neighbors of node n
    Period,   \* timer for nodes that believe themselves to be the leader
    MsgDelay, \* A message is received at most MsgDelay seconds after it is sent
    TODelay   \* Nodes can be awakened up to TODelay seconds after timeout

Node == 1 .. N

ASSUME
    /\ N \in Nat
    /\ \A n \in Node:
        /\ Nbrs(n) \subseteq Node
        /\ \A m \in Nbrs(n) : n \in Nbrs(m)
    /\ {Period, MsgDelay, TODelay} \subseteq {r \in Real : r > 0}
-----------------------------------------------------------------------------
VARIABLES
    ldr,    \* ldr[n]: The node that n believes to be its leader.
    dist,   \* dist[n]: What n believes to be its distance to ldr[n].
    timer,  \* A countdown timer for node n's timeout action.
    msgs,   \* the messages in transit; there may be duplicate messages
    now     \* the now timer

vars == <<ldr, dist, timer, msgs, now>>
    
Msg == [src : Node, \* the sender
       dest : Node, \* the destination
        ldr : Node, \* the leader that originated the message
       hops : Nat,  \* the number of times the message has been forwarded
   rcvTimer : Real] \* a countdown timer used to express the upper-bound constraint on message-delivery time
-----------------------------------------------------------------------------
TypeOK ==
    /\ ldr \in Node
    /\ dist \in Nat
    /\ timer \in Real
    /\ msgs \in SubBag(SetToBag(Msg))
    /\ now \in Real   \* now is unbounded; commet it in model checking
-----------------------------------------------------------------------------
Init ==
    /\ ldr   = [n \in Node |-> n]
    /\ dist  = [n \in Node |-> 0]
    /\ timer = [n \in Node |-> Period]
    /\ msgs  = EmptyBag
    /\ now   = 0
-----------------------------------------------------------------------------
MsgsSent(n, S) ==
    SetToBag([src : {n}, dest : S, ldr : {ldr'[n]},
             hops : {dist'[n]}, rcvTimer: {MsgDelay}])

TimeOut(n) ==
    /\ timer[n] < 0
    /\ ldr'   = [ldr EXCEPT ![n] = n]             
    /\ dist'  = [dist EXCEPT ![n] = 0]
    /\ timer' = [timer EXCEPT ![n] = Period]
    /\ msgs'  = msgs (+) MsgsSent(n, Nbrs(n))
    /\ UNCHANGED now

RcvMsg(n) ==
    /\ \E m \in BagToSet(msgs):
        /\ m.dest = n
        /\ IF \/ m.ldr < ldr[n]
              \/ /\ m.ldr = ldr[n]
                 /\ m.hops + 1 < dist[n] \* TODO: "<=" in Lamport's spec?
           THEN /\ ldr' = [ldr EXCEPT ![n] = m.ldr]
                /\ dist' = [dist EXCEPT ![n] = m.hops + 1]
                /\ timer' = [timer EXCEPT ![n] =
                                Period + TODelay + dist'[n] * MsgDelay]
                /\ msgs' = (msgs (-) SetToBag({m}))
                                 (+) MsgsSent(n, Nbrs(n) \ {m.src})
           ELSE /\ msgs' = msgs (-) SetToBag({m})                                 
                /\ UNCHANGED <<ldr, dist, timer>>
    /\ UNCHANGED now

Tick ==
    \E d \in Real:
        /\ d > 0
        /\ \A n \in Node : timer[n] + TODelay >= d
        /\ \A m \in BagToSet(msgs) : m.rcvTimder >= d
        /\ timer' = [n \in Node |-> timer[n] - d]    
        /\ msgs' = LET Updated(m) == [m EXCEPT !.rcvTimer = @ - d]
                    IN BagOfAll(Updated, msgs)
        /\ now' = now + d
        /\ UNCHANGED <<ldr, dist>>                    

Next ==
    \/ \E n \in Node : TimeOut(n) \/ RcvMsg(n)
    \/ Tick
-----------------------------------------------------------------------------
LSpec == Init /\ [][Next]_vars
-----------------------------------------------------------------------------
Min(S) == CHOOSE i \in S : \A j \in S : i <= j

Ball(i, n) == \* The set of nodes with distance of at most i from node n.
    LET B[j \in 0 .. i] ==
        IF j = 0 THEN {n}
                 ELSE B[j - 1] \cup UNION {Nbrs(m) : m \in B[j - 1]}
     IN B[i]
     
Dist(m, n) == \* The distance between nodes m and n, if it is finite.
    Min({i \in 0 .. N : m \in Ball(i, n)})
-----------------------------------------------------------------------------
Correctness ==
    LET Ldr(n) == Min(Ball(N, n))
     IN \A n \in Node:
            (now > Period + TODelay + Dist(n, Ldr(n) * MsgDelay)
                => ldr[n] = Ldr(n))

THEOREM LSpec => []Correctness
=============================================================================
\* Modification History
\* Last modified Fri Aug 06 14:08:46 CST 2021 by hengxin
\* Created Fri Aug 06 11:55:18 CST 2021 by hengxin