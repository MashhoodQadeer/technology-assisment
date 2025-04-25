//
//  UIImage+Cache.swift
//  TechnologyAssisment
//
//  Created by Mashhood Qadeer on 26/04/2025.
//

import UIKit
import Foundation

class ImageCacheManager {
    
    static let shared = ImageCacheManager()
    
    private init() {}
    
    private var cache = NSCache<NSString, UIImage>()
    
    func image(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    func save(image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
    
}

@IBDesignable
extension UIView {

    @IBInspectable var isCircular: Bool {
        get {
            return layer.cornerRadius == min(bounds.width, bounds.height) / 2
        }
        set {
            if newValue {
                layer.cornerRadius = min(bounds.width, bounds.height) / 2
                clipsToBounds = true
            }
        }
    }
    
}

class AsyncImageView: UIImageView {
    
    private static let imageCache = NSCache<NSString, UIImage>()
    
    private var currentImageURL: URL?
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    func loadImage(from url: URL?, placeholder: UIImage? = nil) {
      
        cancelCurrentLoad()
        
        image = placeholder
        
        guard let url = url else {
            return
        }
        
      
        currentImageURL = url
        let urlString = url.absoluteString as NSString
        
        
        if let cachedImage = AsyncImageView.imageCache.object(forKey: urlString) {
            self.image = cachedImage
            return
        }
        
        activityIndicator.startAnimating()
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            
            // Check if we're still supposed to load this URL
            guard self.currentImageURL == url else { return }
            
            do {
                let data = try Data(contentsOf: url)
                
                // Create image from data
                if let image = UIImage(data: data){
                    AsyncImageView.imageCache.setObject(image, forKey: urlString)
                    DispatchQueue.main.async {
                        // Verify we're still supposed to load this URL
                        if self.currentImageURL == url {
                            self.image = image
                            self.activityIndicator.stopAnimating()
                        }
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                }
                print("Error loading image: \(error.localizedDescription)")
            }
        }
    }
    
    /// Cancels any ongoing image load
    func cancelCurrentLoad() {
        currentImageURL = nil
        activityIndicator.stopAnimating()
    }
    
    // MARK: - Memory Management
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        // If removed from window, cancel current load to save resources
        if window == nil {
            cancelCurrentLoad()
        }
    }
    
    deinit {
        cancelCurrentLoad()
    }
    
    // Clear cache when memory warning is received
    static func clearCache() {
        imageCache.removeAllObjects()
    }
}
