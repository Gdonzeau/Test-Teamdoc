//
//  APIErrors.swift
//  Test_TeamDoc
//
//  Created by Guillaume Donzeau on 02/06/2022.
//

import Foundation

enum APIErrors: String, LocalizedError {
    
    case noData = "No data"
    case noError = "There is no error." // Pour les tests unitaires
    case decodingError = "Decoding Error."
    case invalidURL = "Not the right adress."
    case invalidStatusCode = "Status invalid"
    case errorGenerated = "Error generated"
    case nothingIsWritten = "You must write something correct"
    
    var errorDescription: String? {
        switch self {
        case .noData:
            return "Aucune donnée n'est renvoyée."
        case .noError:
            return "Tout va bien, pas d'erreur."
        case .decodingError:
            return "Le fichier renvoyé est endommagé."
        case .invalidURL:
            return "L'adresse internet est non conforme."
        case .invalidStatusCode:
            return "Le statut est invalide."
        case .errorGenerated:
            return "Erreur au moment de la requête réseau."
        case .nothingIsWritten:
            return "Vous devez écrire quelque chose."
        }
    }
    var failureReason: String? {
        switch self {
        case .noData:
            return "Pas de données"
        case .noError:
            return "Pas d'erreur"
        case .decodingError:
            return "Erreur au décodage"
        case .invalidURL:
            return "Mauvaise adresse"
        case .invalidStatusCode:
            return "Statut invalide"
        case .errorGenerated:
            return "Erreur requête réseau"
        case .nothingIsWritten:
            return "Rien d'inscrit"
        }
    }
}
