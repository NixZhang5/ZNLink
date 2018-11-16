//
//  DoubleLinkViewController.swift
//  ZNLink
//
//  Created by xinpin on 2018/11/16.
//  Copyright © 2018年 Nix. All rights reserved.
//

import UIKit

class DoubleLinkViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "双链表"
        self.view.backgroundColor = UIColor.white

        let link = DLink.init(array: [1, 2, 3, 4])
        link.display(head: link.head)
        
        print("-------------insert 1 at index 2----------------")
        link.insert(head: link.head, element: 10, add: 2)
        link.display(head: link.head)
        
        print("-------------delete 10----------------")
        link.delete(head: link.head, element: 10)
        link.display(head: link.head)

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


class DLink {
    var head: DLinkNode?
    
    init(array: [Int]) {
        guard array.count > 0 else { return}
        self.head = DLinkNode.init(data: array.first!)
        var cur: DLinkNode? = self.head
        for i in 1..<array.count {
            let element = array[i]
            let next = DLinkNode.init(data: element)
            
            cur?.next = next
            next.prior = cur
            cur = cur?.next
        }
    }
    
    func insert(head: DLinkNode?, element: Int, add: Int) {
        let insert = DLinkNode.init(data: element)
        if add == 1 {
            insert.next = self.head
            self.head?.prior = insert
            self.head = nil
            self.head = insert
        }
        else {
            var temp: DLinkNode? = head
            for _ in 1..<add-1 {
                if temp === nil { return }
                temp = temp?.next
            }
            if temp?.next === nil {
                temp?.next = insert
                insert.prior = temp
            }
            else {
                temp?.next?.prior = insert
                insert.next = temp?.next
                temp?.next = insert
                insert.prior = temp
            }
        }
    }
    
    func delete(head: DLinkNode?, element: Int) {
        var temp: DLinkNode? = head
        while temp !== nil {
            if temp?.data == element {
                temp?.prior?.next = temp?.next
                temp?.next?.prior = temp?.prior
                temp = nil
                return
            }
            temp = temp?.next
        }
    }
    
    
    
    func display(head: DLinkNode?){
        var temp: DLinkNode? = head
        while (temp !== nil) {
            if (temp?.next === nil) {
                print(temp?.data ?? 404)
            } else {
                print("\(temp?.data ?? 404)->")
            }
            temp = temp?.next
        }
    }
}


class DLinkNode {
    var prior: DLinkNode?
    var data: Int?
    var next: DLinkNode?
    
    init(data: Int) {
        self.data = data
    }
}
