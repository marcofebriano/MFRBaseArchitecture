## VIPER
because MFRBaseArchitecture has base of protocol that need in VIPER, you should follow how it works:

#### View
for protocol that responsible for View, you should create with implement the **MFRViewVIPER**. because in this protocol has provide **presenter variable** which has generic type using **associatedType**, so whenever you implement in to class you should define the Presenter DataType.

```swift
// MARK: - View

protocol MyViewProtocol: MFRViewVIPER {
    
}

class MyView: UIViewController, MyViewProtocol {
    typealias Presenter = MyPresenterProtocol
    var presenter: (any Presenter)?
    
}
```

#### PRESENT
for protocol that responsible for Presenter, you should create with implement the **MFRPresenterVIPER**. because in this protocol has provide several properties which has generic type using **associatedType**.
- `View`: for update the view. this is associtedType so you can define with your view protocol that implement `MFRViewVIPER`. Don't forget to make it `weak`.
- `Interactor`: for the logic business. this is associtedType so you can define with your interactor protocol that implement `MFRInteractorInputVIPER`.
- `Router`: for navigation to another view. this is associtedType so you can define with your router protocol that implement `MFRRouterVIPER`.
- `Entity`: this entity is responsible for model of view. this is associtedType so you can define with your entity protocol that implement `MFREntityVIPER`.

```swift
// MARK: - Presenter

protocol MyPresenterProtocol: MFRPresenterVIPER {

}

class MyPresenter: MyPresenterProtocol {
    
    typealias View = MyViewProtocol
    
    typealias Interactor = MyInteractorProtocol
    
    typealias Router = MyRouterProtocol
    
    typealias Entity = MyEntity
    
    /// dont forget to make view variable weak!
    weak var view: (any View)?
    
    var interactor: (any Interactor)?
    
    var router: (any Router)?
    
    var entity: (any MissionEntity)?
    
    required init() { }
}
```

#### INTERACTOR INPUT
for protocol that responsible for Interactor Input, you should create with implement the **MFRInteractorInputVIPER**.
- `interactorOutput`: this output is responsible for notify/send data from interactor to presenter. this is associtedType so you can define with your interactor output protocol that implement `MFRInteractorOutputVIPER`. Don't forget to make it `weak`.

```swift
// MARK: - Interactor Contract

protocol MyInteractorProtocol: MFRInteractorInputVIPER {

}

class MyInteractor: MyInteractorProtocol {

    typealias InteractorOutput = MyInteractorOutputProtocol
    
    /// dont forget to make view variable weak!
    weak var interactorOutput: (any InteractorOutput)?
    
    required init() { }
}
```

#### INTERACTOR OUTPUT
for protocol that responsible for Interactor Output, you should create with implement the **MFRInteractorOutputVIPER**. and implement it in `Presenter` class.

```swift
// MARK: - Interactor Output Contract

protocol MyInteractorOutputProtocol: MFRInteractorOutputVIPER {

}

extension MyPresenter: MyInteractorOutputProtocol {

}
```

#### ENTITY
this entity is responsible for model of view. whenever you create class for Entity, you should emplement `MFREntityVIPER`.

```swift

class MyEntity: MFREntityVIPER {
    var title: String?
}
```

#### ROUTER

for protocol that responsible for Router, you should create with implement the **MFRIRouterVIPER**.

```swift
// MARK: - Router Contract

protocol MyModuleRouterProtocol: MFRRouterVIPER {
    func pushToAnotherView()
    func presentAnotherView()
}

class MyRouter: MyModuleRouterProtocol {
    
    /// dont forget to make view variable weak!
    weak viewController: UIViewController?
    
    required init() { }
    
    func pushToAnotherView() {
        
    }
    
    func presentAnotherView() {
    
    }
}
```

because **MFRIRouterVIPER** extend **MFRBaseArchitectureRouter**, so the MFRBaseArchitectureRouter has provide method to push and present another view

---
push:

**push(withView:embedIn:animated:)**

This method pushes the next module onto the navigation stack. It only works if the current module is embeded in a navigation controller or is part of a navigation stack.

- `withView`: View of the module to navigate to.
- `embedIn`: .navigationController or .none. The default value is .none
- `animated`: Whether or not to perform the animation of the transition. The default value is true
 ```swift
     func pushToAnotherView() {
        let view = UIViewController()
        push(withView: view, embedIn: .none, animated: true)
    }
 
 ```
 
---
present:

**present(withView:embedIn:animated:completion:)**

This method presents the next module modally. Check parameters details below:

- `withView`: View of the module to navigate to.
- `embedIn`: .navigationController or .none. The default value is .none
- `animated`: Whether or not to perform the animation of the transition. The default value is true
- `completion`: Handler called when transition finishes. The default value is nil

 ```swift
     func presentAnotherView() {
        let view = UIViewController()
        present(withView: view, embedIn: .none, animated: true, completion: nil)
    }
 
 ```
 
---

#### BUILDER
In the builder class, you specify the respective classes for `View`, `Presenter`, `Interactor`, `router` and `entity` layers for the module.

```swift
final class MyBuilder: MFRVIPERBuilder<MyView, MyPresenter, MyInteractor, MyRouter, MyEntity> {
    
    override class var defaultViewUIType: MFRViewUIType {
        return .storyboard(name: "MyModuleView", bundle: nil)
    }
}

// MARK: - Builder custom methods

extension MyBuilder {

}
```

You also define the way the **view UI will be loaded**, through the `defaultViewUIType` property. There are 3 possible values:

- **Storyboard file**: You just need to inform the name of the storyboard file, without extension, and the bundle, if needed.
```swift
.storyboard(name: "MyModuleView", bundle: nil)
```

- **XIB file**: You just need to inform the name of the XIB file, without extension, and the bundle, if needed.
```swift
.nib(name: "MyModuleView", bundle: nil)
```

- **None**: If you intent to implement the UI programmatically, use this option.
```swift
.none
```

#### Building a module

The 4 methods below can be used to build a module. Additionally **you can create custom build methods**, according to the module needs.

**- build() -> (UIViewController, Presenter)**: 

Creates the module and returns a `MFRVIPERBuilder` struct containing the `view` and `presenter` references. You can use presenter reference for **passing data between the modules**.

```swift

extension MyRouter: MyModuleRouterProtocol {
    
    func pushToAnotherView() {
        let builder = NextModuleBuilder.build()
        let view = builder.0
        push(withView: view)
    }
}
```

---

**- build(viewUIType:) -> (UIViewController, Presenter)**: 

This method works like the method above but it allows you to specify the UI type during method call. This method is convenient when you are using `typealias` to define the configuration of the module builder. 

```swift
    func pushToAnotherView() {
        let builder = NextModuleBuilder.build(viewUIType: .storyboard(name: "MyModuleView", bundle: nil))
        let view = builder.0
        push(withView: view)
    }
```

---

because method build will return `UIViewController` and `Presenter`. if you want set variable in presenter, you can follow this code

```swift
    func pushToAnotherView() {
        let builder = NextModuleBuilder.build()
        let view = builder.0
        let presenter = builder.1
        presenter.title = "some title"
        push(withView: view)
    }

```

or if presenter should set variable more than one, you can set the entity from the builder.

```swift
    func pushToAnotherView() {
        let builder = NextModuleBuilder.buildWith { entity in
            entity.title = "mission"
            entity.count = 2
            ...
        }
        let view = builder.0
        push(withView: view)
    }

```
