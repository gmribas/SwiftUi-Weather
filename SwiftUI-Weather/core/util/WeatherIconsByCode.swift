//
//  WeatherIconsByCode.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 24/09/23.
//

import Foundation
import SwiftUI
import OSLog

struct WeatherIconsByCode {
    
    static func getIconByCode(_ code: Int, forceNight: Binding<Bool>) -> String {
        var value: String? = nil
        
        if forceNight.wrappedValue {
            value = getNightIconByItsDayCode(code)
        }
        
        if value == nil {
            value = getDayIconByCode(code)
        }
        
        if value == nil {
            value = getNightIconCode(code)
        }
        
        let result = value ?? "exclamationmark.octagon.fill" //an ellegant way to show that the current icon has not been found ;)
        
        if (result == "exclamationmark.octagon.fill") {
            Logger.statistics.error("Weather code not found \(code)")
        }
        
        return result
    }
    
    private static func getDayIconByCode(_ code: Int) -> String? {
        return switch code {
        case 1000: "sun.max.fill"
        case 1003: "cloud.sun"
        case 1006: "cloud.fill"
        case 1030: "sun.haze.fill"
        case 1063: "sun.rain.fill"
        case 1066: "sun.snow.fill"
        case 1069, 1072: "cloud.sleet.fill"
        case 1087: "cloud.sun.bolt.fill"
        case 1114, 1117: "sun.snow.fill"
        case 1135, 1147: "cloud.fog.fill"
        case 1150, 1153, 1168: "sun.dust.fill"
        case 1171: "sun.snow.fill"
        case 1180, 1183, 1186, 1189: "cloud.sun.rain.fill"
        case 1192, 1195: "cloud.heavyrain.fill"
        case 1198: "sun.snow.fill"
        case 1240: "cloud.sun.rain.fill"
        default: nil
        }
    }
    
    private static func getNightIconByItsDayCode(_ code: Int) -> String? {
        return switch code {
        case 1000: getNightIconCode(113)
        case 1003: getNightIconCode(116)
        case 1006: getNightIconCode(119)
        case 1030: getNightIconCode(143)
        case 1063: getNightIconCode(176)
        case 1066: getNightIconCode(179)
        case 1069, 1072: getNightIconCode(182)
        case 1087: getNightIconCode(200)
        case 1114, 1117: getNightIconCode(227)
        case 1135, 1147: getNightIconCode(248)
        case 1150, 1153, 1168: getNightIconCode(263)
        case 1171: getNightIconCode(284)
        case 1180, 1183, 1186, 1189: getNightIconCode(293)
        case 1192, 1195: getNightIconCode(305)
        case 1240: getNightIconCode(353)
        default: nil
        }
    }
    
    private static func getNightIconCode(_ code: Int) -> String? {
        return switch code {
        case 113: "moon.fill"
        case 116: "cloud.moon"
        case 119: "cloud.fill"
        case 143: "moon.haze.fill"
        case 176: "cloud.drizzle.fill"
        case 179: "cloud.snow.fill"
        case 182, 185: "cloud.sleet.fill"
        case 200: "cloud.moon.bolt.fill"
        case 227, 230: "cloud.snow.fill"
        case 248, 260: "cloud.fog.fill"
        case 263, 266, 281: "moon.dust.fill"
        case 284: "cloud.snow.fill"
        case 293, 296, 299, 302: "cloud.moon.rain.fill"
        case 305, 308: "cloud.heavyrain"
        case 311: "cloud.snow.fill"
        case 353: "cloud.moon.rain.fill"
        default: nil
        }
    }
    
}

/**
 code,day,night,icon
 X 1000,Sunny,Clear,113
 X 1003,"Partly cloudy","Partly cloudy",116
 X 1006,Cloudy,Cloudy,119
 1009,Overcast,Overcast,122
 X 1030,Mist,Mist,143
 X 1063,"Patchy rain possible","Patchy rain possible",176
 X 1066,"Patchy snow possible","Patchy snow possible",179
 X 1069,"Patchy sleet possible","Patchy sleet possible",182
 X 1072,"Patchy freezing drizzle possible","Patchy freezing drizzle possible",185
 X 1087,"Thundery outbreaks possible","Thundery outbreaks possible",200
 X 1114,"Blowing snow","Blowing snow",227
 X 1117,Blizzard,Blizzard,230
 X 1135,Fog,Fog,248
 X 1147,"Freezing fog","Freezing fog",260
 X 1150,"Patchy light drizzle","Patchy light drizzle",263
 X 1153,"Light drizzle","Light drizzle",266
 X 1168,"Freezing drizzle","Freezing drizzle",281
 X 1171,"Heavy freezing drizzle","Heavy freezing drizzle",284
 X 1180,"Patchy light rain","Patchy light rain",293
 X 1183,"Light rain","Light rain",296
 X 1186,"Moderate rain at times","Moderate rain at times",299
 X1189,"Moderate rain","Moderate rain",302
 X1192,"Heavy rain at times","Heavy rain at times",305
 X1195,"Heavy rain","Heavy rain",308
 X 1198,"Light freezing rain","Light freezing rain",311
 1201,"Moderate or heavy freezing rain","Moderate or heavy freezing rain",314
 1204,"Light sleet","Light sleet",317
 1207,"Moderate or heavy sleet","Moderate or heavy sleet",320
 1210,"Patchy light snow","Patchy light snow",323
 1213,"Light snow","Light snow",326
 1216,"Patchy moderate snow","Patchy moderate snow",329
 1219,"Moderate snow","Moderate snow",332
 1222,"Patchy heavy snow","Patchy heavy snow",335
 1225,"Heavy snow","Heavy snow",338
 1237,"Ice pellets","Ice pellets",350
 X 1240,"Light rain shower","Light rain shower",353
 1243,"Moderate or heavy rain shower","Moderate or heavy rain shower",356
 1246,"Torrential rain shower","Torrential rain shower",359
 1249,"Light sleet showers","Light sleet showers",362
 1252,"Moderate or heavy sleet showers","Moderate or heavy sleet showers",365
 1255,"Light snow showers","Light snow showers",368
 1258,"Moderate or heavy snow showers","Moderate or heavy snow showers",371
 1261,"Light showers of ice pellets","Light showers of ice pellets",374
 1264,"Moderate or heavy showers of ice pellets","Moderate or heavy showers of ice pellets",377
 1273,"Patchy light rain with thunder","Patchy light rain with thunder",386
 1276,"Moderate or heavy rain with thunder","Moderate or heavy rain with thunder",389
 1279,"Patchy light snow with thunder","Patchy light snow with thunder",392
 1282,"Moderate or heavy snow with thunder","Moderate or heavy snow with thunder",395

 */
