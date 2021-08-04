---- MODULE MC ----
EXTENDS UntimedFischer, TLC

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
t1, t2, t3
----

\* MV CONSTANT definitions Thread
const_162805936006449000 == 
{t1, t2, t3}
----

\* SYMMETRY definition
symm_162805936006450000 == 
Permutations(const_162805936006449000)
----

=============================================================================
\* Modification History
\* Created Wed Aug 04 14:42:40 CST 2021 by hengxin
