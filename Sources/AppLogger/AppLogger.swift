//
//  AppLogger.swift
//
//
//  Created by AiD on 26.09.2022.
//

// swiftlint:disable foundation_using
// swiftlint:disable debug_rule
import Foundation

    /// Console Log and describe
final public class AppLogger {

    public enum Level: String {
        case debug = "😈"
        case info = "ℹ️"
        case success = "🟢"
        case warning = "⚠️"
        case error = "🚫"
        case exception = "❗️"
    }

    private init() {}

    static var displayLog: Bool {
        #if PRODUCTION
            return false
        #else
            return true
        #endif
    }

        /// Print debug information in debug scheme
        /// - Parameters:
        ///   - level: enum debug level
        ///   - message: any messages
        ///   - filePath: in what file
        ///   - function: in wich function
        ///   - line: and number of line
    public static func log(level: Level = .debug,
                           _ message: Any...,
                           filePath: String = #file,
                           function: String = #function,
                           line: Int = #line,
                           toFile: Bool = false
    ) {
        for message in message {
            customPrint(message, level: level, filePath: filePath, function: function, line: line, toFile: toFile)
        }
    }

    private static func customPrint(_ message: Any,
                                    level: Level,
                                    filePath: String,
                                    function: String,
                                    line: Int,
                                    toFile: Bool = false) {
        guard displayLog else { return }

        let fileName = filePath.components(separatedBy: "/").last?.components(separatedBy: ".").first ?? "unknown_file_name"
        let stringToPrint = "\(Date()) \(level.rawValue) \(fileName).swift => \(function) => at line \(line) => \(message)"
        Debugger.run({
            print(stringToPrint)
            if toFile {
                FileLog.log.write("\n" + stringToPrint)
            }
        }, releaseHandler: {
            print("RELEASE SCHEME: \(stringToPrint)")
            if toFile {
                FileLog.log.write("\n" + "RELEASE SCHEME: \(stringToPrint)")
            }
        })
    }
}
