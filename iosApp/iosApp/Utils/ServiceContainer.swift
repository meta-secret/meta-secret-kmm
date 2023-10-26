//
//  ServiceContainer.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 19.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation

class ServiceContainer {
    private static var factories: [String: () -> Any] = [:]
    private static var cache: [String: Any] = [:]
    
    static func register<Service>(type: Service.Type, _ factory: @autoclosure @escaping () -> Service) {
        factories[String(describing: type.self)] = factory
    }
    
    static func resolve<Service>(_ resolveType: ServiceType = .automatic, _ type: Service.Type) -> Service? {
        let serviceName = String(describing: type.self)

        switch resolveType {
        case .singleton:
            if let service = cache[serviceName] as? Service {
                return service
            } else {
                let service = factories[serviceName]?() as? Service

                if let service = service {
                    cache[serviceName] = service
                }

                return service
            }
        case .newSingleton:
            let service = factories[serviceName]?() as? Service

            if let service = service {
                cache[serviceName] = service
            }

            return service
        case .automatic:
            fallthrough
        case .new:
            return factories[serviceName]?() as? Service
        }
    }
}

@propertyWrapper
struct Service<Service> {

    var service: Service

    init(_ type: ServiceType = .automatic) {
        guard let service = ServiceContainer.resolve(type, Service.self) else {
            let serviceName = String(describing: Service.self)
            fatalError("No service of type \(serviceName) registered!")
        }

        self.service = service
    }

    var wrappedValue: Service {
        get { self.service }
        mutating set { service = newValue }
    }
}
