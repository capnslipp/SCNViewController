// ViewOptions
// @author: Slipp Douglas Thompson
// @license: Public Domain per The Unlicense.  See accompanying LICENSE file or <http://unlicense.org/>.

import SceneKit



public extension SCNViewController
{
	enum ViewOption : Equatable
	{
		case preferLowPowerDevice(Bool)
		case preferredDevice(MTLDevice)
		case preferredRenderingAPI(SCNRenderingAPI)
		
		
		public static func == (lhs: ViewOption, rhs: ViewOption) -> Bool {
			switch (lhs, rhs) {
				case (.preferLowPowerDevice(let lhsValue), .preferLowPowerDevice(let rhsValue)):
					return lhsValue == rhsValue
				case (.preferredDevice(let lhsValue), .preferredDevice(let rhsValue)):
					if #available(iOS 11.0, macOS 10.13, macCatalyst 13.0, tvOS 11.0, *) {
						return lhsValue.registryID == rhsValue.registryID
					} else {
						return lhsValue.name == rhsValue.name
					}
				case (.preferredRenderingAPI(let lhsValue), .preferredRenderingAPI(let rhsValue)):
					return lhsValue == rhsValue
				default:
					return false
			}
		}
	}
}



extension Array where Element == SCNViewController.ViewOption
{
	public init(objcStyleOptions: [SCNView.Option.RawValue:Any])
	{
		self = []
		if let objcValue = objcStyleOptions[SCNView.Option.preferLowPowerDevice.rawValue] {
			append(.preferLowPowerDevice((objcValue as! NSNumber).boolValue))
		}
		if let objcValue = objcStyleOptions[SCNView.Option.preferredDevice.rawValue] {
			append(.preferredDevice(objcValue as! MTLDevice))
		}
		if let objcValue = objcStyleOptions[SCNView.Option.preferredRenderingAPI.rawValue] {
			append(.preferredRenderingAPI(SCNRenderingAPI(rawValue: (objcValue as! NSNumber).uintValue)!))
		}
	}
	
	public var asObjCStyleOptions: [SCNView.Option.RawValue:Any] {
		var objcStyleOptions: [SCNView.Option.RawValue:Any] = [:]
		
		for element in self {
			switch element {
				case .preferLowPowerDevice(let value):
					objcStyleOptions[SCNView.Option.preferLowPowerDevice.rawValue] = NSNumber(value: value)
				case .preferredDevice(let value):
					objcStyleOptions[SCNView.Option.preferredDevice.rawValue] = value
				case .preferredRenderingAPI(let value):
					objcStyleOptions[SCNView.Option.preferredRenderingAPI.rawValue] = NSNumber(value: value.rawValue)
			}
		}
		
		return objcStyleOptions
	}
}
