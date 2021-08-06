---- MODULE MC ----
EXTENDS Fischer1, TLC

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
t1, t2, t3
----

\* MV CONSTANT definitions Thread
const_162821661762942000 == 
{t1, t2, t3}
----

\* SYMMETRY definition
symm_162821661762943000 == 
Permutations(const_162821661762942000)
----

\* CONSTANT definitions @modelParameterConstants:0Epsilon
const_162821661762944000 == 
3
----

\* CONSTANT definitions @modelParameterConstants:1Delta
const_162821661762945000 == 
3
----

\* CONSTANT definition @modelParameterDefinitions:2
def_ov_162821661762948000 ==
0 .. 5
----
\* ACTION_CONSTRAINT definition @modelParameterActionConstraint:0
action_constr_162821661762949000 ==
\A t \in Thread : counter[t] <= 4
----
=============================================================================
\* Modification History
\* Created Fri Aug 06 10:23:37 CST 2021 by hengxin
