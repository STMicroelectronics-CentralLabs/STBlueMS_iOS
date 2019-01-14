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

/**
 * callback called when a new firmware is available
 * @param url where download the new firmware
 */

public typealias OnFwUpgradeAvailableCallback = (URL)->Void;
public typealias OnIotClientActionCallback = (Error?)->Void;


public protocol BlueMSCloudIotClient {
    var isConnected:Bool {get}
    
    func connect(_ onComplete:OnIotClientActionCallback?)
    func disconnect(_ onComplete:OnIotClientActionCallback?)
}


/**
 * protocol to implement a cloud service
 */
public protocol BlueMSCloudIotConnectionFactory{

/**
 * build a session object for connect to a specific cloud service
 *
 * @return mqtt object to use for connect and send data to the cloud service
 */
    func getSession()->BlueMSCloudIotClient


/**
 * get the url where we can display the data on the cloud
 *
 * @return webpage where show the cloud data, or nil if it is not availabe
 */
 func getDataUrl()->URL?

/**
 * return a feature listener that will pack and send the feature update to the cloud
 *
 * @param session session to use for send the data to the cloud
 *
 * @return object that will send receve and send the feature update to the cloud
 */
func getFeatureDelegate(withSession:BlueMSCloudIotClient, minUpdateInterval:TimeInterval)->BlueSTSDKFeatureDelegate

/**
 * tell if the feature is supported by the specific cloud provider
 * @param feature feature to test
 * @return  true if the feature can be used with the cloud provider, false otherwise
 */
 func isSupportedFeature(_ feature:BlueSTSDKFeature)->Bool;



/**
 * enable the cloud service to send info if a new fw is available to for the node
 * @param node node that will receive the fw upgrade
 * @param cloudConnection connection to use to comumicate with the cloud
 * @param callback function called when a new fw is available
 * @return true if the service is supported by the cloud service
 */
 func enableCloudFwUpgrade(for:BlueSTSDKNode,
                           connection:BlueMSCloudIotClient,
                           callback:@escaping OnFwUpgradeAvailableCallback)->Bool
}
