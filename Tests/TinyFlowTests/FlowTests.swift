//
//  FlowTests.swift
//
//
//  Created by Roy Hsu on 2020/7/1.
//

@testable
import TinyFlow
import XCTest

final class FlowTests: XCTestCase {
  func testInitialize() throws {
    let trafficLight = Flow(Green())
    XCTAssertEqual(trafficLight.wrappedValue as? Green, Green())
  }
  
  func testEnterNextValue() throws {
    var trafficLight = Flow(
      Green(),
      fatalError: { message in XCTFail(message) }
    )
    switch trafficLight.enter(Yellow()).kind {
    case let .valid(content):
      XCTAssertEqual(content.flowID, trafficLight.id)
      XCTAssertEqual(content.fromValue as? Green, Green())
      XCTAssertEqual(content.toValue as? Yellow, Yellow())
    case .invalid:
      XCTFail()
    }
    switch trafficLight.enter(Red()).kind {
    case let .valid(content):
      XCTAssertEqual(content.flowID, trafficLight.id)
      XCTAssertEqual(content.fromValue as? Yellow, Yellow())
      XCTAssertEqual(content.toValue as? Red, Red())
    case .invalid:
      XCTFail()
    }
    switch trafficLight.enter(Green()).kind {
    case let .valid(content):
      XCTAssertEqual(content.flowID, trafficLight.id)
      XCTAssertEqual(content.fromValue as? Red, Red())
      XCTAssertEqual(content.toValue as? Green, Green())
    case .invalid:
      XCTFail()
    }
  }
  
  func testEnterInvalidNextValue() throws {
    let didFailEnterNextValue = expectation(description: "The property did fail to enter the invalid next value.")
    var trafficLight = Flow(
      Green(),
      fatalError: { _ in didFailEnterNextValue.fulfill() }
    )
    switch trafficLight.enter(Red()).kind {
    case .valid:
      XCTFail()
    case .invalid:
      break
    }
    waitForExpectations(timeout: 10.0)
  }
  
  func testRestoreEarlierValueWithTransactions() throws {
    var trafficLight = Flow(
      Green(),
      fatalError: { message in XCTFail(message) }
    )
    let yellowTransaction = trafficLight.enter(Yellow())
    let redTransaction = trafficLight.enter(Red())
    trafficLight.restore(with: yellowTransaction)
    XCTAssertEqual(trafficLight.wrappedValue as? Green, Green())
    trafficLight.restore(with: redTransaction)
    XCTAssertEqual(trafficLight.wrappedValue as? Yellow, Yellow())
  }
  
  func testRestoreEarlierValueWithInvalidTransaction() throws {
    let didFailRestore = expectation(description: "The property did fail to restore the earlier value with an invalid transaction.")
    var trafficLight = Flow(
      Green(),
      fatalError: { _ in didFailRestore.fulfill() }
    )
    trafficLight.restore(with: Flow.Transaction(kind: .invalid))
    waitForExpectations(timeout: 10.0)
  }
  
  func testRestoreEarlierValueWithTransactionsMadeByOthers() throws {
    let didFailRestore = expectation(description: "The property did fail to restore the earlier value with transactions made by others.")
    var currentTrafficLight = Flow(
      Green(),
      fatalError: { _ in didFailRestore.fulfill() }
    )
    var otherTrafficLight = Flow(
      Green(),
      fatalError: { message in XCTFail(message) }
    )
    let transactionMadeByOther = otherTrafficLight.enter(Yellow())
    currentTrafficLight.restore(with: transactionMadeByOther)
    waitForExpectations(timeout: 10.0)
  }
}

extension FlowTests {
  static var allTests = [
    ("testInitialize", testInitialize),
    ("testEnterNextValue", testEnterNextValue),
    ("testEnterInvalidNextValue", testEnterInvalidNextValue),
    ("testRestoreEarlierValueWithTransactions", testRestoreEarlierValueWithTransactions),
    ("testRestoreEarlierValueWithInvalidTransaction", testRestoreEarlierValueWithInvalidTransaction),
    ("testRestoreEarlierValueWithTransactionsMadeByOthers", testRestoreEarlierValueWithTransactionsMadeByOthers),
  ]
}
