//
//  AddPeopleView.swift
//  Tutor App
//
//  Created by Muthu on 02/08/24.
//

import SwiftUI

struct AddPeopleView: View {
    var body: some View {
        VStack {
            Text("Tutor Connect")
                .font(.title)
                .padding()

            Spacer()

            Text("Add Student Or Parent")
                .font(.headline)
                .padding()

            Button(action: {
                // Handle button tap
            }) {
                Text("Add Student")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            Button(action: {
                // Handle button tap
            }) {
                Text("Add Parent")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            Spacer()
            Spacer()
        }
    }
}

#Preview {
    AddPeopleView()
}
