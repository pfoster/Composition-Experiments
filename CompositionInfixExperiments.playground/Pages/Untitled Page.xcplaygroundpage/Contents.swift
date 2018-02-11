//: Playground - noun: a place where people can play

import UIKit
import Foundation



func identity<T>(_ t: T) -> T { return t }

infix operator >: ForwardComposition

precedencegroup ForwardComposition {
    associativity: right
    higherThan: ForwardApplication
}

precedencegroup ForwardApplication {
    associativity: right
}

func ><T,U> (application: (T) -> U, value: T ) -> U {
    return application(value)
}

func ><T,U,V>(left: ((T) -> U)->V, right: @escaping (T) -> U) -> V {
    return left(right)
}

func ><T,U>(left: ((T) -> U)->(), right: @escaping (T) -> U) -> () {
    left(right)
}

func ><U>(left: (() -> U)->(), right: @escaping () -> U) -> () {
    left(right)
}

func ><U>(left: (U)->(), right: U) -> () {
    left(right)
}



let string: String = "foo"


func change(string: String) -> String { return string+"bar" }

change>string



