//
//  AppleReceipt.swift
//  Purchases
//
//  Created by Andrés Boedo on 7/22/20.
//  Copyright © 2020 Purchases. All rights reserved.
//

import Foundation

// https://developer.apple.com/library/archive/releasenotes/General/ValidateAppStoreReceipt/Chapters/ReceiptFields.html
struct ReceiptAttribute {
    let type: ReceiptAttributeType
    let version: Int
    let value: String
}

enum ReceiptAttributeType: Int {
    case bundleId = 2,
         applicationVersion = 3,
         opaqueValue = 4,
         sha1Hash = 5,
         creationDate = 12,
         inAppPurchase = 17,
         originalApplicationVersion = 19,
         expirationDate = 21
}

public struct AppleReceipt: Equatable {
    public let bundleId: String
    public let applicationVersion: String
    public let originalApplicationVersion: String
    public let opaqueValue: Data
    public let sha1Hash: Data
    public let creationDate: Date
    public let expirationDate: Date?
    public let inAppPurchases: [InAppPurchase]

    public func purchasedIntroOfferOrFreeTrialProductIdentifiers() -> Set<String> {
        let productIdentifiers = inAppPurchases
            .filter { $0.isInIntroOfferPeriod || $0.isInTrialPeriod == true }
            .map { $0.productId }
        return Set(productIdentifiers)
    }

    var asDict: [String: Any] {
        return [
            "bundleId": bundleId,
            "applicationVersion": applicationVersion,
            "originalApplicationVersion": originalApplicationVersion,
            "opaqueValue": opaqueValue,
            "sha1Hash": sha1Hash,
            "creationDate": creationDate,
            "expirationDate": expirationDate ?? "",
            "inAppPurchases": inAppPurchases.map { $0.asDict }
        ]
    }

    var description: String {
        return String(describing: self.asDict)
    }
}
