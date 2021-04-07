import UIKit

func algorithmRunningTime(start: Double) {
    let end = CFAbsoluteTimeGetCurrent()
    print("耗时：\(String(format: "%.1f", (end - start) * 1000)) ms")
}

func start() -> Double {
    return CFAbsoluteTimeGetCurrent()
}

//func resultPrint(args: inout T) {
//    print("输出结果：\(args)")
//}


// 两个有序数组，合并成一个有序数组
//[1,3,5][2,4,6]
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



/// 35. 搜索插入位置
/// https://leetcode-cn.com/problems/search-insert-position/
/// 给定一个排序数组和一个目标值，在数组中找到目标值，并返回其索引。
/// 如果目标值不存在于数组中，返回它将会被按顺序插入的位置。
/// 你可以假设数组中无重复元素。

/// 暴力解法  时间复杂度 O(n) 空间复杂度 O(1)
func searchInsert1(_ nums: [Int], _ target: Int) -> Int {
    let startTime = start()
    for i in 0..<nums.count {
        if nums[i] >= target {
            algorithmRunningTime(start: startTime)
            return i
        }
    }
    algorithmRunningTime(start: startTime)
    return nums.count
}

/// Test
print(searchInsert1([1,2,3,8,9,10], 2))


/// 二分法
func searchInsert2(_ nums: [Int], _ target: Int) -> Int {
    // [left right]
    var left = 0
    var right = nums.count - 1
    
    while left <= right {
        // 防止left + right 太大溢出
        let mid = left + (right - left) / 2
        // right > mid
        if nums[mid] > target {
            right = mid - 1
        } else if nums[mid] < target {
            left = mid + 1
        } else if nums[mid] == target {
            return mid
        }
    }
    return left
}

print("prints", searchInsert2([1,2,3,8,9,10], 4))




/// 27. 移除元素
/// https://leetcode-cn.com/problems/remove-element/
/// 给你一个数组 nums 和一个值 val，你需要 原地 移除所有数值等于 val 的元素，并返回移除后数组的新长度。
/// 不要使用额外的数组空间，你必须仅使用 O(1) 额外空间并 原地 修改输入数组。
/// 元素的顺序可以改变。你不需要考虑数组中超出新长度后面的元素。

/// 数组中的元素不能删除，只能覆盖
/// 双指针解法
func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
    var slowIndex = 0
    for i in 0..<nums.count {
        if nums[i] != val {
            nums[slowIndex] = nums[i]
            slowIndex += 1
        }
    }
    return slowIndex
}

var arr = [1,2,3,2,4,2,4]
print("removeElement result", removeElement(&arr, 2))




/// 209. 长度最小的子数组
/// https://leetcode-cn.com/problems/minimum-size-subarray-sum/
/// 给定一个含有 n 个正整数的数组和一个正整数 target 。
/// 找出该数组中满足其和 ≥ target 的长度最小的 连续子数组 [numsl, numsl+1, ..., numsr-1, numsr] ，并返回其长度。如果不存在符合条件的子数组，返回 0 。

/// 滑动窗口算法，先取出满足条件的上下指针，然后while里滑动下面的指针，不满足后，再滑动上面的指针
func minSubArrayLen(_ target: Int, _ nums: [Int]) -> Int {
    var sum = 0
    var slowIndex = 0
    var count = INTPTR_MAX
    for i in 0..<nums.count {
        let cur = nums[i]
        sum += cur
        
        while (sum >= target) {
            sum -= nums[slowIndex]
            count = min(count, i + 1 - slowIndex)
            slowIndex += 1
        }
    }
    return count == INTPTR_MAX ? 0 : count
}

print("minSubArrayLen result", minSubArrayLen(7, [2,3,1,2,4,3]))




/// 二叉树遍历
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
//    [1,2,2,3,4,4,3]
//    [2,3,3,4,5,5,4,null,null,8,9,null,null,9,8]

    var index = 0
    public func createBinaryTree(_ nums: [Int]) -> TreeNode? {
        if nums.count == 0 || index > nums.count - 1 { return nil }
        let root = TreeNode(nums[index])
        index += 1
        root.left = createBinaryTree(nums)
        root.right = createBinaryTree(nums)
        return root
    }
}

