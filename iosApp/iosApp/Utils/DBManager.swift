//
//  DBManager.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 21.11.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import RealmSwift
import Combine

protocol DBManagerProtocol {
    func saveSecret(_ secret: Secret) -> Bool
    func readSecretBy(descriptionName: String) -> Secret?
    func getAllSecrets() -> [Secret]
    func savePass(_ pass: MetaPassId) -> Bool
    func readPassBy(descriptionName: String) -> MetaPassId?
}

final class DBManager: NSObject, DBManagerProtocol {
    // MARK: - SECRET
    func saveSecret(_ secret: Secret) -> Bool {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(secret, update: .all)
                return true
            }
        } catch {
            return false
        }
        return false
    }
    
    func readSecretBy(descriptionName: String) -> Secret? {
        do {
            let realm = try Realm()
            let specificSecret = realm.object(ofType: Secret.self, forPrimaryKey: descriptionName)
            return specificSecret
        } catch {
            return nil
        }
    }
    
    func getAllSecrets() -> [Secret] {
        do {
            let realm = try Realm()
            let objs = realm.objects(Secret.self)
            return Array(objs)
        } catch {
            return []
        }
    }
    
    // MARK: - META PASS
    func savePass(_ pass: MetaPassId) -> Bool {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(pass, update: .all)
                return true
            }
        } catch {
            return false
        }
        return false
    }
    
    func readPassBy(descriptionName: String) -> MetaPassId? {
        do {
            let realm = try Realm()
            let specificPass = realm.object(ofType: MetaPassId.self, forPrimaryKey: descriptionName)
            return specificPass
        } catch {
            return nil
        }
    }
}
