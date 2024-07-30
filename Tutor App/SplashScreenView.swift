//
//  SplashScreenView.swift
//  Tutor App
//
//  Created by Midhun on 17/07/24.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        ZStack {
            Image("logoIc")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .opacity(0.3)
        }
    }
}

#Preview {
    SplashScreenView()
}
