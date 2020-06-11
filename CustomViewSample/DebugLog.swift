//
//  DebugLog.swift
//  CustomViewSample
//
//  Created by Sergey Chistov on 31.05.2020.
//  Copyright © 2020 Sergey Chistov. All rights reserved.
//

import UIKit

extension UIView {

    public func debugLog(_ message: String) {
        #if !(TARGET_OS_IPHONE)
            let logPath = "/tmp/XcodeLiveRendering.log"
            if !FileManager.default.fileExists(atPath: logPath) {
                FileManager.default.createFile(atPath: logPath, contents: NSData() as Data, attributes: nil)
            }

            let fileHandle = FileHandle(forWritingAtPath: logPath)
            fileHandle?.seekToEndOfFile()

            let date = NSDate()
            let bundle = Bundle(for: type(of: self))
            let application: AnyObject = bundle.object(forInfoDictionaryKey: "CFBundleName") as AnyObject
            guard let data = "\(date) \(application) \(message)\n".data(using: String.Encoding.utf8, allowLossyConversion: true) else { return }
            fileHandle?.write(data)
        #endif
    }
}
