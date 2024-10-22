//
//  ContentView.swift
//  WeatherAppSUI
//
//  Created by Maksim Zimens on 21.10.2024.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    
    @StateObject var viewModel: WeatherViewModel = WeatherViewModel(
        networkClient: NetworkClient.shared
    )
    
    // MARK: - Body
    var body: some View {
        if viewModel.isLoading {
            LoadingView()
        } else {
            WeatherView(viewModel: viewModel)
        }
        
    }
}

// MARK: - Preview

#Preview {
    ContentView()
}
