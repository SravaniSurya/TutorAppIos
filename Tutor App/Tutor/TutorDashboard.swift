import SwiftUI

struct TutorDashboard: View {
    @State private var showUploadStorageView = false
    @State private var showEditProfileView = false
    @State private var showAssignmentListView = false
    @State private var showAttendanceView = false // State for showing the TutorAttendanceView

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Top row with assignment and upload buttons
                HStack(spacing: 20) {
                    Button(action: {
                        showAssignmentListView.toggle()
                    }) {
                        DashboardButtonView(imageName: "uploadIc", title: "View Assignment")
                    }
                    .sheet(isPresented: $showAssignmentListView) {
                        AssignmentListView()
                    }

                    Button(action: {
                        showUploadStorageView.toggle()
                    }) {
                        DashboardButtonView(imageName: "noteIc", title: "Upload Assignment")
                    }
                    .sheet(isPresented: $showUploadStorageView) {
                        UploadStorageView()
                    }
                }

                // Bottom row with view attendance and edit profile buttons
                HStack(spacing: 20) {
                    Button(action: {
                        showAttendanceView.toggle() // Toggle state to show TutorAttendanceView
                    }) {
                        DashboardButtonView(imageName: "attendenceIc", title: "Attendance Note")
                    }
                    .sheet(isPresented: $showAttendanceView) {
                        TutorAttendanceView() // Present TutorAttendanceView
                    }

                    Button(action: {
                        showEditProfileView.toggle()
                    }) {
                        DashboardButtonView(imageName: "system:person.crop.circle.fill", title: "Edit Profile") // System icon example
                    }
                    .sheet(isPresented: $showEditProfileView) {
                        EditProfileView()
                    }
                }
            }
            .padding()
            .background(Color.white.ignoresSafeArea()) // Background color
            .navigationTitle("Tutor Dashboard")
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    TutorDashboard()
}
