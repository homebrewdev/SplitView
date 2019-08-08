//
//  md5Generate.swift
//  SplitView
//
//  Created by Egor Devyatov on 06.08.2019.
//  Copyright © 2019 Egor Devyatov. All rights reserved.
//

import Foundation
import CommonCrypto

// хотя почитал про md-5 хеш что его могут подобрать что он старый и
// могут быть колизии с вероятностью 1 к триллиону )
extension String {
    func md5() -> String! {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        
        CC_MD5(str!, strLen, result)
        
        let hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        
        result.deallocate()
        
        return String(format: hash as String)
    }
}

// получаем md5 хэш от входящей строки
func generateMD5hash(inputString: String) -> String {
    return inputString.md5()
}


// для жручего алгоритма sha512 - вывод в hex
func generate_sha512Hex(inputString: String) -> String {
    var digest = [UInt8](repeating: 0, count: Int(CC_SHA512_DIGEST_LENGTH))
    if let data = inputString.data(using: String.Encoding.utf8) {
        let value =  data as NSData
        CC_SHA512(value.bytes, CC_LONG(data.count), &digest)
    }
    
    var digestHex = ""
    for index in 0..<Int(CC_SHA512_DIGEST_LENGTH) {
        digestHex += String(format: "%02x", digest[index])
    }
    
    return digestHex
}

// для жручего алгоритма sha512 - десятичными числами
func generate_sha512(inputString: String) -> [UInt8] {
    var digest = [UInt8](repeating: 0, count: Int(CC_SHA512_DIGEST_LENGTH))
    let data = inputString.data(using: String.Encoding.utf8 , allowLossyConversion: true)
    let value =  data! as NSData
    CC_SHA512(value.bytes, CC_LONG(value.length), &digest)
    
    return digest
}

// для жручего алгоритма sha512 - вывод в Base64 format
func generate_sha512Base64(inputString: String) -> String {
    let digest = NSMutableData(length: Int(CC_SHA512_DIGEST_LENGTH))!
    if let data = inputString.data(using: String.Encoding.utf8) {
        
        let value =  data as NSData
        let uint8Pointer = UnsafeMutablePointer<UInt8>.allocate(capacity: digest.length)
        CC_SHA512(value.bytes, CC_LONG(data.count), uint8Pointer)
    }
    
    return digest.base64EncodedString(options: NSData.Base64EncodingOptions([]))
}


//With CryptoKit added in iOS13, we now have native Swift API:
//
//import Foundation
//import CryptoKit
//
//// CryptoKit.Digest utils
//extension Digest {
//    var bytes: [UInt8] { Array(makeIterator()) }
//    var data: Data { Data(bytes) }
//
//    var hexStr: String {
//        bytes.map { String(format: "%02X", $0) }.joined()
//    }
//}
//
//func example() {
//    guard let data = "hello world".data(using: .utf8) else { return }
//    let digest = SHA512.hash(data: data)
//    print(digest.data) // 64 bytes
//    print(digest.hexStr)
// 309ECC489C12D6EB4CC40F50C902F2B4D0ED77EE511A7C7A9BCD3CA86D4CD86F989DD35BC5FF499670DA34255B45B0CFD830E81F605DCF7DC5542E93AE9CD76F
//}

