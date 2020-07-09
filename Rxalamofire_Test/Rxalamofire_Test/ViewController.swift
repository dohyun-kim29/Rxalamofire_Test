//
//  ViewController.swift
//  Rxalamofire_Test
//
//  Created by DohyunKim on 2020/07/09.
//  Copyright © 2020 DohyunKim. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxOptional
import Alamofire
import RxAlamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    let img = UIImage(named: "teoulttak")
    let url = URL(string : "http://dminside.kro.kr/api/images")
    
    var disposebag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = img
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnPost(_ sender: Any) {
        connect()
        .subscribe()
        .disposed(by: disposebag)
    }
    
    
    func connect() ->  Observable<String> {
        return Observable<String>.create({observer in
            let param : [String:String] = [:]
            let header = ["application/json" : "multipart/form-data"]
            Alamofire.upload(multipartFormData: {multipartFormData in
                if let imageData = self.img!.jpegData(compressionQuality: 0.8) { multipartFormData.append(imageData, withName: "image", fileName: "image.jpg", mimeType: "image/jpg")
                    
                }
                for (key, value) in param {
                    multipartFormData.append((value.data(using: .utf8))!, withName: key)
                }}, to: self.img as! URLConvertible, method: .post, headers: header,
                    encodingCompletion: { encodingResult in
                        switch encodingResult {
                        case .success(let upload, _, _):
                            upload.responseJSON { [weak self] response in
                                
                                guard self != nil else {
                                    return
                                    
                                }
                                guard response.result.error == nil else {
                                    return
                                }
                                
                                if let value: Any = response.result.value {
                                    observer.onNext(value as! String)
                                    
                                }
                                
                            }
                        case .failure(let encodingError):
                            print("error:\(encodingError)")
                            
                        }
                        
                        
            })
             return Disposables.create();
        }
        
    
    )}

}
