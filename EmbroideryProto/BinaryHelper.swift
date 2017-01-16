import UIKit

class BinaryHelper {
    class func load(url: URL, to localUrl: URL, completion: @escaping (_ filename: String) -> ()) {
        let filemgr = FileManager.default
        do {
            try filemgr.removeItem(at: localUrl)
            print("Removal successful")
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        let request = try! URLRequest(url: url)
        
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("Success: \(statusCode)")
                }
                
                do {
                    try FileManager.default.copyItem(at: tempLocalUrl, to: localUrl)
                    completion((response?.suggestedFilename)!)
                } catch (let writeError) {
                    print("error writing file \(localUrl) : \(writeError)")
                }
                
            } else {
                print("Failure: %@", error?.localizedDescription);
            }
        }
        task.resume()
    }
    class func readBytes(_ filehandle: FileHandle, length: Int) -> [UInt8] {
        let databuffer = filehandle.readData(ofLength: length)
        return [UInt8](databuffer)
    }
    
    class func readUInt8(_ filehandle: FileHandle) -> UInt8 {
        let databuffer = filehandle.readData(ofLength: 1)
        return UInt8(databuffer[0])
    }
    
    class func readInt8(_ filehandle: FileHandle) -> Int8 {
        let databuffer = filehandle.readData(ofLength: 1)
        return Int8(bitPattern: databuffer[0])
    }
    
    class func readInt16LE(_ filehandle: FileHandle) -> Int16 {
        let databuffer = filehandle.readData(ofLength: 2)
        return Int16(bitPattern: UInt16(databuffer[0]) | UInt16(databuffer[1]) << 8)
    }
}