print(TreeNode().createBinaryTree([1,2,2,3,4,4,3]) as Any)

let t5 = TreeNode(5)
let t4 = TreeNode(4)
let t3 = TreeNode(3)
let t2 = TreeNode(2, t4, t5)
let t1 = TreeNode(1, t2, t3)

/// 前序遍历
func preorderTraversal(_ root: TreeNode?) -> [Int] {
    var res: [Int] = []
    guard let root = root else { return res }
    res.append(root.val)
    res += preorderTraversal(root.left)
    res += preorderTraversal(root.right)
    return res
}

/// 中序遍历
func inorderTraversal(_ root: TreeNode?) -> [Int] {
    var res: [Int] = []
    guard let root = root else { return res }
    res += inorderTraversal(root.left)
    res.append(root.val)
    res += inorderTraversal(root.right)
    return res
}

/// 后序遍历
func postorderTraversal(_ root: TreeNode?) -> [Int] {
    var res: [Int] = []
    guard let root = root else { return res }
    res += preorderTraversal(root.left)
    res += preorderTraversal(root.right)
    res.append(root.val)
    return res
}


print(preorderTraversal(t1))
print(inorderTraversal(t1))
print(postorderTraversal(t1))


/// 二叉树遍历，递归拆解
//        p(t1) = {
//            res.app(1)
//            res += p(t2) = {
//                res.app(2)
//                res += p(t4) = {
//                    res.app(4)
//                    return res = [4]
//                }
//                res += p(t5) = {
//                    res.app(5)
//                    return res = [5]
//                }
//                return res = [2, 4, 5]
//            }
//            return [1,2,4,5]
//            res += p(t3) = {
//                res.app(3)
//                return res = [3]
//            }
//            return [1,2,4,5,3]
//            return res
//        }


/// 二叉树最大深度
/// 解题思路：计算左子树深度（ld），计算右子树深度（rd） 最大深度 = max(ld, rd) + 1
func leftMaxDepth(_ root: TreeNode?) -> Int {
    guard let root = root else { return 0 }
    return leftMaxDepth(root.left) + 1
}

func rightMaxDepth(_ root: TreeNode?) -> Int {
    guard let root = root else { return 0 }
    return rightMaxDepth(root.right) + 1
}

func maxDepth(_ root: TreeNode?) -> Int {
    guard let root = root else { return 0 }
    return max(maxDepth(root.left), maxDepth(root.right)) + 1
}

print(leftMaxDepth(t1))
print(rightMaxDepth(t1))
print(maxDepth(t1))

/// 最大深度递归拆解
//        m(t1) + 1 = {
//            m(t2) + 1 = {
//                m(t4) = 0 + 1
//            }
//        } = 3


/// 对称二叉树
func isSymmetric(_ root: TreeNode?) -> Bool {
    guard let root = root else { return false }
    if root.left == nil && root.right == nil { return true }
    isSymmetric(root.left)
    isSymmetric(root.right)
    return root.left?.val == root.right?.val
        && root.left?.left?.val == root.right?.right?.val
        && root.left?.right?.val == root.right?.left?.val
}


//[2,3,3,4,5,5,4,null,null,8,9,null,null,9,8]

let ts7 = TreeNode(3)
let ts6 = TreeNode(4)
let ts5 = TreeNode(4)
let ts4 = TreeNode(3)
let ts3 = TreeNode(2, ts6, ts7)
let ts2 = TreeNode(2, ts4, ts5)
let ts = TreeNode(1, ts2, ts3)
print(isSymmetric(ts))


/// 斐波那契数列，经典递归算法
func fab(_ n: Int) -> Int {
    if n == 0 {return 0} // 还要判断溢出
    if n == 1 || n == 2 {return 1}
    return fab(n - 1) + fab(n - 2)
}

/// 斐波那契数列递归拆解
//        fab(4) = fab(3) + fab(2) = fab(2) + fab(1) + fab(1) + fab(0) = fab(1) + fab(0) + fab(1) + fab(1) + fab(0) = 3
print(fab(4))

