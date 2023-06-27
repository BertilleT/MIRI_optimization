import random
import numpy as np 
from local_search_Bertille import local_search_3

def feasible(Sn):
    distances = set()
    # Calculate distances between each pair of numbers in S
    for i in range(len(Sn)):
        for j in range(i + 1, len(Sn)):
            distance = abs(Sn[i] - Sn[j])
            if distance in distances:
                return False
            distances.add(distance)
    return True

def grasp(n=5, M=28, alpha_param = 0.25):
    for i in list(range(0,10)):
        #CONSTRUCTIVE PHASE
        S = []
        while len(S) < n:
            C=list(range(0,M))
            #In the candidate set, remove elements that are already on S. Repetitions are not possible. 
            C = [element for element in C if element not in S]
            feasible_candidates = []
            for c in C:
                Sn = S.copy()
                Sn.append(c)
                if feasible(Sn):
                    feasible_candidates.append(c)
            if feasible_candidates == []:
                print("There are no feasible candidates in grasp. Try to increase the value of your upper bound M, or to decrease the alpha value. ")
                break
            alpha = round(len(feasible_candidates)*alpha_param) #to start, let us say we say the RCL is composed of the 25% better candidates from the feasible one
            if alpha > 1:
                REC = feasible_candidates[:alpha] #REC stands for Restricted Candidate List
            else: 
                REC = feasible_candidates
            c_best = random.choice(REC)
            S.append(c_best)
        S.sort()
        #LOCAL_SEARCH
        local_search_grasp_S = local_search_3(S)
        if len(local_search_grasp_S) == n:
            if i == 0:
                S_best = local_search_grasp_S
            else:
                if max(local_search_grasp_S) < max(S_best):
                    S_best=local_search_grasp_S
    return S_best

if __name__ == '__main__':
    S_grasp = grasp()
    print(S_grasp)