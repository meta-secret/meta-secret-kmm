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
        ServiceContainer.register(type: QRCodeManagerProtocol.self, QRCodeManager())
        ServiceContainer.register(type: BiometricsManagerProtocol.self, BiometricsManager())
        
        //V1
        let jsonSerealizable = JsonSerealizManager()
        let dbManager = DBManager()
        let rustProtocol = RustTransporterManager(dbManager: dbManager, jsonSerializeManager: jsonSerealizable)
        let signable = SigningManager(rustManager: rustProtocol)
        let userService = UsersService()

        ServiceContainer.register(type: AuthorizationProtocol.self, AuthorisationService(jsonManager: jsonSerealizable, userService: userService, rustManager: rustProtocol))
        
        ServiceContainer.register(type: JsonSerealizable.self, jsonSerealizable)
        ServiceContainer.register(type: RustProtocol.self, rustProtocol)
        ServiceContainer.register(type: Signable.self, signable)
        ServiceContainer.register(type: UsersServiceProtocol.self, userService)
        ServiceContainer.register(type: VaultAPIProtocol.self, VaultAPIService(jsonManager: jsonSerealizable, userService: userService, rustManager: rustProtocol))
        ServiceContainer.register(type: DBManagerProtocol.self, dbManager)
    }
}
