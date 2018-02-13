import Foundation




// MARK: - operators

infix operator |>: ForwardApplication

precedencegroup ForwardApplication {
    associativity: left
    higherThan: BackwardApplication
}


public func |><T,U>(lhs: T, rhs: (T) -> U) -> U { return rhs(lhs) }

public func |><T,U>(lhs: T, rhs: (T) -> U?) -> U? { return rhs(lhs) }


public func |><T,U>(lhs: T?, rhs: (T?) -> U) -> U { return rhs(lhs) }

public func |><T,U>(lhs: T?, rhs: (T?) -> U?) -> U? { return rhs(lhs) }



public func |><T>(lhs: T, rhs: (T) -> ()) { rhs(lhs) }

public func |><T>(lhs: T?, rhs: (T?) -> ()) { rhs(lhs) }




infix operator <|: BackwardApplication

precedencegroup BackwardApplication {
    associativity: right
}


public func <|<T,U>(lhs: (T) -> U, rhs: T) -> U { return lhs(rhs) }

public func <|<T,U>(lhs: (T) -> U?, rhs: T) -> U? { return lhs(rhs) }


public func <|<T,U>(lhs: (T?) -> U, rhs: T?) -> U { return lhs(rhs) }

public func <|<T,U>(lhs: (T?) -> U?, rhs: T?) -> U? { return lhs(rhs) }



public func <|<T>(lhs: (T) -> (), rhs: T) { lhs(rhs) }

public func <|<T>(lhs: (T?) -> (), rhs: T?) { lhs(rhs) }




infix operator |>>: ForwardPartialApplication

precedencegroup ForwardPartialApplication {
    associativity: left
    higherThan: ForwardApplication, BackwardApplication, BackwardPartialApplication
}


public func |>><T,U,V>(left: [T], right: @escaping ([T], (T) -> U) -> [V]) -> (((T) -> U) -> [V]) {
    return { right(left, $0) }
}

public func |>><T,U,V>(left: [T], right: @escaping ([T], (T) -> U?) -> [V]) -> (((T) -> U?) -> [V]) {
    return { right(left, $0) }
}

public func |>><T,U,V>(left: [T], right: @escaping ([T], (T) -> U?) -> [V?]) -> (((T) -> U?) -> [V?]) {
    return { right(left, $0) }
}

public func |>><T,U,V>(left: [T], right: @escaping ([T], (T) -> U) -> [V?]) -> (((T) -> U) -> [V?]) {
    return { right(left, $0) }
}


public func |>><T,U,V>(left: [T?], right: @escaping ([T?], (T?) -> U) -> [V]) -> (((T?) -> U) -> [V]) {
    return { right(left, $0) }
}

public func |>><T,U,V>(left: [T?], right: @escaping ([T?], (T?) -> U?) -> [V]) -> (((T?) -> U?) -> [V]) {
    return { right(left, $0) }
}

public func |>><T,U,V>(left: [T?], right: @escaping ([T?], (T?) -> U?) -> [V?]) -> (((T?) -> U?) -> [V?]) {
    return { right(left, $0) }
}

public func |>><T,U,V>(left: [T?], right: @escaping ([T?], (T?) -> U) -> [V?]) -> (((T?) -> U) -> [V?]) {
    return { right(left, $0) }
}



public func |>><T,U,V>(left: @escaping (T) -> U?, right: @escaping ([T], (T) -> U?) -> [V]) -> (([T]) -> [V]) {
    return { right($0, left) }
}

public func |>><T,U,V>(left: @escaping (T) -> U?, right: @escaping ([T], (T) -> U?) -> [V?]) -> (([T]) -> [V?]) {
    return { right($0, left) }
}

public func |>><T,U,V>(left: @escaping (T) -> U, right: @escaping ([T], (T) -> U) -> [V?]) -> (([T]) -> [V?]) {
    return { right($0, left) }
}

public func |>><T,U,V>(left: @escaping (T) -> U, right: @escaping ([T], (T) -> U) -> [V]) -> (([T]) -> [V]) {
    return { right($0, left) }
}


