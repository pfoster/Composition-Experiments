//: [Previous](@previous)

import Foundation




infix operator >>: GeneralComposition

precedencegroup GeneralComposition {
    associativity: left
}


// partial application

func >><T,U,V>(left: [T], right: @escaping ([T], (T) -> U) -> [V]) -> (((T) -> U) -> [V]) {
    return { right(left, $0) }
}

func >><T,U,V>(left: @escaping ([T], (T) -> U) -> [V], right: @escaping (T) -> U) -> (([T]) -> [V]) {
    return { left($0, right) }
}


func >><T,U,V>(left: [T], right: @escaping ([T], (T) -> U?) -> [V]) -> (((T) -> U?) -> [V]) {
    return { right(left, $0) }
}

func >><T,U,V>(left: @escaping ([T], (T) -> U?) -> [V], right: @escaping (T) -> U?) -> (([T]) -> [V]) {
    return { left($0, right) }
}


// finish application

func >><T,U>(left: [T], right: @escaping ([T]) -> [U]) -> [U] {
    return right(left)
}

func >><T,U,V>(left: @escaping ((T) -> U) -> [V], right: (T) -> U) -> [V] {
    return left(right)
}



// MARK: - mapped

func map<T, U>(array: [T], morphism: (T) -> U) -> [U] { return array.map(morphism) }



func toString<T>(element: T) -> String {
    return String(describing: element)
}


var thisOne: ((Int) -> String) -> [String] = [1,2,3]>>map

var mapToString: ([Int]) -> [String] = map>>toString

thisOne>>toString


[1,2,3]>>mapToString

[1,2,3,4]>>map>>toString



let mapPlusFive = map>>{ $0+5 }

[1,2,3]>>mapPlusFive


let plusFive = { $0+5 }

[1,2,3]>>map>>plusFive

let mappedPlusFiveNew = map>>plusFive


[1,2,3]>>mappedPlusFiveNew


let value = [1,2,3]>>map>>{ $0+5 }

value



// MARK: - filtered

func filtered<T>(array: [T], filter: (T) -> Bool) -> [T] { return array.filter(filter) }



func noTwo(int: Int) -> Bool { return int != 2 }

let filterOutTwos = filtered>>noTwo

[1,2,2,3]>>filterOutTwos


let filterWithArray = [1,2,3]>>filtered

filterWithArray>>noTwo


[1,2,3,2,2,2,2,2,5]>>filtered>>noTwo




// MARK: - flatMapped

func flatMapped<T,U>(array: [T], morphism: (T) -> U?) -> [U] { return array.flatMap(morphism) }


func nilAwayThree(int: Int) -> String? {
    guard int != 3 else { return nil }
    return String(describing: int)
}


let flatMapAwayThree = flatMapped>>nilAwayThree

[1,2,3,3,3,5,6,7]>>flatMapAwayThree


let flatMapWithArray: ((Int) -> String?) -> [String] = [1,2,3,3,4,5,6]>>flatMapped

flatMapWithArray>>nilAwayThree


[1,2,3,3,4]>>flatMapped>>nilAwayThree



// MARK: - if


/*
 <T,U,V,W>(condition: Bool, truePath: ([T]) -> [U], falsePath: ([T]) -> [V]) -> Path: ([T]) -> [W]
 */

//: [Next](@next)
