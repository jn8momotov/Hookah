//
//  StorageService.swift
//  HookahPlaces
//
//  Created by Евгений on 16/02/2020.
//  Copyright © 2020 Momotov. All rights reserved.
//

import Foundation
import FirebaseStorage

protocol StorageService {
    func upload(_ dataImage: Data, onSuccess: VoidHandler?, onError: ErrorHandler?)
    func download(onSuccess: ((Data) -> Void)?, onError: ErrorHandler?)
    func delete(onSuccess: VoidHandler?, onError: ErrorHandler?)
}

final class StorageServiceImpl: StorageService {
    private var reference: StorageReference? {
        guard let uid = AuthorizationServiceImpl.currentUser?.uid else {
            return nil
        }
        return Storage.storage().reference().child("users/\(uid).jpg")
    }
    
    func upload(_ dataImage: Data, onSuccess: VoidHandler?, onError: ErrorHandler?) {
        guard let reference = reference else {
            onError?("Не удалось получить ваш профиль!")
            return
        }
        let uploadTask = reference.putData(dataImage, metadata: nil) { metadata, error in
            if let error = error {
                onError?(error.localizedDescription)
                return
            }
            guard let _ = metadata else {
                onError?("Не удалось сохранить изображение!")
                return
            }
            onSuccess?()
        }
        uploadTask.resume()
    }
    
    func download(onSuccess: ((Data) -> Void)?, onError: ErrorHandler?) {
        guard let reference = reference else {
            onError?("Не удалось получить ваш профиль!")
            return
        }
        let downloadTask = reference.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                onError?(error.localizedDescription)
                return
            }
            guard let data = data else {
                onError?("Не удалось сохранить изображение!")
                return
            }
            onSuccess?(data)
        }
        downloadTask.resume()
    }
    
    func delete(onSuccess: VoidHandler?, onError: ErrorHandler?) {
        guard let reference = reference else {
            onError?("Не удалось получить ваш профиль!")
            return
        }
        reference.delete { error in
            if let error = error {
                onError?(error.localizedDescription)
                return
            }
            onSuccess?()
        }
    }
}
