
import Foundation

class BasePresenter<ViewType: BaseView, RouterType: BaseRouter<ViewType>>: NSObject {
  unowned var view: ViewType
  var router: RouterType
  
  required init(view: ViewType, router: RouterType) {
    self.view = view
    self.router = router
    super.init()
  }
}
