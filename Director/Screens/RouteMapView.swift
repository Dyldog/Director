//
//  ContentView.swift
//  Director
//
//  Created by Dylan Elliott on 11/7/2024.
//

import DylKit
import MapKit
import SwiftUI


extension CLLocationCoordinate2D: IDWrappable { }

struct RouteMapView: View {
    @State private var mapRect: MKMapRect = .world
    
    // Draw Mode
    @State private var drawMode: Bool = false
    @State private var drawnLocations: [CLLocationCoordinate2D] = []
    
    @State private var pinLocations: [IDWrapper<CLLocationCoordinate2D>] = []
    
    @State var title: String
    @State var directions: [String]
    typealias Completion = (_ title: String, _ directions: [String]) -> Void
    let completion: Completion
    
    private let locationManager: CLLocationManager = .init()
    
    init(title: String, directions: [String] = [], completion: @escaping Completion) {
        self.title = title
        self.directions = directions.isEmpty ? [""] : directions
        self.completion = completion
    }
    
    var body: some View {
        VStack {
            map
            directionsView
                .padding(.bottom)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(systemIcon: "checkmark") {
                    completion(title, directions)
                }
            }
            ToolbarItem(placement: .principal) {
                TextField("Title", text: $title)
                    .bold()
                    .fixedSize(horizontal: true, vertical: false)
            }
        }
    }
    
    private var map: some View {
        MapReader { mapProxy in
            Map(interactionModes: drawMode ? [.pitch, .rotate, .zoom] : .all) {
                UserAnnotation()
                MapPolyline(coordinates: drawnLocations)
                    .stroke(.blue, lineWidth: 5)
                
                ForEach(pinLocations) { location in
                    Marker(coordinate: location.value, label: { EmptyView() })
                }
            }
            // Going to try the app without any ways of marking the map for now
            //            .onTapGesture { location in
            //                guard let coordinate = mapProxy.convert(location, from: .local) else { return }
            //                pinLocations.append(coordinate.identifiable)
            //            }
            .if(drawMode) {
                $0
                    .highPriorityGesture(
                        DragGesture()
                            .onChanged { gesture in
                                guard let coordinate = mapProxy.convert(gesture.location, from: .local) else { return }
                                drawnLocations.append(coordinate)
                            }
                    )
            }
        }
        .onAppear {
            locationManager.requestWhenInUseAuthorization()
        }
        // Makes map user location button appear under the status bar
        //        .edgesIgnoringSafeArea(.all)
    }
    
    private var directionsView: some View {
        DirectionsWritingSheet(directions: $directions)
    }
}

#Preview {
    RouteMapView(title: "TITLE") { _,_  in }
}
