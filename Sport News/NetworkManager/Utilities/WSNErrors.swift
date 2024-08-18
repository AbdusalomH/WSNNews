//
//  WSNErrors.swift
//  Sport News
//
//  Created by Abdusalom on 30/07/2024.
//

import Foundation


enum WSNErrors: String, Error {
    
    case invalidUsername    = "This user name is invalid, Please try again"
    case unableToComplete   = "Unable to complete you request, Please check your internet"
    case invalidResponse    = "Bad response from server, please try again"
    case invalidData        = "no data available on server, please check again"
    case unableToFavortie   = "There was an error favoriting this user. Please try again later"
    case alreadyInFavorites = "You are already favorited this user"
    
}
