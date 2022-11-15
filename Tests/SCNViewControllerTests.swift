//
//  SCNViewControllerTests.swift
//  SCNViewControllerTests
//
//  Created by Cap'n Slipp on 12/29/22.
//

import XCTest
@testable import SCNViewController
import SceneKit



final class SCNViewControllerTests: XCTestCase
{
	override func setUpWithError() throws {
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}

	override func tearDownWithError() throws {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
	}

	func testExample() throws
	{
		do {
			let viewController = SCNViewController(
				nibName: nil,
				viewFrame: CGRect(x: 0, y: 0, width: 1024, height: 768),
				viewOptions: [
					.preferredRenderingAPI(.openGLES2),
					.preferLowPowerDevice(true)
				]
			)
			
			let view = viewController.view
			XCTAssertNotNil(view)
			if let view = view {
				XCTAssertEqual(view.frame.size, CGSize(width: 1024, height: 768))
				
				XCTAssertTrue(view is SCNView)
				if let scnView = view as? SCNView {
					XCTAssertEqual(scnView.renderingAPI, .openGLES2)
					
				}
			}
		}
	}

}
