import SwiftUI

struct TutorDashboard: View {
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack(spacing: 20) {
                    Spacer()
                    Text("Tutor Dashboard")
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
                                        .font(.system(size: 20).weight(.bold))
                                        .foregroundColor(.black)
                                }
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.2)))
                                .frame(width: geometry.size.width * 0.4)
                                Spacer()
                            }
                            
                            NavigationLink(destination: UploadStorageView()) {
                                VStack {
                                    Image("noteIc")
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
                        
                        HStack {
                            Spacer()
                            Button(action: {
                                print("Button Tapped")
                            }) {
                                VStack {
                                    Image("noteIc")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 60, height: 50)
                                    Text("Upload Notes")
                                        .font(.system(size: 20).weight(.bold))
                                        .foregroundColor(.black)
                                }
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.2)))
                                .frame(width: geometry.size.width * 0.4)
                                Spacer()
                            }
                            
                            Button(action: {
                                print("Button Tapped")
                            }) {
                                VStack {
                                    Image("studentIc")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 60, height: 50)
                                    Text("Add People")
                                        .font(.system(size: 20).weight(.bold))
                                        .foregroundColor(.black)
                                }
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.2)))
                                .frame(width: geometry.size.width * 0.4)
                            }
                            Spacer()
                        }
                        
                        HStack {
                            Spacer()
                            Button(action: {
                                print("Button Tapped")
                            }) {
                                VStack {
                                    Image("attendenceIc")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 60, height: 50)
                                    Text("View Attendance")
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
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(Color.white)
                    .padding(.horizontal, 20)
                    Spacer()
                }   
                .frame(width: geometry.size.width, height: geometry.size.height)
                .background(Color.white)
            }
        }
    }
}

#Preview {
    TutorDashboard()
}
