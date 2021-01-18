import Foundation
import Combine

class SpotifyAPI
{
    private var apiProvider: APIProvider
    private static let credentials = "ZmZjOWY3NzM5MmFlNDk3NmFlOGJjNDU1NWUxYTFmMmE6ZmQ1YTg1MzM3M2RmNDY1ZjljNTVkYmRhZWFkNjI1MTE=";
    
    init(apiProvider: APIProvider) {
        self.apiProvider = apiProvider
    }

    func authorize() -> AnyPublisher<AuthorizationResponse, Error>
    {
        URLComponents(string: "https://accounts.spotify.com/api/token")!
            .post
            .withHeader(name: "Authorization", value: "Basic \(SpotifyAPI.credentials)")
            .withHeader(name: "Accept", value: "application/json")
            .withHeader(name: "Content-Type", value: "application/x-www-form-urlencoded")
            .withBody("grant_type=client_credentials")
            .request(apiProvider: self.apiProvider)
    }

    func search(accessToken : String, query : String, offset : Int = 0, limit : Int = 20) -> AnyPublisher<SearchResponse, Error>
    {
        URLComponents(string: "https://api.spotify.com/v1/search")!
            .withParameter(name: "q", value: query.isEmpty ? "''" : query)
            .withParameter(name: "type", value: "track")
            .withParameter(name: "offset", value: offset)
            .withParameter(name: "limit", value: limit)
            .get
            .withHeader(name: "Authorization", value: "Bearer \(accessToken)")
            .withHeader(name: "Accept", value: "application/json")
            .request(apiProvider: self.apiProvider)
    }

    // MARK: - JSON classes
    struct Factory {
        func getSampleTrack()->Track? {
            let loader = JSONLoader()
            
            if let track: Track  = loader.loadModelFromJSON(filename: "Track")
            {
                return track
            }
            
            return nil
        }
        
        func getSampleArtist()->Artist? {
            let loader = JSONLoader()
            
            if let artist: Artist  = loader.loadModelFromJSON(filename: "Artist")
            {
                return artist
            }
            
            return nil
        }
    }
    struct AuthorizationResponse : Decodable {
        let access_token : String
        let token_type : String
        let expires_in : Int
    }

    struct SearchResponse: Codable {
        let tracks: Tracks
    }

    struct Tracks: Codable {
        let href: String
        let items: [Track]
        let limit: Int
        let next: String
        let offset: Int
        let total: Int
    }

    struct Track: Codable, Identifiable, Equatable {
        let album: Album
        let artists: [Artist]
        let available_markets: [String]
        let disc_number, duration_ms: Int
        let explicit: Bool
        let href: String
        let id: String
        let is_local: Bool
        let name: String
        let popularity: Int
        let track_number: Int
        let uri: String

        static func ==(lhs: Track, rhs: Track) -> Bool {
            return lhs.id == rhs.id
        }
    }

    struct Artist: Codable {
        let href: String
        let id, name: String
        let uri: String
    }

    struct Album: Codable {
        let artists: [Artist]
        let href: String
        let id: String
        let images: [AlbumImage]
        let name, release_date: String
        let total_tracks: Int
        let uri: String
    }

    struct AlbumImage: Codable {
        let height: Int
        let url: String
        let width: Int
    }
}
