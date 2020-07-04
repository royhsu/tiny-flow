//
//  Flow+Transaction+Kind.swift
//  
//
//  Created by Roy Hsu on 2020/7/1.
//

extension Flow.Transaction {
  enum Kind {
    case valid(Content)
    case invalid
  }
}