public func |>><T,U,V>(left: @escaping (T?) -> U, right: @escaping ([T?], (T?) -> U) -> [V]) -> (([T?]) -> [V]) {
    return { right($0, left) }
}

public func |>><T,U,V>(left: @escaping (T?) -> U?, right: @escaping ([T?], (T?) -> U?) -> [V]) -> (([T?]) -> [V]) {
    return { right($0, left) }
}

public func |>><T,U,V>(left: @escaping (T?) -> U, right: @escaping ([T?], (T?) -> U) -> [V?]) -> (([T]) -> [V?]) {
    return { right($0, left) }
}

public func |>><T,U,V>(left: @escaping (T?) -> U?, right: @escaping ([T?], (T?) -> U?) -> [V?]) -> (([T?]) -> [V?]) {
    return { right($0, left) }
}




infix operator <<|: BackwardPartialApplication

precedencegroup BackwardPartialApplication {
    associativity: right
    higherThan: ForwardApplication, BackwardApplication
}


public func <<|<T,U,V>(left: @escaping ([T], (T) -> U?) -> [V], right: @escaping (T) -> U?) -> (([T]) -> [V]) {
    return { left($0, right) }
}

public func <<|<T,U,V>(left: @escaping ([T], (T) -> U?) -> [V?], right: @escaping (T) -> U?) -> (([T]) -> [V?]) {
    return { left($0, right) }
}

public func <<|<T,U,V>(left: @escaping ([T], (T) -> U) -> [V?], right: @escaping (T) -> U) -> (([T]) -> [V?]) {
    return { left($0, right) }
}

public func <<|<T,U,V>(left: @escaping ([T], (T) -> U) -> [V], right: @escaping (T) -> U) -> (([T]) -> [V]) {
    return { left($0, right) }
}


public func <<|<T,U,V>(left: @escaping ([T?], (T?) -> U) -> [V], right: @escaping (T?) -> U) -> (([T?]) -> [V]) {
    return { left($0, right) }
}

public func <<|<T,U,V>(left: @escaping ([T?], (T?) -> U?) -> [V], right: @escaping (T?) -> U?) -> (([T?]) -> [V]) {
    return { left($0, right) }
}

public func <<|<T,U,V>(left: @escaping ([T?], (T?) -> U) -> [V?], right: @escaping (T?) -> U) -> (([T?]) -> [V?]) {
    return { left($0, right) }
}

public func <<|<T,U,V>(left: @escaping ([T?], (T?) -> U?) -> [V?], right: @escaping (T?) -> U?) -> (([T?]) -> [V?]) {
    return { left($0, right) }
}



public func <<|<T,U,V>(left: @escaping ([T], (T) -> U) -> [V], right: [T]) -> (((T) -> U) -> [V]) {
    return { left(right, $0) }
}

public func <<|<T,U,V>(left: @escaping ([T], (T) -> U) -> [V?], right: [T]) -> (((T) -> U) -> [V?]) {
    return { left(right, $0) }
}

public func <<|<T,U,V>(left: @escaping ([T], (T) -> U?) -> [V], right: [T]) -> (((T) -> U?) -> [V]) {
    return { left(right, $0) }
}

public func <<|<T,U,V>(left: @escaping ([T], (T) -> U?) -> [V?], right: [T]) -> (((T) -> U?) -> [V?]) {
    return { left(right, $0) }
}


public func <<|<T,U,V>(left: @escaping ([T?], (T?) -> U) -> [V], right: [T?]) -> (((T?) -> U) -> [V]) {
    return { left(right, $0) }
}

public func <<|<T,U,V>(left: @escaping ([T?], (T?) -> U) -> [V?], right: [T?]) -> (((T?) -> U) -> [V?]) {
    return { left(right, $0) }
}

public func <<|<T,U,V>(left: @escaping ([T?], (T?) -> U?) -> [V], right: [T?]) -> (((T?) -> U?) -> [V]) {
    return { left(right, $0) }
}

