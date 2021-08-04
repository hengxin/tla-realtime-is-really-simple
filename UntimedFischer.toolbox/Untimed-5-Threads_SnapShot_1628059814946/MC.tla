---- MODULE MC ----
EXTENDS UntimedFischer, TLC

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
t1, t2, t3, t4, t5
----

\* MV CONSTANT definitions Thread
const_162805981290684000 == 
{t1, t2, t3, t4, t5}
----

\* SYMMETRY definition
symm_162805981290685000 == 
Permutations(const_162805981290684000)
----

=============================================================================
\* Modification History
\* Created Wed Aug 04 14:50:12 CST 2021 by hengxin
