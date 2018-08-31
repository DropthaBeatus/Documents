//
//  global.swift
//  Documents
//
//  Created by Liam Flaherty on 8/29/18.
//  Copyright © 2018 Liam Flaherty. All rights reserved.
//

import Foundation

func GetAllFileURLs()->[URL]?{
    var FilePaths = [URL]()
    let fileManager = FileManager.default
    let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
    do {
        let fileURLs = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
        return fileURLs
    } catch {
        print("Error while enumerating files \(documentsURL.path): \(error.localizedDescription)")
    }
    FilePaths.append(documentsURL)
    return FilePaths
}

func GetAllFileSizes(urls : [URL])->[Int]{
    var FileSize = [Int]()
    for url in urls {

        do {
            let resources = try url.resourceValues(forKeys:[.fileSizeKey])
            FileSize.append(resources.fileSize!)
        } catch {
            FileSize.append(100)
            
        }
    }
    return FileSize
}

func GetAllFileDates(urls : [URL])->[Date]{
    var FileSize = [Date]()
    for url in urls {
        
        do {
            let resources = try url.resourceValues(forKeys:[.contentModificationDateKey])
            FileSize.append(resources.contentModificationDate!)
        } catch {
            FileSize.append(Date())
            
        }
    }
    return FileSize
}

//I know I should not put this in global
func DeleteFile(url: URL){
    
    let fileManager = FileManager.default
    
    do {
        try fileManager.removeItem(at: url)
    }
    catch let error as NSError {
        print("Ooops! Something went wrong: \(error)")
    }
    
}

