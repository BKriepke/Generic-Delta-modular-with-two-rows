# We simply compute $\sum_{k\leq x} \varphi(k)$ and $\sum_{k\leq x} \varphi(k)/k$ for $x\leq 42000$ and compare it with the upper and lower bounds
# We convert to floats for efficiency, it does not change the results.

eps = 0.001
x0 = 42000
s1 = 0.0
s2 = 0.0
summatory_phik = [0]
summatory_phik_div_k = [0]
for k in range(1,x0):
    s1 = s1 + float(euler_phi(k))
    s2 = s2 + float(euler_phi(k)/k)
    summatory_phik.append(s1)
    summatory_phik_div_k.append(s2)

PI = float(pi)

lowerBounds_phik = [(1-eps)*3/PI^2*k^2 for k in range(x0)]
upperBounds_phik = [(1+eps)*3/PI^2*k^2 for k in range(x0)]
lowerBounds_phik_div_k = [(1-eps)*6/PI^2*k for k in range(x0)]
upperBounds_phik_div_k = [(1+eps)*6/PI^2*k for k in range(x0)]

M1 = [k for k in range(x0) if lowerBounds_phik[k] > summatory_phik[k] or upperBounds_phik[k] < summatory_phik[k]]
print("Biggest k so that at least one of the inequalities for \sum \\varphi(k) is false:")
print(max(M1))

M1 = [k for k in range(x0) if lowerBounds_phik_div_k[k] > summatory_phik_div_k[k] or upperBounds_phik_div_k[k] < summatory_phik_div_k[k]]
print("Biggest k so that at least one of the inequalities for \sum \\varphi(k)/k is false:")
print(max(M1))