//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Júlia on 23/7/22.
//

import Foundation

extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        //Encontramos url del archivo "astronauts.txt" en el bundle.
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        //Cogemos data del archivo
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) in bundle.")
        }
        
        let decoder = JSONDecoder()
        
        //Decodificamos data en un Map [String: Astronaut]
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        
        return loaded
    }
    
}
