//
//  Phase.swift
//  
//
//  Created by Roy Hsu on 2020/7/1.
//

public protocol Phase {
  /// All the possible next phases for a flow.
  var allPossibleNexts: [Phase.Type] { get }
}
