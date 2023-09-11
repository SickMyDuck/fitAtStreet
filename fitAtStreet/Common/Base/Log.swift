//
//  Log.swift
//  fitAtStreet
//
//  Created by Ruslan Sadritdinov on 11.09.2023.
//

import Foundation
import os.log

extension OSLog {

    private static var subsystem = Bundle.main.bundleIdentifier ?? "undefined"

    public static let settings = OSLog(subsystem: subsystem, category: "settings")
    public static let application = OSLog(subsystem: subsystem, category: "application")
    public static let credentialStorage = OSLog(subsystem: subsystem, category: "credentialStorage")
    public static let routing = OSLog(subsystem: subsystem, category: "routing")
    public static let auth = OSLog(subsystem: subsystem, category: "auth")
    public static let network = OSLog(subsystem: subsystem, category: "network")
    public static let logger = OSLog(subsystem: subsystem, category: "logger")
    public static let assembly = OSLog(subsystem: subsystem, category: "assembly")
    public static let analytics = OSLog(subsystem: subsystem, category: "analytics")
    public static let apns = OSLog(subsystem: subsystem, category: "apns")
}

public enum LogLevel: String {
    case debug
    case info
    case error
}

public class Log {
    static let osLogTypes: [LogLevel: OSLogType] = [
        .debug: .debug,
        .info: .info,
        .error: .error
    ]

    static var logLevelGate = LogLevel.debug {
        didSet {
            os_log("%@", log: .logger, type: .info, "*****************LOG LEVEL GATE******************")
            os_log("%@", log: .logger, type: .info, "Log level gate is \(logLevelGate)")
            os_log("%@", log: .logger, type: .info, "*************************************************")
        }
    }

    static let logLevelOrder: [LogLevel] = [
        .debug,
        .info,
        .error
    ]


    static func write(message: String, category: OSLog, level: LogLevel) {

        guard let gateIdx = logLevelOrder.lastIndex(of: logLevelGate),
              let messageIdx = logLevelOrder.lastIndex(of: level) else {return}
        guard messageIdx >= gateIdx else {return}
        guard let type = osLogTypes[level] else {
            os_log("%@", log: category, type: .default, message)
            return
        }
        let typeIndicator = String(with: type)
        os_log("%@: %@", log: category, type: type, typeIndicator, message)
    }

    static func write(request: URLRequest, asCURL: Bool = false) {
        if asCURL {
            let message = request.cURL(pretty: true)
            Self.write(message: message, category: .network, level: .debug)
        } else {
            var message = """
            \n\n\(String(with: "request"))
            \(request.httpMethod ?? "GET") \(request.url?.absoluteString ?? "<url>")
            HEADERS: \(request.allHTTPHeaderFields ?? [:])
            """
            if let data = request.httpBody, let string = String(data: data, encoding: .utf8) {
                message += "\nBODY: \(string)"
            }
            message += "\n" + String(with: "") + "\n\n"
            Self.write(message: message, category: .network, level: .debug)
        }
    }

    static func write(response: HTTPURLResponse, data: Data) {
        var message = """
        \n\n\(String(with: "response"))
        \(response.url?.absoluteString ?? "<url>") (\(response.statusCode))
        HEADERS: \((response.allHeaderFields as? [String: Any]) ?? [:])
        """
        if let string = String(data: data, encoding: .utf8) {
            message += "\nDATA: \(string)"
        }
        message += "\n" + String(with: "") + "\n\n"
        Self.write(message: message, category: .network, level: .debug)
    }
}

private extension String {
    init(with centerText: String, approximateFullLength: Int = 40, char: Character = "*") {
        let space = centerText.isEmpty ? "" : " "
        let centerText = space + centerText.uppercased() + space
        let approximateLength = approximateFullLength - centerText.count
        let leftCount = Int(0.5 * Float(approximateLength))
        let rightCount = approximateLength - leftCount
        let left = String(repeating: char, count: leftCount)
        let right = String(repeating: char, count: rightCount)

        self = left + centerText + right
    }

    init(with osLogType: OSLogType) {
        switch osLogType {
        case .info: self = "✅"
        case .debug: self = "🔷"
        case .error: self = "⭕️"
        case .fault: self = "🆘"
        default: self = "💭"
        }
    }
}

extension URLRequest {
    public func cURL(pretty: Bool = false) -> String {
        let newLine = pretty ? "\\\n" : ""
        let method = (pretty ? "--request " : "-X ") + "\(self.httpMethod ?? "GET") \(newLine)"
        let url: String = (pretty ? "--url " : "") + "\'\(self.url?.absoluteString ?? "")\' \(newLine)"

        var cURL = "curl "
        var header = ""
        var data: String = ""

        if let httpHeaders = self.allHTTPHeaderFields, !httpHeaders.isEmpty {
            for (key, value) in httpHeaders {
                header += (pretty ? "--header " : "-H ") + "\'\(key): \(value)\' \(newLine)"
            }
        }

        if let bodyData = self.httpBody, let bodyString = String(data: bodyData, encoding: .utf8), !bodyString.isEmpty {
            data = "--data '\(bodyString)'"
        }

        cURL += method + url + header + data

        return cURL
    }
}
