//
//  ProfilesViewMolde.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 27.09.2023.
//

import Foundation
import SwiftUI

class ProfilesViewMolde: ObservableObject {
    
    var avaer: [String] = ["Avatar","Avatar2","Avatar3","Avatar4","Avatar5","Avatar6","Avatar7","Avatar8","Avatar9","Avatar10"]
    
    let colums:[GridItem] = [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible()),]
    
    @Published var SectionImages: sectionImage = .images

    @Published var nameUser: String = ""
    @Published var userName: String = ""
    
    
    @Published var imageProfiles: UIImage?
    @Published var savedimages: Bool = false


    @Published var isShowingDetilesView = false
    
    var averageColor: Color {
        Color(imageProfiles?.averageColor ?? UIColor.clear)
    }
    
    func retrieveText() {
        if let savednameUser = UserDefaults.standard.string(forKey: "nameUserforKey")   {
            nameUser = savednameUser
        }
        if let saveduserName = UserDefaults.standard.string(forKey: "userNameforKey"){
            userName = saveduserName
        }
        
    }
    func saveInfo() {
        UserDefaults.standard.set(nameUser, forKey: "nameUserforKey")
        UserDefaults.standard.set(userName, forKey: "userNameforKey")
    }
    
    
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
    
    func iterateOverAuthors(authors: [String]) -> String? {
        for author in avaer {
                  return author
        }
            return nil
    }
    @Published private(set) var user: AuthDataResultModel? = nil
    
    func loadCurrentUser()  throws {
        self.user = try AuthenticationManger.shered.getAuthenticationUser()
    }
}


extension NSNotification.Name {
    static let saveVenueProfileImage = Notification.Name("imagePrilesKeySaved")
//    static let saveVenueBackgroundImage = Notification.Name("saveVenueBackgroundImage")
}

enum sectionImage {
    case images
    case avater
}
