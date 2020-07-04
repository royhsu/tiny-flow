//
//  Yellow.swift
//  
//
//  Created by Roy Hsu on 2020/7/5.
//

import TinyFlow

struct Yellow: TrafficLight {}

// MARK: - Equatable

extension Yellow: Equatable {}

// MARK: - Phase

extension Yellow: Phase {
  var allPossibleNexts: [Phase.Type] { [Red.self] }
}
