---- MODULE MC ----
EXTENDS UntimedFischer, TLC

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
t1, t2, t3, t4
----

\* MV CONSTANT definitions Thread
const_162805972231374000 == 
{t1, t2, t3, t4}
----

\* SYMMETRY definition
symm_162805972231375000 == 
Permutations(const_162805972231374000)
----

=============================================================================
\* Modification History
\* Created Wed Aug 04 14:48:42 CST 2021 by hengxin
