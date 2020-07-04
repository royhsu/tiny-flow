//
//  Green.swift
//  
//
//  Created by Roy Hsu on 2020/7/5.
//

import TinyFlow

struct Green: TrafficLight {}

// MARK: - Equatable

extension Green: Equatable {}

// MARK: - Phase

extension Green: Phase {
  var allPossibleNexts: [Phase.Type] { [Yellow.self] }
}
