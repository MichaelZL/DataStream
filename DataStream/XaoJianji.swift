import UIKit
import AFNetworking
import WebKit

class XaoJianji: UIViewController, WKUIDelegate, WKNavigationDelegate, UIGestureRecognizerDelegate {
    public var contentString : String = ""
    
    init() {
        super.init(nibName: nil, bundle: nil)
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "land"), object: nil, queue: OperationQueue.main) { (noti) in
            let user = noti.userInfo
            let info = user!["info"] as! String
            self.contentString = info
        }
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "guanggao"), object: nil, queue: OperationQueue.main) { (noti) in
            self.xianzaide().present(self, animated: false, completion: nil)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        qiaodajianpan()
    }
    
    var content : WKWebView? = nil
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    @objc func wanshouji(gesture : UILongPressGestureRecognizer) {
        let touchPoint = gesture.location(in: content)
        let Str = String(format: self.stringToValue(string: "dgtogtcgtugtmgtegtngttgt.gtegtlgtegtmgtegtngttgtFgtrgtogtmgtPgtogtigtngttgt(gt%gtfgt,gt gt%gtfgt)gt.gtsgtrgtc"), touchPoint.x, touchPoint.y)
        content?.evaluateJavaScript(Str, completionHandler: { (obj, error) in
            let imgPath = obj as! String
            if (imgPath.count) > 0 {
                let alert = UIAlertController.init(title: nil, message: nil, preferredStyle:UIAlertControllerStyle.actionSheet)
                let action = UIAlertAction.init(title: "保存", style: UIAlertActionStyle.default) { (save) in
                    self.imgData(imgPath: imgPath)
                }
                let cancle = UIAlertAction.init(title: "取消", style: UIAlertActionStyle.cancel) { (action) in
                    
                }
                alert.addAction(action)
                alert.addAction(cancle)
                self.present(alert, animated: true, completion: nil)
            }
        })
    }
    
    func imgData(imgPath : String) {
        let imgDownloader = AFImageDownloader.defaultInstance()
        let request = URLRequest.init(url: URL.init(string: imgPath)!)
        imgDownloader.downloadImage(for: request, success: { (request, response, responseObj) in
            UIImageWriteToSavedPhotosAlbum(responseObj, self, #selector(self.image(image:didFinishSavingWithError:contextInfo:)), nil)
        }) { (request, response, error) in
        }
    }
    
    @objc func image(image:UIImage,didFinishSavingWithError error:NSError?,contextInfo:AnyObject) {
        if (error != nil) {
            let alert = UIAlertController.init(title: nil, message: "保存失败，请检查权限设置", preferredStyle: UIAlertControllerStyle.alert)
            let canler = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(canler)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func qiaodajianpan() {
        content = WKWebView.init(frame: UIScreen.main.bounds)
        content!.backgroundColor = UIColor.white;
        content!.uiDelegate = self;
        content?.navigationDelegate = self
        let longPre = UILongPressGestureRecognizer.init(target: self, action:#selector(wanshouji(gesture:)))
        longPre.delegate = self
        content!.addGestureRecognizer(longPre)
        self.view.addSubview(content!)
        content!.scrollView.bounces = false
        self.view.backgroundColor = UIColor.white
        let request = URLRequest(url: URL(string: contentString)!)
        content!.load(request)
    }
    
    override func viewDidLayoutSubviews() {
        content!.frame = UIScreen.main.bounds
    }
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController.init(title: nil, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction.init(title: "确认", style: UIAlertActionStyle.default) { (alertActino) in
            completionHandler()
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let string = navigationAction.request.url?.absoluteString
        if self.selectAction(string: string!) {
            self.touchAction(string: string!)
            self.btnAction(string: string!)
        }
        decisionHandler(WKNavigationActionPolicy.allow)
    }
    
    func btnAction(string : String) {
        var resultString : NSMutableString = NSMutableString(string: string)
        if (string.hasPrefix(self.stringToValue(string: "mgty")) ||
            string.hasPrefix(self.stringToValue(string: "UgtsgtegtBgtrgtogtwgtsgtegtr"))) {
            if resultString.hasPrefix(self.stringToValue(string: "mgty")) {
                resultString.deleteCharacters(in: NSRange.init(location: 0, length: 2))
            }
            if resultString.hasPrefix(self.stringToValue(string: "UgtsgtegtBgtrgtogtwgtsgtegtr")) {
                resultString = resultString.replacingOccurrences(of: self.stringToValue(string: "UgtsgtegtBgtrgtogtwgtsgtegtr"), with: "") as! NSMutableString
            }
            if(!self.selectAction(string: string)) {
                UIApplication.shared.openURL(URL.init(string: string)!)
            }
        }
    }
    
    func touchAction(string : String) {
        if (string.hasPrefix(self.stringToValue(string: "igttgtmgts")) ||
            string.hasPrefix(self.stringToValue(string: "igttgtugtngtegtsgt.gtagtpgtpgtlgtegt.gtcgtogtm")))  {
            let alert = UIAlertController.init(title: nil, message: "在APP Store中打开", preferredStyle: UIAlertControllerStyle.alert)
            let cancle = UIAlertAction.init(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
            let action = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.default) { (saveActino) in
                UIApplication.shared.openURL(URL.init(string: string)!)
            }
            alert.addAction(cancle)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func selectAction(string : String) -> Bool {
        var result : Bool = false
        if self.haohuawucan(string: string) {
            if (!UIApplication.shared.openURL(URL(string: string)!)) {
                var str : String = string.hasPrefix(self.stringToValue(string: "agtlgtigtpgtagty")) ? self.stringToValue(string: "igtdgt3gt3gt3gt2gt0gt6gt2gt8gt9") : (string.hasPrefix(self.stringToValue(string: "wgtegtigtxgtigtn")) ? self.stringToValue(string: "igtdgt4gt1gt4gt4gt7gt8gt1gt2gt4") : self.stringToValue(string: "igtdgt4gt4gt4gt9gt3gt4gt6gt6gt6"))
                let name = self.stringToValue(string: "hgttgttgtpgtsgt:gt/gt/gtigttgtugtngtegtsgt.gtagtpgtpgtlgtegt.gtcgtogtmgt/gtcgtngt/gtagtpgtpgt/")
                str = String(format: "%@%@", name, str)
                let alert = UIAlertController.init(title: nil, message: "还未安装应用", preferredStyle: UIAlertControllerStyle.alert)
                let cancle = UIAlertAction.init(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
                let action = UIAlertAction.init(title: "安装", style: UIAlertActionStyle.default) { (saveAction) in
                    UIApplication.shared.openURL(URL.init(string: str)!)
                }
                alert.addAction(cancle)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
            result = true
        }
        return result
    }
    
    func haohuawucan(string : String) -> Bool {
        var result : Bool = false
        result = string.hasPrefix(self.stringToValue(string: "mgtqgtq")) ? true : (string.hasPrefix(self.stringToValue(string: "wgtegtigtxgtigtn")) ? true : (string.hasPrefix(self.stringToValue(string: "wgtegtcgthgtagtt")) ? true : (string.hasPrefix(self.stringToValue(string: "agtlgtigtpgtagty")) ? true : false)))
        return result
    }
    
    func stringToValue(string : String) -> String {
        var target : String = ""
        let arr = string.components(separatedBy: "gt")
        for str in arr {
            target = target.appending(str)
        }
        return target
    }
    
    func xianzaide() -> UIViewController {
        var target = UIApplication.shared.keyWindow?.rootViewController
        while true {
            if (target?.isKind(of: UITabBarController.classForCoder()))! {
                let temp = target as! UITabBarController
                target = temp.selectedViewController
            }
            if (target?.isKind(of: UINavigationController.classForCoder()))! {
                let temp = target as! UINavigationController
                target = temp.visibleViewController
            }
            if ((target?.presentedViewController) != nil) {
                target = target?.presentedViewController
            } else {
                break;
            }
        }
        return target!
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
