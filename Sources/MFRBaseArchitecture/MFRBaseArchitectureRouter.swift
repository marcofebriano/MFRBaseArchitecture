//
//  MFRBaseArchitectureBuilder.swift
//  BaseArchitecture
//
//  Created by Marco Febriano Ramadhani on 13/08/23.
//

import Foundation
import UIKit

public protocol MFRBaseArchitectureRouter: MFRBaseArchitectureLayer {
    /// this variable should be WEAK
    var viewController: UIViewController? { get set }
}
public extension MFRBaseArchitectureRouter {
    
    /**
     
     - Parameter destination: View controller of the destination module.
     - Parameter embedIn: Embed the view controller before navigation.
     - Parameter animated: Perform animation. **Default: true**
     - Parameter completion: Handler to execute after presentation. **Default: nil**
     */
    func present(withView destination: UIViewController, embedIn: MFREmbedModuleType = .none, animated: Bool = true, completion: (() -> Void)? = nil) {
        let viewControllerToPresent = getViewControllerToShow(destination, embedIn: embedIn)
        
        if let navigationController = viewController?.navigationController {
            navigationController.present(viewControllerToPresent, animated: animated, completion: completion)
            return
        }
        
        viewController?.present(viewControllerToPresent, animated: animated, completion: completion)
    }
    
    /**
     Pushes a VIPER module onto the receiver’s stack and updates the display.

     - Parameter destination: View controller of the destination module.
     - Parameter embedIn: Embed the view controller before navigation.
     - Parameter animated: Perform animation. **Default: true**
     */
    func push(withView destination: UIViewController, embedIn: MFREmbedModuleType = .none, animated: Bool = true) {
        let viewControllerToPush = getViewControllerToShow(destination, embedIn: embedIn)
        
        if let navigationController = viewController as? UINavigationController {
            navigationController.pushViewController(viewControllerToPush, animated: animated)
            return
        }
        
        viewController?.navigationController?.pushViewController(viewControllerToPush, animated: animated)
    }
}

// MARK: - Private methods

private extension MFRBaseArchitectureRouter {
    
    /**
     Prepares the view controller according to the embed type.
     
     - Parameter viewControllerToShow: View controller to be prepared.
     - Parameter embedIn: Embed type for the view controller.
     - Returns: The prepared view controller.
     */
    func getViewControllerToShow(_ viewControllerToShow: UIViewController, embedIn: MFREmbedModuleType) -> UIViewController {
        switch embedIn {
            case .navigationController:
                return UINavigationController(rootViewController: viewControllerToShow)
                
            case .none:
                return viewControllerToShow
        }
    }
}
