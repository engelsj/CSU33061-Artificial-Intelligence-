# excersive = (9(s,exercise,s`)) / 10 
# relax = (99(ps,relax,s`)) / 100 
#                             fit 0               unfit 1        death 2
Fit =  0
Unfit = 1
Dead = 2
Exercise = 1
Relax = 0
exerciseMatrix = [[[.891, .009, .1],[8, 8, 0]], [[.18, .72, .1],[0, 0, 0]], [[0,0,1],[0,0,0]]]
relaxMatrix =    [[[.693, .297, .01],[10, 10, 0]],[[0, .99, .01],[5, 5, 0]],  [[0,0,1],[0, 0, 0]]]

def show(n,s,gamma):
    if n < 0:
        return "Constraint: n must be a positive integer"
    if  s != Fit and s != Unfit and s != Dead:
        return "Constraint: state must be either Fit, Unfit, or Dead"
    if gamma >= 1 or gamma <= 0:
        return "Constraint: 0 < g < 1"
    global g
    g = gamma
    for i in range(0, n+1):
        print('n=%d exer: %f relax: %f' % (i, q(s, Exercise, i), q(s, Relax, i)))

def q(s, a, n):
    q0 = (p(s, a, Fit) * r(s, a, Fit)) + (p(s, a, Unfit) * r(s, a, Unfit))
    if n == 0:
        return q0
    else:
        return q0 + (g * ((p(s, a, Fit) * v(Fit, n-1)) + (p(s, a, Unfit) * v(Unfit, n-1))))

def v(s,n):
    return max(q(s, Exercise, n), q(s,Relax,n))

def p(s,a,result):
    if a == Exercise:
        return exerciseMatrix[s][0][result]
    else:
         return relaxMatrix[s][0][result]

def r(s,a,result):
    if a == Exercise:
        return exerciseMatrix[s][1][result]
    else:
         return relaxMatrix[s][1][result]

show(10,Fit,0.5)
print()
show(8,Unfit,0.8)
print()
show(10,Dead,0.99)