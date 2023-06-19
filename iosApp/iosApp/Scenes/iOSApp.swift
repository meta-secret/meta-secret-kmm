import SwiftUI

@main
struct iOSApp: App {
    init() {
        setupServiceContainer()
    }
    
	var body: some Scene {
		WindowGroup {
			SplashView()
		}
	}
}

private extension iOSApp {

    func setupServiceContainer() {
        ServiceContainer.register(type: ContentManagerProtocol.self, ContentManager())
    }
}
