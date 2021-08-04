---- MODULE MC ----
EXTENDS UntimedFischer, TLC

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
t1, t2, t3
----

\* MV CONSTANT definitions Thread
const_162805939850459000 == 
{t1, t2, t3}
----

\* SYMMETRY definition
symm_162805939850460000 == 
Permutations(const_162805939850459000)
----

=============================================================================
\* Modification History
\* Created Wed Aug 04 14:43:18 CST 2021 by hengxin
