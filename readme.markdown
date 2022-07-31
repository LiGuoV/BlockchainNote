> 区块链是数据库 公网的状态层 其(不可更改)特性使其可作为 民主化解决方案的骨干   
> 验证身份, 帮助用户控制自己的数据 加强协作  与供应链管理可以说天作之合  
> BTC 被设计为价值转移 维护账本 作为理想的支付系统  
> 为更适合嵌入非财务数据 第二代协议增加编程,领先的是以太坊ETH, NEO and Quantum等...  
> 即智能合约 允许可定制的交易 构建应用程序`Dapp`  
> 这样的网络里运算存储都要成本 没有类似银行那样隐藏费用 这是代码中的特点 离不开钱
> 以太币 以太坊平台的原生货币,为智能合约提供动力  
**`代币(Tokens)`** 建立在以太坊平台上，可用于根据代币智能合约中指定的规则在不同方之间交换价值(交易使用赠送) 
以太坊生态系统中的代币可以代表任何可替代（可替换）的可交易商品，例如货币、积分、金券、借条  两张1元钞票没有区别  
> 或 **NTF**(不可替代的) 独特藏品，例如游戏道具,就像面积一样地价不一样的两块地
> 发行代币 其实就是一种合约 包含帐户地址及其余额的映射 而余额单位是代币名称  
> 这些币遵循以太坊定义的标准化规则
> 
# 1. 基础概念
- 加密:
  - hashing
  - Merkle Trees
  - Ring Signatures
  - 零知识证明 & ZK-SNARKs
  - 差分隐私
- 散列,块数据模型,块链,分布式点对点网络、内存池
- 共识模型: 股权证明,工作证明,拜占庭容错
- 区块链身份
  - 钱包
    - 非确定性钱包
    - 确定性钱包
  - 公私钥
  - 签署交易的工作原理
- bitcoin core test 
  - 区块链数据模型
  - 交易的输入输出
  - 交易数据模型
  - 比特币脚本 脚本操作码 脚本属性
  - 创建交易
- 私有链 跨链

  ![概念框架](images/区块链概念框架.png)
- `交易` 作为基本的原子工作单位,由用户提交到节点，被包含到下个块
- `钱包` 包含类似email的地址 用户互相发送交易
在网络验证交易之前,需要`签名` 签名是提交到结点之前签署交易的过程
签名后进入`内存池` 是放置所有未确认交易的地方,等待被网络中的节点拾取,直到挖矿节点验证这些交易。
网络通过确定哪些交易是有效的来达成`共识`
一旦网络同意，交易将被放置在一个块中并分配哈希
- `哈希`(指纹) 帮助识别 防篡改
- `块`是一个容器，其中包含要添加到区块链的交易列表
最后，这些块使用哈希值链接在一起 成为`区块链`

## 身份管理
###私钥
签署交易
1到2^256中的随机数
需要**加密安全**的随机数生成器,依次生成 公钥 钱包地址 建立证明所有权 防止欺诈
广播到链上 作为未使用的交易输出`UTXO`, 用作已接受交易的输入
### 交易的过程
地址a 有一个 2 btc 的`UTXO` 发送1btc 给地址_b
引发两笔交易:0.5btc 到 地址b,余额(扣掉了手续费)回到地址a  
生命周期: a给b比特币  
  - a先得到地址b ,创建交易  
  - 地址a 取出包含交易费的币  
  - 钱包`验证信息  通过私钥`签署` 发送广播到网络的`内存池` 
  - 被矿工接受后 将交易组合进一个`块`
  - 共识机制下 一个矿工找到`工作量证明`来为这个`块`分配一个`哈希值`放入`链` 
  - 随着这个块不断被确认(链持续增长) 被接受为网络中的有效交易
  - b得到了币

### 开发工具
  [bitcoin core](https://bitcoin.org/zh_CN/) btc的实现和一众软件  用以进入公共测试网 回归测试网 debug

  - ### DATA (块和交易的数据结构)
    一笔交易的Inputs 是另外一笔交易的`UTXO(unspent transaction output)` 
![image.png](images/交易.png)
![image.png](images/交易数据.png)
![image.png](https://upload-images.jianshu.io/upload_images/11802299-aadbbf78713a6439.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
  - ### 脚本 
    基于堆结构 [操作码](https://en.bitcoin.it/wiki/Script#Flow_control) 
    解锁脚本(包含解决方案) 解决 锁定脚本(指定了需要满足的条件) 将其评估为真  
    UTXO的Locking Script包含花费它所需条件  
    e.g. LockingScript:此输出应支付给任何可以出示与Bob公共地址相对应的密钥签名的人 (只有 Bob 的钱包可以出示签名以兑换此输出。)  
    输入的解锁脚本与上一交易的输出的锁定脚本交互  
    同一交易中的锁定脚本与未来交易的解锁脚本交互。

  - ### 创建原始交易
    >原始交易是机器存储交易数据的方式  
    交易输入来自先前交易的输出  
    在交易期间，这些资金从一个地址转移到另一个地址  
    花费一笔交易时，我们的钱包会扫描区块链  
    以查找与我们的钱包地址相关联的任何可花费的 UTXO
    1. 查看钱包中所有未使用的确认 UTXO `listunspent`
    2. 查看有关特定 UTXO 的详细信息 `gettxout`
    3. 创建原始交易 `createrawtransaction`
```
createrawtransaction 
  '[{ "txid":"7c11fc6e3ee986225402d538a164a6abc622d7008ba478de2346d5671a9d1aa8",
      "vout":1}]' 
  '{"2N1vnznLZEDkqWZDdtrHMfAd1nvdAEgrHYP":0.00007,
    "2Mvtva51m5RNtWvoD5LLtkZCHj9NKFRwSvR":0.000025}'
