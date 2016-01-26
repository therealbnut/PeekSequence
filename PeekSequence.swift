//
//  PeekSequence.swift
//  PeekSequence
//
//  Created by Andrew Bennett on 26/01/2016.
//  Copyright © 2016 Andrew Bennett. All rights reserved.
//

public struct PeekSequence<T>: SequenceType {
    public typealias Generator = AnyGenerator<T>

    private var _sequence: AnySequence<T>
    private var _peek: T?

    public init<S: SequenceType where S.Generator.Element == T>(
        _ sequence: S
    ) {
        _sequence = AnySequence(sequence)
        _peek = nil
    }

    public func generate() -> AnyGenerator<T> {
        var peek = _peek, generator = _sequence.generate()
        return anyGenerator {
            let element = peek ?? generator.next()
            peek = nil
            return element
        }
    }

    public func underestimateCount() -> Int {
        return _peek == nil ? 0 : 1
    }
    public mutating func peek() -> T? {
        if let element = _peek { return element }
        _peek = _sequence.generate().next()
        return _peek
    }
}

public func nonEmptySequence<S: SequenceType>(sequence: S) -> AnySequence<S.Generator.Element>? {
    var sequence = PeekSequence(sequence)
    if sequence.peek() != nil {
        return AnySequence(sequence)
    }
    else {
        return nil
    }
}
