## R Programming | Assignment 2

## Matrix inversion is usually a costly computation and there may be some
## benefit to caching the inverse of a matrix rather than computing it
## repeatedly. The following pair of functions work in conjunction to solve
## and cache an inverted matrix.

## makeCacheMatrix creates a special "matrix" object that can cache its inverse.
## It is first assigned to an object (e.g. makeCM) to create an instance of it,
## and passed a matrix to store. It can be retrieved with `makeCM$get()` and a 
## new matrix can be stored by using `makeCM$set()`. In this case, the  
## previously cached matrix is "erased".

makeCacheMatrix <- function(x = matrix()) {
    iM <- NULL
    set <- function(y) {
        x <<- y
        iM <<- NULL
    }
    get <- function() x
    setinv <- function(invM) iM <<- invM
    getinv <- function() iM
    list(set = set, get = get,
         setinv = setinv,
         getinv = getinv)
}

## cacheSolve computes the inverse of a given matrix returned by 
## makeCacheMatrix above, e.g. `cacheSolve(makeCM)` The first call to cacheSolve
## will solve and set the inverted matrix, as well as returning its value.
## If called again, it will only return the cached matrix.

cacheSolve <- function(x, ...) {
    ## Return a matrix that is the inverse of 'x'
    iM <- x$getinv()
    if(!is.null(iM)) {
        message("Getting cached inverted matrix…")
        return(iM)
    }
    data <- x$get()
    iM <- solve(data, ...)
    x$setinv(iM)
    iM
}
