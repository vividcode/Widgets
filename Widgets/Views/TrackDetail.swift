

import SwiftUI

struct TrackDetail: View
{
    var track: SpotifyAPI.Track
    
    var body: some View
    {
        GeometryReader {
            metrics in
            VStack {
                ZStack(alignment: Alignment.bottomLeading, content: {
                    self.track.trackImage(imageDimension: .large)
                    VStack(alignment: .leading, spacing: 5, content: {
                        Text(track.name)
                            .font(.largeTitle)
                            .foregroundColor(Color.textColor)
                        Text((track.artists.first?.name) ?? "")
                            .font(.subheadline)
                            .foregroundColor(Color.textColor)
                    })
                    .frame(maxWidth: .infinity, minHeight: 100, alignment: .bottomLeading)
                    .padding([.bottom, .leading], 10)
                })
                .frame(maxWidth: .infinity, maxHeight: metrics.size.height*0.2)
            }
        }
        .background(Color.backGroundColor)
    }
}

struct TrackDetail_Previews: PreviewProvider {
    static var previews: some View
    {
        let factory : SpotifyAPI.Factory = SpotifyAPI.Factory()
        return TrackDetail(track: factory.getSampleTrack()!)
            .preferredColorScheme(.light)
    }
}
