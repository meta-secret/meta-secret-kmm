import SwiftUI

@main
struct iOSApp: App {
    init() {
        setupServiceContainer()
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = .clear
        UITableView.appearance().backgroundColor = .clear
    }
    
	var body: some Scene {
		WindowGroup {
			SplashView(viewModel: SplashViewModel())
		}
	}
}

private extension iOSApp {

    func setupServiceContainer() {
        ServiceContainer.register(type: ContentManagerProtocol.self, ContentManager())
        ServiceContainer.register(type: DeviceManagerProtocol.self, DeviceManager())
        ServiceContainer.register(type: AuthManagerProtocol.self, AuthManager())
    }
}
