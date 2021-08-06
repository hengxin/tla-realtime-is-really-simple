---- MODULE MC ----
EXTENDS Fischer1, TLC

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
t1, t2, t3
----

\* MV CONSTANT definitions Thread
const_162821672785752000 == 
{t1, t2, t3}
----

\* SYMMETRY definition
symm_162821672785753000 == 
Permutations(const_162821672785752000)
----

\* CONSTANT definitions @modelParameterConstants:0Epsilon
const_162821672785754000 == 
3
----

\* CONSTANT definitions @modelParameterConstants:1Delta
const_162821672785755000 == 
3
----

\* CONSTANT definition @modelParameterDefinitions:2
def_ov_162821672785758000 ==
0 .. 5
----
\* ACTION_CONSTRAINT definition @modelParameterActionConstraint:0
action_constr_162821672785759000 ==
\A t \in Thread : counter[t] <= 4
----
=============================================================================
\* Modification History
\* Created Fri Aug 06 10:25:27 CST 2021 by hengxin
