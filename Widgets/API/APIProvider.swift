

import Foundation
import Combine

typealias APIResponse = URLSession.DataTaskPublisher.Output
protocol APIProvider {
    func apiResponse(for request: URLRequest) -> AnyPublisher<APIResponse, URLError>
}
