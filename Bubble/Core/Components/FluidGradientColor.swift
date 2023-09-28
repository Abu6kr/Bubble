//
//  FluidGradientColor.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 26.09.2023.
//

import SwiftUI
import Combine

struct FluidGradientViewColor: View {
    var body: some View {
        FluidGradient(blobs: [Color.blue,Color(red: 0.08, green: 0.111, blue: 0.097),Color(red: 0.081, green: 0.086, blue: 0.129),Color.white.opacity(0.3)]).ignoresSafeArea(.all)
            .opacity(0.5).background(VisualEffect(style: .systemThickMaterial)).ignoresSafeArea(.all).opacity(0.5)
    }
}
struct FluidGradientColor: View {
    var body: some View {
        FluidGradient(blobs: [.red, .green, .blue],
                      highlights: [.yellow, .orange, .purple])
        .background(.quaternary)
        .cornerRadius(22)
        .padding(15)

    }
}

struct FluidGradientColor_Previews: PreviewProvider {
    static var previews: some View {
        FluidGradientColor()
    }
}

public struct FluidGradient: View {
    private var blobs: [Color]
    private var highlights: [Color]
    private var speed: CGFloat
    private var blur: CGFloat
    
    @State var blurValue: CGFloat = 0.0
    
    public init(blobs: [Color],
                highlights: [Color] = [],
                speed: CGFloat = 1.0,
                blur: CGFloat = 0.75) {
        self.blobs = blobs
        self.highlights = highlights
        self.speed = speed
        self.blur = blur
    }
    
    public var body: some View {
        Representable(blobs: blobs,
                      highlights: highlights,
                      speed: speed,
                      blurValue: $blurValue)
        .blur(radius: pow(blurValue, blur))
        .accessibility(hidden: true)
        .clipped()
    }
}

#if os(OSX)
typealias SystemRepresentable = NSViewRepresentable
#else
typealias SystemRepresentable = UIViewRepresentable
#endif

// MARK: - Representable
extension FluidGradient {
    struct Representable: SystemRepresentable {
        var blobs: [Color]
        var highlights: [Color]
        var speed: CGFloat
        
        @Binding var blurValue: CGFloat
        
        func makeView(context: Context) -> FluidGradientView {
            context.coordinator.view
        }
        
        func updateView(_ view: FluidGradientView, context: Context) {
            context.coordinator.create(blobs: blobs, highlights: highlights)
            DispatchQueue.main.async {
                context.coordinator.update(speed: speed)
            }
        }
        
#if os(OSX)
        func makeNSView(context: Context) -> FluidGradientView {
            makeView(context: context)
        }
        func updateNSView(_ view: FluidGradientView, context: Context) {
            updateView(view, context: context)
        }
#else
        func makeUIView(context: Context) -> FluidGradientView {
            makeView(context: context)
        }
        func updateUIView(_ view: FluidGradientView, context: Context) {
            updateView(view, context: context)
        }
#endif
        
        func makeCoordinator() -> Coordinator {
            Coordinator(blobs: blobs,
                        highlights: highlights,
                        speed: speed,
                        blurValue: $blurValue)
        }
    }
    
    class Coordinator: FluidGradientDelegate {
        var blobs: [Color]
        var highlights: [Color]
        var speed: CGFloat
        var blurValue: Binding<CGFloat>
        
        var view: FluidGradientView
        
        init(blobs: [Color],
             highlights: [Color],
             speed: CGFloat,
             blurValue: Binding<CGFloat>) {
            self.blobs = blobs
            self.highlights = highlights
            self.speed = speed
            self.blurValue = blurValue
            self.view = FluidGradientView(blobs: blobs,
                                          highlights: highlights,
                                          speed: speed)
            self.view.delegate = self
        }
        
        /// Create blobs and highlights
        func create(blobs: [Color], highlights: [Color]) {
            guard blobs != self.blobs || highlights != self.highlights else { return }
            self.blobs = blobs
            self.highlights = highlights
            
            view.create(blobs, layer: view.baseLayer)
            view.create(highlights, layer: view.highlightLayer)
            view.update(speed: speed)
        }
        
