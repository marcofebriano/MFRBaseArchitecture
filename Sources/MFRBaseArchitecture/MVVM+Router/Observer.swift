//
//  Observer.swift
//  BaseArchitecture
//
//  Created by Marco Febriano Ramadhani on 09/08/23.
//

import Foundation

public class MFRObservable<T> {
    
    typealias Listener = (T) -> Void
    
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}

@propertyWrapper
public class MakeObservable<T> {
    lazy var subject: MFRObservable<T> = .init(value)
    private var value: T {
        didSet {
            subject.listener?(value)
        }
    }
    
    public var wrappedValue: T {
        get { value }
        set {
            value = newValue
        }
    }
    
    public init(wrappedValue: T) {
        self.value = wrappedValue
    }
    
    public var projectedValue: MFRObservable<T> {
        return subject
    }
}


struct abcjdd {
    @MakeObservable var count: Int
    var observable: MFRObservable<Int> { $count }
    
    func asdasd() {
        
    }
}
