//
//  DataPersistenceManager.swift
//  NetflixClone
//
//  Created by MOHAMED ABD ELHAMED AHMED on 04/04/2022.
//

import Foundation
import UIKit
import CoreData


class DataPersistenceManager {
    
    enum DataBaseError: Error {
        case failedToSavedata
        case failedToFeatchData
        case feildToDeleteData
    }
    
    static let shared = DataPersistenceManager()
    
    private init() {
    }
    
    func downloadTitleWith(model: Titles, completion: @escaping (Result<Void, Error>) -> Void ) {
        guard let appDelegate =  UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let item = TitleItem(context: context)
        item.originalTitle  = model.originalTitle
        item.id = Int64(model.id ?? 0)
        item.originalName = model.originalName
        item.overview = model.overview
        item.mediaType = model.mediaType
        item.posterPath = model.posterPath
        item.releaseDate  = model.releaseDate
        item.voteCount = Int64(model.voteCount ?? 0)
        item.voteAverage = model.voteAverage ?? 0.0
          
        do {
            try context.save()
            completion(.success(()))
        } catch(let error) {
            print(error.localizedDescription)
            completion(.failure(DataBaseError.failedToSavedata ))
        }
    }
    
    func featchingTitleFromData(completion: @escaping (Result<[TitleItem], Error>) -> Void) {
        guard let appDelegate =  UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let request: NSFetchRequest<TitleItem>
        request = TitleItem.fetchRequest()
        do {
           let titles = try context.fetch(request)
            completion(.success(titles))
        } catch {
            print(error.localizedDescription)
            completion(.failure(DataBaseError.failedToFeatchData))
        }
    }
    
    func deleteTitlWith(model: TitleItem, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let appDelegate =  UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        context.delete(model) // asking data bath to delete certain object
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DataBaseError.feildToDeleteData))
        }
    }
}
