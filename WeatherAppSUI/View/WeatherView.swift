//
//  WeatherView.swift
//  WeatherAppSUI
//
//  Created by Maksim Zimens on 21.10.2024.
//

import SwiftUI

struct WeatherView: View {
    
    // MARK: - Properties
    @StateObject var viewModel: WeatherViewModel = WeatherViewModel()
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .leading) {
            LinearGradient(
                colors: [
                    .purple,
                    .cyan
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                HStack {
                    
                    Button {
                        viewModel.locationManager.getCurrentLocation()
                    } label: {
                        Image(systemName: "arrow.clockwise.circle.fill")
                            .font(.system(size: 30))
                            .fontWeight(.heavy)
                    }
                    
                    Spacer()
                }
                .tint(.black)
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("\(viewModel.name)")
                        .font(.system(size: 500, weight: .bold))
                        .minimumScaleFactor(0.1)
                        .lineLimit(2)
                    HStack {
                        Text("\(viewModel.temp)°")
                            .font(.system(size: 100,weight: .bold))
                        Text(WeatherIcon.getWeatherIcon(condition:viewModel.conditionId))
                            .font(.system(size: 100,weight: .regular))
                    }

                }
                
                                
                Spacer()
                
            }
            .padding()
        }
    }
}

// MARK: - Preview

#Preview {
    WeatherView(viewModel: WeatherViewModel())
}
