// PLEASE ONLY CHANGE THIS FILE WHERE INDICATED.

// Number of measurements.
int n = 30;

// Range of measurements.
range N = 1..n;

// Define here your decision variables and
// any other auxiliary program variables you need.
// You can run an execute block if needed.

//>>>>>>>>>>>>>>>>

dvar int+ x[i in N];
dvar int+ z; // could also be float+

dvar int d[i in N][j in N]; // could also be float+

//<<<<<<<<<<<<<<<<

minimize z ; // Write here the objective function.

//>>>>>>>>>>>>>>>>

//<<<<<<<<<<<<<<<<

subject to {
    // Write here the constraints.

    //>>>>>>>>>>>>>>>>
    zIsMax:
    	forall (i in N)
    	  z >= x[i];
    dIsDifference:
    	forall (i in N, j in N)
    	  d[i][j] == x[i] - x[j];
    xIsOrderedAndNoRepetition:
    	forall (i in 2..n)
    		x[i] >= x[i-1]+1;
    		
   	forall (i,j in N: i < j)
  		forall (k,l in N: k < l)
    		(i != k && j != l) => d[i,j] != d[k,l]; 
}

// You can run an execute block if needed.

//>>>>>>>>>>>>>>>>

execute {
  writeln(x);
  writeln("----");
}

//<<<<<<<<<<<<<<<<
