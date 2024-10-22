//
//  LoadingView.swift
//  WeatherAppSUI
//
//  Created by Maksim Zimens on 21.10.2024.
//

import SwiftUI

struct LoadingView: View {
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            // : Background View
            LinearGradient(
                colors: [
                    .purple,
                    .cyan
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            
            VStack(spacing: 20) {
                ProgressView()
                    .tint(Color.indigo)
                Text("Loading data...")
                    .font(.title)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    LoadingView()
}
