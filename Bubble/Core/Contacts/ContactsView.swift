//
//  ContactsView.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 26.10.2023.
//

import SwiftUI
import CoreData
import Contacts
import LinkPresentation


struct ContactsView: View {
    
    @ObservedObject var contacts = FetchedContacts()
    
    @State private var pick = false
    @State private var searchText: String = ""
    @Binding var dismiss : Bool
    private let photo = Image("LogoApp")
    @StateObject var vmProfie = ProfilesViewMolde()
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [vmProfie.averageColor,Color.them.Colorblack,Color.them.Colorblack,Color.them.Colorblack,Color.them.Colorblack], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack {
                    Button(action: {dismiss.toggle()}){
                        HStack {
                            Text("Contacts")
                                .font(.system(size: 25,weight: .bold))
                                .foregroundStyle(Color.them.ColorblackSwich)
                            Spacer()
                            Image(systemName: "xmark")
                                .font(.system(size: 18,weight: .semibold))
                                .foregroundStyle(Color.them.ColorblackSwich)
                        }
                    }.padding(.all)
                    
                    SearchBar(text: $searchText)
                    
                    ScrollView {
                        ForEach(contacts.contacts.filter {
                            searchText.isEmpty ? true : ($0.firstName + " " + $0.lastName).lowercased().contains(searchText.lowercased())
                        }) { contact in
                            VStack(alignment: .leading){
                                HStack {
                                    Text(contact.firstName)
                                    Text(contact.lastName)
                                    Spacer()
                                    ShareLink(item: photo, preview: SharePreview("Bubble", image: photo)){
                                        Text("Add")
                                            .font(.system(size: 14,weight: .semibold))
                                            .foregroundStyle(Color.them.ColorblackSwich)
                                            .frame(height: 40)
                                            .padding(.horizontal)
                                            .background(
                                                RoundedRectangle(cornerRadius: 22)
                                                    .stroke(lineWidth: 2.5)
                                                    .foregroundStyle(Color.them.ColorOrange)
                                                    .clipShape(.rect(cornerRadius: 22))
                                            )
                                    }
                                }
                            }.padding(.horizontal)
                                .padding(.vertical,5)
                        }
                    }
                }
                .onAppear {
                    DispatchQueue.main.async {
                        contacts.fetchContacts()
                    }
                    vmProfie.loadImage(forKey: "imagePrilesKeySaved")
                }
            }
        }
        
    }
    func actionSheet() {
        guard let urlShare = URL(string: "https://developer.apple.com/xcode/swiftui/") else { return }
        let activityVC = UIActivityViewController(activityItems: [urlShare], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
    }
}

#Preview {
    ContactsView(dismiss: .constant(false))
}

    
    struct Contact: Identifiable, Hashable {
        var id = UUID()
        var firstName: String //= "No firstName"
        var lastName: String //= "No lastName"
        var phoneNumbers: [String] //= []
        var emailAddresses: [String]// = []
        
    }
    
    class FetchedContacts: ObservableObject, Identifiable {
        
        @Published var contacts = [Contact]()
        
        func fetchContacts() {
            contacts.removeAll()
            let store = CNContactStore()
            store.requestAccess(for: .contacts) { (granted, error) in
                if let error = error {
                    print("failed to request access", error)
                    return
                }
                if granted {
                    let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactEmailAddressesKey]
                    let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                    do {
                        try store.enumerateContacts(with: request, usingBlock: { (contact, stopPointer) in
                            
                            //       DispatchQueue.main.async {
                            self.contacts.append(Contact(firstName: contact.givenName, lastName: contact.familyName, phoneNumbers: contact.phoneNumbers.map { $0.value.stringValue }, emailAddresses: contact.emailAddresses.map { $0.value as String }
                                                        ))
                            
                            self.contacts.sort(by: { $0.firstName < $1.firstName })
                            //     }
                        })
                        
                    } catch let error {
                        print("Failed to enumerate contact", error)
                    }
                    
                } else {
                    print("access denied")
                }
            }
        }
    }
    
    struct SearchBar: UIViewRepresentable {
        
        @Binding var text: String
        
        class Coordinator: NSObject, UISearchBarDelegate {
            
            @Binding var text: String
            
            init(text: Binding<String>) {
                _text = text
            }
            
            func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
                if searchText != "" {
                    searchBar.showsCancelButton = true
                }
                text = searchText
                
            }
            
            func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
                searchBar.text = ""
                searchBar.resignFirstResponder()
                searchBar.showsCancelButton = false
                text = ""
            }
            
        }
        
        func makeCoordinator() -> SearchBar.Coordinator {
            return Coordinator(text: $text)
        }
        
        func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
            let searchBar = UISearchBar(frame: .zero)
            searchBar.delegate = context.coordinator
            searchBar.searchBarStyle = .minimal
            searchBar.autocapitalizationType = .none
            return searchBar
        }
        
        func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
            uiView.text = text
        }
        
    }



extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct DetailedContactView: View {
    
    var contact: Contact
    
    var body: some View {
        VStack{
            HStack{
                Text(contact.firstName)
                Text(contact.lastName)
            }
            ForEach(contact.phoneNumbers, id:\.self) { number in
                Text(number)
            }
            ForEach(contact.emailAddresses, id:\.self) { email in
                Text(email)
            }
        }
    }
}