/// 斐波那契数列 动态规划算法
func fib(_ n: Int) -> Int {
    if n < 2 { return n }
    var l = 0, m = 0, r = 1
    for _ in 2..<n + 1 {
        l = m
        m = r
        r = l + m
    }
    return r
}

print("fib 动态规划", fib(10))

/// 斐波那契数列 经典动态规划算法 创建同空间大小的数组存储每个值
func fib2(_ n: Int) -> Int {
    if n < 2 { return n }
    var dp = [Int](repeating: 0, count: n + 1)
    dp[0] = 0
    dp[1] = 1
    var half = 0
    for i in 2..<n + 1 {
        half = dp[i - 2] + (dp[i - 1] - dp[i - 2]) / 2 // 防止整数溢出
        if (half > Int.max / 2) { return 0 }
        dp[i] = half * 2
    }
    return dp[n]
}

print("fib 动态规划", fib2(10))



// 爬楼梯问题1，n个台阶，每次可以爬1个或2个台阶，请问有几种方法爬台阶？
//0 1 1 2 3 5 8
func fib3(_ n: Int) -> Int {
    if n < 2 {return n}
    print("sasa")
    var l = 1, r = 1
    for _ in 2..<n {
        let sum = l + r
        print("ds", sum)
        l = r
        r = sum
    }
    return r
}

print(fib3(2))

// 爬楼梯问题2 消耗最低体力问题
// 数组的每个下标作为一个阶梯，第 i 个阶梯对应着一个非负数的体力花费值 cost[i]（下标从 0 开始）。
// 每当你爬上一个阶梯你都要花费对应的体力值，一旦支付了相应的体力值，你就可以选择向上爬一个阶梯或者爬两个阶梯。
// 请你找出达到楼层顶部的最低花费。在开始时，你可以选择从下标为 0 或 1 的元素作为初始阶梯。

//示例 1：输入：cost = [10, 15, 20] 输出：15 解释：最低花费是从 cost[1] 开始，然后走两步即可到阶梯顶，一共花费 15 。
//示例 2：输入：cost = [1, 100, 1, 1, 1, 100, 1, 1, 100, 1] 输出：6 解释：最低花费方式是从 cost[0] 开始，逐个经过那些 1 ，跳过 cost[3] ，一共花费 6 。

// 注意：这个题目有个坑，到达楼顶是指到了最后一个台阶之后还要往上走一步才是到达楼顶，所以应该手动给数组末尾加上一个元素0
// [10, 15, 20, 0]
func dynamicProgramming(_ cost: [Int]) -> Int {
    if cost.count == 0 { return 0 }
    if cost.count == 1 { return cost.first! }
    var l = cost[0], r = cost[1], res = 0
    for i in 2..<cost.count {
        res = min(l, r)
        l = r
        r = res + cost[i]
    }
    return min(l, r)
}

func dynamicProgramming1(_ cost: [Int]) -> Int {
    if cost.count == 0 { return 0 }
    var dp = [Int](repeating: 0, count: cost.count)
    dp[0] = cost[0]
    dp[1] = cost[1]
    for i in 2..<cost.count {
        dp[i] = min(dp[i - 1], dp[i - 2]) + cost[i]
    }
    return min(dp[cost.count - 1], dp[cost.count - 2])
}


print("计算最小花费结果：", dynamicProgramming([10, 15, 20]))


// 背包问题



/// 链表相关

/// 反转链表
class ListNode {
   var val: Int
   var next: ListNode?
   init(_ val: Int, _ next: ListNode? = nil) {
       self.val = val
       self.next = next
   }
}

// 双链表
public class LinkedListNode<T> {
  var value: T
  var next: LinkedListNode?
  weak var previous: LinkedListNode? // 这里用weak来打破循环引用，A -> B B -> A

  public init(value: T) {
    self.value = value
  }
}

// 常规解法
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


// 栈解法
func reversePrint2(_ head: ListNode?) -> [Int] {
    guard let head = head else { return [] }
    var stack = [Int]()
    var cur: ListNode? = head
    var arr = [Int]()
    while nil != cur {
        stack.append(cur!.val)
        cur = cur!.next
    }
    while stack.count > 0 {
        arr.append(stack.removeLast())
    }

    return arr
}


