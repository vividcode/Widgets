// Hello from Yousician

import Foundation
import Combine

struct MockAPIProvider: APIProvider {
    
    static let urlDict: [String: String] = ["https://accounts.spotify.com/api/token" : "AuthorizeStub", "https://api.spotify.com/v1/search" : "TrackSearchStub"]
    
    func apiResponse(for request: URLRequest) -> AnyPublisher<APIResponse, URLError> {
        let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
        
        let testDataFileName = MockAPIProvider.urlDict[request.baseURLString()]!
        
        let data = JSONLoader().dataFromJSONFile(filename: testDataFileName)!

        return Result.success((data: data, response: response)).publisher
            .setFailureType(to: URLError.self)
            .eraseToAnyPublisher()
    }
}
