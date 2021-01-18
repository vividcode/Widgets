

import SwiftUI

typealias SearchTextChangedClosure = (String)->Void

struct SearchBar: UIViewRepresentable {

    @Binding var text: String
    var searchTextChangedClosure: SearchTextChangedClosure

    class Coordinator: NSObject, UISearchBarDelegate {

        @Binding var text: String
        var textChangedClosure: SearchTextChangedClosure
        
        init(text: Binding<String>, txtChangedClosure: @escaping SearchTextChangedClosure) {
            _text = text
            textChangedClosure = txtChangedClosure
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
            self.textChangedClosure(text)
        }
        
        func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            text = ""
            UIApplication.shared.endEditing()
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            text = ""
            UIApplication.shared.endEditing()
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            text = ""
            UIApplication.shared.endEditing()
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, txtChangedClosure: self.searchTextChangedClosure)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.placeholder = "Enter 3 characters to start search..."
        searchBar.delegate = context.coordinator
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar,
                      context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}
