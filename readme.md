## UITableView

### 初始化

```swift
//初始化
let tableView = UITableView(frame: view.bounds, style: .grouped)
tableView.backgroundColor = UIColor.white
//显示侧边拖动栏
tableView.showsVerticalScrollIndicator = false
//cell中间的间隔线，默认.singleLine表示
tableView.separatorStyle = .none
view.addSubview(tableView)
//设置代理：UITableViewDelegate，UITableViewDataSource
tableView.delegate = self
//设置数据源
tableView.dataSource = self
```

**style**

grouped(组合)、plain(默认)

当style为grouped时，需要实现numberOfSections的代理方法

```swift
//section的个数（分为多少组）
//当style为grouped时，需要实现numberOfSections的代理方法
public func numberOfSections(in tableView: UITableView) -> Int {
  return 2
}
```

### 代理方法

需要实现代理：UITableViewDelegate，UITableViewDataSource

#### 公共代理方法

无论是grouped还是plain都需要实现的代理方法

```swift
// 设置每个 Cell
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  // 从tableview的重用池里通过cellID取一个cell
  let cellID = "cell"
  var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
  //设置cell的样式
  if cell == nil {
    cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellID)
  }
  //选中cell时的样式
  // default:默认的，点击灰色
  cell?.selectionStyle = .none
  //cell的标题
  cell?.textLabel?.text = "MyTile"
  //副标题
  cell?.detailTextLabel?.text = "Subtitle/content"
  return cell!
}

// 选中cell后执行此方法
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  print(indexPath.row)
}
```

#### UI相关代理方法

```swift
// 设置cell高度
func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
  return 44.0
}

// 设置 section 的 header 文字
func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "header-\(section)"
}
// 设置 section 的 footer 文字
func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    return "footer-\(section)"
}
// 设置 section 的 header 高度
func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
// 设置 section 的 footer 高度
func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 20
}
// 设置 cell 的高度
func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
}
// cell 的文字缩进
func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
    return 10
}
// 自定义 section 的 header
func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = UIView()
    headerView.backgroundColor = UIColor.orange
    return headerView
}
// 自定义 section 的 header
func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let footerView = UIView()
    footerView.backgroundColor = UIColor.blue
    return footerView
}
```

#### 点击事件代理方法

```swift
// 选中cell后执行此方法
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  print(indexPath.row)
}
//点击一个已经被选中的单元格时，调用此方法
public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
//cell是否可编辑
func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
//设置删除按钮的title
func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? 
//进行编辑时（如点击了删除按钮）触发
func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
//结束编辑时触发
func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?)
//自定义编辑事件
func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? 
//
```

### 设置左滑删除

使用系统默认的左滑删除按钮

```swift
// 设置 cell 是否允许左滑
func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
}
// 设置默认的左滑按钮的title
func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
    return "WTbtn"
}
// 点击左滑出现的按钮时触发
func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    print("点击左滑出现的按钮时触发")
    return
}
// 左滑结束时调用(只对默认的左滑按钮有效，自定义按钮时这个方法无效)
func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
}
```

自定义左滑时显示的按钮和触发事件

```swift
func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    let cellActionA = UITableViewRowAction(style: .default, title: "按钮-1", handler: {_,_ in
        print("点击了 按钮-1")
    })
    cellActionA.backgroundColor = UIColor.green

    let cellActionB = UITableViewRowAction(style: .default, title: "按钮-2", handler: {_,_ in
        print("点击了 按钮-2")
    })
    return [cellActionA, cellActionB]
}
```

reference: https://blog.csdn.net/u013892686/article/details/51788905

### UITableViewRowAction

UITableViewRowAction对象是一个用户水平左滑UITableViewCell时显示的单独的按钮。默认情况下，左滑会显示一个删除按钮。这个类会帮助实现一个或这多个按钮。

#### 使用

