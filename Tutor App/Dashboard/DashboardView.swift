//
//  DashboardView.swift
//  Tutor App
//
//  Created by Midhun on 17/07/24.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.3)]),
                               startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()

                VStack {
                    Spacer()
                    VStack(spacing: 40) {
                        // Button for Tutor options
                        NavigationLink(destination: TutorSignUpView()) {
                            VStack {
                                Image("tutorIc")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 60, height: 50)
                                Text("Tutor")
                                    .font(.system(size: 22).weight(.semibold))
                                    .foregroundColor(.primary)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 15).fill(Color.white.opacity(0.7)))
                        .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
                        .padding(.horizontal, 30)

                        // Button for Student options
                        NavigationLink(destination: StudentSignUpView()) {
                            VStack {
                                Image("studentIc")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 45, height: 45)
                                Text("Student")
                                    .font(.system(size: 22).weight(.semibold))
                                    .foregroundColor(.primary)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 15).fill(Color.white.opacity(0.7)))
                        .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
                        .padding(.horizontal, 30)

                        // Button for Parent options
                        NavigationLink(destination: ParentSignUpView()) {
                            VStack {
                                Image("parentIc")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 60, height: 50)
                                Text("Parent")
                                    .font(.system(size: 22).weight(.semibold))
                                    .foregroundColor(.primary)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 15).fill(Color.white.opacity(0.7)))
                        .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
                        .padding(.horizontal, 30)
                    }
                    .padding(.vertical, 20)

                    Spacer()
                }
            }
        }
    }
}

#Preview {
    DashboardView()
}
