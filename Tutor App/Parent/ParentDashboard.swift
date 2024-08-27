import SwiftUI

struct ParentDashboard: View {
    
    @State private var isAttendanceSheetPresented = false
    @State private var isEditProfileSheetPresented = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                VStack {
                    // View Attendance Button
                    Button(action: {
                        isAttendanceSheetPresented = true
                    }) {
                        HStack {
                            Image(systemName: "list.bullet") // Example icon
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .foregroundColor(.blue)
                            
                            Text("View Attendance")
                                .font(.headline)
                                .foregroundColor(.primary)
                        }
                        .padding()
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(10)
                    }
                    .sheet(isPresented: $isAttendanceSheetPresented) {
                        ParentViewAttendanceView()
                    }
                    
                    // Edit Profile Button
                    Button(action: {
                        isEditProfileSheetPresented = true
                    }) {
                        HStack {
                            Image(systemName: "pencil") // Example icon
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .foregroundColor(.green)
                            
                            Text("Edit Profile")
                                .font(.headline)
                                .foregroundColor(.primary)
                        }
                        .padding()
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(10)
                    }
                    .sheet(isPresented: $isEditProfileSheetPresented) {
                        EditProfileView()
                    }
                }
                .padding()
                
                Spacer()
            }
            .navigationTitle("Parent Dashboard")
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    ParentDashboard()
}
