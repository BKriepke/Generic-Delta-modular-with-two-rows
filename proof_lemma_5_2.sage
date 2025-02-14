def solve_dual_problem(m, approximate=False, repeat=0):
    if approximate:
        eps = 2^repeat*1.85/m #seems to work good enough
        L = [(k, ell) for k in range(1, ceil(1/sqrt(2)*m)+1) 
                      for ell in range(max(1,floor(sqrt((1-eps)*m^2-k^2))),min(m+1,ceil(sqrt((1+eps)*m^2-k^2))))]
    else:
        L = [(k, ell) for k in range(1,m+1) for ell in range(1,m+1)]
        
    q = MixedIntegerLinearProgram(maximization = False, solver="GLPK")
    y = q.new_variable(real=True, nonnegative=True)
    for k in range(1,m+1):
        X = [x for x in L if x[0] == k] + [x for x in L if x[1] == k] #pairs (k,ell) or (ell,k) 
        q.add_constraint(sum([y[x] for x in X])>= euler_phi(k))
    q.set_objective(sum(2/product(k for k in x)* y[x] for x in L))
    z_q = q.solve()
    return z_q

# Uses Lemma 5.1
def determine_next_m(m, current_opt_sol, w):
    s = current_opt_sol
    while s < w:
        m = m+1
        s = s + euler_phi(m)/m^2
    return m
    
    
print("m, \t \hat z_m, \t number of repeats")
m = 4
w = 0.999
while m < 4000:
    r = 0
    opt_sol = 2
    while opt_sol > w:
        opt_sol = solve_dual_problem(m, approximate=True, repeat=r)
        r = r+1
    print(m, "\t", opt_sol, "\t", r-1)
    m = determine_next_m(m, opt_sol, w)