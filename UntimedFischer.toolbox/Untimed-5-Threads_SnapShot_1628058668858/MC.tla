---- MODULE MC ----
EXTENDS UntimedFischer, TLC

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
t1, t2, t3, t4, t5
----

\* MV CONSTANT definitions Thread
const_162805866565334000 == 
{t1, t2, t3, t4, t5}
----

\* SYMMETRY definition
symm_162805866565335000 == 
Permutations(const_162805866565334000)
----

=============================================================================
\* Modification History
\* Created Wed Aug 04 14:31:05 CST 2021 by hengxin
