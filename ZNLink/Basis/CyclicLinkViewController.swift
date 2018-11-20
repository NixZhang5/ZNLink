//
//  CyclicLinkViewController.swift
//  ZNLink
//
//  Created by xinpin on 2018/11/15.
//  Copyright © 2018年 Nix. All rights reserved.
//

import UIKit

class CyclicLinkViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "循环链表、约瑟夫环"
        self.view.backgroundColor = UIColor.white

        let link = CLink.init(count: 5)
        // 从第三个人开始报数1  报数2的人出列
        link.findAndKill(head: link.head, k: 3, m: 2)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


class CLink {
    var head: CLinkNode
    
    init(count: Int) {
        head = CLinkNode.init(element: 1)
        var cur: CLinkNode? = head
        for i in 2...count {
            let node = CLinkNode.init(element: i)
            cur?.next = node
            cur = cur?.next
        }
        cur?.next = head
    }
    
    func findAndKill(head: CLinkNode?, k: Int, m: Int) {
        var tail: CLinkNode? = head
        while tail?.next !== head {
            tail = tail?.next
        }
        var cur: CLinkNode? = head
        // 找到编号为k的人
        while cur?.element != k {
            tail = cur
            cur = cur?.next
        }
        while cur?.next !== cur {
            //找到从p报数1开始，报m的人，并且还要知道数m-1de人的位置tail，方便做删除操作。
            for _ in 1..<m {
                tail = cur
                cur = cur?.next
            }
            tail?.next = cur?.next
            print("出列编号：\(cur?.element ?? 404)")
            cur = nil
            //继续使用cur指针指向出列编号的下一个编号，游戏继续
            cur = tail?.next
        }
        print("胜出编号：\(cur?.element ?? 404)")
        cur = nil
    }
    
}

class CLinkNode {
    var element: Int?
    var next: CLinkNode?
    
    init(element: Int) {
        self.element = element
    }
}
