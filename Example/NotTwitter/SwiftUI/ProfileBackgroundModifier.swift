import SwiftUI

@available(iOS 13, *)
struct ProfileBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .foregroundColor(Color(.systemGray5))
            )
    }
}

@available(iOS 13, *)
struct ProfileBackgroundModifier_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            Spacer()
            /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
            Spacer()
        }
        .modifier(ProfileBackgroundModifier())
        .previewLayout(.sizeThatFits)
    }
}
