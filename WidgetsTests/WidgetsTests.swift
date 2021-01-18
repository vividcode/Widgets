import XCTest
import Combine

@testable import Widgets

class YousicianSongsTests: XCTestCase {
    var authorizeRequest: Cancellable?
    var trackSearchRequest: Cancellable?
    
    private let accessToken = "fake access token"
    
    override func setUpWithError() throws
    {
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAuthorize() throws
    {
        let apiMockProvider = MockAPIProvider()
        let api = SpotifyAPI(apiProvider: apiMockProvider)
        var resultSuccessStr = ""
        
        self.authorizeRequest = api.authorize()
            .sink(
            receiveCompletion: { completion in
                switch completion {
                    case .finished:
                        break
                case .failure( _):
                        resultSuccessStr = "NO"
                }
            },
            receiveValue:
            {
                value in
                resultSuccessStr = "YES"
                XCTAssert(value.access_token.isEmpty == false)
            })
        
        let exp = expectation(description: "testAuthorize")

        let result = XCTWaiter.wait(for: [exp], timeout: 3)
        if result == XCTWaiter.Result.timedOut
        {
            XCTAssert(resultSuccessStr == "YES")
        } else {
             XCTFail("Delay interrupted testAuthorize")
        }
    }
    
    func testSearchRequest() throws
    {
        let apiMockProvider = MockAPIProvider()
        let api = SpotifyAPI(apiProvider: apiMockProvider)
        var resultSuccessStr = ""
        
        self.trackSearchRequest = api.search(accessToken: self.accessToken, query: "abc")
            .sink(
            receiveCompletion: { completion in
                switch completion {
                    case .finished:
                        break
                case .failure( _):
                        resultSuccessStr = "NO"
                }
            },
            receiveValue:
            {
                value in
                resultSuccessStr = "YES"
                XCTAssert(value.tracks.items.count > 0)
            })
        
        let exp = expectation(description: "testSearchRequest")

        let result = XCTWaiter.wait(for: [exp], timeout: 3)
        if result == XCTWaiter.Result.timedOut
        {
            XCTAssert(resultSuccessStr == "YES")
        } else {
             XCTFail("Delay interrupted testSearchRequest")
        }
    }

}
