//
//  ProfilesViewMolde.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 27.09.2023.
//

import Foundation
import SwiftUI

class ProfilesViewMolde: ObservableObject {
    
    let colums:[GridItem] = [GridItem(.flexible()),GridItem(.flexible()),]
    
    let sectiondAvatar: [String] = ["Avatar1","Avatar2","Avatar3"]
    
    @Published var imageProfiles: UIImage?
    @Published var savedimages: Bool = false

    var sectideFrmeWork: AvatarMolde? {
           didSet {
               isShowingDetilesView = true
           }
       }
       
       @Published var isShowingDetilesView = false
    
    
    func saveImage(imageName: String, image: UIImage,key: String) {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let fileName = imageName
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 1) else { return }

        do {
            try data.write(to: fileURL)
            UserDefaults.standard.set(fileURL, forKey: key)
            savedimages = true
        } catch {
            print("Unable to write image data to disk", error)
        }
    }
    
    //MARK: func section Section Avatar
    
//    func locadAvatar(forKey:String) {
//        guard let fillURK = UserDefaults.standard.url(forKey: forKey) else { return }
//        do {
//            let avatar =  try Data(contentsOf: fillURK)
//            if let Avatar
//        }
//    }
    
    func loadImage(forKey: String) {
        guard let fileURL = UserDefaults.standard.url(forKey: forKey) else { return }
        do {
            let imageData = try Data(contentsOf: fileURL)
            if let uiImage = UIImage(data: imageData) {
                self.imageProfiles = uiImage
            } else {
                print("Unable to convert data to UIImage")
            }
        } catch {
            print("Unable to load image data from disk", error)
        }
    }
}


extension NSNotification.Name {
    static let saveVenueProfileImage = Notification.Name("imagePrilesKeySaved")
    static let saveVenueBackgroundImage = Notification.Name("saveVenueBackgroundImage")
}
