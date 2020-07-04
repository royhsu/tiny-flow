//
//  Flow.swift
//  
//
//  Created by Roy Hsu on 2020/6/21.
//

@propertyWrapper
public struct Flow {
  let id = ID()
  public private(set) var wrappedValue: Phase
  private let fatalError: (String) -> Void
  
  init(_ initialValue: Phase, fatalError: @escaping (String) -> Void) {
    self.wrappedValue = initialValue
    self.fatalError = fatalError
  }
}

extension Flow {
  public init(_ initialValue: Phase) {
    self.init(initialValue, fatalError: { Swift.fatalError($0) })
  }
}

extension Flow {
  /// Enter the given state and return a transaction to the caller for restoring.
  @discardableResult
  public mutating func enter(_ nextValue: Phase) -> Transaction {
    let isPossibleNext = wrappedValue
      .allPossibleNexts
      .contains { $0 == type(of: nextValue) }
    guard isPossibleNext else {
      fatalError("Perform a invalid transition from \(wrappedValue) to \(nextValue).")
      return Transaction(kind: .invalid)
    }
    let content = Transaction.Content(
      flowID: id,
      fromValue: wrappedValue,
      toValue: nextValue
    )
    wrappedValue = nextValue
    return Transaction(kind: .valid(content))
  }
  /// Restore the earlier state from the given transaction.
  public mutating func restore(with transaction: Transaction) {
    switch transaction.kind {
    case let .valid(content):
      guard content.flowID == id else {
        fatalError("The given transaction was not made by this property (\(id)).")
        return
      }
      wrappedValue = content.fromValue
    case .invalid:
      fatalError("The given transaction is invalid.")
    }
  }
}
