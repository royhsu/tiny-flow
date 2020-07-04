//
//  Transitional+Transaction.swift
//  
//
//  Created by Roy Hsu on 2020/7/1.
//

import Foundation

extension Flow {
  /// The caller is responsible for deciding whether to maintain the transaction history.
  /// For example, when a networking task fails, you can restore the previous state with the returned
  /// transaction.
  public struct Transaction {
    var kind: Kind
  }
}
