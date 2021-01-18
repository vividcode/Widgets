import Foundation
import Combine

extension URLRequest {
    func baseURLString()->String {
        let urlStr = self.url?.absoluteURL.absoluteString ?? ""
        let components = urlStr.split(separator: "?")
        return String(components.first ?? "")
    }
    
    func withHeader(name: String, value: String) -> URLRequest {
        var copy = self
        copy.setValue(value, forHTTPHeaderField: name)
        return copy
    }

    func withBody(_ body: String) -> URLRequest {
        var copy = self
        copy.httpBody = body.data(using: .utf8)
        return copy
    }

    func request<T: Decodable>(apiProvider: APIProvider) -> AnyPublisher<T, Error> {
        return apiProvider.apiResponse(for: self)
            .tryMap { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }

                return element.data
            }
            // You can uncomment the line below to print the response
            //.handleEvents(receiveOutput: { print(NSString(data: $0, encoding: String.Encoding.utf8.rawValue)!) })
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
