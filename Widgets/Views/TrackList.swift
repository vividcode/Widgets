

import Foundation

import SwiftUI

struct TrackList: View {
    var tracks: [SpotifyAPI.Track] = []
    var body: some View {
        List {
            ForEach(self.tracks) { track in
                NavigationLink(destination: TrackDetail(track: track))
                {
                    TrackRow(track: track)
                }
            }
        }
    }
}

struct TrackList_Previews: PreviewProvider {
    static var previews: some View
    {
        let factory : SpotifyAPI.Factory = SpotifyAPI.Factory()
        return TrackList(tracks: [factory.getSampleTrack()!, factory.getSampleTrack()!, factory.getSampleTrack()!, factory.getSampleTrack()!])
            .preferredColorScheme(.light)
    }
}
