//
//  CurrentWeatherSourceImpl.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 16/09/23.
//

import Foundation

struct CurrentWeatherSourceImpl: CurrentWeatherSource {
    
    @Dependency<BaseRepository> private var repository: BaseRepository
    
    private let endpoint = CurrentWeatherEndpoint()
    
    func getCurrentWeather(location: String) -> Result<CurrentConditionResponse?, MyError> {
        async {
            let result: Result<CurrentConditionResponse?, MyError> = await repository.execute(endpoint: endpoint, pathToDecode: nil)
            
            switch result {
            case .success(let CurrentConditionResponse):
            case .failure(let error):
                // Handle the error.
                print(error)
            }
        }
        
    }
}