public func <<|<T,U,V>(left: @escaping ([T?], (T?) -> U?) -> [V?], right: [T?]) -> (((T?) -> U?) -> [V?]) {
    return { left(right, $0) }
}




infix operator *>: ForwardComposition

precedencegroup ForwardComposition {
    associativity: left
    higherThan: ForwardPartialApplication, BackwardPartialApplication, ForwardApplication, BackwardApplication, BackwardComposition
}


public func *><X,Y,Z>(lhs: @escaping (X) -> Y, rhs: @escaping (Y) -> Z) -> ((X) -> Z) { return { rhs(lhs($0)) } }

public func *><X,Y,Z>(lhs: @escaping (X) -> Y, rhs: @escaping (Y) -> Z?) -> ((X) -> Z?) { return { rhs(lhs($0)) } }

public func *><X,Y,Z>(lhs: @escaping (X) -> Y?, rhs: @escaping (Y?) -> Z) -> ((X) -> Z) { return { rhs(lhs($0)) } }

public func *><X,Y,Z>(lhs: @escaping (X) -> Y?, rhs: @escaping (Y?) -> Z?) -> ((X) -> Z?) { return { rhs(lhs($0)) } }

public func *><X,Y,Z>(lhs: @escaping (X?) -> Y?, rhs: @escaping (Y?) -> Z?) -> ((X?) -> Z?) { return { rhs(lhs($0)) } }

public func *><X,Y,Z>(lhs: @escaping (X?) -> Y, rhs: @escaping (Y) -> Z) -> ((X?) -> Z) { return { rhs(lhs($0)) } }

public func *><X,Y,Z>(lhs: @escaping (X?) -> Y, rhs: @escaping (Y) -> Z?) -> ((X?) -> Z?) { return { rhs(lhs($0)) } }

public func *><X,Y,Z>(lhs: @escaping (X?) -> Y?, rhs: @escaping (Y?) -> Z) -> ((X?) -> Z) { return { rhs(lhs($0)) } }

public func *><X,Y>(lhs: @escaping (X) -> Y, rhs: @escaping (Y) -> ()) -> ((X) -> ()) { return { rhs(lhs($0)) } }

public func *><X,Y>(lhs: @escaping (X) -> Y?, rhs: @escaping (Y?) -> ()) -> ((X) -> ()) { return { rhs(lhs($0)) } }

public func *><X,Y>(lhs: @escaping (X?) -> Y, rhs: @escaping (Y) -> ()) -> ((X?) -> ()) { return { rhs(lhs($0)) } }

public func *><X,Y>(lhs: @escaping (X?) -> Y?, rhs: @escaping (Y?) -> ()) -> ((X?) -> ()) { return { rhs(lhs($0)) } }



infix operator <*: BackwardComposition

precedencegroup BackwardComposition {
    associativity: right
    higherThan: ForwardPartialApplication, BackwardPartialApplication, ForwardApplication, BackwardApplication
}


public func <*<X,Y,Z>(lhs: @escaping (Y) -> Z, rhs: @escaping (X) -> Y) -> ((X) -> Z) { return { lhs(rhs($0)) } }

public func <*<X,Y>(lhs: @escaping (Y) -> (), rhs: @escaping (X) ->Y) -> ((X) -> ()) { return { lhs(rhs($0)) } }




// MARK: - free higher-order functions


// these versions of map, filter, and flatMap are free functions rather than being methods on Array
// this allows them to exist independently from the Array they might be applied with

public func map<T, U>(array: [T], morphism: (T) -> U) -> [U] { return array.map(morphism) }

public func flatMap<T,U>(array: [T], morphism: (T) -> U?) -> [U] { return array.flatMap(morphism) }

public func filter<T>(array: [T], filter: (T) -> Bool) -> [T] { return array.filter(filter) }



// MARK: - helpers


public func print(_ stuff: [String]) { stuff.forEach { print($0) } }

public func toString<T>(element: T) -> String { return String(describing: element) }
