import Foundation

/// HTTP response codes for Marvel API responses.
struct HTTPResponseCodes {
    static let success = 200              // Successful request
    static let created = 201              // Resource created successfully
    static let unauthorized = 401         // Unauthorized (authentication issues)
    static let forbidden = 403            // Forbidden (access denied)
    static let notFound = 404             // Resource not found
    static let internalServerError = 500  // Internal server error
    static let badGateway = 502           // Bad gateway
    static let serviceUnavailable = 503   // Service unavailable
}
