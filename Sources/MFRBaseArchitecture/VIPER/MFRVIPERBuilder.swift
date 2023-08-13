//
//  MFRVIPERBuilder.swift
//  BaseArchitecture
//
//  Created by Marco Febriano Ramadhani on 09/08/23.
//

import Foundation
import UIKit

open class MFRVIPERBuilder<ViewType: UIViewController & MFRViewVIPER, Presenter: MFRPresenterVIPER & MFRInteractorOutputVIPER, Interactor: MFRInteractorInputVIPER, Router: MFRRouterVIPER, Entity: MFREntityVIPER> {
    
    open class var defaultViewUIType: MFRViewUIType {
        return .none
    }
    
    class func build(viewUIType: MFRViewUIType? = nil) -> (UIViewController, Presenter) {
        var view: ViewType
        let presenter = Presenter()
        let interactor = Interactor()
        let router = Router()
        
        let type = viewUIType ?? defaultViewUIType
        switch type {
        case .storyboard(let name, let bundle):
            view = UIStoryboard(name: name, bundle: bundle).instantiateInitialViewController() as! ViewType
        case .nib(let name, let bundle):
            view = ViewType()
            UINib(nibName: name, bundle: bundle).instantiate(withOwner: view, options: nil)
        case .none:
            view = ViewType()
        }
        
        view.presenter = presenter as? ViewType.Presenter
        presenter.view = view as? Presenter.View
        presenter.interactor = interactor as? Presenter.Interactor
        presenter.router = router as? Presenter.Router
        interactor.interactorOutput = presenter as? Interactor.InteractorOutput
        router.viewController = view
        return (view, presenter)
    }
    
    class func buildWith(viewUIType: MFRViewUIType? = nil, entity: (inout Entity) -> Void) -> (UIViewController, Presenter) {
        let build = MFRVIPERBuilder.build(viewUIType: viewUIType)
        var data = Entity()
        entity(&data)
        build.1.entity = data as? Presenter.Entity
        return build
    }
}