let l4 = ListNode(4)
let l3 = ListNode(3, l4)
let l2 = ListNode(2, l3)
let l1 = ListNode(1, l2)
print(reversePrint1(l1))



/// 栈，Swift中实现一个栈，其实就是对数组进行一些封装，并保证栈的特点
/// 后进先出
/// 栈的弹出效率非常高，因为不需要进行内存移位，只需要将最后一个元素删除即可，时间复杂度为常量级O(1)
struct Stack<T> {
    fileprivate var array = [T]()

    public var isEmpty: Bool {
        return array.isEmpty
    }

    public var count: Int {
        return array.count
    }

    
    /// why use mutating?
    /// 在struct或enum的值类型中，想要更改属性的值，需要用mutating方法修饰。
    /// 使用此关键字，您的方法将能够更改属性的值，并在方法实现结束时将其写回到原始结构。
    public mutating func push(_ element: T) {
        array.append(element)
    }

    public mutating func pop() -> T? {
        // removeLast() or popLast()?  两者都是删除并返回数组集合的最后一个元素，也就是所谓的弹栈
        // Removes and returns the last element of the collection.  区别在于
        // popLast() 调到空数组会返回nil
        // removeLast() 调到空数组会会崩溃
        return array.popLast()
    }

    public var top: T? {
        return array.last
    }
}



/// 队列 Swift中实现一个队列，其实就是对数组进行一些封装，并保证栈的特点
/// 先进先出
/// 从下面这个队列的实现来看，队列的出队时间复杂度为O(n)，因为每次取出第一个元素，后面的元素都要向前位移
/// 所以我们可以实现一个O(1)复杂度的出队算法，
/// 出队后，后面元素不向前位移，而是以nil占据被删除的位置，并给出清理无用内存的方法，如下Queue2的实现
public struct Queue1<T> {
    fileprivate var array = [T]()

    public var isEmpty: Bool {
        return array.isEmpty
    }
  
    public var count: Int {
        return array.count
    }

    public mutating func enqueue(_ element: T) {
        array.append(element)
    }
  
    public mutating func dequeue() -> T? {
        if isEmpty {
            return nil
        } else {
            return array.removeFirst()
        }
    }
  
    public var front: T? {
        return array.first
    }
}


public struct Queue<T> {
    fileprivate var array = [T?]() // 这里的T变成了T? 因为队列内会存在nil值
    fileprivate var head = 0 // 用来标记头部nil的元素数量
  
    public var isEmpty: Bool {
        return count == 0
    }

    public var count: Int {
        return array.count - head
    }
  
    public mutating func enqueue(_ element: T) {
        array.append(element)
    }
  
    public mutating func dequeue() -> T? {
        // 数组为空 返回nil
        guard head < array.count, let element = array[head] else { return nil }

        array[head] = nil
        head += 1

        clearIfNeed()
    
        return element
    }
  
    public var front: T? {
        if isEmpty {
            return nil
        } else {
            return array[head]
        }
    }
    
    mutating func clearIfNeed() {
        // 给出一个具体的条件，达到后清理数组中的无用内存，该操作的时间复杂度为O(n)
        // 由于达到该条件的情况很少，所以可以把该出队方法看成是O(1)或者接近O(1)的算法
        let percentage = Double(head) / Double(array.count)
        if array.count > 50 && percentage > 0.25 {
            array.removeFirst(head)
            head = 0
        }
    }
}




/// 两数之和
/// 给定一个整数数组和一个整数目标，返回两个数字的索引，它们加起来等于目标。

/// Test Case: [2,7,11,15]
/// 利用字典，时间复杂度O(n)  空间复杂度O(n)
func twoSum(_ nums: [Int], _ result: Int) -> [Int] {
    if nums.count < 2 { return [] }
    var dic = [Int: Int]()
    for (i, n) in nums.enumerated() {
        let otherNum = result - n
        
        if let otherIndex = dic[otherNum] {
            return [otherIndex, i]
        }
        
        dic[n] = i
    }
    return []
}

