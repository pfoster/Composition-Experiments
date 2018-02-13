//: [Previous](@previous)

import Foundation

// MARK: - Application  ( |> , <| )


// I'll show the use of Forward Application by applying an Int to the toString<T>(T) function

3 |> toString

// now Backward Application

toString <| 3

// what is happening is that the toString function takes a single generic argument, in this case we are feeding it the Int: 3
//
// The following line of code is the equivalent of the previous applications:

toString(element: 3)






// MARK: - Partial Application  ( >> , << )


// You'll find that you run into problems with application as soon as you have a function that takes more than one argument.
//
// luckily, there's a solution for that... at least if by "more than one," what you mean is 2.
// The solution is Partial Application
//
// Maybe the most useful examples here would be the higher-order functions, map, flatMap, and filter.
// All three of these functions take in a Collection and a function to apply when iterating through that Collection
// as their 2 arguments.

// let's look at an example of a map

[1,2,3] |> map <<| { $0 + 2 }

// This is a two step process
//
// The first step, since Partial Application has a higher precidence than Application, is
// Backward Partial Application of the function to the map:

let mapTwo = map <<| { $0 + 2 }

// The result of this is a function that takes an array of Ints and maps over them with the function { $0 + 2 }.
// Then Forward Application applies the array of Ints to the mapTwo function

[1,2,3] |> mapTwo

// we could have also used Forward Partial Application like this to achieve the same result:

[1,2,3] |> { $0 + 2 } |>> map


// The  equivalent of all this code is:

[1,2,3].map { $0 + 2 }



// When starting a line with Forward Partial Application of a closure such as the following, it must be wrapped in
// parenthesis to associate it with the map function it is being applied to.
//
// If you try removing the parenthesis from the following line, you'll see that the compiler attempts to apply it to
// the earlier map function on line 186.

( { $0 + 2 } |>> map ) <| [1,2,3]


// MARK: - Composition  ( *> , <* )


let resultt = [1,2,3] |> filter <<| { $0 + 2 } *> { $0 > 3 }
resultt


func notTwo(_ string: String) -> String? {
    if (string != "2") {
        return string
    } else {
        return nil
    }
}

print <| [1,2,3,4,5] |> flatMap <<| toString *> notTwo




let plusFive = { $0 + 5 }



print("first example:\n")

print <| [1,2,3] |> map <<| plusFive *> toString <* { $0 + 2 }


// the { $0 + 2 } gets added to the front of the composed function due to Forward Composition having a
// higher execution precidence than Backward Composition
//
// the resulting composed function could be otherwise written as:

let composedOne = { $0 + 2 } *> plusFive *> toString

// then partial application is used to create a function that maps an array of Ints to a transformed array of Strings:

let mapOne = map <<| composedOne

// then an array of Ints is applied to that function using Forward Application:

let resultOne = [1,2,3] |> mapOne

// then Forward Application is used to apply the result to a version of print() that takes an array of strings

print("\n\n shown result: \n")

resultOne |> print





//: [Next](@next)
