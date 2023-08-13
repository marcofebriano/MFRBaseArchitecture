//
//  ImplementationVIPER.swift
//  BaseArchitecture
//
//  Created by Marco Febriano Ramadhani on 09/08/23.
//

import Foundation
import UIKit

// MARK: -

protocol MissionView: MFRViewVIPER {
    func show(message: String)
}
protocol MissionPresenterProtocol: MFRPresenterVIPER {
    func shouldProcessData()
}
protocol MissionInteractorIn: MFRInteractorInputVIPER {
    func processData()
}
protocol MissionInteractorOut: MFRInteractorOutputVIPER {
    func success()
}
protocol MissionRouterProtocol: MFRRouterVIPER { }

class MissionVC: UIViewController, MissionView {
    
    var presenter: (any Presenter)?
    
    typealias Presenter = MissionPresenterProtocol
    
    func show(message: String) {
        print("view")
        print(message)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view -> Presenter")
        view.backgroundColor = .white
        presenter?.shouldProcessData()
    }
}

class MissionPresenter: MissionPresenterProtocol, MissionInteractorOut {
    
    typealias Entity = MissionEntity
    
    typealias View = MissionView
    
    typealias Interactor = MissionInteractorIn
    
    typealias Router = MissionRouterProtocol
    
    weak var view: (any View)?
    
    var interactor: (any Interactor)?
    
    var router: Router?
    
    var entity: MissionEntity?
    
    required init() { }
    
    func shouldProcessData() {
        print("Presenter -> Interactor")
        interactor?.processData()
    }
    
    func success() {
        print("Presenter -> View")
        view?.show(message: "success nih")
    }
}

class MissionInteractor: MissionInteractorIn {
    weak var interactorOutput: InteractorOutput?
    typealias InteractorOutput = MissionInteractorOut
    
    required init() {
        
    }
    
    func processData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: { [weak self] in
            print("Interactor -> Presenter")
            self?.interactorOutput?.success()
        })
    }
    
}

class MissionRouter: MissionRouterProtocol {
    weak var viewController: UIViewController?
    
    required init() {
        
    }
    
}

class MissionEntity: MFREntityVIPER {
    
    required init() { }
    
    var title: String?
}

class MissionBuilder: MFRVIPERBuilder<MissionVC, MissionPresenter, MissionInteractor, MissionRouter, MissionEntity> {
    
}
