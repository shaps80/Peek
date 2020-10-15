import SwiftUI

@available(iOS 13, *)
struct TweetFollowersView: View {

    var body: some View {
        VStack {
            HStack {
                Spacer()
                VStack {
                    Text("FOLLOWERS")
                        .font(.callout)
                        .foregroundColor(.secondary)
                    Text("4,559")
                        .font(.title)
                }

                Spacer()
                Divider()
                Spacer()

                VStack {
                    Text("FOLLOWING")
                        .font(.callout)
                        .foregroundColor(.secondary)
                    Text("256")
                        .font(.title)
                }

                Spacer()
            }
        }
        .padding(.vertical)
    }

}

@available(iOS 13, *)
struct ProfileFollowsView_Previews: PreviewProvider {
    static var previews: some View {
        TweetFollowersView()
            .fixedSize(horizontal: false, vertical: true)
            .previewLayout(.sizeThatFits)
    }
}
