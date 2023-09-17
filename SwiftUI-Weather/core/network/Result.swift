//
//  Result.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 16/09/23.
//
enum Result<T, E> {
    case success(T)
    case failure(E)
}
