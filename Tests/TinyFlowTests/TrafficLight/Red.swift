//
//  Red.swift
//  
//
//  Created by Roy Hsu on 2020/7/5.
//

import TinyFlow

struct Red: TrafficLight {}

// MARK: - Equatable

extension Red: Equatable {}

// MARK: - Phase

extension Red: Phase {
  var allPossibleNexts: [Phase.Type] { [Green.self] }
}