/// 快慢指针法，这个算法需要先将数组排序才行
func twoSum2(_ nums: [Int], _ result: Int) -> [Int] {
    if nums.count < 2 { return [] }
    
    var slowPoint = 0
    var quickPoint = nums.count - 1
    
    for _ in 0..<nums.count {
        let sum = nums[slowPoint] + nums[quickPoint]
        if (sum == result) {
            return [slowPoint, quickPoint]
        } else if (sum < result) {
            slowPoint += 1    // 因为是有序数组，所以当sum小于目标值时，说明前面的数小了，所以+1
        } else if (sum > result) {
            quickPoint -= 1   // 因为是有序数组，所以当sum小于目标值时，说明后面的数大了，所以-1
        }
    }
    
    return []
}


/// 两数之和：取出所有两数相加等于目标值的下标,有序且无重复元素
func twoSum3(_ nums: [Int], _ result: Int) -> [[Int]] {
    if nums.count < 2 { return [] }
    
    var slowPoint = 0
    var quickPoint = nums.count - 1
    
    var r = [[Int]]()
    for _ in 0..<nums.count {
        let sum = nums[slowPoint] + nums[quickPoint]
        if slowPoint >= quickPoint { break }
        if sum == result {
            r.append([slowPoint, quickPoint])
            // 因为是有序数组，所以当取到两个值已经是目标值时，那么
            slowPoint += 1
            quickPoint -= 1
        } else if sum < result {
            slowPoint += 1    // 因为是有序数组，所以当sum小于目标值时，说明前面的数小了，所以+1
        } else if sum > result {
            quickPoint -= 1   // 因为是有序数组，所以当sum小于目标值时，说明后面的数大了，所以-1
        }
    }
    
    return r
}

/// 十大经典排序算法
/// 1、冒泡 时间复杂度 O(n^2)
/// 按顺序，将前面的元素，与后面的元素做比较，如果后面的小，则交换位置，然后再与后面的元素比较，
/// 两层遍历结束后，确保所有的元素都被遍历了，就能排出有序数组了
/// 优化 加个标志位，如果第二层循环没有的if没进去过，说明是有序的数组，不需要排序了
func bubblingSort(_ nums: inout [Int]) -> [Int] {
    if nums.count < 2 { return nums }
//    var needSort = false
    for i in 0..<nums.count {
        var min = nums[i]
        for j in i+1..<nums.count {
            let max = nums[j]
            if min > max {
                nums[j] = min
                nums[i] = max
                min = max
//                needSort = true
            }
        }
//        if !needSort { break }
    }
    return nums
}


/// 选择排序  O(n^2)
/// 也是双层遍历，先找到数组中最小的元素，放到数组的第一位，再从剩下的元素中找地儿小的，依次类推
func selectionSort(_ nums: inout [Int]) -> [Int] {
    if nums.count < 2 { return nums }
    for i in 0..<nums.count {
        var min = nums[i]
        var minIndex = i
        for j in i+1..<nums.count {
            let max = nums[j]
            if min > max {
                min = max
                minIndex = j
            }
        }
        nums[minIndex] = nums[i]
        nums[i] = min
    }
    return nums
}


/// 插入排序  O(n^2)
/// 类似打牌整理手牌的原理，从元素1开始与前面的元素做比较，插到比自己小的元素的后面，依次类推
/// 注意：这里的第二层循环是从倒序的！
func insertSort(_ nums: inout [Int]) -> [Int] {
    if nums.count < 2 { return nums }
    for i in 0..<nums.count {
        let min = nums[i]
        var minIndex = i
        for j in (0..<i+1).reversed() {
            let max = nums[j]
            if max > min {
                nums[minIndex] = max
                nums[j] = min
                minIndex = j
            }
        }
    }
    return nums
}


/// 快速排序




/// 求 2^n
func test2(_ x: Int, _ n: Int) -> Int {
    if n == 0 { return 1 }
    
    let t = test2(x, n / 2)
    if (n % 2 == 1) {
        return t * t * x
    }
    return t * t
}
