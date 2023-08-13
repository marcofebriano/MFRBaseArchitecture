//
//  MFRViewUIType.swift
//  BaseArchitecture
//
//  Created by Marco Febriano Ramadhani on 13/08/23.
//

import Foundation

public enum MFRViewUIType {
    
    /**
     - **name** : The name of the storyboard file
     - **bundle**: Bundle containing the storyboard file
     */
    case storyboard(name: String, bundle: Bundle?)
    
    /**
     - **name** : The name of the xib file
     - **bundle**: Bundle containing the xib file
     */
    case nib(name: String, bundle: Bundle?)
    
    /**
     No file for View UI.
     */
    case none
}