        /// Update speed
        func update(speed: CGFloat) {
            guard speed != self.speed else { return }
            self.speed = speed
            view.update(speed: speed)
        }
        
        func updateBlur(_ value: CGFloat) {
            blurValue.wrappedValue = value
        }
    }
}



public class ResizableLayer: CALayer {
    override init() {
        super.init()
        #if os(OSX)
        autoresizingMask = [.layerWidthSizable, .layerHeightSizable]
        #endif
        sublayers = []
    }
    
    public override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSublayers() {
        super.layoutSublayers()
        sublayers?.forEach { layer in
            layer.frame = self.frame
        }
    }
}


 
#if os(OSX)
import AppKit
public typealias SystemColor = NSColor
public typealias SystemView = NSView
#else
import UIKit
public typealias SystemColor = UIColor
public typealias SystemView = UIView
#endif

/// A system view that presents an animated gradient with ``CoreAnimation``
public class FluidGradientView: SystemView {
    var speed: CGFloat
    
    let baseLayer = ResizableLayer()
    let highlightLayer = ResizableLayer()
    
    var cancellables = Set<AnyCancellable>()
    
    weak var delegate: FluidGradientDelegate?
    
    init(blobs: [Color] = [],
         highlights: [Color] = [],
         speed: CGFloat = 1.0) {
        self.speed = speed
        super.init(frame: .zero)
        
        if let compositingFilter = CIFilter(name: "CIOverlayBlendMode") {
            highlightLayer.compositingFilter = compositingFilter
        }
        
        #if os(OSX)
        layer = ResizableLayer()
        
        wantsLayer = true
        postsFrameChangedNotifications = true
        
        layer?.delegate = self
        baseLayer.delegate = self
        highlightLayer.delegate = self
        
        self.layer?.addSublayer(baseLayer)
        self.layer?.addSublayer(highlightLayer)
        #else
        self.layer.addSublayer(baseLayer)
        self.layer.addSublayer(highlightLayer)
        #endif
        
        create(blobs, layer: baseLayer)
        create(highlights, layer: highlightLayer)
        DispatchQueue.main.async {
            self.update(speed: speed)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Create blobs and add to specified layer
    public func create(_ colors: [Color], layer: CALayer) {
        // Remove blobs at the end if colors are removed
        let count = layer.sublayers?.count ?? 0
        let removeCount = count - colors.count
        if removeCount > 0 {
            layer.sublayers?.removeLast(removeCount)
        }
        
        for (index, color) in colors.enumerated() {
            if index < count {
                if let existing = layer.sublayers?[index] as? BlobLayer {
                    existing.set(color: color)
                }
            } else {
                layer.addSublayer(BlobLayer(color: color))
            }
        }
    }
    
    /// Update sublayers and set speed and blur levels
    public func update(speed: CGFloat) {
        cancellables.removeAll()
        self.speed = speed
        guard speed > 0 else { return }
        
        let layers = (baseLayer.sublayers ?? []) + (highlightLayer.sublayers ?? [])
        for layer in layers {
            if let layer = layer as? BlobLayer {
                Timer.publish(every: .random(in: 0.8/speed...1.2/speed),
                              on: .main,
                              in: .common)
                    .autoconnect()
                    .sink { _ in
                        #if os(OSX)
                        let visible = self.window?.occlusionState.contains(.visible)
                        guard visible == true else { return }
                        #endif
                        layer.animate(speed: speed)
                    }
                    .store(in: &cancellables)
            }
        }
    }
    
    /// Compute and update new blur value
    private func updateBlur() {
        delegate?.updateBlur(min(frame.width, frame.height))
    }
    
    /// Functional methods
    #if os(OSX)
    public override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        let scale = window?.backingScaleFactor ?? 2
        layer?.contentsScale = scale
        baseLayer.contentsScale = scale
        highlightLayer.contentsScale = scale
        
        updateBlur()
    }
    
    public override func resize(withOldSuperviewSize oldSize: NSSize) {
        updateBlur()
    }
    #else
    public override func layoutSubviews() {
        layer.frame = self.bounds
        baseLayer.frame = self.bounds
        highlightLayer.frame = self.bounds
        
        updateBlur()
    }
    #endif
}

protocol FluidGradientDelegate: AnyObject {
    func updateBlur(_ value: CGFloat)
}

#if os(OSX)
extension FluidGradientView: CALayerDelegate, NSViewLayerContentScaleDelegate {
    public func layer(_ layer: CALayer,
                      shouldInheritContentsScale newScale: CGFloat,
                      from window: NSWindow) -> Bool {
        return true
    }
}
#endif


import SwiftUI

/// A CALayer that draws a single blob on the screen
public class BlobLayer: CAGradientLayer {
    init(color: Color) {
        super.init()
        
        self.type = .radial
        #if os(OSX)
        autoresizingMask = [.layerWidthSizable, .layerHeightSizable]
        #endif
        
        // Set color
        set(color: color)
        
        // Center point
        let position = newPosition()
        self.startPoint = position
        
        // Radius
        let radius = newRadius()
        self.endPoint = position.displace(by: radius)
    }
    
