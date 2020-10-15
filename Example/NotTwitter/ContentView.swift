import SwiftUI

@available(iOS 13.0, *)
struct ContentView: View {
    @State var a: String = "AAAAA"
    @State var b: String = "BBBB"
    @State var c: String = "CCCCCC"

    var body: some View {
         VStack {
            ZStack(alignment: .mid) {
                // create vertical and horizontal
                // space to align to
                HStack { Spacer() }
                VStack { Spacer() }

                VStack(alignment: .midX) {
                    Text(self.a)

                    HStack(alignment: .center) {
                        Text(self.c)


                        Text(self.b)
                            .font(.title)
                            .border(Color.blue)
                            .alignmentGuide(.midX) { d in
                                (d[.leading] + d[.trailing])/2
                            }
                            .alignmentGuide(.midY) { d in
                                (d[.top] + d[.bottom])/2
                            }
                    }
                }
            }
            .layoutPriority(1.0)

            TextField("", text: self.$b).textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}

@available(iOS 13.0, *)
fileprivate extension HorizontalAlignment {
    @available(iOS 13.0, *)
    enum MidX : AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            return (d[.leading] + d[.trailing])/2
        }
    }

    static let midX = HorizontalAlignment(MidX.self)
}

@available(iOS 13.0, *)
fileprivate extension VerticalAlignment {
    @available(iOS 13.0, *)
    enum MidY : AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            return (d[.top] + d[.bottom])/2
        }
    }

    static let midY = VerticalAlignment(MidY.self)
}

@available(iOS 13.0, *)
fileprivate extension Alignment {
    @available(iOS 13.0, *)
    static let mid = Alignment(horizontal: .midX, vertical: .midY)
}

@available(iOS 13.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
     ContentView()
    }
}
