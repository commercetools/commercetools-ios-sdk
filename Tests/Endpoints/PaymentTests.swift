//
// Copyright (c) 2017 Commercetools. All rights reserved.
//

import XCTest
@testable import Commercetools

class PaymentTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        setupTestConfiguration()
    }
    
    override func tearDown() {
        cleanPersistedTokens()
        super.tearDown()
    }
    
    func testPaymentCreation() {
        let creationExpectation = expectation(description: "creation expectation")
        
        let username = "swift.sdk.test.user2@commercetools.com"
        let password = "password"
        
        AuthManager.sharedInstance.loginCustomer(username: username, password: password, completionHandler: { _ in})
        
        let transactionDraft = TransactionDraft(type: .charge, amount: Money(currencyCode: "EUR", centAmount: 808))
        let paymentDraft = PaymentDraft(amountPlanned: Money(currencyCode: "EUR", centAmount: 808), paymentMethodInfo: PaymentMethodInfo(paymentInterface: nil, method: "VISA", name: nil), transaction: transactionDraft)
        
        Payment.create(paymentDraft) { result in
            if let payment = result.model {
                XCTAssert(result.isSuccess)
                XCTAssertEqual(payment.amountPlanned.centAmount, 808)
                XCTAssertEqual(payment.amountPlanned.currencyCode, "EUR")
                XCTAssertEqual(payment.paymentMethodInfo.method, "VISA")
                XCTAssertEqual(payment.transactions.first!.amount.centAmount, 808)
                XCTAssertEqual(payment.transactions.first!.amount.currencyCode, "EUR")
                XCTAssertEqual(payment.transactions.first!.type, .charge)
                XCTAssertEqual(payment.transactions.first!.state, .initial)
                XCTAssertNotNil(payment.customer)
                XCTAssertNil(payment.anonymousId)
                creationExpectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testPaymentRetrievalById() {
        let retrievalExpectation = expectation(description: "retrieval expectation")
        
        let username = "swift.sdk.test.user2@commercetools.com"
        let password = "password"
        
        AuthManager.sharedInstance.loginCustomer(username: username, password: password, completionHandler: { _ in})
        
        let paymentDraft = PaymentDraft(amountPlanned: Money(currencyCode: "EUR", centAmount: 300))
        
        Payment.create(paymentDraft) { result in
            if let payment = result.model {
                Payment.byId(payment.id) { result in
                    XCTAssert(result.isSuccess)
                    XCTAssertEqual(result.model!.id, payment.id)
                    retrievalExpectation.fulfill()
                }
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testUpdateEndpointWithModelAction() {
        let updateExpectation = expectation(description: "update expectation")
        
        let username = "swift.sdk.test.user2@commercetools.com"
        let password = "password"
        
        AuthManager.sharedInstance.loginCustomer(username: username, password: password, completionHandler: { _ in})
        
        let paymentDraft = PaymentDraft(amountPlanned: Money(currencyCode: "EUR", centAmount: 808), paymentMethodInfo: PaymentMethodInfo(paymentInterface: nil, method: "VISA", name: nil))
        
        Payment.create(paymentDraft) { result in
            if let payment = result.model {
                let transactionDraft = TransactionDraft(type: .charge, amount: Money(currencyCode: "EUR", centAmount: 300))
                let updateActions: [PaymentUpdateAction] = [.changeAmountPlanned(amount: Money(currencyCode: "EUR", centAmount: 300)), .addTransaction(transaction: transactionDraft)]
                Payment.update(payment.id, actions: UpdateActions(version: payment.version, actions: updateActions)) { result in
                    if let updatedPayment = result.model {
                        XCTAssert(result.isSuccess)
                        XCTAssertEqual(updatedPayment.amountPlanned.centAmount, 300)
                        XCTAssertEqual(updatedPayment.amountPlanned.currencyCode, "EUR")
                        XCTAssertEqual(updatedPayment.transactions.count, 1)
                        XCTAssertEqual(updatedPayment.transactions.last!.amount.centAmount, 300)
                        XCTAssertEqual(updatedPayment.transactions.last!.type, .charge)
                        XCTAssertEqual(updatedPayment.transactions.last!.state, .initial)
                        XCTAssertNotNil(updatedPayment.customer)
                        XCTAssertNil(updatedPayment.anonymousId)
                        updateExpectation.fulfill()
                    }
                }
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testDeletePayment() {
        let removalExpectation = expectation(description: "removal expectation")
        
        let username = "swift.sdk.test.user2@commercetools.com"
        let password = "password"
        
        AuthManager.sharedInstance.loginCustomer(username: username, password: password, completionHandler: { _ in})
        
        let paymentDraft = PaymentDraft(amountPlanned: Money(currencyCode: "EUR", centAmount: 300))
        
        Payment.create(paymentDraft) { result in
            if let payment = result.model {
                Payment.delete(payment.id, version: payment.version) { result in
                    XCTAssert(result.isSuccess)
                    XCTAssertEqual(result.model!.id, payment.id)
                    removalExpectation.fulfill()
                }
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testPaymentCreationWithAnonymous() {
        let creationExpectation = expectation(description: "creation expectation")
        
        let transactionDraft = TransactionDraft(type: .charge, amount: Money(currencyCode: "EUR", centAmount: 808))
        let paymentDraft = PaymentDraft(amountPlanned: Money(currencyCode: "EUR", centAmount: 808), paymentMethodInfo: PaymentMethodInfo(paymentInterface: nil, method: "VISA", name: nil), transaction: transactionDraft)
        
        Payment.create(paymentDraft) { result in
            if let payment = result.model {
                XCTAssert(result.isSuccess)
                XCTAssertEqual(payment.amountPlanned.centAmount, 808)
                XCTAssertEqual(payment.amountPlanned.currencyCode, "EUR")
                XCTAssertEqual(payment.paymentMethodInfo.method, "VISA")
                XCTAssertEqual(payment.transactions.first!.amount.centAmount, 808)
                XCTAssertEqual(payment.transactions.first!.amount.currencyCode, "EUR")
                XCTAssertEqual(payment.transactions.first!.state, .initial)
                XCTAssertNil(payment.customer)
                XCTAssertNotNil(payment.anonymousId)
                creationExpectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testPaymentRetrievalByIdWithAnonymous() {
        let retrievalExpectation = expectation(description: "retrieval expectation")
        
        let paymentDraft = PaymentDraft(amountPlanned: Money(currencyCode: "EUR", centAmount: 300))
        
        Payment.create(paymentDraft) { result in
            if let payment = result.model {
                Payment.byId(payment.id) { result in
                    XCTAssert(result.isSuccess)
                    XCTAssertEqual(result.model!.id, payment.id)
                    retrievalExpectation.fulfill()
                }
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testUpdateEndpointWithAnonymous() {
        let updateExpectation = expectation(description: "update expectation")
        
        let paymentDraft = PaymentDraft(amountPlanned: Money(currencyCode: "EUR", centAmount: 808), paymentMethodInfo: PaymentMethodInfo(paymentInterface: nil, method: "VISA", name: nil))
        
        Payment.create(paymentDraft) { result in
            if let payment = result.model {
                let transactionDraft = TransactionDraft(type: .charge, amount: Money(currencyCode: "EUR", centAmount: 300))
                let updateActions: [PaymentUpdateAction] = [.changeAmountPlanned(amount: Money(currencyCode: "EUR", centAmount: 300)), .addTransaction(transaction: transactionDraft)]
                Payment.update(payment.id, actions: UpdateActions(version: payment.version, actions: updateActions)) { result in
                    if let updatedPayment = result.model {
                        XCTAssert(result.isSuccess)
                        XCTAssertEqual(updatedPayment.amountPlanned.centAmount, 300)
                        XCTAssertEqual(updatedPayment.amountPlanned.currencyCode, "EUR")
                        XCTAssertEqual(updatedPayment.transactions.count, 1)
                        XCTAssertEqual(updatedPayment.transactions.last!.amount.centAmount, 300)
                        XCTAssertEqual(updatedPayment.transactions.last!.type, .charge)
                        XCTAssertEqual(updatedPayment.transactions.last!.state, .initial)
                        XCTAssertNil(updatedPayment.customer)
                        XCTAssertNotNil(updatedPayment.anonymousId)
                        updateExpectation.fulfill()
                    }
                }
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testDeletePaymentWithAnonymous() {
        let removalExpectation = expectation(description: "removal expectation")
        
        let paymentDraft = PaymentDraft(amountPlanned: Money(currencyCode: "EUR", centAmount: 300))
        
        Payment.create(paymentDraft) { result in
            if let payment = result.model {
                Payment.delete(payment.id, version: payment.version) { result in
                    XCTAssert(result.isSuccess)
                    XCTAssertEqual(result.model!.id, payment.id)
                    removalExpectation.fulfill()
                }
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
//    func testRefundNotAllowed() {
//        let creationExpectation = expectation(description: "creation expectation")
//        
//        let username = "swift.sdk.test.user2@commercetools.com"
//        let password = "password"
//        
//        AuthManager.sharedInstance.loginCustomer(username: username, password: password, completionHandler: { _ in})
//        
//        let transactionDraft = TransactionDraft(type: .refund, amount: Money(currencyCode: "EUR", centAmount: 808))
//        let paymentDraft = PaymentDraft(amountPlanned: Money(currencyCode: "EUR", centAmount: 808), paymentMethodInfo: PaymentMethodInfo(paymentInterface: nil, method: "VISA", name: nil), transaction: transactionDraft)
//        
//        Payment.create(paymentDraft) { result in
//            if let error = result.errors?.first as? CTError, case .invalidJsonInputError(let reason) = error {
//                XCTAssert(result.isFailure)
//                XCTAssertEqual(result.statusCode, 400)
//                XCTAssertEqual(reason.message, "Request body does not contain valid JSON.")
//                XCTAssertEqual(reason.details, "transaction: Only Authorization or Charge allowed")
//                creationExpectation.fulfill()
//            }
//        }
//        
//        waitForExpectations(timeout: 10, handler: nil)
//    }
}

