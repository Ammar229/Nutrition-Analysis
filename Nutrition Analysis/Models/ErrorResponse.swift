//
//  ErrorResponse.swift
//  Nutrition Analysis
//
//  Created by Ammar on 06/08/2021.
//
import Foundation

struct ErrorResponse: Codable {
    let code: Int?
    let state: Bool?
    let message: String?
}

enum APIError: LocalizedError {
    case parsing
    case severError(String)
    var  errorDescription: String? {
        switch self {
        case .parsing:
            return "Error! failed to decode json object"
        case .severError(let message):
            return message
        }
    }
}

enum ErrorNetworkMessage: String {
    case authenticationError = "Wrong credentials invalid username or password"
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated"
    case failed = "Network request failed"
    case noData = "The data you entered is not valid"
    case unableToDecode = "We could not decode the response"
}
