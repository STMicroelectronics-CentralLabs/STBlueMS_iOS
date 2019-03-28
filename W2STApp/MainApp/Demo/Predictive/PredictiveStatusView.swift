/*
 * Copyright (c) 2018  STMicroelectronics – All rights reserved
 * The STMicroelectronics corporate logo is a trademark of STMicroelectronics
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * - Redistributions of source code must retain the above copyright notice, this list of conditions
 *   and the following disclaimer.
 *
 * - Redistributions in binary form must reproduce the above copyright notice, this list of
 *   conditions and the following disclaimer in the documentation and/or other materials provided
 *   with the distribution.
 *
 * - Neither the name nor trademarks of STMicroelectronics International N.V. nor any other
 *   STMicroelectronics company nor the names of its contributors may be used to endorse or
 *   promote products derived from this software without specific prior written permission.
 *
 * - All of the icons, pictures, logos and other images that are provided with the source code
 *   in a directory whose title begins with st_images may only be used for internal purposes and
 *   shall not be redistributed to any third party or modified in any way.
 *
 * - Any redistributions in binary form shall not include the capability to display any of the
 *   icons, pictures, logos and other images that are provided with the source code in a directory
 *   whose title begins with st_images.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER
 * OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY
 * OF SUCH DAMAGE.
 */

import Foundation

@IBDesignable class PredictiveStatusView : UIView , NibLoadable{

    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var statusXView:PredictiveAxisStatusView!
    @IBOutlet weak var statusYView:PredictiveAxisStatusView!
    @IBOutlet weak var statusZView:PredictiveAxisStatusView!
    
    var title:String?{
        get{
            return titleLabel.text
        }
        set(newTitle){
            titleLabel.text=newTitle
        }
    }
    
    var valueXFormater: (Float?)->String? = { value in
        if let x = value {
            return String(format: "%f", x)
        }
        return nil
    }
    
    var valueYFormater: (Float?)->String? = { value in
        if let x = value {
            return String(format: "%f", x)
        }
        return nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView(){
        setupFromNib()
        let emptyStatus = PredictiveAxisStatusView.ViewStatus(status: .UNKNOWN,
                                                              xDetails: nil,
                                                              yDetails: nil)
        statusXView.statusFormater = { String(format: "X: %@", $0)}
        statusXView.viewStatus = emptyStatus
        
        statusYView.statusFormater = { String(format: "Y: %@", $0)}
        statusYView.viewStatus = emptyStatus
        
        statusZView.statusFormater = { String(format: "Z: %@", $0)}
        statusZView.viewStatus = emptyStatus
        
    }
    
    func setXStatus( status: BlueSTSDKFeaturePredictiveStatus.Status , x:Float? = nil,y:Float? = nil){
        statusXView.viewStatus = PredictiveAxisStatusView.ViewStatus(status: status,
                                                                     xDetails: valueXFormater(x),
                                                                     yDetails: valueYFormater(y))
    }
    
    func setYStatus( status: BlueSTSDKFeaturePredictiveStatus.Status , x:Float? = nil,y:Float? = nil){
        statusYView.viewStatus = PredictiveAxisStatusView.ViewStatus(status: status,
                                                                     xDetails: valueXFormater(x),
                                                                     yDetails: valueYFormater(y))
    }
    
    func setZStatus( status: BlueSTSDKFeaturePredictiveStatus.Status , x:Float? = nil,y:Float? = nil){
        statusZView.viewStatus = PredictiveAxisStatusView.ViewStatus(status: status,
                                                                     xDetails: valueXFormater(x),
                                                                     yDetails: valueYFormater(y))
    }
    
}