```
1. 解码原始交易（仔细检查它是否正确完成）`decoderawtransaction`
1. 签署原始交易 `signrawtransactionwithwallet`
1. 向网络提交原始交易 `sendrawtransaction`
1. 查询发送的交易的 TxID

- ### 私有和公共区块链以及如何在两条链之间进行交互
  - 监控公链新块的交易 记录进私链
  - 私链数据存入公链  将SHA256 8个字节存入 引用私链数据集的hash  
  链之间连接数据称跨链 协调各协议工作

  [波卡的跨链服务](https://polkadot.network/)
  > 使用多链方式和名为 Relay的区块链协调区块链之间的共识和交易交付
  > 使用称为 Parachain 的第二个区块链来收集和处理交易
  >![](images/多链.png)

# 数字资产 
  >通过数字身份保护资产
  资产可以是 影像 新闻 法律 账号 原创内容   
  有价值的 需要声明公开或私有的 需要追溯的  
- ### Proof of Existence 
  验证其哈希值公开证明和验证链上资产的概念
  - 不泄露实际数据的情况下展示数据所有权
  - 检查数字资产的完整性
  - 提供文档时间戳
  - 无需中央机构 central authority

# 2 以太坊 
## 术语和工具
 - `以太坊`开源、可编程的公共区块链平台  
 - `EVM` 虚拟机 执行逻辑、算法和处理数据输入
  -`图灵完备` 解决计算问题的能力。
 - `智能合约`用代码编写的合约。以太坊区块链上包含 EVM 代码功能的对象。  
   应用程序完全按照编码运行，没有停机、审查、欺诈或第三方干扰的可能性。  
   被编译成两个试图: 
   - 用于机器的字节码(运行在EVM)
   - 人类可读的汇编
 - `Solidity`用于编码和部署智能合约的高级语言
 - `通用世界计算机 ` 一个分散的全球计算机网络，执行点对点交易和合同。
 - `Dapp `导航:
   - https://www.stateofthedapps.com/zh
   - https://dappradar.com/rankings

 - Etherscan 网站,区块链浏览器 搜索查看链上数据
 - Metamask 钱包,浏览器插件,允许您执行以太坊交易。
 - Remix 浏览器IDE，编写,部署 Solidity 合约。
 - [web3.js](https://web3js.readthedocs.io) 您与以太坊节点交互的库
 - Infura 由于通过`geth`安装自己的节点下载的副本很大  
   infura可以远程连接到节点,这是将整个区块链下载到本地设备的轻量级替代方案
 - Ganache 启动`本地以太坊区块链` 实例的应用程序
 - Truffle 一个开发环境、测试框架和资产管道 
 - Geth 以太坊区块链的golang实现，用于设置本地完整以太坊节点
 
## 2.2 Solidity
  
  - 内存管理,基本 & 复杂 数据类型,类型转换,
  - 数组,字符串,字节类型,映射,结构,枚举,
  - [单位,全局变量](https://docs.soliditylang.org/en/v0.5.3/units-and-global-variables.html) [[例子](code/globalVariablesContract.sol)]
  - 函数  
    - 可见性 
      - public 修饰一个存储变量编译器会创建其getter函数
      - private 本合约可见
      - internal 内部函数和状态变量只能在内部访问
      - external(禁用存储变量) 交易调用 其它合约调用 不能内部调用  
      [[示例](code/functions.sol)]![函数](images/functiontypes.png)
    - 全局函数 & 错误处理 [[示例](code/exception.sol)]
      - revert() 回滚状态,抛出异常 停止执行传播给调用者 退回剩余gas
      - require(condition), 执行函数之前满足某些条件 
      - assert(condition)
  - [继承](code/inheritance) 可以多继承 所有代码都被复制生成一个合约  
接口不能声明变量 声明函数没有功能体  
    最典型例子:[ERO20代币接口示例](code/inheritance/ERC20.sol)
  - 事件 [示例](code/event.sol)
## 2.3 ERC(以太坊征求意见)-代币标准
  - ERC-20 可替代代币的标准接口
  - ERC-223 一些完善
  - ERC-621 可增加供给和减少供给


  - ERC-721 不可替代代币的标准接口
  - ERC-827
  - [查看发行的代币](https://etherscan.io/tokens)
## 2.4 创建代币  
  - [示例](code/mytoken.sol)
  - 使用库 [OpenZeppelin](https://wizard.openzeppelin.com/) 快速构建 [示例](code/create-token)

# 3 架构
  - UML绘图 活动图,时序图,状态图,数据模型图  
  工具: 
    - [LucidChart](https://www.lucidchart.com/) 
    - [draw.io](https://www.draw.io/)
  - Dapp堆栈  
  ![](images/Dapp堆栈.png)
  - 合约安全


- ### 账户
`外部拥有的帐户EOA`externally owned accounts  
`合同账户CA` contract accounts  
`ganache ` 本地eth实现 并有预装以太币的账户 立即交易 快速测试
- ### 交易类型
1. 消息调用
字段
`nonce` 是来自发送者账户的交易计数 从0 递增
`gas price` 发送者愿意为每单位 gas 支付的价格
`gas limit` 限制指定合约可以花费的最大 gas 数量
`to` `value`
2. 合同创建
额外参数`data` &`init `用于记录智能合约创建和执行的信息。

- ### Solidity
Remix 在部署合约时提供以下 3 个环境选项
- Javascript VM（浏览器内的以太坊网络，用于测试）
- 注入 web3（与 Metamask 配合使用部署到公共网络）
- Web3 提供程序（用于连接到本地运行的节点z
EVM中的内存分为Memory、Storage和Calldata

数据类型:
- 复杂类型
普通数组:内存或存储中创建
特殊数组: 字符串 字节  
enums stuct

  全局变量和以太币单位
<details><summary>生成3个[0-9]不重复随机数的示例</summary>

```solidity
uint8 private nonce = 0;
// Returns array of three non-duplicating integers from 0-9
function generateIndexes(address account)
    internal returns(uint8[3]){
    
    uint8[3] memory indexes;
    indexes[0] = getRandomIndex(account);

    indexes[1] = indexes[0];
    while(indexes[1] == indexes[0]) {
        indexes[1] = getRandomIndex(account);
    }

    indexes[2] = indexes[1];
    while((indexes[2] == indexes[0]) || (indexes[2] == indexes[1])) {
        indexes[2] = getRandomIndex(account);
    }

    return indexes;
}

