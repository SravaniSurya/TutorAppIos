//
//  Studentdashboard.swift
//  Tutor App
//
//  Created by Muthu on 17/07/24.
//

import SwiftUI

struct StudentDashboard: View {
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 20) {
                Spacer()
                Text("Student Dashboard")
                    .font(.title)
                    .padding()
                VStack(spacing: 20) {
                    HStack {
                        Spacer()
                        Button(action: {
                            print("View Assignment Tapped")
                        }) {
                            VStack {
                                Image("uploadIc")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 60, height: 50)
                                Text("View Assignment")
                                    .font(.system(size: 20).weight(.bold))
                                    .foregroundColor(.black)
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.2)))
                            .frame(width: geometry.size.width * 0.4)
                        }
                        Spacer()
                        
                        Button(action: {
                            print("Upload Assignment Tapped")
                        }) {
                            VStack {
                                Image("uploadIc")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 60, height: 50)
                                Text("Upload Assignment")
                                    .font(.system(size: 20).weight(.bold))
                                    .foregroundColor(.black)
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.2)))
                            .frame(width: geometry.size.width * 0.4)
                        }
                        Spacer()
                    }
                }
                .padding()
                Button(action: {
                    print("Upload Assignment Tapped")
                }) {
                    VStack {
                        Image("uploadIc")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height: 50)
                        Text("Upload Assignment")
                            .font(.system(size: 20).weight(.bold))
                            .foregroundColor(.black)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.2)))
                    .frame(width: geometry.size.width * 0.4)
                }

                
                Spacer()
            }
        }
    }
}

#Preview {
    StudentDashboard()
}