自定义的按钮需要添加在[tableView:editActionsForRowAtIndexPath:](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UITableViewDelegate_Protocol/index.html#//apple_ref/occ/intfm/UITableViewDelegate/tableView:editActionsForRowAtIndexPath:)代理方法中.

```swift
override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
  //style:Default默认红色，Normal默认灰色
  //title时按钮的文字
  //handler是点击时候的回调函数，相当于block
  let deleteAction = UITableViewRowAction(style: .Default, title: "Delete", handler: { (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
                                                                                      println("Delete button of row\(indexPath.row) have been Tapped")
                                                                                     })

  let moreAction = UITableViewRowAction(style: .Normal, title: "More", handler: { (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
                                                                                 println("More button of row\(indexPath.row) have been Tapped")
                                                                                })
  //数组前面的放在后面显示
  return [deleteAction, moreAction]
}

//即使没有实现也需要重写这个方法
override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
}
```

#### 自定义样式

修改颜色和模糊效果

```swift
deleteAction.backgroundColor = UIColor.blueColor()
deleteAction.backgroundEffect = UIBlurEffect(style:UIBlurEffectStyle.Dark)
moreAction.backgroundColor = UIColor.greenColor()
moreAction.backgroundEffect = UIBlurEffect(style:UIBlurEffectStyle.Dark)
```

reference: https://blog.csdn.net/lcl130/article/details/42131821

#### 添加图片

**ios11:**

```swift
@available(iOS 11.0, *)
func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

  let deleteAction:UIContextualAction = UIContextualAction(style: .destructive, title: "删除") { (action, sourceView, completionHandler) in
                                                                                              completionHandler(true)
                                                                                             }
  //delete操作按钮可使用UIContextualActionStyleDestructive类型，当使用该类型时，如果是右滑操作，一直向右滑动某个cell，会直接执行删除操作，不用再点击删除按钮。
  deleteAction.backgroundColor = UIColor.red
  deleteAction.image = UIImage(named: "delete")

  let actions:[UIContextualAction] = [deleteAction]

  let action:UISwipeActionsConfiguration = UISwipeActionsConfiguration(actions: actions)
  // 当一直向右滑是会执行第一个action
  action.performsFirstActionWithFullSwipe = true

  return action
}

@available(iOS 11.0, *)
func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

}
```

**ios11以下：**

低于iOS 11的系统UITableViewRowAction只有标题不能添加图片,并且没有提供滑出的API，并且在iOS 11和iOS < 11的系统按钮层次不一样(iOS 11按钮加在TableView上，< 11在UITableViewCell上),自定义起来比较麻烦。

**MGSwipeTableCell**可以加载多个按钮支持左滑rightButtons或者右滑leftButtons，可以自己设置动画效果自定义事件调出滑出效果，通过代理**MGSwipeTableCellDelegate**监听按钮点击。

```swift
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
{
    let reuseIdentifier = "programmaticCell"
    var cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MGSwipeTableCell

    cell.textLabel!.text = "Title"
    cell.detailTextLabel!.text = "Detail text"
    cell.delegate = self //optional

    //configure left buttons
    cell.leftButtons = [MGSwipeButton(title: "", icon: UIImage(named:"check.png"), backgroundColor: .green),
                        MGSwipeButton(title: "", icon: UIImage(named:"fav.png"), backgroundColor: .blue)]
    cell.leftSwipeSettings.transition = .rotate3D

    //configure right buttons
    cell.rightButtons = [MGSwipeButton(title: "Delete", backgroundColor: .red),
                         MGSwipeButton(title: "More",backgroundColor: .lightGray)]
    cell.rightSwipeSettings.transition = .rotate3D

    return cell
}
```

### UITableViewCell

#### 使用

##### 1、声明自定义组件

```swift
var userLabel:UILabel!      // 名字
var sexLabel:UILabel!       // 性别
var iconImv:UIImageView!    // 头像
sexLabel = UILabel(frame: CGRect(x: 200, y: 20, width: 50, height: 13))
sexLabel.textColor = UIColor.black
sexLabel.font = UIFont.systemFont(ofSize: 13)
sexLabel.textAlignment = .left

iconImv = UIImageView(frame: CGRect(x: 20, y: 15, width: 44, height: 44))
iconImv.layer.masksToBounds = true
iconImv.layer.cornerRadius = 22.0
```

##### 2、重写init方法，设置UI

```swift
override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {

  super.init(style: style, reuseIdentifier: reuseIdentifier)
  setupUI()

}
```

##### 3、在UITableView的代理方法中创建cell对象

```swift
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  let cellID = "defineCell"
  var cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? MyUITableViewCell
  if cell == nil {
    cell = MyUITableViewCell(style: .subtitle, reuseIdentifier: cellID)
  }
  //cell与datasource交互，cell定义了样式，从datasource中拿数据
  let dict = dataSource[indexPath.row]
  cell?.iconImv.image = UIImage(named: dict["icon"]!)
  cell?.userLabel.text = dict["name"]
  cell?.sexLabel.text = dict["sex"]

  return cell!
}
```

##### 4、设置cell高度

```swift
func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
}
```

#### cell的四种样式

default、subtitle、value1、value2



![image-20190926103051825](/Users/zwt/Library/Application Support/typora-user-images/image-20190926103051825.png)

### cell拖动更改排序

1、创建数据源

```swift
var dataArray: NSMutableArray = ["a", "b", "c", "e"]
```

2、使用数据源

```swift
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataArray.count
}
```

3、实现cell的代理方法

```swift
// 设置 cell 是否允许移动
func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    return true
}
// 移动 cell 时触发
func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    // 移动cell之后更换数据数组里的循序
    dataArray.exchangeObject(at: (sourceIndexPath as NSIndexPath).row, withObjectAt: (destinationIndexPath as NSIndexPath).row)
}
```

### 添加索引和章节(section)

常见使用场景：通讯录

需要用到的代理方法

```swift
//设置TableView中章节（Section的数量）不设置默认为1。
numberOfSections(in tableView: UITableView)
//在指定章节中，cell的个数。
tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
//设置章节标题文字，返回结果为字符串，如果返回为nil，则不显示标题。
-tableView(_ tableView: UITableView, titleForHeaderInSection section: Int)
//设置在表格右侧显示的索引序列的内容，返回结果为一个字符串数组
sectionIndexTitles(for tableView: UITableView)
//TableViewCell初始化和复用
tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
```

代码实现

```swift
class IndexsViewController: UIViewController,UITableViewDataSource {

    let contents:Dictionary<String,[String]> =
        ["A":["安其拉"],
         "B":["步惊云","不知火舞","白起","扁鹊"],
         "C":["程咬金","成吉思汗","蔡文姬","曹操"],
         "D":["妲己","狄仁杰","典韦","貂蝉","达摩","大乔","东皇太一"],
         "G":["高渐离","关羽","宫本武藏","干将莫邪","鬼谷子"],
         "H":["韩信","后羿","花木兰","黄忠"],
         "J":["荆轲","姜子牙"],
         "L":["老夫子","刘邦","刘婵","鲁班七号","兰陵王","露娜","廉颇","李元芳","刘备","李白","吕布"],
         "M":["墨子","芈月"],
         "N":["牛魔","娜可露露","哪吒","女娲"],
         "P":["庞统",""],
         "S":["孙膑","孙尚香","孙悟空"],
         "W":["王昭君","武则天"],
         "X":["项羽","小乔"],
         "Y":["亚瑟","虞姬","嬴政"],
         "Z":["周瑜","庄周","甄姬","钟无艳","张飞","张良","钟馗","赵云","诸葛亮"]]
    var keys:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        // 把字典里的key拿出来放到一个数组中，备用，作为章节的标题
        keys = contents.keys.sorted()
        
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        view.addSubview(tableView)
    }
//MARK: UITableViewDataSource
    //MARK: 章节的个数
    func numberOfSections(in tableView: UITableView) -> Int {
        return keys.count
    }
    //MARK: 某一章节cell个数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let arr = contents[keys[section]]
        return (arr?.count)!
    }
    //MARK: 初始化cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "indexsCellId")
        if cell==nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "indexsCellId")
        }
      	//indexPath.section：索引
      	//indexPath.row：所在的行
        let arr = contents[keys[indexPath.section]]
        cell?.textLabel?.text = arr?[indexPath.row]
        return cell!
    }
    //MARK: 每一个章节的标题
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return keys[section]
    }
    //MARK: 设置索引序列内容,添加了这个方法，右侧才会出现索引序列
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return keys
    }  
}
```

ps：

- **.plain**:如果传的是这个参数，向上滑动，当章节头部滑动到`UITableVeiw`的上方边界时，章节头部会停在边界位置，知道下一个章节头部到达它的位置，它才会继续向上滑动，下一个章节头部会占据它的位置。
- **. grouped**：就正常滑动，没啥影响。

reference: https://www.jianshu.com/p/bb65e97a2e8e

### cell的选择和取消选择

三种支付方式，只能单选

```swift
import UIKit

class SelectViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    // 数据源，
    var dataSource = [["微信支付":"select"],["支付宝支付":"on"],["银联支付":"no"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "selectCell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "selectCell")
            cell?.selectionStyle = .none
        }
        let dic = dataSource[indexPath.row] as Dictionary
        cell?.textLabel?.text = dic.keys.first
        if dic.values.first == "select" {
            cell?.accessoryType = .checkmark
        } else {
            cell?.accessoryType = .none
        }
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        var i = 0
        for var dict in dataSource {
            
            if i == indexPath.row {
                dict[dict.keys.first!] = "select"
                dataSource[i] = dict
            } else {
                dict[dict.keys.first!] = "no"
                dataSource[i] = dict
            }
            i = i+1
        }
        tableView.reloadData()
    }
    
}
```

**UITableViewCellAccessoryType**

| 枚举类型               | 说明                                               |
| ---------------------- | -------------------------------------------------- |
| none                   | 没有任何样式                                       |
| detailbutton           | 右侧蓝色的圆圈，中间带叹号                         |
| detailDisclosureButton | 右侧蓝色圆圈带叹号，它的右侧还有一个灰色向右的箭头 |
| disclosureIndicator    | 右侧一个灰色的向右箭头                             |
| checkmark              | 右侧蓝色对号                                       |

cell的插入和删除

```swift
import UIKit

class AddViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var dataSource = [["微信","支付宝","银联"],["微信","支付宝","银联"]]
    var tableView:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "支付方式"
        
        let rightBar = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addButtonClick))
        navigationItem.rightBarButtonItem = rightBar
        
        tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
    }
    
    //MARK: 导航栏右侧按钮，点击开启或关闭编辑模式
    func addButtonClick() {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "addCell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "addCell")
            cell?.selectionStyle = .none
        }
        let arr = dataSource[indexPath.section] as Array
        cell?.textLabel?.text = arr[indexPath.row] as String
        return cell!
    }
    
    //MARK: 编辑模式，增加还是删除
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if indexPath.section == 1 {
            return .delete
        }
        return .insert
    }
    //MARK: 执行编辑操作时，调用此方法
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        var arr = dataSource[indexPath.section] as Array
        if editingStyle == .insert {
            arr.insert("Apple Pay", at: indexPath.row)
            dataSource[indexPath.section] = arr
            tableView.insertRows(at: [indexPath], with: .right)
        } else {
            arr.remove(at: indexPath.row)
            dataSource[indexPath.section] = arr
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
    
}
```

**UITableViewRowAnimation**

控制操作的动画

|    属性     | 说明                                                   |
| :---------: | ------------------------------------------------------ |
|   `fade`    | 以淡入淡出的方式显示或移除                             |
|   `right`   | 添加或删除时，从右侧滑入或划出                         |
|   `left`    | 添加或删除时，从左侧滑入或划出                         |
|    `top`    | 添加或删除时，从上方滑入或划出                         |
|  `bottom`   | 添加或删除时，从底部滑入或划出                         |
|  `middle`   | 表格视图将尽量使新旧cell居中显示在曾经或将要显示的位置 |
| `automatic` | 自动选择适合自身的动画方式                             |
|   `none`    | 采用默认动画方式                                       |