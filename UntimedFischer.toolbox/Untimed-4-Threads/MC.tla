---- MODULE MC ----
EXTENDS UntimedFischer, TLC

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
t1, t2, t3, t4
----

\* MV CONSTANT definitions Thread
const_1628060304104104000 == 
{t1, t2, t3, t4}
----

\* SYMMETRY definition
symm_1628060304104105000 == 
Permutations(const_1628060304104104000)
----

=============================================================================
\* Modification History
\* Created Wed Aug 04 14:58:24 CST 2021 by hengxin
