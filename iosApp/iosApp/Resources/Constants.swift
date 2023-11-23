//
//  Constants.swift
//  MetaSecret
//
//  Created by Dmitry Kuklin on 13.08.2022.
//

import Foundation
import UIKit

struct Constants {
    //MARK: - COMMON
    struct Common {
        static let animationTime: CGFloat = 0.3
        static let timerInterval: CGFloat = 1
//        static let appStoreLink = "https://testflight.apple.com/join/AkzuH5A4/"
        static let appStoreLink = "https://apps.apple.com/ru/app/metasecret/id1644286751/"
        static let secureSafe = NSLocalizedString("secureSafe", comment: "")
        static let next = NSLocalizedString("next", comment: "")
        static let skip = NSLocalizedString("skip", comment: "")
        static let needDevices = NSLocalizedString("needDevices", comment: "")
        static let needDevices2 = NSLocalizedString("needDevices2", comment: "")
        static let addPLus = NSLocalizedString("+add", comment: "")
        static let neededDeviceCount: Int = 3
        static let enterValue = NSLocalizedString("enterValue", comment: "")
        static let ok = "ok"
        static let neededMembersCount = 3
    }
    
    //MARK: - ALERTS
    struct Alert {
        static let emptyTitle = ""
        static let ok = NSLocalizedString("ok", comment: "")
        static let cancel = NSLocalizedString("cancel", comment: "")
        static let biometricalReason = NSLocalizedString("biometricalReason", comment: "")
        static let needConfirmation = NSLocalizedString("needConfirmation", comment: "")
        static let confirmationText = NSLocalizedString("confirmationText", comment: "")
        static let waitConfirmationText = NSLocalizedString("waitConfirmationText", comment: "")
    }
    
    //MARK: - ONBOARDING
    struct Onboarding {
        static let gotSecrets = NSLocalizedString("gotSecrets", comment: "")
        static let splitIt = NSLocalizedString("splitIt", comment: "")
        static let secureSafe = NSLocalizedString("secureSafe", comment: "")
    }
    
    //MARK: - SIGN IN
    struct LetsStart {
        static let letsStart = NSLocalizedString("letsStart", comment: "")
        static let chooseName = NSLocalizedString("chooseName", comment: "")
        static let scanQR = NSLocalizedString("scanQR", comment: "")
        static let chooseNamePlaceHolder = NSLocalizedString("chooseNamePlaceHolder", comment: "")
        static let moveNext = NSLocalizedString("moveNext", comment: "")
    }
    
    struct Main {
        static let secrets = NSLocalizedString("Secrets", comment: "")
        static let devices = NSLocalizedString("Devices", comment: "")
        static let help = NSLocalizedString("Help", comment: "")
        static let profile = NSLocalizedString("Profile", comment: "")
    }
    
    struct Secrets {
        static let noSecrets = NSLocalizedString("noSecrets", comment: "")
        static let youHaveNoSecrets = NSLocalizedString("youHaveNoSecrets", comment: "")
        static let weak = NSLocalizedString("weak", comment: "")
        static let strong = NSLocalizedString("strong", comment: "")
        static let maximum = NSLocalizedString("maximum", comment: "")
        static let deviceCount = NSLocalizedString("countDevice", comment: "")
        static let devicesCount = NSLocalizedString("countDevices", comment: "")
        static let devicesCount2 = NSLocalizedString("countDevices2", comment: "")
        static let secretsCount = NSLocalizedString("countSecrets", comment: "")
        static let countSecretsZero = NSLocalizedString("countSecretsZero", comment: "")
        static let addSecret = NSLocalizedString("addSecret", comment: "")
        static let secretName = NSLocalizedString("secretName", comment: "")
        static let secret = NSLocalizedString("secret", comment: "")
        static let secretNameNeeded = NSLocalizedString("secretNameNeeded", comment: "")
        static let secretNeeded = NSLocalizedString("secretNeeded", comment: "")
        static let showSecret = NSLocalizedString("showSecret", comment: "")
        static let show = NSLocalizedString("show", comment: "")
        static let copySecret = NSLocalizedString("copySecret", comment: "")
    }
    
    struct Devices {
        static let addDevice = NSLocalizedString("addDevice", comment: "")
        static let threeDevicesNeeded = NSLocalizedString("threeDevicesNeeded", comment: "")
        static let soon = NSLocalizedString("soon", comment: "")
        static let notEnoughtDevices = NSLocalizedString("notEnoughtDevices", comment: "")
        static let metaSecretCloud = NSLocalizedString("metaSecretCloud", comment: "")
        static let downloadApp = NSLocalizedString("downloadApp", comment: "")
        static let repeatNickName = NSLocalizedString("repeatNickName", comment: "")
        static let approveConnection = NSLocalizedString("approveConnection", comment: "")
        static let useQR = NSLocalizedString("useQR", comment: "")
        
