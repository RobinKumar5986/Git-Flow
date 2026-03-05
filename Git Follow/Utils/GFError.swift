//
//  GFError.swift
//  Git Follow
//
//  Created by iOS Dev on 04/02/26.
//


enum GFError: String, Error {
    case invalidRequest = "This user create an invalid request.Please try again."
    case completionError = "Unable to complete you request.Please Check your connection and try again."
    case fetchError = "Failed to fetch data. Please Try Again."
    case nullDataError = "No Data recived from the server"
    case parsingError = "Unable to decode the data please try again after some time."
    case unableToFavorite = "There was an error favoriting this user. Please try again."
    case alreadyExist = "The User already exists in the favorites list."
}

