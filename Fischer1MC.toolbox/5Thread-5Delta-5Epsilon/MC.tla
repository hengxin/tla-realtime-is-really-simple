---- MODULE MC ----
EXTENDS Fischer1MC, TLC

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
t1, t2, t3, t4, t5
----

\* MV CONSTANT definitions Thread
const_16283389592772000 == 
{t1, t2, t3, t4, t5}
----

\* SYMMETRY definition
symm_16283389592773000 == 
Permutations(const_16283389592772000)
----

\* CONSTANT definitions @modelParameterConstants:0Epsilon
const_16283389592774000 == 
5
----

\* CONSTANT definitions @modelParameterConstants:1Delta
const_16283389592775000 == 
5
----

\* CONSTANT definition @modelParameterDefinitions:1
def_ov_16283389592777000 ==
0 .. 10
----
\* SPECIFICATION definition @modelBehaviorSpec:0
spec_16283389592778000 ==
SafetySpec
----
\* INVARIANT definition @modelCorrectnessInvariants:0
inv_16283389592779000 ==
TypeOK
----
\* INVARIANT definition @modelCorrectnessInvariants:1
inv_162833895927710000 ==
MutualExclusion
----
=============================================================================
\* Modification History
\* Created Sat Aug 07 20:22:39 CST 2021 by hengxin
