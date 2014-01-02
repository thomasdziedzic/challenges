### How many programmers does it take to screw in a lightbulb?

  

#### Given

1. n programmers 
2. A light bulb socket that takes D clockwise turns to fully screw in a lightbulb into 
3. A list xs of size n containing Integers which represents how many turns each programmer is able to make before the programmer gets tired 

- A positive number represents that programmer can only do clockwise turns 
- A negative number represents that programmer can only do counter-clockwise turns 

  

#### Constraints

1. The socket has a maximum depth D so at any point in the process of screwing in the lightbulb, the depth of the lightbulb cannot exceed D 
2. The socket has a minimum depth of d meaning that counter-clockwise turns at point d will not decrement the current depth of the lightbulb 
3. Programmers are stubborn so they insist that if they can turn the bulb k turns, then they must turn the lightbulb k turns. 
4. The bulb starts at depth s where d &lt;= s &lt;= D 
  

#### Solve

Is there a combination of programmers that is able to fully screw in the lighbulb?

Note: not all of the programmers need to be used.

  

#### Bonus

Print out the order they take turns.

What is the minimum amount of programmers it takes to fully screw in the lighbulb?

What is the maximum amount of programmers it takes to fully screw in the lightbulb?

#### Positive Example

s = 0

d = 0

D = 6

xs = [-1,0,1,2,3,4,5,6]

  

Yes

A possible solution is [0,1,-1,6] but not [-1,0,1,6]

The minimum solution is [6]

The maximum solution is [0,1,-1,2,4]

or [-1, 0, 1, 2, 3]

#### Negative Example

s = 6

d = 0

D = 7

xs = [7,7,5,3,8,9,0]

  
No
