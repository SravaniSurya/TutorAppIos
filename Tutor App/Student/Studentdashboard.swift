import SwiftUI

struct StudentDashboard: View {
    @State private var showingEditProfile = false
    @State private var showingUploadFile = false
    @State private var showingAssignmentList = false // State to control the presentation of AssignmentListView

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Top row with assignment buttons
                HStack(spacing: 20) {
                    // View Assignment Button
                    Button(action: {
                        showingAssignmentList = true
                    }) {
                        DashboardButtonView(imageName: "uploadIc", title: "View Assignment")
                    }
                    .sheet(isPresented: $showingAssignmentList) {
                        AssignmentListView()
                    }

                    // Upload Assignment Button
                    Button(action: {
                        showingUploadFile = true
                    }) {
                        DashboardButtonView(imageName: "uploadIc", title: "Upload Assignment")
                    }
                    .sheet(isPresented: $showingUploadFile) {
                        StudentUploadView()
                    }
                }
                
                // Edit Profile Button
                Button(action: {
                    showingEditProfile = true
                }) {
                    DashboardButtonView(imageName: "system:person.fill", title: "Edit Profile") // System icon example
                }
                .sheet(isPresented: $showingEditProfile) {
                    StudentEditProfileView()
                }
                
                Spacer()
            }
            .padding()
            .background(Color.white.ignoresSafeArea()) // Background color
            .navigationTitle("Student Dashboard")
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    StudentDashboard()
}