        static let member = NSLocalizedString("member", comment: "")
        static let declined = NSLocalizedString("declined", comment: "")
        static let pending = NSLocalizedString("pending", comment: "")
    }
    
    //MARK: - LOGIN
    struct LoginScreen {
//        static let title = NSLocalizedString("metaSecret", comment: "")
//        static let loginTitle = NSLocalizedString("loginTitle", comment: "")
//        static let userNameLabel = NSLocalizedString("yourName", comment: "")
//        static let letsGoButton = NSLocalizedString("letsgo", comment: "")
//        static let scanQRButton = NSLocalizedString("scanQR", comment: "")
//        static let alreadyExisted = NSLocalizedString("wannaJoin", comment: "")
//        static let renameOk = NSLocalizedString("rename", comment: "")
        static let declined = NSLocalizedString("declinedRequest", comment: "")
//        static let awaitingTitle = NSLocalizedString("waitingForApproval", comment: "")
//        static let awaitingMessage = NSLocalizedString("pleaseAcceptRequest", comment: "")
//        static let chooseAnotherName = NSLocalizedString("pleaseAcceptRequest", comment: "")
//        static let qrScanner = NSLocalizedString("qrScanner", comment: "")
    }
    
    struct MainScreen {
//        static let secrets = NSLocalizedString("secrets", comment: "")
//        static let devices = NSLocalizedString("devices", comment: "")
//        static let joinPendings = NSLocalizedString("doYouWannaAccept", comment: "")
//        static let ok = NSLocalizedString("accept", comment: "")
//        static let cancel = NSLocalizedString("decline", comment: "")
//        static let pendingTitle = NSLocalizedString("pending", comment: "")
//        static let declineTitle = NSLocalizedString("declined", comment: "")
//        static let memberTitle = NSLocalizedString("member", comment: "")
//        static let noSecrets = NSLocalizedString("noSecrets", comment: "")
//        static let noDevices = NSLocalizedString("hmmm", comment: "")
//        static let titleFirstTimeHint = NSLocalizedString("createCluster", comment: "")
//
//        static func messageFirstTimeHint(name: String) -> String {
//            let localizedString = NSLocalizedString("onlyOneDevice", comment: "")
//            let wantedString = String(format: localizedString, name)
//            return wantedString
//        }
//        static func addDevices(memberCounts: Int) -> String {
//            let neededDevicesCount = 3 - memberCounts
//            let localizedString = NSLocalizedString("pleaseInstall", comment: "")
//            let wantedString = String(format: localizedString, "\(neededDevicesCount)")
//
//            return wantedString
//        }
//        static let yourNick = NSLocalizedString("yourNick", comment: "")
//        static let yourDevices = NSLocalizedString("yourDevices", comment: "")
//        static let yourSecrets = NSLocalizedString("yourSecrets", comment: "")
//        static let add = NSLocalizedString("add", comment: "")
//        static let notBackedUp = NSLocalizedString("notBackedUp", comment: "")
    }
    
//    struct Devices {
//        static let member = NSLocalizedString("member", comment: "")
//        static let declined = NSLocalizedString("declined", comment: "")
//        static let pending = NSLocalizedString("pending", comment: "")
//        static let istallInstructionTitle = NSLocalizedString("howToAdd", comment: "")
//        static func installInstruction(name: String) -> String {
//            return String(format: NSLocalizedString("stepsToAdd", comment: ""), name)
//        }
//    }
    
    struct PairingDeveice {
//        static let title = NSLocalizedString("deviceAdding", comment: "")
//        static let accept = NSLocalizedString("accept", comment: "")
//        static let decline = NSLocalizedString("decline", comment: "")
//        static let warningMessage = NSLocalizedString("pleaseApprove", comment: "")
    }
    
