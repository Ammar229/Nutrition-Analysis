//
//  DataState.swift
//  Nutrition Analysis
//
//  Created by Ammar on 05/08/2021.
//

import Foundation

public enum DataState {
    case loading
    case error(String)
    case empty
    case populated
}


