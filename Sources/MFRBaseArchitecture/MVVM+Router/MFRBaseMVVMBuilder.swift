//
//  MFRBaseMVVMBuilder.swift
//  BaseArchitecture
//
//  Created by Marco Febriano Ramadhani on 13/08/23.
//

import Foundation
import UIKit

open class MVVMObserverBuilder<ViewType: UIViewController & MFRViewMVVMObserver, ViewModel: MFRViewModelMVVMObserver, Router: MFRBaseArchitectureRouter, Model: MFRModelMVVVM> {
    
    open class var defaultViewUIType: MFRViewUIType {
        return .none
    }
    
    class func build(viewUIType: MFRViewUIType? = nil) -> (UIViewController, ViewModel) {
        var view: ViewType
        let viewModel = ViewModel()
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
        
        view.viewModel = viewModel.request as? ViewType.ViewModelRequest
        guard let observer = viewModel.output as? ViewType.ViewModelOutput else {
            fatalError("")
        }
        view.observe(observer)
        viewModel.router = router as? ViewModel.Router
        return (view, viewModel)
    }
    
    class func buildWith(viewUIType: MFRViewUIType? = nil, entity: (inout Model) -> Void) -> (UIViewController, ViewModel) {
        let build = MVVMObserverBuilder.build(viewUIType: viewUIType)
        var data = Model()
        entity(&data)
        build.1.model = data as? ViewModel.Model
        return build
    }
}
