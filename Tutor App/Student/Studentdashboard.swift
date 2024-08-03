//
//  Studentdashboard.swift
//  Tutor App
//
//  Created by Muthu on 17/07/24.
//

import SwiftUI
import Firebase

struct StudentDashboard: View {
    @State private var showAssignmentList = false
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack(spacing: 20) {
                    Spacer()
                    Text("Student Dashboard")
                        .font(.title)
                        .padding()
                    
                    
                    VStack(spacing: 20) {
                        HStack {
                            Spacer()
                            NavigationLink(destination: AssignmentListView()) {
                                VStack {
                                    Image("uploadIc")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 60, height: 50)
                                    Text("View Assignment")
                                        .font(.system(size: 35).weight(.bold))
                                        .foregroundColor(.black)
                                }
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.2)))
                                .frame(width: geometry.size.width * 0.4)
                            }
                            Spacer()
                            
                            Button(action: {
                                // Handle upload action if needed
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
                    
                    Spacer()
                }
            }
            .navigationBarTitle("Student Dashboard", displayMode: .inline)
        }
    }
}

#Preview {
    StudentDashboard()
}
