//
//  MKThread.swift
//  MyKitchen
//
//  Created by wochu on 16/1/6.
//  Copyright © 2016年 @Wochu. All rights reserved.
//

import UIKit

func go(b : dispatch_block_t){
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 2), b)
}

func run(b : dispatch_block_t){
    if NSThread.isMainThread() {
        b()
    }
    else{
        dispatch_async(dispatch_get_main_queue(), b)
    }
}

class MKThread: MKObject {
}
