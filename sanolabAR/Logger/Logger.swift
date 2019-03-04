//
//  Logger.swift
//  KIT-BUS-APP
//
//  Created by yodaaa on 2019/01/27.
//  Copyright © 2019 yodaaa. All rights reserved.
//

import Foundation

public final class Logger {
    ///
    /// デバッグログ出力
    ///
    /// - Parameters:
    ///   - obj: <#obj description#>
    ///   - file: <#file description#>
    ///   - line: <#line description#>
    public class func debugLog(_ obj: Any?, file: String = #file, line: Int = #line, function: String = #function) {
        #if DEBUG
        if let obj = obj {
            print("💫🐰💫Logger:[file:\(file) Line:\(line) Function:\(function)] : \(obj)")
        } else {
            print("💫🐰💫Logger:[file:\(file) Line:\(line) Function:\(function)]")
        }
        #endif
    }
}

//usage example
// Logger.debugLog(変数名)
// Logger.debugLog("変数名: \(変数名)")

