//
//  MFRBaseMVVMProtocol.swift
//  BaseArchitecture
//
//  Created by Marco Febriano Ramadhani on 12/08/23.
//

import Foundation

public protocol MFRViewMVVMObserver: MFRBaseArchitectureLayer {
    associatedtype ViewModelRequest
    associatedtype ViewModelOutput
    var viewModel: ViewModelRequest? { get set }
    func observe(_ observable: ViewModelOutput)
}

public protocol MFRViewModelMVVMObserver: MFRBaseArchitectureLayer {
    associatedtype Request
    associatedtype Output
    associatedtype Model
    associatedtype Router
    
    var request: Request { get }
    var output: Output { get }
    var model: Model? { get set }
    var router: Router? { get set }
}

public extension MFRViewModelMVVMObserver {
    var request: Request {
        guard let ask: Request = self as? Request else {
            fatalError("Please implement input getter manually or implement Input type to your Porting object\n reason: Input type is not implemented in Porting")
        }
        return ask
    }
    
    var output: Output {
        guard let portOutput: Output = self as? Output else {
            fatalError("Please implement output getter manually or implement Ouput type to your Porting object\n reason: Ouput type is not implemented in Porting")
        }
        return portOutput
    }
}

public protocol MFRModelMVVVM: MFRBaseArchitectureLayer { }

public protocol MFRRouterMVVM: MFRBaseArchitectureRouter { }
