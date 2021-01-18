

import Foundation
import Combine

typealias TokenObtainedClosure = ()->Void

class TracksViewModel: ObservableObject {
    private var tokenRequest: Cancellable? = nil
    private var trackSearchRequest: Cancellable? = nil
    
    @Published var accessToken: String = ""
    var tokenExpiry : Date?
    
    @Published var tracks: [SpotifyAPI.Track] = []
    @Published var errorStr: String = ""
    @Published var isLoading: Bool = false
    
    var api = SpotifyAPI(apiProvider: URLSession.shared)
    
    func getTracks(query: String) {
        if (self.isLoading) {
            return
        }
        self.isLoading = true
        
        if (self.isTokenValid())
        {
            self.trackSearchRequest(query: query)
        }
        else
        {
            self.getToken {
                self.trackSearchRequest(query: query)
            }
        }
    }
    
    func getToken(tokenObtainedClosure: TokenObtainedClosure?) {
        self.tokenRequest = self.api.authorize()
            .sink(
            receiveCompletion: { completion in
                switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        self.errorStr = "Failed to retrieve token:\n\(error.localizedDescription)"
                }

                self.tokenRequest = nil
            },
            receiveValue:
            {
                value in
                self.accessToken = value.access_token
                self.tokenExpiry = Date().addingTimeInterval(TimeInterval(value.expires_in))
                self.tokenRequest = nil
                tokenObtainedClosure?()
            })
    }
    
    private func trackSearchRequest(query: String)
    {
        self.trackSearchRequest = self.api.search(accessToken: self.accessToken, query: query, offset: 0, limit: 10).sink
        {
            completion in
            
            switch completion
            {
                case .finished:
                    self.isLoading = false
                    break
                case .failure(let error):
                    self.isLoading = false
                    self.errorStr = "Failed to retrieve Tracks:\n\(error.localizedDescription)"
            }
        }
        receiveValue:
        {
            value in
            self.errorStr = ""
            self.tracks = value.tracks.items
        }
    }
    
    private func isTokenValid()->Bool
    {
        let tokenExpiry = self.tokenExpiry ?? Date(timeIntervalSinceReferenceDate: 0)   //if it was never obtained, set to earliest date, to get it fresh
        return Date() < tokenExpiry
    }
}