    /// Generate a random point on the canvas
    func newPosition() -> CGPoint {
        return CGPoint(x: CGFloat.random(in: 0.0...1.0),
                       y: CGFloat.random(in: 0.0...1.0)).capped()
    }
    
    /// Generate a random radius for the blob
    func newRadius() -> CGPoint {
        let size = CGFloat.random(in: 0.15...0.75)
        let viewRatio = frame.width/frame.height
        let safeRatio = max(viewRatio.isNaN ? 1 : viewRatio, 1)
        let ratio = safeRatio*CGFloat.random(in: 0.25...1.75)
        return CGPoint(x: size,
                       y: size*ratio)
    }
    
    /// Animate the blob to a random point and size on screen at set speed
    func animate(speed: CGFloat) {
        guard speed > 0 else { return }
        
        self.removeAllAnimations()
        let currentLayer = self.presentation() ?? self
        
        let animation = CASpringAnimation()
        animation.mass = 10/speed
        animation.damping = 50
        animation.duration = 1/speed
        
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        
        let position = newPosition()
        let radius = newRadius()
        
        // Center point
        let start = animation.copy() as! CASpringAnimation
        start.keyPath = "startPoint"
        start.fromValue = currentLayer.startPoint
        start.toValue = position
        
        // Radius
        let end = animation.copy() as! CASpringAnimation
        end.keyPath = "endPoint"
        end.fromValue = currentLayer.endPoint
        end.toValue = position.displace(by: radius)
        
        self.startPoint = position
        self.endPoint = position.displace(by: radius)
        
        // Opacity
        let value = Float.random(in: 0.5...1)
        let opacity = animation.copy() as! CASpringAnimation
        opacity.fromValue = self.opacity
        opacity.toValue = value
        
        self.opacity = value
        
        self.add(opacity, forKey: "opacity")
        self.add(start, forKey: "startPoint")
        self.add(end, forKey: "endPoint")
    }
    
    /// Set the color of the blob
    func set(color: Color) {
        // Converted to the system color so that cgColor isn't nil
        self.colors = [SystemColor(color).cgColor,
                       SystemColor(color).cgColor,
                       SystemColor(color.opacity(0.0)).cgColor]
        self.locations = [0.0, 0.9, 1.0]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Required by the framework
    public override init(layer: Any) {
        super.init(layer: layer)
    }
}

import CoreGraphics

extension CGPoint {
    /// Build a point from an origin and a displacement
    func displace(by point: CGPoint = .init(x: 0.0, y: 0.0)) -> CGPoint {
        return CGPoint(x: self.x+point.x,
                       y: self.y+point.y)
    }
    
    /// Caps the point to the unit space
    func capped() -> CGPoint {
        return CGPoint(x: max(min(x, 1), 0),
                       y: max(min(y, 1), 0))
    }
}

