---- MODULE MC ----
EXTENDS UntimedFischer, TLC

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
t1, t2, t3, t4, t5
----

\* MV CONSTANT definitions Thread
const_1628060333575114000 == 
{t1, t2, t3, t4, t5}
----

\* SYMMETRY definition
symm_1628060333575115000 == 
Permutations(const_1628060333575114000)
----

=============================================================================
\* Modification History
\* Created Wed Aug 04 14:58:53 CST 2021 by hengxin
