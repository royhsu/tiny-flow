//
//  Flow+Transaction+Content.swift
//  
//
//  Created by Roy Hsu on 2020/7/1.
//

extension Flow.Transaction {
  struct Content {
    /// The id of the flow which produces this transaction.
    var flowID: Flow.ID
    var fromValue: Phase
    var toValue: Phase
  }
}
