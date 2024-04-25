//
//  ImageCacheManager.swift
//  WeatherForecast
//
//  Created by Hong yujin on 4/21/24.
//

import UIKit

enum CacheOption {
    case onlyMemory
    case onlyDisk
    case both
    case nothing
}

actor ImageCacheManager {
    
    static let shared = ImageCacheManager(memoryCache: MemoryCache(), diskCache: DiskCache())
    private let memoryCache: ImageCachable
    private var diskCache: ImageCachable
    private var option: CacheOption = .both
    
    init(memoryCache: ImageCachable, 
         diskCache: ImageCachable,
         _ option: CacheOption = .both) {
        self.memoryCache = memoryCache
        self.diskCache = diskCache
        self.option = option
    }
    
    func image(for key: String) async -> UIImage? {
        if let memoryImage = loadMemoryCache(for: key) {
            return memoryImage
        }
        
        if let diskImage = loadDiskCache(for: key) {
            self.storeMemoryCache(for: key, image: diskImage)
            return diskImage
        }
        
        return nil
    }
    
    private func loadMemoryCache(for key: String) -> UIImage? {
        return memoryCache.value(for: key)
    }
    
    private func loadDiskCache(for key: String) -> UIImage? {
        return diskCache.value(for: key)
    }
    
    func storeMemoryCache(for key: String, image: UIImage) {
        if option == .both || option == .onlyMemory {
            do {
                try memoryCache.store(for: key, image: image)
            } catch {
                print("Error writing image to disk: \(error)")
            }
        }
    }
    
    func storeDiskCache(for key: String, image: UIImage) {
        if option == .both || option == .onlyDisk {
            
            do {
                try diskCache.store(for: key, image: image)
            } catch {
                print("Error writing image to disk: \(error)")
            }
        }
    }
    
}
