import Foundation

class InMemoryFile {
    public var offsetInFile : Int = 0
    private var data: Data
    public var filename : String = ""
    
    init(contents: Data) {
        self.data = contents
    }
    
    func readBytes(length: Int) -> [UInt8] {
        let databuffer = self.data.subdata(in: offsetInFile..<offsetInFile + length)
        offsetInFile += length
        return [UInt8](databuffer)
    }
    
    func readUInt8() -> UInt8 {
        let databuffer = self.data[offsetInFile]
        offsetInFile += 1
        return UInt8(databuffer)
    }
    
    func readInt8() -> Int8 {
        let databuffer = self.data[offsetInFile]
        offsetInFile += 1
        return Int8(bitPattern: databuffer)
    }
    
    func readInt16LE() -> Int16 {
        let databuffer = self.data.subdata(in: offsetInFile..<offsetInFile+2)
        offsetInFile += 2
        return Int16(bitPattern: UInt16(databuffer[0]) | UInt16(databuffer[1]) << 8)
    }
    
    func seek(set: Int){
        offsetInFile = set
    }
    
    func seek(fromCurrent: Int) {
        offsetInFile += fromCurrent
    }
    
    func count() -> Int {
        return data.count;
    }
}
