import Foundation

extension URLComponents {
    func withParameter(name: String, value: String) -> URLComponents {
        var queryItems = self.queryItems ?? []
        queryItems.append(URLQueryItem(name: name, value: value))

        var copy = self
        copy.queryItems = queryItems
        return copy
    }
    
    func withParameter(name: String, value: Int) -> URLComponents {
        self.withParameter(name: name, value: String(value))
    }

    func withMethod(_ method: String) -> URLRequest {
        guard let url = self.url else {
            preconditionFailure("Failed to build URL")
        }

        var request = URLRequest.init(url: url)
        request.httpMethod = method
        return request
    }

    var get: URLRequest {
        self.withMethod("GET")
    }

    var post: URLRequest {
        self.withMethod("POST")
    }
}
