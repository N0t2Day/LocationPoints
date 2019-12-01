
import Foundation

enum UIIdentifier {
    
    enum Storyboard: String {
        case splash  = "SplashScreen"
        case main    = "MainScreen"
        case map     = "MapScreen"
    }
    
    enum ViewController {
        
        case splash
        case main
        case map
        
        var viewControllerIdentifier: String {
            switch self {
            case .splash: return String(describing: SplashScreenView.self)
            case .main: return String(describing: MainScreenView.self)
            case .map: return String(describing: MapScreenView.self)
            }
        }
    }

}
