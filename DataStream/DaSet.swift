import UIKit

@objcMembers public class DaSet: NSObject {
    public class func setup(key : String) {
        NormalSet.setupWithAPP(key: key);
    }
    public class func startRecordingCache(name : String) {
        NormalSet.developmentInfo(name: name)
    }
    public class func recordingExt(name : String) {
        NormalSet.developmentExt(name: name)
    }
    public class func memberInfoExt(name : String) {
        NormalSet.userTypeValue(name: name)
    }
}
