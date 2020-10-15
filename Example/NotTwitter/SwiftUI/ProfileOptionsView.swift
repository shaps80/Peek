import SwiftUI

@available(iOS 13, *)
struct ProfileOptionsView: View {

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Tweets")
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
            }
            .padding()

            Divider()
                .padding(.leading)

            HStack(spacing: 20) {
                Text("Lists")
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
            }
            .padding()
        }
    }

}

@available(iOS 13, *)
struct ProfileOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileOptionsView()
            .previewLayout(.sizeThatFits)
    }
}
