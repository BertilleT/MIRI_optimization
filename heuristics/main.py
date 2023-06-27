import numpy as np
import matplotlib.pyplot as plt
from greedy_Bertille import greedy
from local_search_Bertille import local_search_3
from GRASP_Bertille import grasp

def tune_alpha(n, M, max_n):
    for n in range(3,max_n):
        print("n under study", n)
        #M=round(1.5*(n**2) -2*n)
        alpha_list = np.linspace(0,1,11)
        alpha_q_dict = {}
        S = greedy(n,M)
        local_search_greedy_S = local_search_3(S)
        opt_sol = max(local_search_greedy_S)
        #opt_values = {2: 1, 3: 3, 4: 6, 5: 11, 6:17}
        #opt_sol = opt_values[n]
        for alpha in alpha_list:
            S = grasp(n,M,alpha)
            q = max(S)   
            relative_gap = abs(q-opt_sol)/opt_sol
            alpha_q_dict[alpha] = relative_gap
        plt.plot(*zip(*sorted(alpha_q_dict.items())), label = "n (number of elements in the set) = "+str(n))
    plt.xlabel("alpha", size=12)
    plt.ylabel("relative gap", size=12)
    plt.legend()
    plt.show()

if __name__ == '__main__':
    M=15
    n=5

    #Greedy
    #greedy_S = greedy(n, M)
    #local_search_greedy_S = local_search_3(greedy_S)
    #print("Greedy + local search solution: ", local_search_greedy_S)
    #Grasp
    #grasp_S = grasp(n, M, 0.2)
    #print("GRASP solution: ", grasp_S)
    
    #Alpha tuning
    max_n = 9
    M = 100
    tune_alpha(n, M, max_n)