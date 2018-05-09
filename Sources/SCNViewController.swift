// SCNViewController
// @author: Slipp Douglas Thompson
// @license: Public Domain per The Unlicense.  See accompanying LICENSE file or <http://unlicense.org/>.

import SceneKit
import class AVFoundation.AVAudioEngine

#if os(macOS)
	import AppKit
	public typealias SCNNativeBaseViewController = NSViewController
	//typealias SCNNativeButton = NSButton
	//typealias SCNNativeStoryboardSegue = NSStoryboardSegue
#else
	import UIKit
	public typealias SCNNativeBaseViewController = UIViewController
	//typealias SCNNativeButton = UIButton
	//typealias SCNNativeStoryboardSegue = UIStoryboardSegue
#endif


#if os(macOS)
	@available(macOS 10.13, *)
	extension NSNib.Name
	{
		convenience init?(_ rawValue:String?)
		{
			if let rawValue = rawValue {
				self.init(rawValue)
			} else {
				return nil
			}
		}
	}
#endif



public class SCNViewController : SCNNativeBaseViewController
{
	enum Error : Swift.Error {
		case nibStoryboardViewIsNotAnSCNView
	}
	
	
	/// Unfortunately, SCNView's API hasn't yet been fully updated for Swift, so if you use `viewOptions`s they need to be specified similar to the following:
	///		viewOptions: [
	///			SCNView.Option.preferredRenderingAPI.rawValue: NSNumber(value: SCNRenderingAPI.metal.rawValue),
	///			SCNView.Option.preferredDevice.rawValue: MTLCreateSystemDefaultDevice()!,
	///			SCNView.Option.preferLowPowerDevice.rawValue: NSNumber(value: true)
	///		]
	public required init(nibName:String?, bundle nibBundle:Bundle?=nil, viewFrame:CGRect?, viewOptions:[String:Any]?=[:])
	{
		if nibName == nil {
			_initViewFrame = viewFrame ?? CGRect.null
			_initViewOptions = viewOptions
		} else {
			_initViewFrame = CGRect.null
			_initViewOptions = nil
		}
		
		#if os(macOS)
			if #available(macOS 10.13, *) {
				super.init(nibName: NSNib.Name(nibName), bundle: nibBundle)
			} else {
				super.init(nibName: nibName, bundle: nibBundle)!
			}
		#else
			super.init(nibName: nibName, bundle: nibBundle)
		#endif
	}
	public convenience init(viewFrame:CGRect?, viewOptions:[String:Any]? = [:]) {
		self.init(nibName: nil, bundle: nil, viewFrame: viewFrame, viewOptions: viewOptions)
	}
	
	public convenience override init(nibName:String?, bundle nibBundle:Bundle?=nil) {
		self.init(nibName: nibName, bundle: nibBundle, viewFrame: nil, viewOptions: nil)
	}
	
	public required init?(coder aDecoder:NSCoder) {
		_initViewFrame = CGRect.null
		_initViewOptions = nil
		
		super.init(coder: aDecoder)
	}
	
	
	private let _initViewFrame:CGRect
	private let _initViewOptions:[String:Any]?
	
	
	public var scnView:SCNView {
		return self.view as! SCNView
	}
	public var scene:SCNScene? {
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
			let view = SCNView(frame: _initViewFrame, options: _initViewOptions)
			if #available(macOS 10.11, iOS 9.0, tvOS 9.0, *), NSClassFromString("AVAudioEngine") != nil {
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
	
	#if os(iOS)
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
		
		/// Release any cached data, images, etc that aren't in use.
		public override func didReceiveMemoryWarning() {
			super.didReceiveMemoryWarning()
		}
	#endif
}
