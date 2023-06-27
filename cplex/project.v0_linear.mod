// PLEASE ONLY CHANGE THIS FILE WHERE INDICATED.

int nNaturalNumbers=3;
range N=1..nNaturalNumbers;

// Define here your decision variables and
// any other auxiliary program variables you need.
// You can run an execute block if needed.

//>>>>>>>>>>>>>>>>
dvar int+ x[n in N];
dvar int+ z;

dvar int d[i in N, j in N]; // d[ij] = x[i] - x[j]
dvar boolean e[i in N,j in N]; 
// e[ij] = 1 if d[ij]-av[ij] >= 0, d[ij] >= av[ij]. 
// Because of the constraint "d[i,j] <= av[i,j]", we obtain that d[ij] = av[ij]. 
// e[ij] = 0 if d[ij]+av[ij] <= 0, d[ij] <= -av[ij]
// Because of the constraint "d[ij] >= -av[ij]", we obtain that d[ij] = -av[ij]. 
dvar int+ av[i in N, j in N]; // av[ij] = |d[ij]|. av stands for absolute value

dvar int dif[i in N, j in N, k in N, l in N]; //dif[ijkl] = d[ij] - d[kl]
dvar boolean g[i in N,j in N, k in N, l in N]; //g[ijkl] = 1 if dif[i,j,k,l] - avd[i,j,k,l] >=0. 
//g[ijkl] = 0 if dif[i,j,k,l] + avd[i,j,k,l] <= 0. Same reasoning as with e. 
dvar int+ avd[i in N, j in N, k in N, l in N]; //avd[ijkl] = |d[ij]-d[kl]|. avd stands for absolute value of the distance

dvar boolean b[i in N, j in N, k in N, l in N]; // b[ijkl] = 1 if avd[ijkl] <= 0. b[ijkl] = 0 if avd[ijkl] > 0 => avd[ijkl]-1 >= 0. 

//<<<<<<<<<<<<<<<<

minimize z ; // Write here the objective function.

//>>>>>>>>>>>>>>>>

//<<<<<<<<<<<<<<<<

subject to {
    // Write here the constraints.

    //>>>>>>>>>>>>>>>>
  	x[1]==0;
    zIsMax:
	    forall (i in N)
      		z >= x[i];
 	xIsOrderedAndNoRepetition:	
	  	forall (i in 2..nNaturalNumbers)
	    	x[i] >= x[i-1]+1;
	distanceij:
	//dij is the difference between xi and xj  
		forall (i,j in N)
		  d[i,j] == x[i] - x[j];
	dijPositive:
	//-avij <= dij <= avij
		forall (i,j in N)
		  	d[i,j] <= av[i,j];
	dijNegative:
		forall (i,j in N)
		  	d[i,j] >= -av[i,j];
	//avij is the absolute value of dij. eij is 1 if avij = dij, eij is 0 if avij = -dij. 
	e_ijIsOne: 	
		forall (i,j in N)
	  	//absoluteValueijLowBound:
  	  	// In the worst case, dij = -z, and avij = z. A lower bound of dij-avij is -2z. 
		// Yet, we can not choose -2z as a lower bound because z is a variable and opl does not accept it. 
		// We chose z=11 which works for n<=5. 
			d[i,j] - av[i,j] >= -2*11 * (1-e[i,j]);
	e_ijIsZero:
		forall (i,j in N)
	  	  //absoluteValueijUpBound:
			d[i,j] + av[i,j] <= 2*11 * e[i,j];
	
	//dif_ijkl is the difference between dij and dkl  
	difDijDkl:
		forall (i,j,k,l in N)
			dif[i,j,k,l] == d[i,j] - d[k,l];
	
	//-avd_ijkl <= dif_ijkl <= avd_ijkl
	dif_ijklPositive:
		forall (i,j,k,l in N)
		  	dif[i,j,k,l] <= avd[i,j,k,l];
	dif_ijklNegative:
		forall (i,j,k,l in N)
		  	dif[i,j,k,l] >= -avd[i,j,k,l];
	  	
	//avd_ijkl is the absolute value of dif_ijkl. g_ijkl is 1 if avd_ijkl = dif_ijkl, g_ijkl is 0 if avd_ijkl = -dif_ijkl.
	g_ijklIsOne:
		forall (i,j,k,l in N)
			dif[i,j,k,l] - avd[i,j,k,l] >= -2*11 * (1-g[i,j,k,l]);
	g_ijklIsZero:
		forall (i,j,k,l in N)
			dif[i,j,k,l] + avd[i,j,k,l] <= 2*11  * g[i,j,k,l];	
		
	//link b_ijkl and avd_ijkl
	
	//ensure that bijkl = 1 implies that avd_ijkl <= 0, which mean that av_ij = av_kl. 
	//let us consider Bijkl = 1-bijkl
	//then Bijkl = 0 implies that avd_ijkl <= 0
  	b_ijklIsOne:
	   forall (i,j,k,l in N)
	  	//f <= U * B
	  	avd[i,j,k,l] <= 11 * (1-b[i,j,k,l]);
	b_ijklIsZero:
		forall (i,j,k,l in N)
		  	// f >= L (1-B)
		  	avd[i,j,k,l]-1 >= 0 - b[i,j,k,l];
	//ensure that bijkl = 1 (ie 1-bijkl = 0) implies that avd_ijkl > 0
	//ensure all distances are differents
	distanceAreDif:
    	forall (i in N)
    		sum(j in N, k in N, l in N: k!=i)b[i,j,k,l] == 2;// ==nNaturalNumbers if i==k
}

// You can run an execute block if needed.

//>>>>>>>>>>>>>>>>

execute {
  writeln(x);
  writeln("----");
}

//<<<<<<<<<<<<<<<<
