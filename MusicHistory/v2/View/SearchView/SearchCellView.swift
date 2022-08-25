//
//  SearchCellView.swift
//  MusicHistory
//
//  Created by Vitaly Gromov on 8/24/22.
//

import SwiftUI

struct SearchCellView: View {
    var jsonObject: ItunesJson
    var body: some View {
        HStack() {
            AsyncImage(url: URL(string: jsonObject.artworkUrl100!)!) {
                $0
                    .resizable()
                    .frame(width: 100, height: 100, alignment: .center)
                    .scaledToFit()
                    .border(.gray)
            } placeholder: {
                ProgressView()
                    .progressViewStyle(.circular)
                    .frame(width: 100, height: 100, alignment: .center)
            }
            VStack(alignment: .leading) {
                Text(jsonObject.collectionCensoredName ?? "error")
                    .font(.body)
                    .fontWeight(.regular)
                    .lineLimit(2)
                    .truncationMode(.tail)
                    .textSelection(.enabled)
                Text(jsonObject.artistName ?? "error")
                    .font(.subheadline)
                    .foregroundColor(Color.gray)
                    .truncationMode(.tail)
                    .textSelection(.enabled)
                Text(formatDate(stringItunesDate:jsonObject.releaseDate ?? "error"))
                    .font(.caption)
                    .foregroundColor(Color.gray)
            }
            Spacer(minLength: 20)
            Link(destination: URL(string: jsonObject.collectionViewUrl!)!) {
                Image(systemName: "link")
            }.buttonStyle(.borderedProminent)

        }
    }
}
// MARK: - Preview

struct SearchCellView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCellView(jsonObject: ItunesJson.getTestItunesJson())
    }
}

// MARK: - Extensions

extension String {
    func trimFrom(index: Int) -> String {
        var x = String()
        var counter = 0
        for i in self {
            if x.count < index {
                x += "\(i)"
                counter += 1
            }
        }
        return x
    }
}

extension SearchCellView {
    
    func formatDate(stringItunesDate: String) -> String {
        // "2007-01-02T08:00:00Z"
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        guard let date = dateFormatterGet.date(from: stringItunesDate) else {
            return "date error"
        }
        
        let dateFormatterSet = DateFormatter()
        dateFormatterSet.locale = Locale.current
        dateFormatterSet.dateFormat = "Y"
        return dateFormatterSet.string(from: date)
    }
}
