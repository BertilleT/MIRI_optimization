import itertools
from greedy_Bertille import feasible

#In theory, we could replace one number by every number from 0 to M, 
#In the context of improvement based local search (make the move only if the solution is better than the current one)
#it does not make sense to replace a number by a number higher or equal than the current maximum of S, 
#because it would imply to obtain a solution of worse or equal quality than the current one, 
#and thus the move would not be done. Thus we can remove values higher or equal to M in the set if possible_substitutions
def local_search_3(S):
    better_sol_list = []
    possible_substitutions = list(range(0,max(S)))
    possible_substitutions = [element for element in possible_substitutions if element not in S]
    combinations_3 = list(itertools.combinations(possible_substitutions, 3))
    S_better = S
    betterSoluFound = False
    for x, y, z in list(itertools.combinations(S, 3)):
        # S_new contains S with x, y and z substituted by three new elements u, v and w. 
        for (u,v,w) in combinations_3:                
            S_new = [o if o not in (x,y,z) else u if o == x else v if o == y else w for o in S] #u replaces x, v replaces y, w replaces z
            if feasible(S_new) and max(S_new) < max(S):
                betterSoluFound = True
                S_better = S_new
                #better_sol_list.append(S_better)
                break
        if betterSoluFound==True: 
            break
    S_better.sort()
    return S_better

if __name__ == '__main__':
    pass