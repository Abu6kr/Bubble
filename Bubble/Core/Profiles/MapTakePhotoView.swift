//
//  MapTakePhotoView.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 07.11.2023.
//

import SwiftUI
import MapKit

struct MapTakePhotoView: View {

    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 56.840506, longitude: 60.659330), span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))

    let moldeTakePhoto = [
        MoldeTakePhoto(image: "Story1", coordinate: .init(latitude: 56.835076, longitude: 60.643591)),
        MoldeTakePhoto(image: "Story2", coordinate: .init(latitude: 56.839771, longitude: 60.652180)),
        MoldeTakePhoto(image: "Story3", coordinate:  .init(latitude: 56.834513, longitude: 60.645652)),
    ]
    @StateObject var vmMap = MapMoldeView()
    
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: moldeTakePhoto) { item in
            MapAnnotation(coordinate: item.coordinate) {
                ZStack(alignment: .bottom) {
                    
                    Image(systemName: "arrowtriangle.down.fill")
                        .font(.system(size: 22,weight: .semibold))
                        .foregroundStyle(Color.white)
                        .offset(y: 18)
                    
                    Image(item.image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .clipShape(.rect(cornerRadius: 15))
                        .padding(5)
                        .background(Color.white)
                        .clipShape(.rect(cornerRadius: 15))
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        
    }
}

#Preview {
    MapTakePhotoView()
}


//MARK: Take photo save inmape
struct MoldeTakePhoto: Identifiable {
    let id = UUID().uuidString
    let image: String
    var coordinate: CLLocationCoordinate2D
}


//
//struct MapTakePhotoViewMoldeTbe: View {
//    @State private var image: UIImage? // To store the captured image
//    @State private var selectedLocations: [CLLocationCoordinate2D] = [] // To store the photo locations
//    
//    var body: some View {
//        VStack {
//            Button(action: {
//                takePhoto()
//            }) {
//                Text("Take Photo")
//                    .font(.title)
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
//            .padding()
//            
//            MapTakePhotoView2(locations: $selectedLocations, annotationImages: [image])
//                .edgesIgnoringSafeArea(.all)
//                .frame(height: 400)
//        }
//    }
//    
//    private func takePhoto() {
//        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
//            print("Camera not available")
//            return
//        }
//        
//        let imagePicker = UIImagePickerController()
//        imagePicker.sourceType = .camera
////        imagePicker.delegate = context.coordinator
//        
//        // Present the image picker
//        UIApplication.shared.windows.first?.rootViewController?.present(imagePicker, animated: true, completion: nil)
//    }
//}
//
//
//struct MapTakePhotoView2: UIViewRepresentable {
//    @Binding var locations: [CLLocationCoordinate2D]
//    var annotationImages: [UIImage?]
//    
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//    
//    func makeUIView(context: Context) -> MKMapView {
//        MKMapView()
//    }
//    
//    func updateUIView(_ uiView: MKMapView, context: Context) {
//        uiView.delegate = context.coordinator
//        
//        // Remove previous annotations from the map
//        uiView.removeAnnotations(uiView.annotations)
//        
//        // Add new annotations based on the captured photo locations
//        for i in 0..<locations.count {
//            let annotation = MKPointAnnotation()
//            annotation.coordinate = locations[i]
//            annotation.title = "Photo \(i + 1)"
//            uiView.addAnnotation(annotation)
//        }
//        
//        // Center the map on the last captured photo location
//        if let lastLocation = locations.last {
//            let region = MKCoordinateRegion(center: lastLocation, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
//            uiView.setRegion(region, animated: true)
//        }
//    }
//    
//    class Coordinator: NSObject, MKMapViewDelegate {
//        var parent: MapTakePhotoView2
//        
//        init(_ parent: MapTakePhotoView2) {
//            self.parent = parent
//        }
//        
//        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//            guard let annotationImages = parent.annotationImages as? [UIImage] else {
//                return nil
//            }
//            
//            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "photoAnnotation")
//            annotationView.image = annotationImages[mapView.annotations.firstIndex(of: annotation)!]
//            annotationView.canShowCallout = true
//            return annotationView
//        }
//    
//    }
//}
