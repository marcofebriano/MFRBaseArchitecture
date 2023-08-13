//
//  BaseProtocol.swift
//  BaseArchitecture
//
//  Created by Marco Febriano Ramadhani on 07/08/23.
//

import Foundation
import UIKit

// MARK: - VIEW
public protocol MFRViewVIPER: MFRBaseArchitectureLayer {
    associatedtype Presenter
    var presenter: Presenter? { get set }
}

// MARK: - PRESENTER
public protocol MFRPresenterVIPER: MFRBaseArchitectureLayer {
    associatedtype View
    associatedtype Interactor
    associatedtype Router
    associatedtype Entity
    
    /// this variable should be WEAK
    var view: View? { get set }
    var interactor: Interactor? { get set }
    var router: Router? { get set }
    var entity: Entity? { get set }
}

// MARK: - INTERACTOR OUT
public protocol MFRInteractorOutputVIPER: MFRBaseArchitectureLayer {}

// MARK: - INTERACTOR IN
public protocol MFRInteractorInputVIPER: MFRBaseArchitectureLayer {
    associatedtype InteractorOutput
    /// this variable should be WEAK
    var interactorOutput: InteractorOutput? { get set }
}

// MARK: - ROUTER
public protocol MFRRouterVIPER: MFRBaseArchitectureRouter {
    
}

public protocol MFREntityVIPER: MFRBaseArchitectureLayer { }
