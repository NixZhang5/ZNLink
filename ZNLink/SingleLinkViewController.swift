//
//  SingleLinkViewController.swift
//  ZNLink
//
//  Created by xinpin on 2018/11/14.
//  Copyright © 2018年 Nix. All rights reserved.
//

import UIKit

class SingleLinkViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        // 静态链表和动态链表的区别：静态链表限制了数据元素存放的位置范围；动态链表是整个内存空间。

        // 动态链表
        print("----------init [3, 5, 6, 8, 9]-------------")
        let link = SLink.init(elements: [3, 5, 6, 8, 9])
        link.display(node: link.head)

        print("----------insert 4 atIndex 1-------------")
        link.insert(node: link.head, element: 4, add: 1)
        link.display(node: link.head)
        
        print("----------delete 4 atIndex 1-------------")
        link.deleteElement(node: link.head, add: 1)
        link.display(node: link.head)
        
        print("----------change 9 to 10-------------")
        link.changeElement(node: link.head, add: 4, targetElement: 10)
        link.display(node: link.head)

        print("----------find 8-------------")
        let result = link.find(node: link.head, element: 8)
        print("find:\(8), index:\(result)")

        
        
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

class SLink: NSObject {
    
    var head: SLinkNode = SLinkNode.init(element: 0)
    
    init(elements: [Int]) {
        var tempNode: SLinkNode = head
        for element in elements {
            let node = SLinkNode.init(element: element)
            tempNode.next = node
            tempNode = node
        }
    }
    
    func display(node: SLinkNode) {
        var temp = node
        while (temp.next != nil) {
            temp = temp.next!
            print(temp.element ?? "no value")
        }
    }
    
    func insert(node: SLinkNode, element: Int, add: Int) {
        
        var temp: SLinkNode? = node
        for _ in 0..<add {
            if temp == nil {
                return
            }
            temp = temp?.next
        }
        let insertNode = SLinkNode.init(element: element)
        insertNode.next = temp?.next
        temp?.next = insertNode
    }
    
    func deleteElement(node: SLinkNode, add: Int) {
        var temp: SLinkNode? = node
        for _ in 0..<add {
            if temp == nil {
                return
            }
            temp = temp?.next
        }
        var delNode = temp?.next
        temp?.next = delNode?.next
        delNode = nil
    }
    
    func changeElement(node: SLinkNode, add: Int, targetElement: Int) {
        var temp: SLinkNode? = node
        for _ in 0...add {
            if temp == nil {
                return
            }
            temp = temp?.next
        }
        temp?.element = targetElement
    }
    
    func find(node: SLinkNode, element: Int) -> Int {
        var temp: SLinkNode? = node
        var i = 0
        while temp != nil {
            temp = temp?.next
            if temp?.element == element {
                return i
            }
            i += 1
        }
        return -1
    }
    
}

class SLinkNode {
    var element: Int?
    var next: SLinkNode?
    
    init(element: Int) {
        self.element = element
    }
}
