<%@ Page Language="VB" AutoEventWireup="false" CodeFile="注册.aspx.vb" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">

        .style2
        {
            width: 100%;
            height: 166px;
        }
        .style3
        {
            width: 136px;
            height: 141px;
        }
        .style4
        {
            width: 100%;
            height: 95px;
        }
        .style32
        {
            width: 77px;
            height: 16px;
        }
        .style15
        {
            width: 55px;
            height: 16px;
        }
        .style16
        {
            width: 51px;
            height: 16px;
        }
        .style17
        {
            width: 71px;
            height: 16px;
        }
        .style18
        {
            width: 57px;
            height: 16px;
        }
        .style19
        {
            width: 70px;
            height: 16px;
        }
        .style20
        {
            width: 59px;
            height: 16px;
        }
        .style21
        {
            width: 44px;
            height: 16px;
        }
        .style35
        {
            width: 47px;
            height: 16px;
        }
        .style22
        {
            width: 152px;
            height: 16px;
        }
        .style33
        {
            width: 77px;
            height: 23px;
        }
        .style24
        {
            width: 55px;
            height: 23px;
        }
        .style25
        {
            width: 51px;
            height: 23px;
        }
        .style26
        {
            width: 71px;
            height: 23px;
        }
        .style27
        {
            width: 57px;
            height: 23px;
        }
        .style28
        {
            width: 70px;
            height: 23px;
        }
        .style29
        {
            width: 59px;
            height: 23px;
        }
        .style30
        {
            width: 44px;
            height: 23px;
        }
        .style36
        {
            width: 47px;
            height: 23px;
        }
        .style31
        {
            width: 152px;
            height: 23px;
        }
        .style34
        {
            width: 77px;
        }
        .style6
        {
            width: 55px;
        }
        .style7
        {
            width: 51px;
        }
        .style8
        {
            width: 71px;
        }
        .style9
        {
            width: 57px;
        }
        .style10
        {
            width: 70px;
        }
        .style11
        {
            width: 59px;
        }
        .style12
        {
            width: 44px;
        }
        .style37
        {
            width: 47px;
        }
        .style13
        {
            width: 152px;
        }
        .style38
        {
            height: 141px;
        }
        .style39
        {
            width: 279px;
        }
        .style40
        {
            width: 528px;
        }
        .style41
        {
            font-size: large;
        }
        .style43
        {
            width: 322px;
        }
        .style44
        {
            width: 475px;
        }
        .style45
        {
            width: 100%;
            height: 550px;
        }
        .style46
        {
            height: 150px;
        }
        .style47
        {
            width: 100%;
            height: 121px;
        }
        .style48
        {
            width: 41px;
        }
        .style49
        {
            width: 100%;
        }
        .style50
        {
            width: 95px;
        }
        .style51
        {
            width: 101px;
        }
        .style52
        {
            width: 72px;
        }
        </style>
