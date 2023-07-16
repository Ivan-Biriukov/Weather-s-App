import Foundation

@available (macOS 10.15, * )
extension String {
    subscript(idx: Int) -> String {
        String(self[index(startIndex, offsetBy: idx)])
    }
}
