import SwiftUI

struct DashboardButtonView: View {
    let imageName: String
    let title: String

    var body: some View {
        VStack {
            if imageName.starts(with: "system:") {
                Image(systemName: String(imageName.dropFirst(7))) // Remove "system:" prefix
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
                    .padding(.bottom, 10)
            } else {
                Image(imageName) // Custom image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
                    .padding(.bottom, 10)
            }

            Text(title)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).fill(Color.white))
        .shadow(radius: 5)
        .frame(maxWidth: .infinity)
    }
}
