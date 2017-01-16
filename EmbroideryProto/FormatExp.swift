import UIKit

class FormatExp {
    class func read(file : FileHandle) -> EmbPattern {
        let pattern = EmbPattern()
        file.seekToEndOfFile()
        let fileLength = file.offsetInFile
        file.seek(toFileOffset: 0)
        while ((file.offsetInFile) < fileLength) {
            var b0 = BinaryHelper.readInt8(file)
            var b1 = BinaryHelper.readInt8(file)
            var flags: StitchType = StitchType.Normal
            if (b0 == -128) {
                if ((b1 & 1) > 0) {
                    b0 = BinaryHelper.readInt8(file)
                    b1 = BinaryHelper.readInt8(file)
                    flags = StitchType.Stop
                } else if ((b1 == 2) || (b1 == 4) || b1 == 6) {
                    flags = StitchType.Trim
                    if (b1 == 2) {
                        flags = StitchType.Normal
                    }
                    b0 = BinaryHelper.readInt8(file)
                    b1 = BinaryHelper.readInt8(file)
                } else if (b1 == -128) {
                    b0 = BinaryHelper.readInt8(file)
                    b1 = BinaryHelper.readInt8(file)
                    b0 = 0
                    b1 = 0
                    flags = StitchType.Trim
                }
            }
            pattern.addStitchRel(point: CGPoint(x: CGFloat(b0), y: CGFloat(b1)), stitchType: flags)
        }
        return pattern
    }
}
