
import UIKit

/// View layer abstract
protocol BaseView where Self: UIViewController {
    associatedtype PresenterType
    var presenter: PresenterType? { set get }
        
    func showError(title: String?, message: String?, okAction: VoidCompletionBlock, deniedAction: VoidCompletionBlock)
    func showNavigationBar(animated: Bool)
    func hideNavigationBar(animated: Bool)
}

extension BaseView {
    
    func showError(title: String?, message: String?, okAction: VoidCompletionBlock = nil, deniedAction: VoidCompletionBlock = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { _ in okAction?() }))
        alert.addAction(UIAlertAction(title: "NO", style: .cancel, handler: { _ in deniedAction?() }))
        present(alert, animated: true, completion: nil)
    }
    
    
    func showInfoError(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        present(alert, animated: true, completion: nil)
        
    }
    
    func showInfoError(title: String?, message: String?, hideAfter delay: TimeInterval, action: VoidCompletionBlock = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        present(alert, animated: true, completion: {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {[weak self] in
                self?.dismiss(animated: true, completion: action)
            }
        })
    }
    
    func showError(_ error: Error, okAction: VoidCompletionBlock = nil) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in okAction?() }))
        present(alert, animated: true, completion: nil)
    }
    
    
    func showNavigationBar(animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    func hideNavigationBar(animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    
    func replaceWithRoot(view: UIViewController, animated: Bool = true) {
        navigationController?.setViewControllers([view], animated: animated)
    }
    
    func beginIgnoring() {
        view.isUserInteractionEnabled = false
    }
    
    func endIgnoring() {
        view.isUserInteractionEnabled = true
    }
    func showAlert(with title: String, message: String?, completion: @escaping ((String?)->Void)) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField { (textField) in textField.text = "Some default text" }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in completion(nil) }))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] _ in
            guard let alert = alert else { return }
            let textField = alert.textFields![0]
            completion(textField.text)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
