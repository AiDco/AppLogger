//
//  File.swift
//  
//
//  Created by AiD on 26.12.2022.
//

import Foundation

extension Date {
    var logFileName: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        return dateFormatter.string(from: self)
    }
}

private struct FileIO {
    func write(
        _ string: String,
        toDocumentNamed documentName: String,
        encodedUsing encoder: JSONEncoder = .init()
    ) throws {
        let rootFolderURL = try FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        )

        let nestedFolderURL = rootFolderURL.appendingPathComponent("logs")

        if !FileManager.default.fileExists(atPath: nestedFolderURL.path) {
            try FileManager.default.createDirectory(
                at: nestedFolderURL,
                withIntermediateDirectories: false,
                attributes: nil
            )
        }

        let fileURL = nestedFolderURL.appendingPathComponent(documentName)

        if let handle = try? FileHandle(forWritingTo: fileURL) {
            handle.seekToEndOfFile()
            handle.write(string.data(using: .utf8)!)
            handle.closeFile()
        } else {
            try string.data(using: .utf8)?.write(to: fileURL)
        }
    }
}

final class FileLog: TextOutputStream {
    private let fileIO = FileIO()
    private let fileName = Date().logFileName
    static var log: FileLog = FileLog()

    private init() {}

    func write(_ string: String) {
        do {
            let fileNameWithExtension = (fileName + ".log")
            try fileIO.write(string, toDocumentNamed: fileNameWithExtension)
        } catch {
            print("Can't write log")
        }
    }
}
