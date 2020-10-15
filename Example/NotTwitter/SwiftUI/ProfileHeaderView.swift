import SwiftUI

@available(iOS 13, *)
struct ProfileHeaderView: View {

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            HStack {
                Image("promo")
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(1, contentMode: .fill)
            }

            HStack {
                Image("profile-large")
                    .overlay(
                        Circle()
                            .stroke(lineWidth: 2)
                            .foregroundColor(Color(.systemGroupedBackground))
                    )

                VStack(alignment: .leading, spacing: 5) {
                    Text("Shaps Benkau")
                        .font(.headline)

                    Text("@shaps")
                        .foregroundColor(.secondary)
                }
                .alignmentGuide(VerticalAlignment.center) {
                    d in d[.top] - 10
                }
            }
            .alignmentGuide(.bottom) {
                d in d[VerticalAlignment.center]
            }
            .padding(.horizontal)
        }
        .clipped()
    }

}

@available(iOS 13, *)
struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView()
            .previewLayout(.fixed(width: 320, height: 300))
    }
}
