

import SwiftUI

enum ImageDimension
{
    case small, large
}

extension SpotifyAPI.Track
{
    func trackImage(imageDimension: ImageDimension)->AnyView
    {
        let albumImages = self.album.images.sorted { (img0, img1) -> Bool in
            return (img0.width > img1.width)
        }
        
        let albumImage = (imageDimension == .large) ? albumImages.first : albumImages.last
        
        guard let urlStr = albumImage?.url,
              let imgURL = URL(string: urlStr)
        else
        {
            return Image.placeHolder
        }
        
        let imageView = URLImageView(url: imgURL, id: UUID())
        
        return AnyView(imageView)
    }
}
