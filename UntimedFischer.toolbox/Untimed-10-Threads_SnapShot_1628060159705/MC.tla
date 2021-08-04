---- MODULE MC ----
EXTENDS UntimedFischer, TLC

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
t1, t2, t3, t4, t5, t6, t7, t8, t9, t10
----

\* MV CONSTANT definitions Thread
const_162805993265994000 == 
{t1, t2, t3, t4, t5, t6, t7, t8, t9, t10}
----

\* SYMMETRY definition
symm_162805993265995000 == 
Permutations(const_162805993265994000)
----

=============================================================================
\* Modification History
\* Created Wed Aug 04 14:52:12 CST 2021 by hengxin
