import SwiftUI
import Combine

struct TrackSearchView: View {

    @State private var searchText : String = ""
    @ObservedObject var viewModel: TracksViewModel = TracksViewModel()
    
    var body: some View {
        NavigationView {
            VStack
            {
                SearchBar(text: $searchText, searchTextChangedClosure: {
                    text in
                    if (text.count > 2)
                    {
                        self.viewModel.getTracks(query: text)
                    }
                })
                
                if (self.viewModel.isLoading && self.viewModel.tracks.count == 0)
                {
                    self.showProgressView()
                }
                else if (!self.viewModel.errorStr.isEmpty)
                {
                    TransientTextView(message: self.viewModel.errorStr) {
                        self.viewModel.errorStr = ""
                    }
                }
                else
                {
                    TrackList(tracks: self.viewModel.tracks)
                }
            }
//            .onTapGesture {
//                UIApplication.shared.endEditing()
//            }
            .onAppear(perform: {
                self.viewModel.getToken(tokenObtainedClosure: nil)
            })
            .navigationBarTitle("Songs")
            .frame(maxHeight: .infinity)
        }
    }
    
    func showProgressView()->AnyView
    {
        if #available(iOS 14.0, *)
        {
            return AnyView(
                ProgressView("Loading Tracks")
                    .background(Color.backGroundColor)
                    .foregroundColor(Color.textColor)
                    .font(.subheadline)
                    .padding(8)
                    .border(Color.backGroundColor, width: 8)
                    .cornerRadius(8.0)
                
            )
        }
        else
        {
            return AnyView(
                Text("Loading Tracks")
                    .background(Color.messageBackgroundColor)
                    .foregroundColor(Color.textColor)
                    .font(.subheadline)
                    .padding(8)
                    .border(Color.messageBackgroundColor, width: 8)
                    .cornerRadius(8.0)
            )
        }
    }
}

struct TrackSearchView_Previews: PreviewProvider {
    static var previews: some View {
        TrackSearchView()
            .preferredColorScheme(.light)
    }
}
