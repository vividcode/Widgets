

import SwiftUI

struct TrackRow: View {
    var track: SpotifyAPI.Track

    var body: some View {
        HStack {
            self.track.trackImage(imageDimension: .small)
                .frame(width: 50, height: 50, alignment: .center)
            VStack(alignment: .leading, spacing: 5, content:
                {
                    Text(track.name)
                        .font(.body)
                        .foregroundColor(Color.textColor)
                    Text((track.artists.first?.name) ?? "")
                        .font(.caption)
                        .foregroundColor(Color.textColor)
                })
            }
    }
}

struct TrackRow_Previews: PreviewProvider {
    static var previews: some View
    {
        let factory : SpotifyAPI.Factory = SpotifyAPI.Factory()
        return TrackRow(track: factory.getSampleTrack()!)
            .preferredColorScheme(.dark)
    }
}
