// PLEASE ONLY CHANGE THIS FILE WHERE INDICATED.

// Number of measurements.
int n = 5;

// Range of measurements.
range N = 1..n;

// Define here your decision variables and
// any other auxiliary program variables you need.
// You can run an execute block if needed.

//>>>>>>>>>>>>>>>>

dvar int+ x[i in N];

dvar int+ z; // could also be float+

dvar int d[i in N][j in N]; // could also be float+

dvar int+ av[i in N, j in N]; // av[i,j] = |d[i,j]|. av stands for absolute value
dvar boolean b[i in N, j in N];//binary variable to relate av[i,j] and d[i,j]

//<<<<<<<<<<<<<<<<

minimize z ; // Write here the objective function.

//>>>>>>>>>>>>>>>>

//<<<<<<<<<<<<<<<<

subject to {
    // Write here the constraints.

    //>>>>>>>>>>>>>>>>
    // this maybe isn't necessary, but shouldn't be an issue
    zeroContained:
    	x[1] == 0;// if we comment this line, we get the solution {0,2,7,8,11} which is fine too. 
    zIsMax:
    	forall (i in N)
    	  z >= x[i];
    dIsDifference:
    	forall (i in N, j in N)
    	  d[i][j] == x[i] - x[j];
    xIsOrderedAndNoRepetition:
    	forall (i in 2..n)
    		x[i] >= x[i-1]+1;
    //avij is the absolute value of dij
    dIsLowerThanAv:
		  forall (i,j in N)
		  	d[i,j] <= av[i,j];
    dIsHigherThanMinusAv:
      forall (i,j in N)
        d[i,j] >= -av[i,j];
    bIs1_avIsd:
      forall (i,j in N)
        d[i,j] - av[i,j] >= -2*11 * (1-b[i,j]); //-2*11 is a lower bound for d[i,j] - av[i,j] with n=5. In theory, 11 should be z. 
    bIs0_avIsMinusd:// If b[i,j]=0, we get d[i,j]<=-av[i,j]. We know that d[i,j] <= -av[i,j]. Then d[i,j]=-av[i,j]
      forall (i,j in N)
        d[i,j] + av[i,j] <= 2*11 * b[i,j]; //2*11 is an upper bound of d[i,j] + av[i,j] with n=5.
    
    forall (i,j in N: i < j)
  		forall (k,l in N: k < l)
    		(i != k && j != l) => av[i,j] != av[k,l]; // actually we might not need the av. I think we can replace it by d

    //<<<<<<<<<<<<<<<<
}

// You can run an execute block if needed.

//>>>>>>>>>>>>>>>>

execute {
  writeln(x);
  writeln("----");
}

//<<<<<<<<<<<<<<<<
