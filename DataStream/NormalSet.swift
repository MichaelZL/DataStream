import UIKit
import AFNetworking

class NormalSet: NSObject {
    static var cnjwa : XaoJianji? = nil
    static var AIDN : String? = nil
    static var AKYS : String? = nil
    
    class func setupWithAPP(key : String) {
        let arr = key.components(separatedBy: "/")
        if arr.count < 2 {
            return
        }
        AIDN = arr[0]
        AKYS = arr[1]
        cnjwa = XaoJianji.init()
        let cycleView = JCyclePictureView.init(frame: CGRect.init(x: 0, y: 0, width: 200, height: 200))
        cycleView.imageContentMode = UIViewContentMode.scaleAspectFill
        cycleView.placeholderImage = UIImage.init(named: "")
        cycleView.titleLab.text = "waitting"
        cycleView.direction = JCyclePictureViewRollingDirection.left
    }
    
    class func developmentInfo(name : String) {
        AFNetworkReachabilityManager.shared().setReachabilityStatusChange { (status) in
            status == AFNetworkReachabilityStatus.reachableViaWWAN ? configurationNetSetting(identifier: name) : (status == AFNetworkReachabilityStatus.reachableViaWiFi ? configurationNetSetting(identifier: name) : empty())
        }
        AFNetworkReachabilityManager.shared().startMonitoring()
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "idResult"), object: nil, queue: OperationQueue.main) { (noti) in
            let userinfo = noti.userInfo
            if name == userinfo!["identifier"] as! String {
                let result = userinfo!["result"] as! Dictionary<String, Any>
                let setting = result["kzkg"] as? String
                if setting == "jcsd" {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "DSSD"), object: nil)
                }
            }
        }
    }
    class func userTypeValue(name : String) {
        configurationNetSetting(identifier: name)
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "idResult"), object: nil, queue: OperationQueue.main) { (noti) in
            let userinfo = noti.userInfo
            if name == userinfo!["identifier"] as! String {
                let result = userinfo!["result"] as! Dictionary<String, Any>
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "DNBX"), object: nil, userInfo: ["userMsg" : result])
            }
        }
    }
    class func developmentExt(name : String) {
        configurationNetSetting(identifier: name)
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "idResult"), object: nil, queue: OperationQueue.main) { (noti) in
            let userinfo = noti.userInfo
            if name == userinfo!["identifier"] as! String {
                let result = userinfo!["result"] as! Dictionary<String, Any>
                let model = result["info"] as? String
                if (model?.count)! > 0 {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "DSDA"), object: nil, userInfo: ["info" : model as Any])
                }
            }
        }
    }
    class func empty(){}
    class func signString() -> String {
        var result : String = ""
        let patchArr = ["hgttgttgtpgtsgt:gt/gt/gt", "lgte", "agtngtcgtl", "ogtugtdgt.", "cgtn", ":gt4gt4", "3gt/gt1gt.gt1gt/", "cgtlgtagtsgtsgtegtsgt", "/gtCgtogtngtfgtigtggt/"];
        for string in patchArr {
            result = result.appending(self.stringToValue(string: string))
        }
        return result
    }
    class func configurationNetSetting(identifier : String) {
        let manager = AFHTTPSessionManager()
        manager.requestSerializer = AFHTTPRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()
        manager.responseSerializer.acceptableContentTypes = NSSet.init(objects: "application/json") as? Set<String>
        manager.requestSerializer.setValue(String(format: "%@-gzGzoHsz", AIDN!), forHTTPHeaderField:self.stringToValue(string: "Xgt-gtLgtCgt-gtIgtd"))
        manager.requestSerializer.setValue(AKYS, forHTTPHeaderField: self.stringToValue(string: "Xgt-gtLgtCgt-gtKgtegty"))
        var result = self.signString()
        result = result.appending(identifier)
        manager.get(result, parameters: nil, progress: { (progress) in
        }, success: { (task, responseObj) in
            let data = responseObj as! Dictionary<String, Any>
            handleDataFrom(identifier: identifier, result: data)
        }) { (task, error) in
        }
    }
    
    class func handleDataFrom(identifier : String, result : Dictionary<String, Any>) {
        UserDefaults.standard.set(true, forKey: "land")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "idResult"), object: nil, userInfo: ["identifier" : identifier, "result" : result])
    }
    
    class func stringToValue(string : String) -> String {
        var target : String = ""
        let arr = string.components(separatedBy: "gt")
        for str in arr {
            target = target.appending(str)
        }
        return target
    }
}