// Returns array of three non-duplicating integers from 0-9
function getRandomIndex (address account) 
    internal returns (uint8) {
    uint8 maxValue = 10;

    // Pseudo random number...the incrementing nonce adds variation
    uint8 random = uint8(uint256(keccak256(abi.encodePacked(blockhash(block.number - nonce++), account))) % maxValue);

    if (nonce > 250) {
        nonce = 0;  // Can only fetch blockhashes for last 256 blocks so we adapt
    }

    return random;
}
```
</details>


由于涉及巨额资金,合约一旦启动无法更新,所以合约安全尤其重要
案例
- Parity wallet hack 
- the DAO attack

最佳实践参考
- [solidity security considerations 注意事项](https://docs.soliditylang.org/en/latest/security-considerations.html)
- [consenSys best practices](https://consensys.github.io/smart-contract-best-practices/)
- 白皮书和研究进展

对以太坊智能合约的攻击调查
以太坊智能合约：安全漏洞和安全工具
让智能合约更智能
Consensys：已知攻击

tooling
- [Open Zeppelin](https://openzeppelin.org/)

专业安全
- 安全审计 Audits
- 漏洞奖赏 Bounties


### 存储 Distributed File System
免费托管文件包括Dapp(基于内容的寻址 用hash) 取代Http(基于位置的寻址,会404)  
项目 
- Swarm
- [IPFS](https://ipfs.io/)
  ```bash
  $ ipfs add my-website.html
  $ ipfs name --help
  $ ipfs name publish {$ID}
  
  ```
  不同于文件,网站静态URL需要使用IPNS(Interplanetary Naming System)
  得到的哈希循这链指向最新版本

### DAPP 
#### 合约的自主性 with autonomous smart contract
- 控制:暂停或重新启

  当发现合约出现问题,资金正在被提取 这时候需要暂停,通常也叫止损(stop loss)  
  基本思路 创建当前可操作状态的bool变量 修饰符 get,set函数  
  要特别注意一个典型BUG: 锁定

不希望一个人来决定暂停合约 多方参与决策 比方说:五个合约管理员中的三个达成共识控制合约状态
- 多方共识 multi-party consensus  multi-signature  
  多重签名账户(multisig) 账户拥有多个私钥  
  好处 
  - 多个用户执行交易,一个人无法转移资金 
  - 一个私钥丢失后好找
  - 企业中业务规则,交易多方授权 的限制的场景  
  
  > 概念:多重签名地址(M-of-N address): 需要 N 个可用的 M 个私钥来签署交易。 
  > requiring M private keys of N available to sign the transaction.
  > M是执行交易需要的密钥key数量, N指private key私钥数量
- 通过合约接收和转移资金 receiving and transferring funds 
  扩展:多方共识实现为函数修饰符,基于时间等非静态变量的多方共识


UI & event 审查用户接口 如何响应事件

第三方或第三世界资源集成到合约

针对代码不可变性进行架构设计


## 安全最佳实践
- 区分数据是否上链 区块链不是用于快速访问的数据库 缓慢 存储成本很高 合理使用IPFS,常规DB等服务
- 保持 function 私有或内部，除非在你的合同之外需要它们。
- 当心`变量,函数`的作用域 明确标记可见性
- 不要存储敏感信息在合约 即便标记为private 部署时足够有钱就可能读到
- 支付基础知识 接收,转移,发送资金
- Debit Before Credit 简单说 卡里先划掉钱 再出款
- delegatecall 委托调用  
  区分用户账户和外部拥有的帐户(合约),被其他合约调用造成伤害,所以代码做防御
- 对时间敏感的操作中,now是block.timestamp的同义词 不要使用 涉及博彩游戏的合约有可能被矿工操作
- 调用外部合约 加前缀`untrusted-`作提醒
- 函数中不要修改修饰符的状态 只用于断言 避免产生意外的副作用
- safeMath library `防止数值溢出 取代原生的 + - * / `

- 保护支付的设计模式

 1. Checks - Effects - Interaction 三步骤
  ```solidity
      require(balance[msg.sender] > 0);
      uint256 prev = balance[msg.sender];
      balance[msg.sender] = 0;
      msg.sender.transfer(prev);
  ```
    
  2. Rate Limiting 来减少资金快速流失  做法:接受时间参数的函数修饰符，
  3.  Re-entrancy Guard  针对函数被调用过程中 被恶意调用,从堆栈角度理解  
  函数完成执行后 检查合约状态和本地状态是否一致

  ```solidity

      using SafeMath for unit256;
      uint256 private enabled = block.timestramp;
      uint256 private counter = 1;
    
      modifier rateLimit(uint time){
       require(block.timestamp > enabled "Rate limiting in effect");
       enabled = enabled.add(time);
       _;  
      }
      
      modifier entrancyGuard(){
          counter = counter.add(1);
          uint256 guard = counter; //本地状态
          _;
          // counter 合约状态
          require(guard==counter,"That is not allowed");
      
      }
  
      mapping(address => uint256) private sales;
      
      function safeWithdraw(uint256 amount) external 
          rateLimit(30 minutes)
          entrancyGuard()
      {
          // 检查
          require(msg.sender == tx.orgin,"Contracts not allowed");
          require(sales[msg.sender]>=amount,"资金不足Insufficient funds")
          //Effects
          uint256 amount = sales[msg.sender];
          sales[msg.sender] = sales[msg.sender].sub(amount);
          //Interaction
          msg.sender.transfer(amount);
      }
      
