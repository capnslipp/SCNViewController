// SCNViewController
// @copyright: Slipp Douglas Thompson
// @copyright date: The date(s) of version control check-ins corresponding to this file and this project as a whole; or in lieu of, no earlier than June 2016.

import UIKit
import SceneKit



public class SCNViewController : UIViewController
{
	enum Error : Swift.Error {
		case nibStoryboardViewIsNotAnSCNView
	}
	
	
    public required init(nibName nibNameOrNil:String?, bundle nibBundleOrNil:Bundle?, viewFrame:CGRect?, viewOptions:[String:AnyObject]? = [:])
	{
		if nibNameOrNil == nil {
			_initViewFrame = viewFrame
			_initViewOptions = viewOptions
		} else {
			_initViewFrame = nil
			_initViewOptions = nil
		}
		
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}
	public convenience init(viewFrame:CGRect?, viewOptions:[String:AnyObject]? = [:]) {
		self.init(nibName: nil, bundle: nil, viewFrame: viewFrame, viewOptions: viewOptions)
	}
	
    public convenience override init(nibName nibNameOrNil:String?, bundle nibBundleOrNil:Bundle?) {
		self.init(nibName: nibNameOrNil, bundle: nibBundleOrNil, viewFrame: nil, viewOptions: nil)
	}
	
	public required init?(coder aDecoder:NSCoder) {
		_initViewFrame = nil
		_initViewOptions = nil
		
		super.init(coder: aDecoder)
	}
	
	
	private let _initViewFrame:CGRect?
	private var initViewFrame:CGRect {
		return _initViewFrame ?? CGRect.null
	}
	
	private let _initViewOptions:[String:AnyObject]?
	private var initViewOptions:[String:AnyObject]? {
		return _initViewOptions
	}
	
	
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
		
		self.view = SCNView(frame: self.initViewFrame, options: self.initViewOptions)
	}
	
	public override func viewDidLoad()
	{
		self.scnView.scene = SCNScene()
		
		super.viewDidLoad()
	}
	
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

}
