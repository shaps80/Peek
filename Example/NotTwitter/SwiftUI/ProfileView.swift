import SwiftUI

@available(iOS 13, *)
struct ProfileView: View {

    var body: some View {
        ScrollView {
            ProfileHeaderView()

            VStack(spacing: 20) {
                TweetFollowersView()
                    .modifier(ProfileBackgroundModifier())

                ProfileOptionsView()
                    .modifier(ProfileBackgroundModifier())
            }
            .padding()
        }
        .background(
            Color(.systemGroupedBackground)
                .edgesIgnoringSafeArea(.all)
        )
        .navigationBarTitle("Shaps", displayMode: .inline)
    }

}

@available(iOS 13, *)
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .edgesIgnoringSafeArea(.top)
            .preferredColorScheme(.dark)
            .environment(\., .)
    }
}