```

# 4 具有`自主智能合约和预言机`的Dapp
  - 暂停合约 多方共识暂停
  - 安全地 接收转移发送资金
  - 升级 设计分离数据合约&应用程序合约
## Upgradability可升级性 
> Why: BUG, gas涨价, 密钥丢失,修改业务规则 修改参数

合约数据和应用逻辑分离成单独的合约 应用单独升级  
方法: 
- 将数据合约函数存根添加到应用程序合约
- `应用合约`中包含 `数据合约中的函数` 的`类Java`接口,接口提供函数引用  
  include an interface refrence to the Data-Contract for each function
  that will be called from Application-Contract
- 在`应用合约`的构造函数中提供数据合约的地址。为避免输入错误地址,让应
用合约能够通过函数更改数据合约的地址，因此授权用户可以调用
函数并更改地址,或者推迟 用一个单独的初始化函数。
- 
大量合同数据迁移到新合同成本高 
- 合约之间的安全 
> #### 限制数据合约调用者
> 合约拆分为数据和应用两个合约   
> 数据合约要知道已部署的有效授权应用合约的地址是什么 从而不被任意合约调用   
> 这种场景 使用注册 取消注册  
> 创建状态变量跟踪哪些合约授权 映射 
> 函数:authorizedContract 和 deauthorizedContract
> 函数修饰符 IsCallerauthorized



# 保护智能合约免受各种攻击
# 预言机(Oracles)
  > 合约在区块链运行无权访问区块链以外的任何内容,例如股价,物流信息  
  > 合约与外部数据源交互的网关
![](images/oracle-architecture.jpg)
  >
  > 
- 区分可信与不可信预言机 和相关的威胁向量  
公链上的预言机默认是不可信的 可能是恶意的 为了防止单点故障 
  - 需要有多个数据来源到预言机  
  - 多个预言机(相信群众)降低对单个预言机的信任程度 
  - 质押(staking) 要求预言机使用支付权益参与游戏 或者这么说:orcale需要向合约预付款注册自己
### 攻击类型
- Sybil 女巫攻击 类似一个实体制造大量账户选票影响结果
- Cartel卡特尔攻击 类似犯罪团伙勾结 制造情景并创造有利于他们的结果
- Mirroring 镜像 多个节点多个预言机 一个效果影响结果
- Freeloading 免费下载 无需支付成本 偷窃其它预言机结果 降低了信息质量
- Privacy隐私 过度利用拥有隐私数据的优势 反向或直接访问造成天平倾斜 
#### 措施
  阻止与其他Oracle的通信,让它们无法相互通信  
  识别:一个预言机甚至不知道参与智能合约的另一个账户是预言机  
  散列隐藏 使结果对其它预言机不可见  
  注册预言机 安全地从预言机请求接收数据

# UX
- waiting: 由于web3应用反馈时间迟钝,不确定.使用第三方服务api来评估交易时间 定期拉取 发送通知
- impact: 由于涉及资金 告知用户采取行动时发生什么影响
- cost: 不同于信用卡支付隐藏成本到供应商,即便交易失败也会有gas形式的区块链交易成本 要让用户知道 以免归咎于应用
- events: 交易可能产生大量事件 适当过滤 区分优先级 平衡`用户收到大量事件通知`和`获得重要信息`
- Provenance:  
  链上数据是公开的 用户可能不慎会被公开的内容 另外他们不知道查看的数据来自哪里 有必要说明:
  - 哪些数据来自区块链，是否公开
  - 什么数据来自数据库以及数据是否可能是私有或半私有的
  - 哪些数据来自您无法控制的第3方预言机
- addresses 地址很长 让用户不适应 适当隐藏显示末几位 也避免污染UI 但要做到透明 可查看选择复制
- history 管理用户的个人帐本 从事件通知,用户可以导航到所在的历史,看到做了什么，什么时候做的
- Context 
  使用颜色和清晰的语言来指示上下文
  - 显示当前网络环境 test,product Ganache...
  - 当前交易状态 比如交易挂起 (用禁用按钮等方式)防止用户重试
- privacy 避免被永久的公开隐私
  不要将私人用户数据直接存储在智能合约中
  加密敏感数据 加密存储在诸如IPFS
- Affordance 不要让用户思考








