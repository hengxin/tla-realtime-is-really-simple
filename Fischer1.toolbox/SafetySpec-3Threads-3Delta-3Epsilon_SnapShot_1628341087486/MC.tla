---- MODULE MC ----
EXTENDS Fischer1, TLC

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
t1, t2, t3
----

\* MV CONSTANT definitions Thread
const_162833920537411000 == 
{t1, t2, t3}
----

\* SYMMETRY definition
symm_162833920537412000 == 
Permutations(const_162833920537411000)
----

\* CONSTANT definitions @modelParameterConstants:0Epsilon
const_162833920537413000 == 
3
----

\* CONSTANT definitions @modelParameterConstants:1Delta
const_162833920537414000 == 
3
----

\* CONSTANT definition @modelParameterDefinitions:2
def_ov_162833920537417000 ==
0 .. 5
----
\* ACTION_CONSTRAINT definition @modelParameterActionConstraint:0
action_constr_162833920537418000 ==
\A t \in Thread : counter[t] <= 4
----
=============================================================================
\* Modification History
\* Created Sat Aug 07 20:26:45 CST 2021 by hengxin
