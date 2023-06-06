import Foundation

public protocol URLSessionType {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionType {}
