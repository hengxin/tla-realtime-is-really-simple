---- MODULE MC ----
EXTENDS Fischer1, TLC

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
t1, t2, t3
----

\* MV CONSTANT definitions Thread
const_162838599985151000 == 
{t1, t2, t3}
----

\* SYMMETRY definition
symm_162838599985152000 == 
Permutations(const_162838599985151000)
----

\* CONSTANT definitions @modelParameterConstants:0Epsilon
const_162838599985153000 == 
3
----

\* CONSTANT definitions @modelParameterConstants:1Delta
const_162838599985154000 == 
3
----

\* CONSTANT definition @modelParameterDefinitions:2
def_ov_162838599985257000 ==
0 .. 5
----
\* ACTION_CONSTRAINT definition @modelParameterActionConstraint:0
action_constr_162838599985258000 ==
\A t \in Thread : counter[t] <= 4
----
=============================================================================
\* Modification History
\* Created Sun Aug 08 09:26:39 CST 2021 by hengxin
