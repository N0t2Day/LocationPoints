
import Foundation

class BaseConfigurator<ViewType: BaseView, RouterType: BaseRouter<ViewType>,
                                        PresenterType: BasePresenter<ViewType, RouterType>> {
  
  @discardableResult
  func configure(_ view: ViewType) -> PresenterType {
    let router = RouterType(view: view)
    let presenter = PresenterType(view: view, router: router)
    
    view.presenter = presenter as? ViewType.PresenterType
    
    return presenter
  }
}


