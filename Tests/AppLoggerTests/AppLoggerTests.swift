import XCTest
@testable import AppLogger

final class AppLoggerTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(AppLogger().text, "Hello, World!")
    }
}
