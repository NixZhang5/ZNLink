//
//  PalindromeViewController.swift
//  ZNLink
//
//  Created by xinpin on 2018/11/20.
//  Copyright © 2018年 Nix. All rights reserved.
//

import UIKit

class PLink {
    
    var head: PLinkNode?
    
    init(str: String) {
        if str.count > 0 {
            var cur: PLinkNode?
            for (i,value) in str.enumerated() {
                if i == 0 {
                    self.head = PLinkNode.init(value: String(value))
                    cur = self.head
                }
                else {
                    let node = PLinkNode.init(value: String(value))
                    cur?.next = node
                    cur = cur?.next
                }
            }
        }
    }
    
    func isPalindrome(head: PLinkNode?) -> Bool {
        var fast: PLinkNode? = head, slow: PLinkNode? = head
        while (fast !== nil && fast?.next !== nil) {
            fast = fast?.next?.next
            slow = slow?.next!
        }
        if (fast != nil) { // odd nodes: let right half smaller
            slow = slow?.next!
        }
        slow = reverse(head: slow!)
        fast = head
        
        while (slow != nil) {
            if (fast?.value != slow?.value) {
                return false;
            }
            fast = fast?.next
            slow = slow?.next
        }
        return true
    }
    
    func reverse(head: PLinkNode) -> PLinkNode {
        var pre: PLinkNode?
        var cur: PLinkNode? = head
        while cur != nil {
            let next = cur?.next
            cur?.next = pre
            pre = cur
            cur = next
        }
        return pre!
    }
}

class PLinkNode {
    var value: String?
    var next: PLinkNode?
    
    init(value: String?) {
        self.value = value
    }
}

class PalindromeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "回文，反转链表"
        self.view.backgroundColor = UIColor.white
        
        let str = "abcdefggfedcba"
        let link = PLink.init(str: str)
        let result = link.isPalindrome(head: link.head)
        print("\(str) isPalindrome:\(result)")
        
        let result2 = isPalindrome(str: str)
        print("\(str) isPalindrome:\(result2)")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func isPalindrome(str: String) -> Bool {
        let mid = str.count / 2
        let reverse = String(str.reversed())
        for (i,value) in str.enumerated() {
            let index = reverse.index(reverse.startIndex, offsetBy: i)
            let reverseStr = reverse[index]
            if reverseStr != value {
                return false
            }
            if i > mid {
                break
            }
        }
        return true
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
