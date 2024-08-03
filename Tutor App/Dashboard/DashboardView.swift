//
//  DashboardView.swift
//  Tutor App
//
//  Created by Muthu on 17/07/24.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.white // Background color for entire view
                VStack {
                    Spacer()
                    VStack(spacing: 50) {
                        // Button for Tutor options
                        NavigationLink(destination: TutorSignUpView()) {
                            VStack {
                                Image("tutorIc")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 60, height: 50)
                                Text("Tutor")
                                    .font(.system(size: 24).weight(.bold))
                                    .foregroundColor(.black)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.2)))
                        .padding(.horizontal, 50)

                        // Button for Student options
                        NavigationLink(destination: StudentSignUpView()) {
                            VStack {
                                Image("studentIc")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 45, height: 45)
                                Text("Student")
                                    .font(.system(size: 24).weight(.bold))
                                    .foregroundColor(.black)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.2)))
                        .padding(.horizontal, 50)

                        // Button for Parent options
                        NavigationLink(destination: ParentSignUpView()) {
                            VStack {
                                Image("parentIc")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 60, height: 50)
                                Text("Parent")
                                    .font(.system(size: 24).weight(.bold))
                                    .foregroundColor(.black)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.2)))
                        .padding(.horizontal, 50)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(Color.white)

                    Spacer()
                }
            }
        }
    }
}

#Preview {
    DashboardView()
}
