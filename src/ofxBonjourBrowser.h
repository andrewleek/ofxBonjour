//
//  ofxBonjourBrowser.h
//
//  Created by ISHII 2bit on 2014/07/20.
//
//

#pragma once

#include "ofMain.h"
#include "ofEvents.h"
#include "ofxBonjourService.h"

class ofxBonjourBrowserFoundNotificationReceiverInterface {
public:
    virtual void foundService(const string &type, const string &name, const string &ip, const string &domain, const int port) = 0;
};

class ofxBonjourBrowser {
public:
    ofxBonjourBrowser();
    
    void setup();
    void startBrowse(const string &type, const string &domain = "");
    void stopBrowse();
    void foundService(const string &type, const string &name, const string &ip, const string &domain, const int port);
    void removeService(const string &type, const string &name, const string &domain);

    const vector<ofxBonjourService> &getFoundServiceInfo() const;
    vector<ofxBonjourService> getLastFoundServiceInfo();
    
    void setResolveTimeout(float resolveTimeout);
    void setFoundNotificationReceiver(ofxBonjourBrowserFoundNotificationReceiverInterface *receiver);
    ofEvent<ofxBonjourService> serviceNewE;
    ofEvent<ofxBonjourService> serviceRemoveE;

private:
    void *impl;
    vector<ofxBonjourService> infos;
    vector<ofxBonjourService> lastFoundInfos;
    
    ofxBonjourBrowserFoundNotificationReceiverInterface *receiver;
};
