---- MODULE MC ----
EXTENDS UntimedFischer, TLC

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
t1, t2, t3
----

\* MV CONSTANT definitions Thread
const_1628060323546109000 == 
{t1, t2, t3}
----

\* SYMMETRY definition
symm_1628060323547110000 == 
Permutations(const_1628060323546109000)
----

=============================================================================
\* Modification History
\* Created Wed Aug 04 14:58:43 CST 2021 by hengxin
