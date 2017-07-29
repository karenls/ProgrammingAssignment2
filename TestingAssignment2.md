# Simple test matrices for the lexical scoping programming assignment

(The info below was copied from a week 3 post in the forums for Coursera's R Programming class.) I've edited it for better reading as reference.)

Since linear algebra is not a prerequisite for this Course (note - linear algebra is very valuable to learn), and queries about testing cachematrix.R have come up, I thought it might be useful to provide a couple simple examples. Also, as has been noted (and one learns in linear algebra) , not all square matrices have matrix inverses ("most" do). And, as noted in a previous Post, trying to invert a singular matrix using the solve function will result in an error message.

The R session below gives a couple examples - hope it is helpful,

Alan

    > setwd("C:/berger/R_course_cs") # my working directory
    > rm(list = ls())  # remove any "left over" objects
    > source("cachematrix.R")
    > testmtx <- matrix(c(1,0,0,1), 2,2)
    > testmtx
         [,1] [,2]
    [1,]    1    0
    [2,]    0    1
    > solve(testmtx)
         [,1] [,2]
    [1,]    1    0
    [2,]    0    1

The identity matrix is not the only matrix that is its own inverse - such matrices are called involutory matrices

    > cachedtestmtx <- makeCacheMatrix(testmtx)
    > cacheSolve(cachedtestmtx)
         [,1] [,2]
    [1,]    1    0
    [2,]    0    1
    > cacheSolve(cachedtestmtx)
    getting cached data
     [,1] [,2]
    [1,]    1    0
    [2,]    0    1

A second more complicated matrix

    testmtx2 <- matrix(c(9,1,9,7,2,3,6,7,8,0,3,1,4,1,5,9), 4,4)
    > testmtx2
         [,1] [,2] [,3] [,4]
    [1,]    9    2    8    4
    [2,]    1    3    0    1
    [3,]    9    6    3    5
    [4,]    7    7    1    9
    > solve(testmtx2)
                [,1]       [,2]        [,3]        [,4]
    [1,] -0.11888112 -0.3916084  0.34965035 -0.09790210
    [2,]  0.02331002  0.5081585 -0.04895105 -0.03962704
    [3,]  0.22843823  0.3799534 -0.27972028  0.01165501
    [4,]  0.04895105 -0.1328671 -0.20279720  0.21678322

Now we can use the set function instead of calling makeCacheMatrix a second time. Use the set function to "put" a new matrix into the cachedtestmtx object (in the variable x).

Set also resets the matrix inverse to be NULL so that cacheSolve will "know" it needs to compute the matrix inverse of x and not just "fetch" an already calculated one (since x has been changed).

    > cachedtestmtx$set(testmtx2)

Now check the above command has reset the matrix in the cachedtestmtx object as desired

    > cachedtestmtx$get()  
         [,1] [,2] [,3] [,4]
    [1,]    9    2    8    4
    [2,]    1    3    0    1
    [3,]    9    6    3    5
    [4,]    7    7    1    9

OK, so now we are ready to use cacheSolve to get the matrix inverse of testmtx2:

    > cacheSolve(cachedtestmtx)
            [,1]       [,2]        [,3]        [,4]
    [1,] -0.11888112 -0.3916084  0.34965035 -0.09790210
    [2,]  0.02331002  0.5081585 -0.04895105 -0.03962704
    [3,]  0.22843823  0.3799534 -0.27972028  0.01165501
    [4,]  0.04895105 -0.1328671 -0.20279720  0.21678322
    > cacheSolve(cachedtestmtx)
    getting cached data
                [,1]       [,2]        [,3]        [,4]
    [1,] -0.11888112 -0.3916084  0.34965035 -0.09790210
    [2,]  0.02331002  0.5081585 -0.04895105 -0.03962704
    [3,]  0.22843823  0.3799534 -0.27972028  0.01165501
    [4,]  0.04895105 -0.1328671 -0.20279720  0.21678322

Check

    > cacheSolve(cachedtestmtx) %*% testmtx2
    getting cached data
                  [,1]          [,2]          [,3]          [,4]
    [1,]  1.000000e+00  8.881784e-16  1.665335e-16  3.330669e-16
    [2,]  1.110223e-16  1.000000e+00  2.706169e-16 -2.220446e-16
    [3,] -4.579670e-16 -1.387779e-17  1.000000e+00 -4.024558e-16
    [4,]  0.000000e+00 -4.440892e-16 -8.326673e-17  1.000000e+00

Matrix inversion is in general not an exact ("infinite precision") calculation for all practical purposes this is the 4 by 4 identity matrix (as it should be).

Controlling printout with number of significant digits

    > print(cacheSolve(cachedtestmtx) %*% testmtx2, digits = 4)
    getting cached data
              [,1]       [,2]       [,3]       [,4]
    [1,]  1.00e+00  8.882e-16  1.665e-16  3.331e-16
    [2,]  1.11e-16  1.000e+00  2.706e-16 -2.220e-16
    [3,] -4.58e-16 -1.388e-17  1.000e+00 -4.025e-16
    [4,]  0.00e+00 -4.441e-16 -8.327e-17  1.000e+00

Better handling of this printout:

    > round(cacheSolve(cachedtestmtx) %*% testmtx2, digits = 4)
    getting cached data
         [,1] [,2] [,3] [,4]
    [1,]    1    0    0    0
    [2,]    0    1    0    0
    [3,]    0    0    1    0
    [4,]    0    0    0    1