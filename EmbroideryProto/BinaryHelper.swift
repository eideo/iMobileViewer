import UIKit

class BinaryHelper {
    class func load(url: URL, to localUrl: URL, completion: @escaping () -> ()) {
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
                    completion()
                } catch (let writeError) {
                    print("error writing file \(localUrl) : \(writeError)")
                }
                
            } else {
                print("Failure: %@", error?.localizedDescription);
            }
        }
        task.resume()
    }
    
    class func readUInt8(_ filehandle: FileHandle) -> UInt8 {
        let databuffer = filehandle.readData(ofLength: 1)
        return UInt8(databuffer[0])
    }
    
    class func readInt8(_ filehandle: FileHandle) -> Int8 {
        let databuffer = filehandle.readData(ofLength: 1)
        return Int8(bitPattern: databuffer[0])
    }
}