    struct AddSecret {
//        static let title = NSLocalizedString("addSecret", comment: "")
//        static let titleEdit = NSLocalizedString("editSecret", comment: "")
//        static let recoverEdit = NSLocalizedString("recoverEdit", comment: "")
//        static let addDescriptionTitle = NSLocalizedString("addDescription", comment: "")
//        static let description = NSLocalizedString("description", comment: "")
//        static let addPassword = NSLocalizedString("addPassword", comment: "")
//        static let password = NSLocalizedString("password", comment: "")
//        static let decriptionPlaceHolder = NSLocalizedString("password", comment: "")
//        static let splitInstruction = NSLocalizedString("splitInstruction", comment: "")
//        static let splitInstructionLocal = NSLocalizedString("splitInstructionLocal", comment: "")
//        static let selectSecond = NSLocalizedString("selectSecond", comment: "")
//        static let selectThird = NSLocalizedString("selectThird", comment: "")
//        static let selectSecondButton = NSLocalizedString("selectSecondButton", comment: "")
//        static let selectThirdButton = NSLocalizedString("selectThirdButton", comment: "")
//        static let split = NSLocalizedString("split", comment: "")
//        static let selectDevice = NSLocalizedString("selectDevice", comment: "")
//        static let selectDeviceButton = NSLocalizedString("selectDeviceButton", comment: "")
//        static let selectDeviceButtonLocal = NSLocalizedString("selectDeviceButtonLocal", comment: "")
//        static let notSplitedMessage = NSLocalizedString("notSplitedMessage", comment: "")
        static let alreadySavedMessage = NSLocalizedString("alreadySavedMessage", comment: "")
//        static let edit = NSLocalizedString("edit", comment: "")
//        static let showSecret = NSLocalizedString("showSecret", comment: "")
//        static let success = NSLocalizedString("success", comment: "")
//        static let successSplited = NSLocalizedString("successSplited", comment: "")
    }
    
    struct SelectDevice {
//        static let sentShareTitle = NSLocalizedString("sentShareTitle", comment: "")
//        static let sentShareMessage = NSLocalizedString("sentShareMessage", comment: "")
//        static let chooseDevices = NSLocalizedString("chooseDevices", comment: "")
    }
    
    struct Errors {
        static let error = NSLocalizedString("error", comment: "")
        static let warning = NSLocalizedString("warning", comment: "")
        static let commonError = NSLocalizedString("commonError", comment: "")
        static let networkError = NSLocalizedString("networkError", comment: "")
        static let registerError = NSLocalizedString("registerError", comment: "")
        static let vaultError = NSLocalizedString("vaultError", comment: "")
        static let userSignatureError = NSLocalizedString("userSignatureError", comment: "")
        static let userNameMesasge = NSLocalizedString("wannaLogin", comment: "")
        static let enterName = NSLocalizedString("enterName", comment: "")
        static let swwError = NSLocalizedString("sww", comment: "")
        static let notEnoughtMembers = NSLocalizedString("atLeast3", comment: "")
        static let generateUserError = NSLocalizedString("generateUserError", comment: "")
        static let distributeError = NSLocalizedString("distributeError", comment: "")
        static let restoreError = NSLocalizedString("restoreError", comment: "")
        static let encodeError = NSLocalizedString("encodeError", comment: "")
        static let noMainUserError = NSLocalizedString("noMainUserError", comment: "")
        static let objectToJsonError = NSLocalizedString("objectToJsonError", comment: "")
        static let cantRestore = NSLocalizedString("cantRestore", comment: "")
        static let cantClaim = NSLocalizedString("cantClaim", comment: "")
        static let shareSearchError = NSLocalizedString("shareSearchError", comment: "")
        static let distributionDBError = NSLocalizedString("distributionDBError", comment: "")
        static let splitError = NSLocalizedString("splitError", comment: "")
        static let authError = NSLocalizedString("authError", comment: "")
        static let authErrorMessage = NSLocalizedString("authErrorMessage", comment: "")
        static let notConfirmed = NSLocalizedString("notConfirmed", comment: "")
        static let dbNotConsistence = NSLocalizedString("dbNotConsistence", comment: "")
        static let cameraError = NSLocalizedString("cameraError", comment: "")
        static let requiredField = NSLocalizedString("requiredField", comment: "")
        static let signInError = NSLocalizedString("signInError", comment: "")
    }
    
    struct BiometricError {
        static let authenticationFailed = NSLocalizedString("authenticationFailed", comment: "")
        static let userCancel = NSLocalizedString("userCancel", comment: "")
        static let userFallback = NSLocalizedString("userFallback", comment: "")
        static let biometryNotAvailable = NSLocalizedString("biometryNotAvailable", comment: "")
        static let biometryNotEnrolled = NSLocalizedString("biometryNotEnrolled", comment: "")
        static let biometryLockout = NSLocalizedString("biometryLockout", comment: "")
        static let unknown = NSLocalizedString("unknown", comment: "")
        static let enterAppPass = NSLocalizedString("enterAppPass", comment: "")
    }
    
    //MARK: - TAGS
    struct ViewTags {
//        static let loaderTag = 1001
    }
}
