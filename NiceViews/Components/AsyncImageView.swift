import SwiftUI

//struct AsyncImageView: View {
//    let url: String
//    let width: CGFloat
//    let height: CGFloat
//    
//    var body: some View {
//        AsyncImage(url: URL(string: url)) { image in
//            image
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(width: width, height: height)
//                .clipped()
//        } placeholder: {
//            Rectangle()
//                .fill(Color.gray.opacity(0.2))
//                .frame(width: width, height: height)
//                .overlay(
//                    ProgressView()
//                        .progressViewStyle(CircularProgressViewStyle(tint: .gray))
//                )
//        }
//    }
//}
