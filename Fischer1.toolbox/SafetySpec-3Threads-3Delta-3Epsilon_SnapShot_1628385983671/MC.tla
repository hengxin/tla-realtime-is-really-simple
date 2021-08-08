---- MODULE MC ----
EXTENDS Fischer1, TLC

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
t1, t2, t3
----

\* MV CONSTANT definitions Thread
const_162834115440741000 == 
{t1, t2, t3}
----

\* SYMMETRY definition
symm_162834115440742000 == 
Permutations(const_162834115440741000)
----

\* CONSTANT definitions @modelParameterConstants:0Epsilon
const_162834115440743000 == 
3
----

\* CONSTANT definitions @modelParameterConstants:1Delta
const_162834115440744000 == 
3
----

\* CONSTANT definition @modelParameterDefinitions:2
def_ov_162834115440747000 ==
0 .. 5
----
\* ACTION_CONSTRAINT definition @modelParameterActionConstraint:0
action_constr_162834115440748000 ==
\A t \in Thread : counter[t] <= 4
----
=============================================================================
\* Modification History
\* Created Sat Aug 07 20:59:14 CST 2021 by hengxin
