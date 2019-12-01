
import UIKit

func instantiateViewController(from storyboard: UIIdentifier.Storyboard, with identifier: UIIdentifier.ViewController) -> UIViewController {
    let _storyboard = UIStoryboard(name: storyboard.rawValue, bundle: Bundle.main)
    return _storyboard.instantiateViewController(withIdentifier: identifier.viewControllerIdentifier)
}

extension UIViewController {

    /// Change last ViewController from navigation stack to another
    ///
    /// - Parameters:
    ///   - storyboard: Storyboard's name
    ///   - identifier: UIViewController's storyboard identifier
    func changeViewControllerWithAnother(from storyboard: UIIdentifier.Storyboard, with identifier: UIIdentifier.ViewController) {
        if var controllers = navigationController?.viewControllers {
            controllers.removeLast()
            controllers.append(instantiateViewController(from: storyboard, with: identifier))
            navigationController?.setViewControllers(controllers, animated: true)
        }
    }
    
    /// Change last ViewController from navigation stack to another
    ///
    /// - Parameter anotherVC: another ViewController
    func changeViewControllerWithAnother(_ anotherVC: UIViewController) {
        if var controllers = navigationController?.viewControllers {
            controllers.removeLast()
            controllers.append(anotherVC)
            navigationController?.setViewControllers(controllers, animated: true)
        }
    }
    
    /// Show ViewController
    ///
    /// - Parameters:
    ///   - storyboard: Storyboard's name
    ///   - identifier: UIViewController's storyboard identifier
    func showViewController(from storyboard: UIIdentifier.Storyboard, with identifier: UIIdentifier.ViewController) {
        navigationController?.show(instantiateViewController(from: storyboard, with: identifier), sender: self)
    }
    
    
    /// Show ViewController
    ///
    /// - Parameter viewController: another ViewController
    func showViewController(_ viewController: UIViewController) {
        navigationController?.show(viewController, sender: self)
    }
    
    
    
    func popToRoot() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func popToLast() {
        navigationController?.popViewController(animated: true)
    }
    
    func presentViewController(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void )? = nil ) {
        present(viewController, animated: animated, completion: completion)
    }

    func newSession(from storyboard: UIIdentifier.Storyboard) {
        let _storyboard = UIStoryboard(name: storyboard.rawValue, bundle: .main)
        let keyWindow = UIApplication.shared.connectedScenes
        .filter { $0.activationState == .foregroundActive }
        .map { $0 as? UIWindowScene }
        .compactMap { $0 }
        .first?.windows
            .filter{ $0.isKeyWindow }.first
        guard let window = keyWindow else { return }
        let _vc = _storyboard.instantiateInitialViewController()
        if let split = _vc as? UISplitViewController {
            split.preferredDisplayMode = .primaryOverlay
        }
        window.rootViewController = _vc
        window.makeKeyAndVisible()
    }
    
    /// Present ViewController
    ///
    /// - Parameters:
    ///   - storyboard: Storyboard's name
    ///   - identifier: UIViewController's storyboard identifier
    func presentViewController(from storyboard: UIIdentifier.Storyboard, with identifier: UIIdentifier.ViewController) {
        present(instantiateViewController(from: storyboard, with: identifier), animated: true, completion: nil)
    }
}
