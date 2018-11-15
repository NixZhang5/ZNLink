//
//  StaticLinkViewController.swift
//  ZNLink
//
//  Created by xinpin on 2018/11/15.
//  Copyright © 2018年 Nix. All rights reserved.
//

import UIKit

class StaticLinkViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "静态链表"
        self.view.backgroundColor = UIColor.white
        
        let link = StaticLink.init()
        var array = link.reserve()
        /*
         初始化备用链表
        index:0, data:None, cur:1
        index:1, data:None, cur:2
        index:2, data:None, cur:3
        index:3, data:None, cur:4
        index:4, data:None, cur:5
        index:5, data:None, cur:6
        index:6, data:None, cur:0
        */
        print("----------初始化 [a, b, c, d]----------");
        let body = link.initArray(array: &array)
        link.displayArray(array: array, body: body)
        /*
        index:0, data:None, cur:6
        index:1, data:None, cur:2
        index:2, data:a, cur:3
        index:3, data:b, cur:4
        index:4, data:c, cur:5
        index:5, data:d, cur:0
        index:6, data:None, cur:0
        */

        print("----------insert e at cur 3----------")
        link.insert(array: &array, body: body, add: 3, data: "e")
        link.displayArray(array: array, body: body)
        
        print("----------delete a node----------")
        link.delete(array: &array, body: body, data: "a")
        link.displayArray(array: array, body: body)

        print("----------search e----------");
        let selectAdd = link.selectElement(array: &array, body: body, data: "e")
        print("e at index:\(selectAdd)")
        
        print("----------change e to h----------");
        link.amendElem(array: &array, body: body, oldData: "e", newData: "h")
        link.displayArray(array: array, body: body)

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

struct Component {
    var data: String?
    var cur: Int
}

class StaticLink {
    
    var maxSize: Int = 7
    
    //创建备用链表
    func reserve() -> [Component] {
        var array = [Component]()
        for i in 0..<maxSize {
            let component = Component.init(data: nil, cur: i + 1)
            array.append(component)
        }
        array[maxSize - 1].cur = 0 //链表最后一个结点的游标值为0
        return array
    }
    
    //提取分配空间
    func mallocArray(array:inout [Component]) -> Int{
        //若备用链表非空，则返回分配的结点下标，否则返回0（当分配最后一个结点时，该结点的游标值为0）
        let i = array[0].cur
        if (array[0].cur > 0) {
            array[0].cur = array[i].cur
        }
        return i
    }
    
    func initArray(array: inout [Component]) -> Int {
        //从备用链表中拿出一个分量作为链表的头结点，返回的是这个分量的下标
        let body = mallocArray(array: &array)  // 1
        //声明一个变量，把它当指针使，指向链表的最后的一个结点，因为链表为空，所以和头结点重合
        var tempBody = body
        let charArray = ["a", "b", "c", "d"]
        for i in 1..<5 {
            let j = mallocArray(array: &array) //从备用链表中拿出空闲的分量
            array[tempBody].cur = j //将申请的空线分量链接在链表的最后一个结点后面
            array[j].data = charArray[i-1]//给新申请的分量的数据域初始化
            tempBody = j //将指向链表最后一个结点的指针后移
        }
        array[tempBody].cur = 0//新的链表最后一个结点的指针设置为0
        return body
    }
    
    func insert(array: inout [Component], body: Int, add: Int, data: String) {
        var tempBody = body
        for _ in 1..<add {
            tempBody = array[tempBody].cur
        }
        let insert = mallocArray(array: &array)
        array[insert].cur = array[tempBody].cur
        array[insert].data = data
        array[tempBody].cur = insert
    }
    
    func delete(array: inout [Component], body: Int, data: String) {
        var tempBody = body
        //找到被删除结点的位置
        while (array[tempBody].data != data) {
            tempBody = array[tempBody].cur
            //当tempBody为0时，表示链表遍历结束，说明链表中没有存储该数据的结点
            if (tempBody == 0) {
                print("链表中没有此数据")
                return
            }
        }
        //运行到此，证明有该结点
        let del = tempBody
        tempBody = body
        //找到该结点的上一个结点，做删除操作
        while (array[tempBody].cur != del) {
            tempBody = array[tempBody].cur
        }
        //将被删除结点的游标直接给被删除结点的上一个结点
        array[tempBody].cur = array[del].cur
        free(array: &array, k: del)
    }
    
    func selectElement(array: inout [Component], body: Int, data: String) -> Int{
        var tempBody = body
        //当游标值为0时，表示链表结束
        while (array[tempBody].cur != 0) {
            if (array[tempBody].data == data) {
                return tempBody
            }
            tempBody = array[tempBody].cur
        }
        return -1 //返回-1，表示在链表中没有找到该元素
    }
    
    func amendElem(array: inout [Component], body: Int, oldData: String, newData: String){
        let add = selectElement(array: &array, body: body, data: oldData)
        if (add == -1) {
            print("无更改元素")
            return
        }
        array[add].data = newData
    }
    
    func displayArray(array: [Component], body: Int) {
        var tempBody = body //tempBody准备做遍历使用
        while (array[tempBody].cur > 0) {
            print("data:\(array[tempBody].data ?? "None"), cur:\(array[tempBody].cur)")
            tempBody = array[tempBody].cur
        }
        print("data:\(array[tempBody].data ?? "None"), cur:\(array[tempBody].cur)")
        print("**********************************")
        for (i,component) in array.enumerated() {
            print("index:\(i), data:\(component.data ?? "None"), cur:\(component.cur)")
        }
    }
    
    func free(array: inout [Component], k: Int){
        array[k].cur = array[0].cur
        array[k].data = nil
        array[0].cur = k
    }
}

