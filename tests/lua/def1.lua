local b  = mk_constant_assumption("bit", Type)
local l1 = mk_param_univ("l1")
local l2 = mk_param_univ("l2")
local p  = mk_constant_assumption("tst", {"l1", "l2"}, mk_arrow(mk_sort(l1), mk_sort(l2)))
assert(p:is_constant_assumption())
assert(not p:is_axiom())
assert(p:name() == name("tst"))
print(mk_arrow(mk_sort(l1), mk_sort(l2)))
assert(p:type() == mk_arrow(mk_sort(l1), mk_sort(l2)))
assert(#(p:univ_params()) == 2)
assert(p:univ_params():head() == name("l1"))
assert(p:univ_params():tail():head() == name("l2"))
local ax  = mk_axiom("ax", {"l1", "l2"}, mk_arrow(mk_sort(l1), mk_sort(l2)))
assert(ax:is_constant_assumption())
assert(ax:is_axiom())
assert(ax:name() == name("ax"))
assert(not pcall(function() print(ax:value()) end))
local th  = mk_theorem("t1", {"l1", "l2"}, mk_arrow(mk_sort(l1), mk_sort(l2)), mk_lambda("x", mk_sort(l1), Var(0)))
assert(th:is_theorem())
assert(th:is_definition())
assert(th:value() == mk_lambda("x", mk_sort(l1), Var(0)))
print(th:value())
local A = Const("A")
local B = Const("B")
local th2  = mk_theorem("t2", A, B)
assert(th2:type() == A)
assert(th2:value() == B)
assert(th2:name() == name("t2"))
local d  = mk_definition("d1", A, B)
assert(d:is_definition())
assert(not d:is_theorem())
assert(d:opaque())
assert(d:weight() == 0)
assert(d:module_idx() == 0)
assert(d:use_conv_opt())
assert(d:name() == name("d1"))
assert(d:value() == B)
local d2  = mk_definition("d2", A, B, nil)
local d3  = mk_definition("d3", A, B, {opaque=false, weight=100, module_idx=10, use_conv_opt=false})
assert(not d3:opaque())
assert(d3:weight() == 100)
assert(d3:module_idx() == 10)
assert(not d3:use_conv_opt())
local env = bare_environment()
local d4  = mk_definition(env, "bool", Type, Prop)
assert(d4:weight() == 1)
local d5  = mk_definition(env, "bool", Type, Prop, {opaque=false, weight=100, module_idx=3, use_conv_opt=true})
assert(not d5:opaque())
assert(d5:weight() == 1)
assert(d5:module_idx() == 3)
assert(d5:use_conv_opt())
local d6  = mk_definition("d6", {"l1", "l2"}, A, B, {opaque=true, weight=5})
assert(d6:type() == A)
assert(d6:value() == B)
assert(#(d6:univ_params()) == 2)
assert(d6:univ_params():head() == name("l1"))
assert(d6:univ_params():tail():head() == name("l2"))
assert(d6:opaque())
assert(d6:weight() == 5)
local d7 = mk_definition(env, "d7", {"l1", "l2"}, A, B, {opaque=true, weight=5})
assert(d7:type() == A)
assert(d7:value() == B)
assert(d7:weight() == 1)
assert(#(d7:univ_params()) == 2)
assert(d7:univ_params():head() == name("l1"))
assert(d7:univ_params():tail():head() == name("l2"))
assert(d7:opaque())
print("done")
assert(not pcall(function() mk_theorem("t1", {max_univ("l1", "l2")}, mk_arrow(mk_sort(l1), mk_sort(l2)), mk_lambda("x", mk_sort(l1), Var(0))) end))
local l1 = global_univ("l1")
mk_theorem("t1", {l1, "l2"}, mk_arrow(mk_sort(l1), mk_sort(l2)), mk_lambda("x", mk_sort(l1), Var(0)))

assert(not pcall(function() mk_definition("bit", Type) end))
local env = environment(10)
assert(not pcall(function() mk_definition(env, "bit", Type) end))
