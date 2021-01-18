

import SwiftUI
import URLImage

struct URLImageView: View
{
    let url: URL
    let id: UUID
    
    init(url: URL, id: UUID) {
        self.url = url
        self.id = id
    }
    
    var body: some View
    {
        URLImage(url: url,
                 options: URLImageService.shared.defaultOptions,
             empty: {                                   // This view is displayed before download starts
                Image.placeHolder
             },
             inProgress: { progress -> AnyView in       // Display progress
                Image.placeHolder
             },
             failure: { error, retry in                 // Display error and retry button
                Group {
                    Image.placeHolder
                }
             },
             content: { image in                // Content view
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
             })
    }
}
