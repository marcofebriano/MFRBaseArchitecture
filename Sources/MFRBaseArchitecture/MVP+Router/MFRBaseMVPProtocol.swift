//
//  MFRBaseMVP.swift
//  BaseArchitecture
//
//  Created by Marco Febriano Ramadhani on 09/08/23.
//

import Foundation
import UIKit

public protocol MFRViewMVP: MFRBaseArchitectureLayer {
    associatedtype Presenter
    var presenter: Presenter? { get set }
}

public protocol MFRPresenterMVP: MFRBaseArchitectureLayer {
    associatedtype View
    associatedtype Model
    associatedtype Router
    var view: View? { get set }
    var model: Model? { get set }
    var router: Router? { get set }
}

public protocol MFRROuterMVP: MFRBaseArchitectureRouter { }

public protocol MFRModelMVP: MFRBaseArchitectureLayer { }
