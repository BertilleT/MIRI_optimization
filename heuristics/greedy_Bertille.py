import matplotlib.pyplot as plt
import numpy as np

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

def greedy(n=5, M=15):
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
            print("There are no feasible candidates. Try to increase the value of your upper bound M")
            break
        c_best = min(feasible_candidates)
        S.append(c_best)
    return S

def upper_bound(n):
    return 1.5*n**2-n

def plot_upper_bound():
    my_dict={}
    for n in list(range(1,21)):
        my_dict[n] = max(greedy(n,500))
    plt.plot(*zip(*sorted(my_dict.items())), color="blue", label = "Maximum value of the optimal solution")
    x = np.linspace(1, 21, 100)
    plt.plot(x, upper_bound(x), color="red", label="f(x) = 1.5x² -2x. Upper bound chosen")
    plt.xlim(0,40)
    plt.ylabel("Maximum value of the set")
    plt.xlabel("n(= the number of elements in the set)")
    plt.legend()
    plt.show()

if __name__ == '__main__':
    S = greedy()
    print(S)