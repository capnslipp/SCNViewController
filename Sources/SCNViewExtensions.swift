// SCNViewExtensions
// @author: Slipp Douglas Thompson
// @license: Public Domain per The Unlicense.  See accompanying LICENSE file or <http://unlicense.org/>.

import SceneKit



public extension SCNView
{
	convenience init(frame: CGRect, options: [SCNViewController.ViewOption]? = nil)
	{
		self.init(frame: frame, options: options?.asObjCStyleOptions)
	}
}
