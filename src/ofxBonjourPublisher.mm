//
//  ofxBonjourPublisher.mm
//
//  Created by ISHII 2bit on 2014/07/20.
//
//

#include "ofxBonjourPublisher.h"

static const string LogTag = "ofxBonjourPublisher";

@interface BonjourPublisherImpl : NSObject {
    NSSocketPort* socket;
    NSNetService *service;
}

- (BOOL)publishForType:(NSString *)type
                  name:(NSString *)name
                  port:(int)port
                domain:(NSString *)domain;

@end

@implementation BonjourPublisherImpl

- (BOOL)publishForType:(NSString *)type
                  name:(NSString *)name
                  port:(int)port
                domain:(NSString *)domain
{
    socket = [[NSSocketPort alloc] initWithTCPPort:port];
    if (socket) {
        service = [[NSNetService alloc] initWithDomain:domain
                                                  type:type
                                                  name:name
                                                  port:port];
        if (service) {
//            service.delegate = self;
            [service scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
            [service publish];
        } else {
            ofLogVerbose(LogTag) << "invalid NSNetSevice";
        }
    } else {
        ofLogVerbose(LogTag) << "invalid NSSocketPort";
    }
}

//- (void)netServiceDidPublish:(NSNetService *)sender
//{
//    NSLog(@"%@", [sender description]);
//    socketHandle = [[NSFileHandle alloc] initWithFileDescriptor:socket.socket
//                                                  closeOnDealloc:YES];
//    if (socketHandle) {
//        NSLog(@"has sockethandle");
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptConnect:) name:NSFileHandleConnectionAcceptedNotification object:socketHandle_];
//        [socketHandle_ acceptConnectionInBackgroundAndNotify];
//    }
//}

@end

ofxBonjourPublisher::ofxBonjourPublisher()
    : impl([[BonjourPublisherImpl alloc] init]) {}

ofxBonjourPublisher::~ofxBonjourPublisher() {
    [(BonjourPublisherImpl *)impl release];
}

void ofxBonjourPublisher::setup() {
    
}

bool ofxBonjourPublisher::publish(string type, string name, int port, string domain) {
    return [(BonjourPublisherImpl *)impl publishForType:@(type.c_str())
                                                   name:@(name.c_str())
                                                   port:port
                                                 domain:@(domain.c_str())] ? true : false;
}