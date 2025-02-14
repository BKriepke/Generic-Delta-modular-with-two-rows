# We prove Claim 3.10 by bruteforce. 
# This could be more efficient but even bruteforce barely takes a couple of seconds.
# We check that for all options of the variables at least one of the equations is not true. 
# The first four equations we only check mod 6.

import itertools


# In the paper this is c(a,b,3), see Equation (3.5)
def c(a,b):
    if a == 2 and b == 1: return 1/3
    if a == b: return 0
    if a == 1 and b == 2: return -1/3

print("Any solution to the system of equations will be printed.")

# domains for delta, a_i, b_i are mod 6
# domains for d, e_i are in Z
delta_domain = [0,1,3,4,5]
d_domain = [3,4]
b1_domain = [0,1,2,3,4,5]
a2_domain = [1,3,5]
b2_domain = [1,3,5]
a3_domain = [1,2,4,5]
b3_domain = [1,2,4,5]
e1_domain = [0,1,2,3,4]
e2_domain = [0,1,2,3,4]
e3_domain = [0,1,2,3,4,5,6,7,8]
e4_domain = [0,1,2,3,4,5,6,7,8]
cart_product = itertools.product(delta_domain,d_domain,b1_domain,a2_domain,b2_domain,a3_domain,b3_domain,e1_domain,e2_domain,e3_domain,e4_domain)
for (delta, d, b1, a2, b2, a3, b3, e1, e2, e3, e4) in cart_product:
    if delta % 2 == 1 and d == 3: continue
    r = 6*(4-d-c(a3 % 3,b3 % 3))
    if 2*e1+2*e2+e3+e4 != r: continue
    if (b3 + e1 - delta) % 6 != 0: continue
    if (3*b1-a3+e2-delta) % 6 != 0: continue
    if (-3*a2+2*b3+e3-delta) % 6 != 0: continue
    if (3*b2-2*a3+e4-delta)%6 != 0: continue
    print((delta, d, b1, a2, b2, a3, b3, e1, e2, e3, e4))

print("Nothing was printed, so there are no solutions.")