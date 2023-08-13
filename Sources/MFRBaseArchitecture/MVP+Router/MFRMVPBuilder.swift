//
//  MFRMVPBuilder.swift
//  BaseArchitecture
//
//  Created by Marco Febriano Ramadhani on 09/08/23.
//

import Foundation
import UIKit

open class MVPBuilder<ViewType: UIViewController & MFRViewMVP, Presenter: MFRPresenterMVP, Router: MFRROuterMVP, Model: MFRModelMVP> {
    
    open class var defaultViewUIType: MFRViewUIType {
        return .none
    }
    
    class func build(viewUIType: MFRViewUIType? = nil) -> (UIViewController, Presenter) {
        var view: ViewType
        let presenter = Presenter()
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
        presenter.router = router as? Presenter.Router
        return (view, presenter)
    }
    
    class func buildWith(viewUIType: MFRViewUIType? = nil, entity: (inout Model) -> Void) -> (UIViewController, Presenter) {
        let build = MVPBuilder.build(viewUIType: viewUIType)
        var data = Model()
        entity(&data)
        build.1.model = data as? Presenter.Model
        return build
    }
}
