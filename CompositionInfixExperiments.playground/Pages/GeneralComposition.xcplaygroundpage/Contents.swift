//: [Previous](@previous)

import Foundation


// MARK: - operators

infix operator |>: ForwardApplication

precedencegroup ForwardApplication {
    associativity: left
    higherThan: BackwardApplication
}


func |><T,U>(lhs: T, rhs: (T) -> U) -> U { return rhs(lhs) }

func |><T>(lhs: T, rhs: (T) -> ()) { rhs(lhs) }



infix operator <|: BackwardApplication

precedencegroup BackwardApplication {
    associativity: right
}


func <|<T,U>(lhs: (T) -> U, rhs: T) -> U { return lhs(rhs) }

func <|<T>(lhs: (T) -> (), rhs: T) { lhs(rhs) }



infix operator >>: ForwardPartialApplication

precedencegroup ForwardPartialApplication {
    associativity: left
    higherThan: ForwardApplication, BackwardApplication, BackwardPartialApplication
}


func >><T,U,V>(left: [T], right: @escaping ([T], (T) -> U) -> [V]) -> (((T) -> U) -> [V]) {
    return { right(left, $0) }
}

func >><T,U,V>(left: [T], right: @escaping ([T], (T) -> U?) -> [V]) -> (((T) -> U?) -> [V]) {
    return { right(left, $0) }
}

func >><T,U,V>(left: @escaping (T) -> U?, right: @escaping ([T], (T) -> U?) -> [V]) -> (([T]) -> [V]) {
    return { right($0, left) }
}

func >><T,U,V>(left: @escaping (T) -> U, right: @escaping ([T], (T) -> U) -> [V]) -> (([T]) -> [V]) {
    return { right($0, left) }
}



infix operator <<: BackwardPartialApplication

precedencegroup BackwardPartialApplication {
    associativity: right
    higherThan: ForwardApplication, BackwardApplication
}


func <<<T,U,V>(left: @escaping ([T], (T) -> U?) -> [V], right: @escaping (T) -> U?) -> (([T]) -> [V]) {
    return { left($0, right) }
}

func <<<T,U,V>(left: @escaping ([T], (T) -> U) -> [V], right: @escaping (T) -> U) -> (([T]) -> [V]) {
    return { left($0, right) }
}


func <<<T,U,V>(left: @escaping ([T], (T) -> U) -> [V], right: [T]) -> (((T) -> U) -> [V]) {
    return { left(right, $0) }
}

func <<<T,U,V>(left: @escaping ([T], (T) -> U?) -> [V], right: [T]) -> (((T) -> U?) -> [V]) {
    return { left(right, $0) }
}


infix operator *>: ForwardComposition

precedencegroup ForwardComposition {
    associativity: left
    higherThan: ForwardPartialApplication, BackwardPartialApplication, ForwardApplication, BackwardApplication, BackwardComposition
}


func *><X,Y,Z>(lhs: @escaping (X) -> Y, rhs: @escaping (Y) -> Z) -> ((X) -> Z) { return { rhs(lhs($0)) } }

func *><X,Y>(lhs: @escaping (X) -> Y, rhs: @escaping (Y) -> ()) -> ((X) -> ()) { return { rhs(lhs($0)) } }



infix operator <*: BackwardComposition

precedencegroup BackwardComposition {
    associativity: right
    higherThan: ForwardPartialApplication, BackwardPartialApplication, ForwardApplication, BackwardApplication
}


func <*<X,Y,Z>(lhs: @escaping (Y) -> Z, rhs: @escaping (X) -> Y) -> ((X) -> Z) { return { lhs(rhs($0)) } }

func <*<X,Y>(lhs: @escaping (Y) -> (), rhs: @escaping (X) ->Y) -> ((X) -> ()) { return { lhs(rhs($0)) } }




// MARK: - higher-order functions

func map<T, U>(array: [T], morphism: (T) -> U) -> [U] { return array.map(morphism) }

func flatMap<T,U>(array: [T], morphism: (T) -> U?) -> [U] { return array.flatMap(morphism) }

func filter<T>(array: [T], filter: (T) -> Bool) -> [T] { return array.filter(filter) }



// MARK: - helpers


func print(_ stuff: [String]) { stuff.forEach { print($0) } }

func toString<T>(element: T) -> String { return String(describing: element) }



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

[1,2,3]|>map<<{ $0 + 2 }

// This is a two step process
//
// The first step is Backward Partial Application of the function to the map:

let mapTwo = map<<{ $0 + 2 }

// The result of this is a function that takes an array of Ints and maps over them with the function { $0 + 2 }.
// Then Forward Application applies the array of Ints to the mapTwo function

[1,2,3]|>mapTwo

// we could have also used Forward Partial Application like this to achieve the same result:

[1,2,3]|>{ $0 + 2 }>>map

// you'll see from these examples that Partial Application has a higher precidence than Application.
//
// The  equivalent of all this code is:

[1,2,3].map { $0 + 2 }






var thisOne: ((Int) -> String) -> [String] = [1,2,3]>>map

var mapToString: ([Int]) -> [String] = map<<toString

thisOne<|toString


[1,2,3]|>mapToString

[1,2,3,4]>>map<|toString



let mapPlusFive = map<<{ $0+5 }

[1,2,3]|>mapPlusFive


let plusFive = { $0+5 }

[1,2,3]|>map<<plusFive


let mappedPlusFiveNew = map<<plusFive

[1,2,3]|>mappedPlusFiveNew


(map<<plusFive)([1,2,3])

(map<<{ $0 + 5 })([1,2,3])

[2,3,4].map { $0 + 5 }

mapPlusFive([1,2,3])


let value = [1,2,3]>>map<|{ $0+5 }

value



func noTwo(int: Int) -> Bool { return int != 2 }

let filterOutTwos = (map<<{ $0 + 5 })<*(filter<<noTwo)

[1,-3,2,3]|>filterOutTwos


let filterWithArray = [1,2,3]>>filter

filterWithArray<|noTwo


[1,2,3,2,2,2,2,2,5]>>filter<|noTwo



func nilAwayThree(int: Int) -> String? {
    guard int != 3 else { return nil }
    return String(describing: int)
}


let flatMapAwayThree = flatMap<<nilAwayThree

[1,2,3,3,3,5,6,7]|>flatMapAwayThree


let flatMapWithArray: ((Int) -> String?) -> [String] = [1,2,3,3,4,5,6]>>flatMap

flatMapWithArray<|nilAwayThree


[1,2,3,3,4]>>flatMap<|nilAwayThree









plusFive*>{ $0 * 3 }*>toString





print("first example:\n")

[1,2,3]|>map<<plusFive*>{ $0 * 3 }*>toString<*{ $0 + 2 }|>print

// the { $0 + 2 } gets added to the front of the composed function due to Forward Composition having a
// higher execution precidence than Backward Composition
//
// the resulting composed function could be otherwise written as:

let composedOne = { $0 + 2 }*>plusFive*>{ $0 * 3 }*>toString

// then partial application is used to create a function that maps an array of Ints to a transformed array of Strings:

let mapOne = map<<composedOne

// then an array of Ints is applied to that function using Forward Application:

let resultOne = [1,2,3]|>mapOne

// then Forward Application is used to apply the result to a version of print() that takes an array of strings

print("\n\n shown result: \n")

resultOne|>print





print("\n\n other stuff: \n")

[0,0,0]|>map<<toString<*{$0 + 5}|>print

print("\n\n")

(map<<plusFive*>{ $0 * 2 }*>toString)([4,5,6,8,32,18])|>print







//: [Next](@next)
