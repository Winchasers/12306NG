#12306NG

--------------------

2012-12-12 1.0 

view：   基本视图显示、跳转
  1、user：用户模块 
  	LoginViewController               	用户登录
  	RegisterViewController			 	用户注册
 	UserCenterViewController		  	我的抢票助手  
  	UserInfomationViewController	  	个人资料
  	AddTravelCompanionViewController   	添加同行旅客
  	
  2、ticket:车票模块
  	QueryTicketViewController   		车票查询
  	QueryTicketResultViewController		车票查询结果
  	BookingTicketViewController			预订车票
  	ChooseTravelCompanionViewController	选择同行旅客
  	AddPassengerViewController			添加乘客
  	SubmitOrderViewController			提交订单
  	
  3、order:订单模块
  	OrderListViewController				订单列表
  	NonPaymentViewController			未支付订单
  	PaymentDoneViewController			已支付订单
  	PaymentViewController				支付页面
  	
  4、other：其他模块
  	FeedbackViewController				反馈信息
  	GradeAppViewController				软件评分
  	AboutUsViewController				关于我们
  	ResidualTicketInformViewController  余票通知
  	软件是否更新的判断提示在app启动方法中完成.

util：    常用的工具包(加密、验证码、本地存储、网络通信、支付、常用的配置信息，网络接口定义等)
  1、common:常用配置信息、网络接口定义
	Constants      全都定义在这里
  2、network：网络通信模块
    ASIHTTPRequest
  3、payment
  4、其他如有需要，自行追加

model：   查询的数据、订单数据结果处理 
  1、user    组织用户相关数据
  2、ticket  组织车票相关数据
  3、order   组织订单相关数据
  
***关于使用的图片，如果目前的切图没有或是不符合UI的，暂时使用其他代替，全部功能开发完毕，整理有问题的图片交与美工修改***

