import SwiftUI

struct StudentDashboard: View {
    @State private var showingEditProfile = false
    @State private var showingUploadFile = false
    @State private var showingAssignmentList = false
    @State private var showingAttendance = false
    var studentId: String

    var body: some View {
        NavigationStack {
           
            VStack(spacing: 20) {
                Spacer()
                HStack(spacing: 20) {
                    Button(action: {
                        showingAssignmentList = true
                    }) {
                        DashboardButtonView(imageName: "uploadIc", title: "View Assignment")
                    }
                    .sheet(isPresented: $showingAssignmentList) {
                        AssignmentListView()
                    }

                    Button(action: {
                        showingUploadFile = true
                    }) {
                        DashboardButtonView(imageName: "uploadIc", title: "Upload Assignment")
                    }
                    .sheet(isPresented: $showingUploadFile) {
                        StudentUploadView(uploaderRole: "Student")
                    }
                }
                
                HStack(spacing: 20) {
                    Button(action: {
                        showingAttendance = true
                    }) {
                        DashboardButtonView(imageName: "attendenceIc", title: "View Attendance")
                    }
                    .sheet(isPresented: $showingAttendance) {
                        StudentAttendanceView(studentId: studentId)
                    }
                    
                    Button(action: {
                        showingEditProfile = true
                    }) {
                        DashboardButtonView(imageName: "system:person.fill", title: "Edit Profile")
                    }
                    .sheet(isPresented: $showingEditProfile) {
                        StudentEditProfileView()
                    }
                }
                Spacer()
            }
            .padding()
            .background(Color.white.ignoresSafeArea())
            .navigationTitle("Student Dashboard")
            .navigationBarBackButtonHidden(true)
            .onAppear {
                // Debug print to check studentId
                print("StudentDashboard studentId: \(studentId)")
            }
        }
    }
}

#Preview {
    StudentDashboard(studentId: "sampleStudentId")
}
