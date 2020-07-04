//
//  Flow+ID.swift
//  
//
//  Created by Roy Hsu on 2020/7/1.
//

import Foundation

extension Flow {
  struct ID {
    var rawValue = UUID()
  }
}

// MARK: - RawRepresentable

extension Flow.ID: RawRepresentable {}

// MARK: - Equatable

extension Flow.ID: Equatable {}
