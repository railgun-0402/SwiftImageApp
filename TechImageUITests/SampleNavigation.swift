//
//  SampleNavigation.swift
//  TechImageUITests
//

import XCTest
import ViewInspector
@testable import TechImage

extension Album: Inspectable {}


final class SampleNavigation: XCTestCase {
    
    func testView() throws {
        try XCTContext.runActivity(named: "static string") {_ in
            let view = Album()
            let text = try view.inspect().vStack().text(0).string()
            XCTAssertEqual(text, "Hello")
        }
    }
    
}
