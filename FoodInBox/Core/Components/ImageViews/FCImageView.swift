//
//  FCImageView.swift
//  FoodInBox
//
//  Created by Fatih Kilit on 19.09.2022.
//

import UIKit

class FCImageView: UIImageView {
    
    var dataTask: URLSessionDataTask?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        clipsToBounds = true
        contentMode = .scaleToFill
        tintColor = .white
    }
    
    func downloadImage(urlString: String, renderingMode: UIImage.RenderingMode) {
        guard let url = URL(string: urlString) else { return }
        image = nil
        
        if let cachedImage = CacheManager.shared.cache.object(forKey: urlString as NSString) {
            self.image = cachedImage.withRenderingMode(.alwaysTemplate)
        }
        
        self.dataTask = URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, _, _) in
            guard
                let self = self,
                let data = data,
                let image = UIImage(data: data) else {
                return
            }
            
            CacheManager.shared.cache.setObject(image, forKey: urlString as NSString)
            
            DispatchQueue.main.async {
                self.image = image.withRenderingMode(renderingMode)
            }
        })
        
        dataTask?.resume()
    }
    
    func cancelDownloading() {
        dataTask?.cancel()
        dataTask = nil
    }
}
