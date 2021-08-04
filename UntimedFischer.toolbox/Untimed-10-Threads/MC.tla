---- MODULE MC ----
EXTENDS UntimedFischer, TLC

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
t1, t2, t3, t4, t5, t6, t7, t8, t9, t10
----

\* MV CONSTANT definitions Thread
const_162806028264799000 == 
{t1, t2, t3, t4, t5, t6, t7, t8, t9, t10}
----

\* SYMMETRY definition
symm_1628060282647100000 == 
Permutations(const_162806028264799000)
----

=============================================================================
\* Modification History
\* Created Wed Aug 04 14:58:02 CST 2021 by hengxin
