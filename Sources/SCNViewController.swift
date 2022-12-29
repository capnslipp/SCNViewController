// SCNViewController
// @author: Slipp Douglas Thompson
// @license: Public Domain per The Unlicense.  See accompanying LICENSE file or <http://unlicense.org/>.

import UIKit
import SceneKit
import class AVFoundation.AVAudioEngine



public class SCNViewController : UIViewController
{
	enum Error : Swift.Error {
		case nibStoryboardViewIsNotAnSCNView
	}
	
	
	/// The `viewFrame` and `viewOptions` arguments are ignored if a `nibName` is specified (values come from the nib's SCNView object).
	public convenience init(nibName:String?, bundle nibBundle:Bundle?=nil, viewFrame:CGRect?, viewOptions:[ViewOption]?=nil) {
		self.init(nibName: nibName, bundle: nibBundle, viewFrame: viewFrame, viewOptions: viewOptions?.asObjCStyleOptions)
	}
	
	/// Uses SCNView-API-like viewOptions (Obj-C-style), like the following:
	///		viewOptions: [
	///			SCNView.Option.preferredRenderingAPI.rawValue: NSNumber(value: SCNRenderingAPI.metal.rawValue),
	///			SCNView.Option.preferredDevice.rawValue: MTLCreateSystemDefaultDevice()!,
	///			SCNView.Option.preferLowPowerDevice.rawValue: NSNumber(value: true)
	///		]
	/// The `viewFrame` and `viewOptions` arguments are ignored if a `nibName` is specified (values come from the nib).
	public required init(nibName:String?, bundle nibBundle:Bundle?=nil, viewFrame:CGRect?, viewOptions:[SCNView.Option.RawValue:Any]?=nil)
	{
		if nibName == nil {
			_initViewFrame = viewFrame ?? CGRect.null
			_initViewOptions = viewOptions
		} else {
			_initViewFrame = CGRect.null
			_initViewOptions = [:]
		}
		
		super.init(nibName: nibName, bundle: nibBundle)
	}
	
	public convenience init(viewFrame:CGRect?, viewOptions:[ViewOption] = []) {
		self.init(nibName: nil, bundle: nil, viewFrame: viewFrame, viewOptions: viewOptions)
	}
	
	public convenience override init(nibName:String?, bundle nibBundle:Bundle?=nil) {
		self.init(nibName: nibName, bundle: nibBundle, viewFrame: nil, viewOptions: [])
	}
	
	public required init?(coder aDecoder:NSCoder) {
		_initViewFrame = CGRect.null
		_initViewOptions = [:]
		
		super.init(coder: aDecoder)
	}
	
	
	private let _initViewFrame:CGRect
	private let _initViewOptions:[SCNView.Option.RawValue:Any]?
	
	
	@objc public var scnView:SCNView {
		return self.view as! SCNView
	}
	@objc public var scene:SCNScene? {
		return self.scnView.scene
	}
	
	
	public override func loadView()
	{
		guard self.nibName == nil && self.storyboard == nil else {
			super.loadView()
			try! { guard self.view is SCNView else { throw Error.nibStoryboardViewIsNotAnSCNView } }()
			return
		}
		
		self.view = {
			let view =  SCNView(frame: _initViewFrame, options: _initViewOptions)
			if #available(iOS 9.0, tvOS 9.0, *), NSClassFromString("AVAudioEngine") != nil {
				_ = view.audioEngine
			}
			return view
		}()
	}
	
	public override func viewDidLoad()
	{
		self.scnView.scene = SCNScene()
		
		super.viewDidLoad()
	}
	
	#if !os(tvOS)
		public override var shouldAutorotate:Bool { return true }
		
		public override var prefersStatusBarHidden:Bool { return true }
		
		public override var supportedInterfaceOrientations:UIInterfaceOrientationMask {
			switch UIDevice.current.userInterfaceIdiom {
				case .phone:
					return .allButUpsideDown
				default:
					return .all
			}
		}
	#endif // !tvOS
	
	/// Release any cached data, images, etc that aren't in use.
	public override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
}
