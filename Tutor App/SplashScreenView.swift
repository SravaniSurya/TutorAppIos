//
//  SplashScreenView.swift
//  Tutor App
//
//  Created by Muthu on 17/07/24.
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
