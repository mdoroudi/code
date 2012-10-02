### Dynamic Programming 
Dynamic programming is an algorithm technique which is usually based on: 
* recurrent formula
* one or more starting states

A sub-solution of the problem is constructed from previously found ones, which starts from the starting states.
DP solutions have a polynomial complexity where the brute-force or backtracking solutions usually have exponantial solutions.
DP computes the recurrence efficiently because it stores (memoized) the sub-probelms and use the results instead of recalculating them everytime.

## Examples
* Fibonacci number
* Longest Increasing Sub Sequence
* Min number of coins used to add to a sum
#### Graph DP
* Floyd–Warshall: Single source shortest path for in a graph with positive and negative weighed edges
* Bellman–Ford: Single source shortest path for a graph with positive and negative weighted edges, but no negative cycles.
* Dijkstra Algorithm: Single source shortest path for a grpah with only positive edges.

Resources used here are 
http://community.topcoder.com/tc?module=Static&d1=tutorials&d2=dynProg and http://www.algorist.com/
