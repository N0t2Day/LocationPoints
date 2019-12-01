
import Foundation

class BaseRouter<ViewType: BaseView> {
  unowned var view: ViewType
  
  required init(view: ViewType) {
    self.view = view
  }
  
}