</head>
<body style="background-image: url('image/conbg.jpg')">
    <form id="form1" runat="server">
    <div>
    
        <h1>
            <asp:HyperLink ID="HyperLink49" runat="server" CssClass="style41" 
                NavigateUrl="~/首页.aspx">首页</asp:HyperLink>
            <span class="style41">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </span>
            <asp:HyperLink ID="HyperLink47" runat="server" CssClass="style41" 
                NavigateUrl="~/注册.aspx">注册</asp:HyperLink>
            <span class="style41">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>
            <asp:HyperLink ID="HyperLink48" runat="server" CssClass="style41" 
                NavigateUrl="~/登陆.aspx">登录</asp:HyperLink>
            <table class="style4">
                <tr>
                    <td class="style39">
                        <asp:Image 
                ID="Image4" runat="server" Height="103px" Width="225px" ImageUrl="~/image/星星.jpg" />
                    </td>
                    <td class="style40" style="background-color: #FFFFFF">
                        ≧▽≦欢迎注册I Cube≧▽≦</td>
                    <td>
                        <asp:Image ID="Image5" 
                runat="server" Height="103px" Width="165px" ImageUrl="~/image/星星.jpg" />
                    </td>
                </tr>
            </table>
    
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </h1>
        <table class="style2">
            <tr>
                <td class="style3">
                    <asp:Image ID="Image1" runat="server" Height="132px" ImageUrl="~/image/1.png" 
                        style="margin-right: 0px" Width="177px" />
                </td>
                <td class="style38">
                    <table class="style4">
                        <tr>
                            <td class="style32">
                                <asp:HyperLink ID="HyperLink1" runat="server" Font-Bold="True" 
                                    NavigateUrl="~/net/新闻中心_腾讯网.mht" Target="_blank">新闻</asp:HyperLink>
                            </td>
                            <td class="style15">
                                <asp:HyperLink ID="HyperLink2" runat="server" Target="_blank" 
                                    NavigateUrl="~/net/腾讯视频.mht">视频</asp:HyperLink>
                            </td>
                            <td class="style16">
                                <asp:HyperLink ID="HyperLink3" runat="server" 
                                    NavigateUrl="~/net/图片站 _新闻中心_腾讯网.mht" Target="_blank">图片</asp:HyperLink>
                            </td>
                            <td class="style17">
                                <asp:HyperLink ID="HyperLink4" runat="server" NavigateUrl="~/net/评论频道_腾讯网.mht" 
                                    Target="_blank">评论</asp:HyperLink>
                            </td>
                            <td class="style16">
                                <asp:HyperLink ID="HyperLink5" runat="server" Font-Bold="True" 
                                    NavigateUrl="~/net/德尔惠-娱乐频道_腾讯网.mht" Target="_blank">娱乐</asp:HyperLink>
                            </td>
                            <td class="style18">
                                <asp:HyperLink ID="HyperLink6" runat="server" 
                                    NavigateUrl="~/net/明星频道_腾讯娱乐_腾讯网.mht" Target="_blank">明星</asp:HyperLink>
                            </td>
                            <td class="style19">
                                <asp:HyperLink ID="HyperLink25" runat="server" 
                                    NavigateUrl="~/net/电影频道_腾讯娱乐_腾讯网.mht" Target="_blank">电影</asp:HyperLink>
                            </td>
                            <td class="style20">
                                <asp:HyperLink ID="HyperLink29" runat="server" NavigateUrl="~/net/音乐频道_腾讯网.mht" 
                                    Target="_blank">音乐</asp:HyperLink>
                            </td>
                            <td class="style21">
                                <asp:HyperLink ID="HyperLink46" runat="server" Font-Bold="True" Target="_blank" 
                                    NavigateUrl="~/net/护肤彩妆_女性频道_腾讯网.htm">女性</asp:HyperLink>
                            </td>
                            <td class="style35">
                                <asp:HyperLink ID="HyperLink37" runat="server" 
                                    NavigateUrl="~/net/护肤彩妆_女性频道_腾讯网.htm" Target="_blank">美容</asp:HyperLink>
                            </td>
                            <td class="style22">
                                <asp:HyperLink ID="HyperLink41" runat="server" NavigateUrl="~/net/育儿频道_腾讯网.htm" 
                                    Target="_blank">育儿</asp:HyperLink>
                                </td>
                        </tr>
                        <tr>
                            <td class="style33">
                                <asp:HyperLink ID="HyperLink7" runat="server" Font-Bold="True" 
                                    NavigateUrl="~/net/财经频道_腾讯网.mht" Target="_blank">财经</asp:HyperLink>
                            </td>
                            <td class="style24">
                                <asp:HyperLink ID="HyperLink10" runat="server" 
                                    NavigateUrl="~/net/腾讯彩票_体育中心_腾讯网.mht" Target="_blank">股票</asp:HyperLink>
                            </td>
                            <td class="style25">
                                <asp:HyperLink ID="HyperLink13" runat="server" 
                                    NavigateUrl="~/net/国信证券(香港)-港股_财经频道_腾讯网.mht" Target="_blank">港股</asp:HyperLink>
                            </td>
                            <td class="style26">
                                <asp:HyperLink ID="HyperLink16" runat="server" Target="_blank" 
                                    NavigateUrl="~/net/基金_财经频道_腾讯网.mht">基金</asp:HyperLink>
                            </td>
                            <td class="style25">
                                <asp:HyperLink ID="HyperLink19" runat="server" Font-Bold="True" 
                                    NavigateUrl="~/net/NBA_体育频道_腾讯网 - 最好的中文NBA门户.mht" Target="_blank">体育</asp:HyperLink>
                            </td>
                            <td class="style27">
                                <asp:HyperLink ID="HyperLink22" runat="server" 
                                    NavigateUrl="~/net/361°-腾讯体育_腾讯网NBA姚明火箭刘翔中超意甲英超西甲欧冠梅西C罗.mht" Target="_blank">NBA</asp:HyperLink>
                            </td>
                            <td class="style28">
                                <asp:HyperLink ID="HyperLink26" runat="server" 
                                    NavigateUrl="~/net/腾讯彩票_体育中心_腾讯网.mht" Target="_blank">彩票</asp:HyperLink>
                            </td>
                            <td class="style29">
                                <asp:HyperLink ID="HyperLink30" runat="server" 
                                    NavigateUrl="~/net/2012年伦敦奥运会_腾讯奥运_腾讯网.mht" Target="_blank">奥运</asp:HyperLink>
                            </td>
                            <td class="style30">
                                <asp:HyperLink ID="HyperLink34" runat="server" Font-Bold="True" 
                                    NavigateUrl="~/net/时尚频道_腾讯网.mht" Target="_blank">时尚</asp:HyperLink>
                            </td>
                            <td class="style36">
                                <asp:HyperLink ID="HyperLink35" runat="server" 
                                    NavigateUrl="~/net/拍拍网腾讯旗下购物网站.mht" Target="_blank">购物</asp:HyperLink>
                            </td>
                            <td class="style31">
                                <asp:HyperLink ID="HyperLink42" runat="server" 
                                    NavigateUrl="~/net/艺龙旅游指南 – 旅游景点 – 游记攻略 – 旅游问答.mht" Target="_blank">旅游</asp:HyperLink>
                                </td>
                        </tr>
                        <tr>
                            <td class="style34">
                                <asp:HyperLink ID="HyperLink8" runat="server" Font-Bold="True" Target="_blank" 
                                    NavigateUrl="~/net/汽车频道_腾讯网.mht">汽车</asp:HyperLink>
                            </td>
                            <td class="style6">
                                <asp:HyperLink ID="HyperLink11" runat="server" 
                                    NavigateUrl="~/net/房产频道_腾讯·大闽网.mht" Target="_blank">房产</asp:HyperLink>
                            </td>
                            <td class="style7">
                                <asp:HyperLink ID="HyperLink14" runat="server" 
                                    NavigateUrl="~/net/安家啦家居网_腾讯网家居合作频道_爱家居,爱生活.mht" Target="_blank">家居</asp:HyperLink>
                            </td>
                            <td class="style8">
                                <asp:HyperLink ID="HyperLink17" runat="server" 
                                    NavigateUrl="~/net/腾讯家电首页_腾讯科技频道_腾讯网.mht" Target="_blank">家电</asp:HyperLink>
                            </td>
                            <td class="style7">
                                <asp:HyperLink ID="HyperLink20" runat="server" Font-Bold="True" 
                                    NavigateUrl="~/net/读书频道_腾讯网.mht" Target="_blank">读书</asp:HyperLink>
                            </td>
                            <td class="style9">
                                <asp:HyperLink ID="HyperLink23" runat="server" 
                                    NavigateUrl="~/net/原创小说_读书频道_腾讯网.mht" Target="_blank">小说</asp:HyperLink>
                            </td>
                            <td class="style10">
                                <asp:HyperLink ID="HyperLink27" runat="server" NavigateUrl="~/net/教育频道_腾讯网.mht" 
                                    Target="_blank">教育</asp:HyperLink>
                            </td>
                            <td class="style11">
                                <asp:HyperLink ID="HyperLink31" runat="server" 
                                    NavigateUrl="~/net/艺龙旅游指南 – 旅游景点 – 游记攻略 – 旅游问答.mht" Target="_blank">出国</asp:HyperLink>
                            </td>
                            <td class="style12">
                                <asp:HyperLink ID="HyperLink45" runat="server" Font-Bold="True" Target="_blank" 
                                    NavigateUrl="~/net/腾讯博客首页_腾讯网.mht">博客</asp:HyperLink>
                            </td>
                            <td class="style37">
                                <asp:HyperLink ID="HyperLink39" runat="server" 
                                    NavigateUrl="~/net/腾讯微博_你的心声，世界的回声.mht" Target="_blank">微博</asp:HyperLink>
                            </td>
                            <td class="style13">
                                <asp:HyperLink ID="HyperLink43" runat="server" 
                                    NavigateUrl="~/net/腾讯论坛_做最好的综合性中文论坛.mht" Target="_blank">论坛</asp:HyperLink>
                            </td>
                        </tr>
                        <tr>
                            <td class="style34">
                                <asp:HyperLink ID="HyperLink9" runat="server" Font-Bold="True" 
                                    NavigateUrl="~/net/科技频道_腾讯网.mht" Target="_blank">科技</asp:HyperLink>
                            </td>
                            <td class="style6">
                                <asp:HyperLink ID="HyperLink12" runat="server" NavigateUrl="~/net/数码频道_腾讯网.mht" 
                                    Target="_blank">数码</asp:HyperLink>
                            </td>
                            <td class="style7">
                                <asp:HyperLink ID="HyperLink15" runat="server" 
                                    NavigateUrl="~/net/手机频道_腾讯数码_腾讯网.mht" Target="_blank">手机</asp:HyperLink>
                            </td>
                            <td class="style8">
                                <asp:HyperLink ID="HyperLink18" runat="server" 
                                    NavigateUrl="~/net/下载首页_腾讯科技频道_腾讯网.mht" Target="_blank">下载</asp:HyperLink>
                            </td>
                            <td class="style7">
                                <asp:HyperLink ID="HyperLink21" runat="server" Font-Bold="True" 
                                    NavigateUrl="~/net/腾讯游戏频道—最有影响力的游戏媒体 新网游 网络游戏 小游戏 电脑游戏 电子竞技 电视游戏 掌机游戏 游戏攻略 行业新闻.htm" 
                                    Target="_blank">游戏</asp:HyperLink>
                            </td>
                            <td class="style9">
                                <asp:HyperLink ID="HyperLink24" runat="server" NavigateUrl="~/net/腾讯动漫频道.htm" 
                                    Target="_blank">动漫</asp:HyperLink>
                            </td>
                            <td class="style10">
                                <asp:HyperLink ID="HyperLink28" runat="server" 
                                    NavigateUrl="~/net/原创漫画_动漫频道_腾讯网.mht" Target="_blank">漫画</asp:HyperLink>
                            </td>
                            <td class="style11">
                                <asp:HyperLink ID="HyperLink32" runat="server" NavigateUrl="~/net/星座频道_腾讯网.mht" 
                                    Target="_blank">星座</asp:HyperLink>
                            </td>
                            <td class="style12">
                                <asp:HyperLink ID="HyperLink36" runat="server" Font-Bold="True" 
                                    NavigateUrl="~/net/腾讯公益网_腾讯公益 让爱传递_腾讯网.mht" Target="_blank">公益</asp:HyperLink>
                            </td>
                            <td class="style37">
                                <asp:HyperLink ID="HyperLink40" runat="server" 
                                    NavigateUrl="~/net/绿色频道_腾讯新闻_腾讯网.mht" Target="_blank">绿色   </asp:HyperLink>
                            </td>
                            <td class="style13">
                                <asp:HyperLink ID="HyperLink44" runat="server" 
                                    NavigateUrl="~/net/腾讯儿童_腾讯网.mht" Target="_blank">儿童</asp:HyperLink>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    
        <br />
    
    </div>
    <table class="style4">
        <tr>
            <td class="style43">
                <table class="style45">
                    <tr>
                        <td class="style46">
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            <table class="style47">
                                <tr>
                                    <td align="center" class="style48" valign="middle">
                                        实用查询</td>
                                    <td>
                                        <table class="style49">
                                            <tr>
                                                <td class="style50">
                                                    <asp:HyperLink ID="HyperLink50" runat="server" Target="_blank" 
                                                        NavigateUrl="~/实用查询/【火车时刻表列车时刻表火车票转让】- 酷讯.mht">火车时刻</asp:HyperLink>
                                                </td>
                                                <td class="style51">
                                                    <asp:HyperLink ID="HyperLink52" runat="server" 
                                                        NavigateUrl="~/实用查询/guishu_showji_com.mht" Target="_blank">手机位置</asp:HyperLink>
                                                </td>
                                                <td class="style52">
                                                    <asp:HyperLink ID="HyperLink54" runat="server" 
                                                        NavigateUrl="~/实用查询/北京公交查询网—图吧地图提供【全国】公交车线路查询和公交换乘.mht" Target="_blank">查公交</asp:HyperLink>
                                                </td>
                                                <td>
                                                    &nbsp;</td>
                                                <td>
                                                    &nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td class="style50">
                                                    <asp:HyperLink ID="HyperLink51" runat="server" 
                                                        NavigateUrl="~/实用查询/【交通违章查询】_中国精彩网址『 5566_NET，5566_ORG 』.mht" Target="_blank">交通违章</asp:HyperLink>
                                                </td>
                                                <td class="style51">
                                                    <asp:HyperLink ID="HyperLink53" runat="server" 
                                                        NavigateUrl="~/实用查询/【快递查询】_中国精彩网址『 5566_NET，5566_ORG 』.mht" Target="_blank">快速查询</asp:HyperLink>
                                                </td>
                                                <td class="style52">
                                                    <asp:HyperLink ID="HyperLink55" runat="server" 
                                                        NavigateUrl="~/实用查询/【实用网址--实用查询】_中国精彩网址『 5566_NET，5566_ORG 』.mht" 
                                                        Target="_blank">更多</asp:HyperLink>
                                                </td>
                                                <td>
                                                    &nbsp;</td>
                                                <td>
                                                    &nbsp;</td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;</td>
                    </tr>
                </table>
            </td>
            <td class="style44">
        <asp:CreateUserWizard ID="CreateUserWizard1" runat="server" 
            AnswerLabelText="安全答案:" AnswerRequiredErrorMessage="安全答案不能为空哦\(^o^)/~" 
            BackColor="#99CCFF" BorderColor="#3333FF" BorderStyle="Double" 
            BorderWidth="1px" CancelButtonType="Image" 
            CompleteSuccessText="恭喜您!O(∩_∩)O~~您的账户已成功创建\(^o^)/~" 
            ConfirmPasswordCompareErrorMessage="密码和验证密码必须匹配." 
            ConfirmPasswordLabelText="验证密码:" 
            ConfirmPasswordRequiredErrorMessage="验证密码不能为空." ContinueButtonText="继续" 
            CreateUserButtonText="注册新账户" 
            DuplicateEmailErrorMessage="对不起，您输入的邮箱已注册。请另用一个邮箱注册\(^o^)/~" 
            DuplicateUserNameErrorMessage="对不起，用户名已存在(⊙o⊙)" 
            EmailRegularExpressionErrorMessage="请输入正确的邮箱格式o(&gt;﹏&lt;)o" 
            EmailRequiredErrorMessage="E-mail不能为空哈。(⊙o⊙)" FinishCompleteButtonText="结束" 
            FinishPreviousButtonText="上一步" Height="563px" 
            InvalidAnswerErrorMessage="请输入一个不同的安全答案(⊙o⊙)" 
            InvalidEmailErrorMessage="请输入有效的邮箱地址哈(⊙o⊙)" 
            InvalidPasswordErrorMessage="密码最短长度为: {0}.其中必须包含以下非字母数字字符: ‘*’。" 
            InvalidQuestionErrorMessage="请输入一个不同的安全提示问题(⊙o⊙)" PasswordLabelText="密码:" 
            PasswordRegularExpressionErrorMessage="请输入一个不同的密码." 
            PasswordRequiredErrorMessage="密码不能为空(⊙o⊙)" QuestionLabelText="安全提示问题:" 
            QuestionRequiredErrorMessage="安全提示问题不能为空(⊙o⊙)" StartNextButtonText="下一步 " 
            StepNextButtonText="下一步" StepPreviousButtonText="上一步" 
            style="margin-left: 0px" UnknownErrorMessage="对不起,您的用户没有成功创建哈.请重新尝试哦~~(⊙o⊙)" 
            UserNameLabelText="用户名:" UserNameRequiredErrorMessage="用户名不能为空。(⊙o⊙)" 
            Width="496px">
            <TextBoxStyle Height="25px" Width="200px" />
            <LabelStyle Width="200px" />
            <TitleTextStyle BackColor="#3366FF" />
            <WizardSteps>
                <asp:CreateUserWizardStep runat="server" />
                <asp:CompleteWizardStep runat="server" />
            </WizardSteps>
        </asp:CreateUserWizard>
            </td>
            <td>
                <asp:Image ID="Image7" runat="server" Height="244px" ImageUrl="~/image/小熊.gif" 
                    Width="252px" />
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
