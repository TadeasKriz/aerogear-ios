/*
 * JBoss, Home of Professional Open Source.
 * Copyright Red Hat, Inc., and individual contributors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#ifdef CCBUILD

#import <SenTestingKit/SenTestingKit.h>
#import "AGCodeCoverageHelper.h"

@interface AGTestObserver : SenTestObserver
@end

static id mainSuite = nil;

@implementation AGTestObserver

+ (void)initialize {
    [[NSUserDefaults standardUserDefaults] setValue:@"AGTestObserver" forKey:SenTestObserverClassKey];
    [super initialize];
}

+(void)testSuiteDidStart:(NSNotification*)notification {
    [super testSuiteDidStart:notification];
    
    SenTestSuiteRun* suite = notification.object;
    if(mainSuite == nil) {
        mainSuite = suite;
    }
}

+(void)testSuiteDidStop:(NSNotification *)notification {
    [super testSuiteDidStop:notification];
    
    SenTestSuiteRun* suite = notification.object;
    if(mainSuite == suite) {
        [AGCodeCoverageHelper flushGcov];
    }
}

@end
#endif