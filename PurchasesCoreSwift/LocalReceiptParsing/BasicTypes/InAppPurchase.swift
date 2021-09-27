//
// Created by Andrés Boedo on 7/29/20.
// Copyright (c) 2020 Purchases. All rights reserved.
//

import Foundation

// https://developer.apple.com/library/archive/releasenotes/General/ValidateAppStoreReceipt/Chapters/ReceiptFields.html
enum InAppPurchaseAttributeType: Int {
    case quantity = 1701,
         productId = 1702,
         transactionId = 1703,
         purchaseDate = 1704,
         originalTransactionId = 1705,
         originalPurchaseDate = 1706,
         productType = 1707,
         expiresDate = 1708,
         webOrderLineItemId = 1711,
         cancellationDate = 1712,
         isInTrialPeriod = 1713,
         isInIntroOfferPeriod = 1719,
         promotionalOfferIdentifier = 1721
}

public enum InAppPurchaseProductType: Int {
    case unknown = -1,
         nonConsumable,
         consumable,
         nonRenewingSubscription,
         autoRenewableSubscription
}

public struct InAppPurchase: Equatable {
    public let quantity: Int
    public let productId: String
    public let transactionId: String
    public let originalTransactionId: String
    public let productType: InAppPurchaseProductType?
    public let purchaseDate: Date
    public let originalPurchaseDate: Date
    public let expiresDate: Date?
    public let cancellationDate: Date?
    public let isInTrialPeriod: Bool?
    public let isInIntroOfferPeriod: Bool
    public let webOrderLineItemId: Int64
    public let promotionalOfferIdentifier: String?

    public var asDict: [String: Any] {
        return [
            "quantity": quantity,
            "productId": productId,
            "transactionId": transactionId,
            "originalTransactionId": originalTransactionId,
            "promotionalOfferIdentifier": promotionalOfferIdentifier ?? "",
            "purchaseDate": purchaseDate,
            "productType": productType?.rawValue ?? "",
            "originalPurchaseDate": originalPurchaseDate,
            "expiresDate": expiresDate ?? "",
            "cancellationDate": cancellationDate ?? "",
            "isInTrialPeriod": isInTrialPeriod ?? "",
            "isInIntroOfferPeriod": isInIntroOfferPeriod,
            "webOrderLineItemId": webOrderLineItemId
        ]
    }

    public var description: String {
        return String(describing: self.asDict)
    }
}
