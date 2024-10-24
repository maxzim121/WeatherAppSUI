//
//  LoadingView.swift
//  WeatherAppSUI
//
//  Created by Maksim Zimens on 21.10.2024.
//

import SwiftUI

struct LoadingView: View {
    
    @ObservedObject var viewModel: WeatherViewModel = WeatherViewModel()
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
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
        .alert(isPresented: $viewModel.failed) {
            Alert(
                title: Text("Failed to fetch weather data."),
                message: Text("Check your connection and VPN settings."),
                dismissButton: .default(Text("Try again")) {
                    viewModel.tryAgainButtonTapped()
                    viewModel.failed = false
                }
            )
        }
    }
}

// MARK: - Preview

#Preview {
    LoadingView(viewModel: WeatherViewModel())
}
