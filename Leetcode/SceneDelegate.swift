//
//  SceneDelegate.swift
//  Leetcode
//
//  Created by jieming on 2021/2/19.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    public class TreeNode {
        public var val: Int
        public var left: TreeNode?
        public var right: TreeNode?
        public init() { self.val = 0; self.left = nil; self.right = nil; }
        public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
        public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
            self.val = val
            self.left = left
            self.right = right
        }
    }
    
    class ListNode {
       var val: Int
       var next: ListNode?
       init(_ val: Int, _ next: ListNode? = nil) {
           self.val = val
           self.next = next
       }
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        
        func reserveNode(_ head: ListNode?) -> ListNode? {
            guard let head = head else { return nil }
            var cur: ListNode? = head, next: ListNode? = nil
            while cur != nil {
                let tmp = cur?.next
                cur?.next = next
                next = cur
                cur = tmp
            }
            return next
        }
        
        
        func hasCycle(_ head: ListNode?) -> Bool {
            guard let head = head else { return false }
            var slow = head.next, fast = head.next?.next
            while slow != nil && fast != nil {
                if slow === fast {
                    return true
                }
                slow = slow?.next
                fast = fast?.next?.next
            }
            return false
        }
        
    
        func twoSum ( _ numbers: [Int],  _ target: Int) -> [Int] {
            // write code here
            var dic = [Int: Int]()
            for i in 0..<numbers.count {
                let num = numbers[i]
               let val = dic[target - num]
                if (val != nil) {
                    return [val! + 1, i + 1]
                } else {
                   dic[num] = i
                }
            }
            return []
        }
        
        print(twoSum([3,3], 6))
        
        
        func lengthOfLongestSubstring(_ s: String) -> Int {
            if s.count == 0 { return 0 }
            var left = 0, right = 0, dic = [Character: Int]()
            for (i, char) in s.enumerated() {
                let val = dic[char]
                if val != nil {
                    left = val! + 1
                }
                dic[char] = i
                right += 1
                print(left, right)
            }
            return right - left
        }
        
        print(lengthOfLongestSubstring("abcabcbb"))
        
        // 相交链表
        func getIntersectionNode(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
            guard let headA = headA else { return nil }
            guard let headB = headB else { return nil }
        
            var curA: ListNode? = headA, curB: ListNode? = headB
            while curA !== curB {
                curA = curA == nil ? headB : curA?.next
                curB = curB == nil ? headA : curB?.next
            }
            return curA
        }
        
        // 倒数第k个节点
        func getKthFromEnd(_ head: ListNode?, _ k: Int) -> ListNode? {
            guard let head = head else { return nil }
            var left: ListNode? = head, right: ListNode? = head
            for _ in 0..<k {
                right = right?.next
            }
            while right != nil {
                left = left?.next
                right = right?.next
            }
            return left
        }
        
        
        // 最大子序和
        func maxSubArray(_ nums: [Int]) -> Int {
            if nums.count == 0 { return 0 }
            var sum = nums.first!, lastSum = 0
            for i in 0..<nums.count {
                lastSum = max(lastSum + nums[i], nums[i])
                sum = max(sum, lastSum)
            }
            return sum
        }
        
        print(maxSubArray([-2,1,-3,4,-1,2,1,-5,4]))
        
        
        func ReverseList ( _ head: ListNode?) -> ListNode? {
            guard let head = head else { return nil }
            var cur: ListNode? = head, next: ListNode? = nil
            while cur != nil {
                let tmp = cur!.next
                cur!.next = next
                next = cur
                cur = tmp
            }
            return next
        }
        
        

        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    func testCode() {
        func test(_ x: Int, _ n: Int) -> Int {
            if n == 0 { return 1 }
            var result = x
            for _ in 1..<n {
                result = result * x
            }
            return result
        }
        
        func test2(_ x: Int, _ n: Int) -> Int {
            if n == 0 { return 1 }
            
            let t = test2(x, n / 2)
            if (n % 2 == 1) {
                return t * t * x
            }
            return t * t
        }
        
        print(test2(2, 5))
        
        func partitionLomuto<T: Comparable>(_ a: inout [T]) -> Int {
            let low = 0
            let high = a.count - 1
            let pivot = a[high]

              var i = low
              for j in low..<high {
                if a[j] <= pivot {
                  (a[i], a[j]) = (a[j], a[i])
                  i += 1
                }
              }

              (a[i], a[high]) = (a[high], a[i])
              return i
        }
        
        var arr = [9,7,8,5,4,3,2,6]
        print(partitionLomuto(&arr))
        
        struct ATest {
            var array = [Int]()
            var str = "sasa"

            mutating func  add() {
                array.append(10)
            }
        
            mutating func changeStr() {
                str = "changeString"
            }
        }
        
        
        struct Stack<T> {
          fileprivate var array = [T]()

          public var isEmpty: Bool {
            return array.isEmpty
          }

          public var count: Int {
            return array.count
          }

          /// why use mutating?
          ///
            public mutating func push(_ element: T) {
                array.append(element)
            }

          public mutating func pop() -> T? {
            // removeLast() or popLast()?  两者都是返回数组集合的最后一个元素Removes and returns the last element of the collection.  区别在于
            // popLast() 调到空数组会返回nil
            // removeLast() 调到空数组会会崩溃
            return array.popLast()
          }

          public var top: T? {
            return array.last
          }
        }
        
        // 栈
        var stack = Stack<Int>()
        // 压栈，把数据放入栈中
        stack.push(10)
        stack.push(32)
        stack.push(13)
        // 弹栈
        print(stack.pop() ?? 0)
        
        
         
        func getIntersectionNode(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
            guard let headA = headA else { return nil }
            guard let headB = headB else { return nil }
            var curA: ListNode? = headA, curB: ListNode? = headB

              while curA !== curB {
                curA = (curA != nil) ? curA?.next : headB
                curB = (curB != nil) ? curB?.next : headA
              }
              return curA
        }
        
        func deleteNode(_ head: ListNode?, _ val: Int) -> ListNode? {
            guard let head = head else { return nil }
            var cur: ListNode? = head
            while cur!.val == val {
                cur = cur!.next
            }
        
            while let next = cur!.next {
                if (next.val == val) {
                    cur!.next = next.next
                } else {
                    cur = cur!.next
                }
            }
            return head
        }
        
        
        func reversePrint1(_ head: ListNode?) -> ListNode? {
            guard let head = head else { return nil }
            var cur: ListNode? = head
            var next: ListNode? = nil
            while nil != cur {
                let tmp = cur!.next
                cur!.next = next
                next = cur
                cur = tmp
            }
            return next
        }
        
        #if DEBUG
            print("DEBUG")
        #else
            print("RELEASE")
        #endif
        
        
        let l4 = ListNode(4)
        let l3 = ListNode(3, l4)
        let l2 = ListNode(2, l3)
        let l1 = ListNode(1, l2)
        print(deleteNode(l1, 3) as Any)
//        print(reversePrint1(l1))
        
//        let str = "haha"
//        print(String(format: "%p", str))
//        let arr = [str, str, str]
//        print(String(format: "%p", arr))
//        print((MemoryLayout<Array<Any>>.size))

//        class TreeNode {
//            public var val: Int
//            public var left: TreeNode?
//            public var right: TreeNode?
//            public init() { self.val = 0; self.left = nil; self.right = nil; }
//            public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
//            public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
//                self.val = val
//                self.left = left
//                self.right = right
//            }
//        //    [1,2,2,3,4,4,3]
//        //    [2,3,3,4,5,5,4,null,null,8,9,null,null,9,8]
//
//
//        }
//        var index = 0
//
//        func creatPreBt(_ arr : [Int]) -> TreeNode?{
//            if index >= arr.count {
//                return nil
//            }
//            let val = arr[index]
//            var node : TreeNode? = nil
//            node = TreeNode(val)
//            index += 1
//            node?.left = creatPreBt(arr)
//            index += 1
//            node?.right = creatPreBt(arr)
//            return node
//        }
//
//        let node = creatPreBt([1,2,2,3,4,4,3])
//        print(node!)
        
//        func createBinaryTree(_ nums: [Int]) -> TreeNode? {
//            if nums.count == 0 || index > nums.count - 1 { return nil }
//            let root = TreeNode(nums[index])
//            index += 1
//
//            if (index % 2 == 1) {
//                root.left = createBinaryTree(nums)
//            }
//            if (index % 2 == 0) {
//                root.right = createBinaryTree(nums)
//            }
//            return root
//        }
//
////        c() = {
////            1: right = c() = {
////
////            }
////        }
//
//        let node = createBinaryTree([1,2,2,3,4,4,3])
//        print(node as Any)
        
        func mergeTwoArr(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
            if nums1.count == 0 { return nums2 }
            if nums2.count == 0 { return nums1 }
            var nums = [Int]()
            var l = 0, r = 0
            while l < nums1.count || r < nums2.count {
                if l == nums1.count {
                    nums.append(nums2[r])
                    r += 1
                } else if r == nums2.count {
                    nums.append(nums1[l])
                    l += 1
                } else if nums1[l] < nums2[r] {
                    nums.append(nums1[l])
                    l += 1
                } else if (nums1[l] > nums2[r]) {
                    nums.append(nums2[r])
                    r += 1
                } else if (nums1[l] == nums2[r]) {
                    nums.append(nums2[r])
                    r += 1
                }
            }
            return nums
        }
        
        print(mergeTwoArr([1,3,4,5], [2,4,5,5,6]))
        
        
        // 连续子数组的最大和
//        [-2, 1, -3, 4, -1, 2, 1, -5, 4]
        func maxSum(_ nums: [Int]) -> Int {
            if nums.count == 0 { return 0 }
            var sum = 0
            var dp = [Int](repeating: 0, count: nums.count)
            dp.append(nums.first!)
            for i in 1..<nums.count {
                if dp[i - 1] < 0 {
                    dp[i] = nums[i]
                } else {
                    dp[i] = dp[i - 1] + nums[i]
                }
                sum = max(sum, dp[i])
            }
            return sum
        }


        print(maxSum([-2, 1, -3, 4, -1, 2, 1, -5, 4]))
        
        func listNodeReserve(_ head: ListNode?) -> ListNode? {
            guard let head = head else { return nil }
            var cur: ListNode? = head
            var next: ListNode? = nil

            while nil != cur {
                let tmp = cur
                cur = head.next
                cur!.next = next
                next = tmp
            }
            return next
        }
        
        
        let quickArr = [2, 3, 10, 4, 8, 1, 5, 6, 7, 9]
        func quickSort(_ left: Int, _ right: Int) {
            var i = left, j = right
            
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

