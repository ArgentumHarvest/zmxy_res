package export.huodong
{
   import config.Config;
   import export.huodong.advertising.YaYaLeBitTurntableInterface;
   import export.huodong.advertising.YaYaLeSaveHorsePresent;
   import export.huodong.advertising.YaYaLeTenYearPresent;
   import export.huodong.android.PhoneActivity;
   import export.huodong.chengzheng.ChengZhengPersonPresent;
   import export.huodong.childrenDay.ChildrenDayActivity2015;
   import export.huodong.christmas.ChristmasInterface;
   import export.huodong.christmas.DoubleEgePresent;
   import export.huodong.client.PhoneClientActivity;
   import export.huodong.dayday.Dayday;
   import export.huodong.duanwujie.DuanWuActivity;
   import export.huodong.duanwujie.DuanWuPhoneActivity;
   import export.huodong.dujia.DujiaPresent;
   import export.huodong.festival.ChildrenDay;
   import export.huodong.fruit.GinsengFruitInterface;
   import export.huodong.gamebox.GameBoxActivity;
   import export.huodong.gamebox.YaoYaoLeActivity;
   import export.huodong.gamebox.YaoYaoLeActivity3;
   import export.huodong.guoqing.GuoQingPresent2018;
   import export.huodong.halloween.HalloweenDay;
   import export.huodong.haohua.HaoHuaPresent;
   import export.huodong.kaixue.KaiXuePresent;
   import export.huodong.kapai.KaPaiPresent;
   import export.huodong.miaomiaoBase.AoTeManPresent;
   import export.huodong.miaomiaoBase.BiBaBoTogetherPresent;
   import export.huodong.miaomiaoBase.BiBaBoYuZhouTxPresent;
   import export.huodong.miaomiaoBase.CangjinggePresent;
   import export.huodong.miaomiaoBase.CatchSpritePresent;
   import export.huodong.miaomiaoBase.DiaoYuPresent;
   import export.huodong.miaomiaoBase.DoubleEleventPresent;
   import export.huodong.miaomiaoBase.DregonBigPresent;
   import export.huodong.miaomiaoBase.DuoBaoPresent;
   import export.huodong.miaomiaoBase.DuoLaAMengPresent;
   import export.huodong.miaomiaoBase.GameBoxNewYearPresent;
   import export.huodong.miaomiaoBase.HaiMianBaoBaoPresent;
   import export.huodong.miaomiaoBase.KuaNianPresent2019;
   import export.huodong.miaomiaoBase.LaborsDay2016;
   import export.huodong.miaomiaoBase.MiaoMiaoBaseInterface;
   import export.huodong.miaomiaoBase.MonkeyYearPresent2016;
   import export.huodong.miaomiaoBase.NewYear2025Present;
   import export.huodong.miaomiaoBase.ShiZhouNianPresent;
   import export.huodong.miaomiaoBase.ShiZhouNianZZPresent;
   import export.huodong.miaomiaoBase.ShuMaBaoLongPresent;
   import export.huodong.miaomiaoBase.ThanksGivingDay2018;
   import export.huodong.miaomiaoBase.WanshengjiePresent;
   import export.huodong.miaomiaoBase.WeiXinChongZhiPresent;
   import export.huodong.miaomiaoBase.WeiXinChongZhiPresent2;
   import export.huodong.miaomiaoBase.WeiXinLPZPresent;
   import export.huodong.miaomiaoBase.WeiXinLiaoMeiPresent;
   import export.huodong.miaomiaoBase.WeiXinNeiHanPresent;
   import export.huodong.miaomiaoBase.XiaoHuDuiPresent;
   import export.huodong.miaomiaoBase.XiariJiActivity;
   import export.huodong.miaomiaoBase.YouNeiHanPresent;
   import export.huodong.miaomiaoBase.YouXiHeDaZuoZhanPresent;
   import export.huodong.miaomiaoBase.YouXiHeYunYouXiPresent;
   import export.huodong.miaomiaoBase.ZaoMengDaLiBaoPresent;
   import export.huodong.miaomiaoBase.ZaoMengGongZuoPresent;
   import export.huodong.miaomiaoBase.ZaoMengPresent14;
   import export.huodong.miaomiaoBase.ZaoMengZhouNian12;
   import export.huodong.miaomiaoBase.ZhuoQuPresent;
   import export.huodong.miaomiaoBase.ZmliandongPresent;
   import export.huodong.miaomiaoBase.ZqQiandaoPresent;
   import export.huodong.midautumn.MidAutumnActivity2014;
   import export.huodong.midautumn.MidAutumnActivityInterface;
   import export.huodong.millionpack.EveryDayPresent;
   import export.huodong.millionpack.NewEveryDayPresent;
   import export.huodong.nationalday.NationalDayInterface2014;
   import export.huodong.newyear.NewYearPresent2014;
   import export.huodong.newyear.NewYearPresent2015;
   import export.huodong.newyear.PCNewYearPresent;
   import export.huodong.nianshou.NianShouPresent;
   import export.huodong.nuandong.NuanDongPresent;
   import export.huodong.pk.pkPresent;
   import export.huodong.present2019.BaoXiaoPresent;
   import export.huodong.present2019.DuanWuJiePresent2019;
   import export.huodong.present2019.HanjiaPresent;
   import export.huodong.present2019.XiaoYouXiPresent2019;
   import export.huodong.present2020.NeightBirthdayPresent;
   import export.huodong.present2020.NewYearPresent2020;
   import export.huodong.qinglongjian.QingLongJianPresent;
   import export.huodong.shouyoutong.ShouyoutongActivity;
   import export.huodong.sign.SignUpEveryDay;
   import export.huodong.sole.SolePresent;
   import export.huodong.starPet.StarPetPresent;
   import export.huodong.summer.SummerPresent2017;
   import export.huodong.summerholiday.SummerHoliday;
   import export.huodong.summerholiday.SummerHoliday2015;
   import export.huodong.summerholiday.SummerHoliday3;
   import export.huodong.summerholiday.SummerHoliday4;
   import export.huodong.tequan.TeQuanPresent;
   import export.huodong.tuya.Tuya99Present;
   import export.huodong.tuya.TuyaSaiPresent;
   import export.huodong.vote.VoteActivity;
   import export.huodong.wangzi.PrinceActivity;
   import export.huodong.weixin.WeiXinBaoXiaoActivity;
   import export.huodong.weixin.WeiXinDuanWuBaoXiaoPresent;
   import export.huodong.weixin.WeiXinInterface;
   import export.huodong.weixin.WeiXinInterface3;
   import export.huodong.weixin.WeiXinInterface4;
   import export.huodong.weixin.WeiXinInterface5;
   import export.huodong.weixin.WeiXinInterface6;
   import export.huodong.weixin.WeiXinInterface9;
   import export.huodong.weixin.WuyiBaoXiaoPresent;
   import export.huodong.wuyijie.WuyiJieInterface;
   import export.huodong.wuzhounian.SheQuFiveYearActivity;
   import export.huodong.yikatong.YiKaTongPresent2015;
   import export.huodong.yikatong.YiKaTongThreeYear;
   import export.huodong.yuanbao.YuanBaoPresent;
   import export.huodong.yuetu.StarYueTuPresent;
   import export.huodong.zhuanpan.ZhuanPanActivity;
   import export.huodong.zm3.ShenLongDaLiBao;
   import export.huodong.zmxy.BangWoTongXinPresent;
   import export.huodong.zztenyear.FifteenYearActivity;
   import export.huodong.zztenyear.ZhuZhangTenYearActivity;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class AllHuoDongInterface7 extends Sprite
   {
       
      
      private var gc:Config;
      
      private var firstPageList:Array;
      
      private var secondPageList:Array;
      
      public var btn1:SimpleButton;
      
      public var btn2:SimpleButton;
      
      private var lastBtn:String = "";
      
      private var btnState;
      
      public var xbtn:SimpleButton;
      
      public var qdlbbtnLink:SimpleButton;
      
      public var jfbtn:SimpleButton;
      
      public var qdlbbtn:SimpleButton;
      
      public var yyxbtn:SimpleButton;
      
      public var ldbtn:SimpleButton;
      
      public function AllHuoDongInterface7()
      {
         firstPageList = ["jfbtn","qdlbbtn","yyxbtn","ldbtn"];
         secondPageList = [];
         trace("---new---AllHuoDongInterface7");
         super();
         gc = Config.getInstance();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         xbtn.addEventListener("click",xClick);
         btn1.addEventListener("click",changePage);
         btn2.addEventListener("click",changePage);
         jfbtn.addEventListener("click",jfClick);
         qdlbbtn.addEventListener("click",qdlbClick);
         qdlbbtnLink.addEventListener("click",qdlbLinkClick);
         yyxbtn.addEventListener("click",yyxClick);
         ldbtn.addEventListener("click",ldClick);
         btn1.dispatchEvent(new MouseEvent("click"));
         if(this.secondPageList.length == 0)
         {
            this.btn2.visible = false;
         }
      }
      
      private function removed(e:Event) : void
      {
         xbtn.removeEventListener("click",xClick);
         jfbtn.removeEventListener("click",jfClick);
         qdlbbtn.removeEventListener("click",qdlbClick);
         qdlbbtnLink.removeEventListener("click",qdlbLinkClick);
         yyxbtn.removeEventListener("click",yyxClick);
         ldbtn.removeEventListener("click",ldClick);
         btn1.removeEventListener("click",changePage);
         btn2.removeEventListener("click",changePage);
      }
      
      private function changePage(e:MouseEvent) : void
      {
         switch(e.currentTarget.name)
         {
            case "btn1":
               this.changeCurrentPageActivity(this.firstPageList);
               break;
            case "btn2":
               this.changeCurrentPageActivity(this.secondPageList);
         }
         if(btnState)
         {
            if(lastBtn != "")
            {
               this[lastBtn].upState = btnState;
            }
         }
         lastBtn = e.currentTarget.name;
         btnState = e.target.upState;
         e.target.upState = e.target.downState;
      }
      
      private function changeCurrentPageActivity(ary:Array) : void
      {
         var len:* = 0;
         var i:* = 0;
         i = 0;
         i = 0;
         i = 0;
         var aname:String = "";
         len = uint(this.firstPageList.length);
         for(i = uint(0); i < len; )
         {
            aname = this.firstPageList[i];
            trace("---------aname-------" + aname);
            if(this[aname])
            {
               this[aname].visible = false;
            }
            i++;
         }
         len = uint(this.secondPageList.length);
         for(i = uint(0); i < len; )
         {
            aname = this.secondPageList[i];
            if(this[aname])
            {
               this[aname].visible = false;
            }
            i++;
         }
         len = uint(ary.length);
         for(i = uint(0); i < len; )
         {
            aname = ary[i];
            if(this[aname])
            {
               this[aname].visible = true;
            }
            i++;
         }
      }
      
      private function qdlbLinkClick(e:MouseEvent) : void
      {
         gc.openUrl("https://huodong2.4399.com/n/comm/pcsign/index.php?strcode=Mg==");
      }
      
      private function sznbtnClick(e:MouseEvent) : void
      {
         var mmbi:ShiZhouNianPresent = new ShiZhouNianPresent();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(mmbi);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function sznzzClick(e:MouseEvent) : void
      {
         var mmbi:ShiZhouNianZZPresent = new ShiZhouNianZZPresent();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(mmbi);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function gejBtnClick(e:MouseEvent) : void
      {
         var spp:ThanksGivingDay2018 = new ThanksGivingDay2018();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(spp);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function gqBtnClick(e:MouseEvent) : void
      {
         var spp:GuoQingPresent2018 = new GuoQingPresent2018();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(spp);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function zqBtnClick(e:MouseEvent) : void
      {
         var spp:WeiXinLPZPresent = new WeiXinLPZPresent();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(spp);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function kaixueBtnClick(e:Event) : void
      {
         var spp:KaiXuePresent = new KaiXuePresent();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(spp);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function xrjBtnClick(e:MouseEvent) : void
      {
         var spp:XiariJiActivity = new XiariJiActivity();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(spp);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function wuyiBtnClick(e:MouseEvent) : void
      {
         var spp:WuyiBaoXiaoPresent = new WuyiBaoXiaoPresent();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(spp);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function wxBBtnClick(e:MouseEvent) : void
      {
         var spp:WeiXinChongZhiPresent2 = new WeiXinChongZhiPresent2();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(spp);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function lzBtnClick(e:MouseEvent) : void
      {
         var spp:DregonBigPresent = new DregonBigPresent();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(spp);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function knBtnClick(e:MouseEvent) : void
      {
         var spp:KuaNianPresent2019 = new KuaNianPresent2019();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(spp);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function sdBtnClick(e:MouseEvent) : void
      {
         var spp:ZqQiandaoPresent = new ZqQiandaoPresent();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(spp);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function yuanxiaoBtnClick(e:MouseEvent) : void
      {
         var spp:XiaoYouXiPresent2019 = new XiaoYouXiPresent2019();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(spp);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function djBtnClick(e:MouseEvent) : void
      {
         var spp:DujiaPresent = new DujiaPresent();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(spp);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function ynhBtnClick(e:MouseEvent) : void
      {
         var spp:YouNeiHanPresent = new YouNeiHanPresent();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(spp);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function hmbbBtnClick(e:MouseEvent) : void
      {
         var spp:HaiMianBaoBaoPresent = new HaiMianBaoBaoPresent();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(spp);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function wxczBtnClick(e:MouseEvent) : void
      {
         var spp:WeiXinChongZhiPresent = new WeiXinChongZhiPresent();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(spp);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function dwjBtnClick(e:MouseEvent) : void
      {
         var spp:ZaoMengDaLiBaoPresent = new ZaoMengDaLiBaoPresent();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(spp);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function wxlmBtnClick(e:MouseEvent) : void
      {
         var spp:WeiXinLiaoMeiPresent = new WeiXinLiaoMeiPresent();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(spp);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function diaoyuBtnClick(e:MouseEvent) : void
      {
         var spp:DiaoYuPresent = new DiaoYuPresent();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(spp);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function dlamBtnClick(e:MouseEvent) : void
      {
         var spp:DuoLaAMengPresent = new DuoLaAMengPresent();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(spp);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function doubleBtnClick(e:MouseEvent) : void
      {
         var spp:DoubleEleventPresent = new DoubleEleventPresent();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(spp);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function wsjBtnClick(e:MouseEvent) : void
      {
         var spp:WanshengjiePresent = new WanshengjiePresent();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(spp);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function weixin9BtnClick(e:MouseEvent) : void
      {
         var spp:WeiXinInterface9 = new WeiXinInterface9();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(spp);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function qinghuaiBtnClick(e:MouseEvent) : void
      {
         var spp:FifteenYearActivity = new FifteenYearActivity();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(spp);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function summerBtnClick(e:MouseEvent) : void
      {
         var spp:SummerPresent2017 = new SummerPresent2017();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(spp);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function catchSpriteBtnClick(e:MouseEvent) : void
      {
         var spp:CatchSpritePresent = new CatchSpritePresent();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(spp);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function smblBtnClickHandler(e:MouseEvent) : void
      {
         var spp:ShuMaBaoLongPresent = new ShuMaBaoLongPresent();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(spp);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function bbb2BtnClick(e:MouseEvent) : void
      {
         var spp:BiBaBoYuZhouTxPresent = new BiBaBoYuZhouTxPresent();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(spp);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function dzzlbBtnClick(e:MouseEvent) : void
      {
         var spp:YouXiHeDaZuoZhanPresent = new YouXiHeDaZuoZhanPresent();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(spp);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function nyBtn2020Click(e:MouseEvent) : void
      {
         var spp:NewYearPresent2020 = new NewYearPresent2020();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(spp);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function sjlbBtnClick(e:MouseEvent) : void
      {
         var spp:BaoXiaoPresent = new BaoXiaoPresent();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(spp);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function cjgBtnClick(e:MouseEvent) : void
      {
         var spp:CangjinggePresent = new CangjinggePresent();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(spp);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function sytbtnClick(e:MouseEvent) : void
      {
         var spp:ShouyoutongActivity = new ShouyoutongActivity();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(spp);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function aoTeManClick(e:MouseEvent) : void
      {
         var spp:AoTeManPresent = new AoTeManPresent();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(spp);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function weiXinBaoXiaoClick(e:MouseEvent) : void
      {
         var spp:WeiXinBaoXiaoActivity = new WeiXinBaoXiaoActivity();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(spp);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function kapaiBtnClick(e:MouseEvent) : void
      {
         var spp:* = null;
         var dayAry1:Array = gc.dataObjectInstance.curDate.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]) - 1;
         var day1:uint = int(dayAry1[2]);
         var timeAry1:Array = gc.dataObjectInstance.curTime.split(":");
         var hours:uint = int(timeAry1[0]);
         var date1:Date = new Date(year1,month1,day1,hours);
         if(date1.getTime() >= 1468893600000)
         {
            spp = new KaPaiPresent();
            if(this.parent)
            {
               if(this.parent.parent)
               {
                  this.parent.parent.addChild(spp);
               }
               this.parent.removeChild(this);
            }
         }
         else
         {
            gc.ts.setTxt("星斗卡牌礼包将于7月19日开启，敬请期待");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function chongzhiClick(e:MouseEvent) : void
      {
         var spp:ChongZhiActivity = new ChongZhiActivity();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(spp);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function shenlongClick(e:MouseEvent) : void
      {
         var dayAry1:Array = gc.dataObjectInstance.curDate.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]) - 1;
         var day1:uint = int(dayAry1[2]);
         var timeAry1:Array = gc.dataObjectInstance.curTime.split(":");
         var hours:uint = int(timeAry1[0]);
         var date1:Date = new Date(year1,month1,day1,hours);
         var spp:ShenLongDaLiBao = new ShenLongDaLiBao();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(spp);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function weiXin7Click(e:MouseEvent) : void
      {
         var spp:WeiXinDuanWuBaoXiaoPresent = new WeiXinDuanWuBaoXiaoPresent();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(spp);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function weiXin6Click(e:MouseEvent) : void
      {
         var spp:* = null;
         var dayAry1:Array = gc.dataObjectInstance.curDate.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]) - 1;
         var day1:uint = int(dayAry1[2]);
         var timeAry1:Array = gc.dataObjectInstance.curTime.split(":");
         var hours:uint = int(timeAry1[0]);
         var date1:Date = new Date(year1,month1,day1,hours);
         if(date1.getTime() >= 1493344800000)
         {
            spp = new WeiXinInterface6();
            if(this.parent)
            {
               if(this.parent.parent)
               {
                  this.parent.parent.addChild(spp);
               }
               this.parent.removeChild(this);
            }
         }
         else
         {
            gc.ts.setTxt("豪华微信礼包将于4月28日开启，敬请期待");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function duobaoBtnClick(e:MouseEvent) : void
      {
         var spp:DuoBaoPresent = new DuoBaoPresent();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(spp);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function weiXin5Click(e:MouseEvent) : void
      {
         var spp:* = null;
         var dayAry1:Array = gc.dataObjectInstance.curDate.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]) - 1;
         var day1:uint = int(dayAry1[2]);
         var timeAry1:Array = gc.dataObjectInstance.curTime.split(":");
         var hours:uint = int(timeAry1[0]);
         var date1:Date = new Date(year1,month1,day1,hours);
         if(date1.getTime() >= 1468461600000)
         {
            spp = new WeiXinInterface5();
            if(this.parent)
            {
               if(this.parent.parent)
               {
                  this.parent.parent.addChild(spp);
               }
               this.parent.removeChild(this);
            }
         }
         else
         {
            gc.ts.setTxt("微信礼包将于7月14日开启，敬请期待");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function soleBtnClick(e:MouseEvent) : void
      {
         var dayAry1:Array = gc.dataObjectInstance.curDate.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]) - 1;
         var day1:uint = int(dayAry1[2]);
         var timeAry1:Array = gc.dataObjectInstance.curTime.split(":");
         var hours:uint = int(timeAry1[0]);
         var gbny:SolePresent = new SolePresent();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(gbny);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function bibaboBtnClick(e:MouseEvent) : void
      {
         var gbny:* = null;
         var dayAry1:Array = gc.dataObjectInstance.curDate.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]) - 1;
         var day1:uint = int(dayAry1[2]);
         var timeAry1:Array = gc.dataObjectInstance.curTime.split(":");
         var hours:uint = int(timeAry1[0]);
         var date1:Date = new Date(year1,month1,day1,hours);
         if(date1.getTime() >= 1489975200000)
         {
            gbny = new BiBaBoTogetherPresent();
            if(this.parent)
            {
               if(this.parent.parent)
               {
                  this.parent.parent.addChild(gbny);
               }
               this.parent.removeChild(this);
            }
         }
         else
         {
            gc.ts.setTxt("比巴卜一起去玩乐礼包将于3月20日开启，敬请期待",2.5,20);
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function weiXinBtnClick(e:MouseEvent) : void
      {
         var gbny:WeiXinNeiHanPresent = new WeiXinNeiHanPresent();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(gbny);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function xhdBtnClick(e:MouseEvent) : void
      {
         var gbny:* = null;
         var dayAry1:Array = gc.dataObjectInstance.curDate.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]) - 1;
         var day1:uint = int(dayAry1[2]);
         var timeAry1:Array = gc.dataObjectInstance.curTime.split(":");
         var hours:uint = int(timeAry1[0]);
         var date1:Date = new Date(year1,month1,day1,hours);
         if(date1.getTime() >= 1461895200000)
         {
            gbny = new XiaoHuDuiPresent();
            if(this.parent)
            {
               if(this.parent.parent)
               {
                  this.parent.parent.addChild(gbny);
               }
               this.parent.removeChild(this);
            }
         }
         else
         {
            gc.ts.setTxt("康师傅小虎队礼包将于4月29日开启，敬请期待",2.5,22);
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function laborBtnClick(e:MouseEvent) : void
      {
         var gbny:* = null;
         var dayAry1:Array = gc.dataObjectInstance.curDate.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]) - 1;
         var day1:uint = int(dayAry1[2]);
         var timeAry1:Array = gc.dataObjectInstance.curTime.split(":");
         var hours:uint = int(timeAry1[0]);
         var date1:Date = new Date(year1,month1,day1,hours);
         if(date1.getTime() >= 1461722400000)
         {
            gbny = new LaborsDay2016();
            if(this.parent)
            {
               if(this.parent.parent)
               {
                  this.parent.parent.addChild(gbny);
               }
               this.parent.removeChild(this);
            }
         }
         else
         {
            gc.ts.setTxt("4399游戏盒五一礼包将于4月27日开启，敬请期待",2.5,24);
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function millionEveryDayClick(e:MouseEvent) : void
      {
         var gbny:NewEveryDayPresent = new NewEveryDayPresent();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(gbny);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function monkey2016BtnClick(e:MouseEvent) : void
      {
         var gbny:* = null;
         var dayAry1:Array = gc.dataObjectInstance.curDate.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]) - 1;
         var day1:uint = int(dayAry1[2]);
         var timeAry1:Array = gc.dataObjectInstance.curTime.split(":");
         var hours:uint = int(timeAry1[0]);
         var date1:Date = new Date(year1,month1,day1,hours);
         if(date1.getTime() >= 1454385600000)
         {
            gbny = new MonkeyYearPresent2016();
            if(this.parent)
            {
               if(this.parent.parent)
               {
                  this.parent.parent.addChild(gbny);
               }
               this.parent.removeChild(this);
            }
         }
         else
         {
            gc.ts.setTxt("猴年礼包将于2月2日开启，敬请期待");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function everyDayBtnClick(e:MouseEvent) : void
      {
         var gbny:* = null;
         var dayAry1:Array = gc.dataObjectInstance.curDate.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]) - 1;
         var day1:uint = int(dayAry1[2]);
         var timeAry1:Array = gc.dataObjectInstance.curTime.split(":");
         var hours:uint = int(timeAry1[0]);
         var date1:Date = new Date(year1,month1,day1,hours);
         if(date1.getTime() >= 1453255200000)
         {
            gbny = new EveryDayPresent();
            if(this.parent)
            {
               if(this.parent.parent)
               {
                  this.parent.parent.addChild(gbny);
               }
               this.parent.removeChild(this);
            }
         }
         else
         {
            gc.ts.setTxt("每日礼包将于1月20日开启，敬请期待");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function gameBoxBtnClick(e:MouseEvent) : void
      {
         var dayAry1:Array = gc.dataObjectInstance.curDate.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]) - 1;
         var day1:uint = int(dayAry1[2]);
         var timeAry1:Array = gc.dataObjectInstance.curTime.split(":");
         var hours:uint = int(timeAry1[0]);
         var date1:Date = new Date(year1,month1,day1,hours);
         var gbny:GameBoxNewYearPresent = new GameBoxNewYearPresent();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(gbny);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function yuetuClick(e:MouseEvent) : void
      {
         var spp:* = null;
         var dayAry1:Array = gc.dataObjectInstance.curDate.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]) - 1;
         var day1:uint = int(dayAry1[2]);
         var timeAry1:Array = gc.dataObjectInstance.curTime.split(":");
         var hours:uint = int(timeAry1[0]);
         var date1:Date = new Date(year1,month1,day1,hours);
         if(date1.getTime() >= 1438221600000)
         {
            spp = new StarYueTuPresent();
            if(this.parent)
            {
               if(this.parent.parent)
               {
                  this.parent.parent.addChild(spp);
               }
               this.parent.removeChild(this);
            }
         }
         else
         {
            gc.ts.setTxt("明星宠物月兔礼包将于7月30日开启，敬请期待");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function summerHoliday2015Click(e:MouseEvent) : void
      {
         var spp:* = null;
         var dayAry1:Array = gc.dataObjectInstance.curDate.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]) - 1;
         var day1:uint = int(dayAry1[2]);
         var timeAry1:Array = gc.dataObjectInstance.curTime.split(":");
         var hours:uint = int(timeAry1[0]);
         var date1:Date = new Date(year1,month1,day1,hours);
         if(date1.getTime() >= 1437012000000)
         {
            spp = new SummerHoliday2015();
            if(this.parent)
            {
               if(this.parent.parent)
               {
                  this.parent.parent.addChild(spp);
               }
               this.parent.removeChild(this);
            }
         }
         else
         {
            gc.ts.setTxt("暑假年兽大礼包将于7月16日开启，敬请期待");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function tuya4Click(e:MouseEvent) : void
      {
         var spp:* = null;
         var dayAry1:Array = gc.dataObjectInstance.curDate.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]) - 1;
         var day1:uint = int(dayAry1[2]);
         var timeAry1:Array = gc.dataObjectInstance.curTime.split(":");
         var hours:uint = int(timeAry1[0]);
         var date1:Date = new Date(year1,month1,day1,hours);
         if(date1.getTime() >= 1436493600000)
         {
            spp = new TuyaSaiPresent();
            if(this.parent)
            {
               if(this.parent.parent)
               {
                  this.parent.parent.addChild(spp);
               }
               this.parent.removeChild(this);
            }
         }
         else
         {
            gc.ts.setTxt("涂鸦赛活动礼包将于7月10日开启，敬请期待");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function bwtxClick(e:MouseEvent) : void
      {
         var spp:* = null;
         var dayAry1:Array = gc.dataObjectInstance.curDate.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]) - 1;
         var day1:uint = int(dayAry1[2]);
         var timeAry1:Array = gc.dataObjectInstance.curTime.split(":");
         var hours:uint = int(timeAry1[0]);
         var date1:Date = new Date(year1,month1,day1,hours);
         if(date1.getTime() >= 1436500800000)
         {
            spp = new BangWoTongXinPresent();
            if(this.parent)
            {
               if(this.parent.parent)
               {
                  this.parent.parent.addChild(spp);
               }
               this.parent.removeChild(this);
            }
         }
         else
         {
            gc.ts.setTxt("伴我同行礼包将于7月10日开启，敬请期待");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function weiXin4Click(e:MouseEvent) : void
      {
         var spp:* = null;
         var dayAry1:Array = gc.dataObjectInstance.curDate.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]) - 1;
         var day1:uint = int(dayAry1[2]);
         var timeAry1:Array = gc.dataObjectInstance.curTime.split(":");
         var hours:uint = int(timeAry1[0]);
         var date1:Date = new Date(year1,month1,day1,hours);
         if(date1.getTime() >= 1436925600000)
         {
            spp = new WeiXinInterface4();
            if(this.parent)
            {
               if(this.parent.parent)
               {
                  this.parent.parent.addChild(spp);
               }
               this.parent.removeChild(this);
            }
         }
         else
         {
            gc.ts.setTxt("微信礼包将于7月15日开启，敬请期待");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function summerHoliday4Click(e:MouseEvent) : void
      {
         var spp:* = null;
         var dayAry1:Array = gc.dataObjectInstance.curDate.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]) - 1;
         var day1:uint = int(dayAry1[2]);
         var timeAry1:Array = gc.dataObjectInstance.curTime.split(":");
         var hours:uint = int(timeAry1[0]);
         var date1:Date = new Date(year1,month1,day1,hours);
         if(date1.getTime() >= 1443146400000)
         {
            spp = new SummerHoliday4();
            if(this.parent)
            {
               if(this.parent.parent)
               {
                  this.parent.parent.addChild(spp);
               }
               this.parent.removeChild(this);
            }
         }
         else
         {
            gc.ts.setTxt("摇摇乐每日礼包将于9月25日开启，敬请期待");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function pkClick(e:MouseEvent) : void
      {
         var dayAry1:Array = gc.dataObjectInstance.curDate.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]) - 1;
         var day1:uint = int(dayAry1[2]);
         var timeAry1:Array = gc.dataObjectInstance.curTime.split(":");
         var hours:uint = int(timeAry1[0]);
         var date1:Date = new Date(year1,month1,day1,hours);
         var spp:pkPresent = new pkPresent();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(spp);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function daydayClick(e:MouseEvent) : void
      {
         var dayAry1:Array = gc.dataObjectInstance.curDate.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]) - 1;
         var day1:uint = int(dayAry1[2]);
         var timeAry1:Array = gc.dataObjectInstance.curTime.split(":");
         var hours:uint = int(timeAry1[0]);
         var date1:Date = new Date(year1,month1,day1,hours);
         var spp:Dayday = new Dayday();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(spp);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function yktbtn2015Click(e:MouseEvent) : void
      {
         var spp:* = null;
         var dayAry1:Array = gc.dataObjectInstance.curDate.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]) - 1;
         var day1:uint = int(dayAry1[2]);
         var timeAry1:Array = gc.dataObjectInstance.curTime.split(":");
         var hours:uint = int(timeAry1[0]);
         var date1:Date = new Date(year1,month1,day1,hours);
         if(date1.getTime() >= 1434506400000)
         {
            spp = new YiKaTongPresent2015();
            if(this.parent)
            {
               if(this.parent.parent)
               {
                  this.parent.parent.addChild(spp);
               }
               this.parent.removeChild(this);
            }
         }
         else
         {
            gc.ts.setTxt("一卡通礼包将于6月17日开启，敬请期待");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function qljbtnClick(e:MouseEvent) : void
      {
         var spp:* = null;
         var dayAry1:Array = gc.dataObjectInstance.curDate.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]) - 1;
         var day1:uint = int(dayAry1[2]);
         var timeAry1:Array = gc.dataObjectInstance.curTime.split(":");
         var hours:uint = int(timeAry1[0]);
         var date1:Date = new Date(year1,month1,day1,hours);
         if(date1.getTime() >= 1433296800000)
         {
            spp = new QingLongJianPresent();
            if(this.parent)
            {
               if(this.parent.parent)
               {
                  this.parent.parent.addChild(spp);
               }
               this.parent.removeChild(this);
            }
         }
         else
         {
            gc.ts.setTxt("青龙剑原创大礼包将于6月1日开启，敬请期待");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function childDay2015Click(e:MouseEvent) : void
      {
         var spp:* = null;
         var dayAry1:Array = gc.dataObjectInstance.curDate.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]) - 1;
         var day1:uint = int(dayAry1[2]);
         var timeAry1:Array = gc.dataObjectInstance.curTime.split(":");
         var hours:uint = int(timeAry1[0]);
         var date1:Date = new Date(year1,month1,day1,hours);
         if(date1.getTime() >= 1433142000000)
         {
            spp = new ChildrenDayActivity2015();
            if(this.parent)
            {
               if(this.parent.parent)
               {
                  this.parent.parent.addChild(spp);
               }
               this.parent.removeChild(this);
            }
         }
         else
         {
            gc.ts.setTxt("六一儿童节礼包将于6月1日开启，敬请期待");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function yyl10Click(e:MouseEvent) : void
      {
         var spp:* = null;
         var dayAry1:Array = gc.dataObjectInstance.curDate.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]) - 1;
         var day1:uint = int(dayAry1[2]);
         var timeAry1:Array = gc.dataObjectInstance.curTime.split(":");
         var hours:uint = int(timeAry1[0]);
         var date1:Date = new Date(year1,month1,day1,hours);
         if(date1.getTime() >= 1431655200000)
         {
            spp = new YaYaLeTenYearPresent();
            if(this.parent)
            {
               if(this.parent.parent)
               {
                  this.parent.parent.addChild(spp);
               }
               this.parent.removeChild(this);
            }
         }
         else
         {
            gc.ts.setTxt("伢牙乐相伴十年礼包将于5月15日开启，敬请期待");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function ksfbtnClick(e:MouseEvent) : void
      {
         var yyla:ZhuoQuPresent = new ZhuoQuPresent();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(yyla);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function zpbtnClick(e:MouseEvent) : void
      {
         var spp:* = null;
         var dayAry1:Array = gc.dataObjectInstance.curDate.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]) - 1;
         var day1:uint = int(dayAry1[2]);
         var timeAry1:Array = gc.dataObjectInstance.curTime.split(":");
         var hours:uint = int(timeAry1[0]);
         var date1:Date = new Date(year1,month1,day1,hours);
         if(date1.getTime() >= 1427853600000)
         {
            spp = new ZhuanPanActivity();
            if(this.parent)
            {
               if(this.parent.parent)
               {
                  this.parent.parent.addChild(spp);
               }
               this.parent.removeChild(this);
            }
         }
         else
         {
            gc.ts.setTxt("转盘礼包将于4月1日开启，敬请期待");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function qcbtnClick(e:MouseEvent) : void
      {
         var yyla:HanjiaPresent = new HanjiaPresent();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(yyla);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function newYearPresent2015(e:MouseEvent) : void
      {
         var yyla:* = null;
         var dayAry1:Array = gc.dataObjectInstance.curDate.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]) - 1;
         var day1:uint = int(dayAry1[2]);
         var timeAry1:Array = gc.dataObjectInstance.curTime.split(":");
         var hours:uint = int(timeAry1[0]);
         var date1:Date = new Date(year1,month1,day1,hours);
         if(date1.getTime() >= 1424080800000)
         {
            yyla = new NewYearPresent2015();
            if(this.parent)
            {
               if(this.parent.parent)
               {
                  this.parent.parent.addChild(yyla);
               }
               this.parent.removeChild(this);
            }
         }
         else
         {
            gc.ts.setTxt("羊年春节礼包将于2月16日开启，敬请期待");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function bbbbtnClick(e:MouseEvent) : void
      {
         var yyla:DuanWuJiePresent2019 = new DuanWuJiePresent2019();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(yyla);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function bbqxmClick(e:MouseEvent) : void
      {
         gc.openUrl("https://huodong3.4399.com/laoba/");
      }
      
      private function ybbtnClick(e:MouseEvent) : void
      {
         var spp:* = null;
         var dayAry1:Array = gc.dataObjectInstance.curDate.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]) - 1;
         var day1:uint = int(dayAry1[2]);
         var timeAry1:Array = gc.dataObjectInstance.curTime.split(":");
         var hours:uint = int(timeAry1[0]);
         var date1:Date = new Date(year1,month1,day1,hours);
         if(date1.getTime() >= 1421737200000)
         {
            spp = new YuanBaoPresent();
            if(this.parent)
            {
               if(this.parent.parent)
               {
                  this.parent.parent.addChild(spp);
               }
               this.parent.removeChild(this);
            }
         }
         else
         {
            gc.ts.setTxt("元宝礼包将于1月20日开启，敬请期待");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function yztmClick(e:MouseEvent) : void
      {
         var spp:* = null;
         var dayAry1:Array = gc.dataObjectInstance.curDate.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]) - 1;
         var day1:uint = int(dayAry1[2]);
         var timeAry1:Array = gc.dataObjectInstance.curTime.split(":");
         var hours:uint = int(timeAry1[0]);
         var date1:Date = new Date(year1,month1,day1,hours);
         if(date1.getTime() >= 1443060000000)
         {
            spp = new HaoHuaPresent();
            if(this.parent)
            {
               if(this.parent.parent)
               {
                  this.parent.parent.addChild(spp);
               }
               this.parent.removeChild(this);
            }
         }
         else
         {
            gc.ts.setTxt("造梦西游3豪华礼包将于9月24日开启，敬请期待");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function sd14Click(e:MouseEvent) : void
      {
         var spp:* = null;
         var dayAry1:Array = gc.dataObjectInstance.curDate.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]) - 1;
         var day1:uint = int(dayAry1[2]);
         var timeAry1:Array = gc.dataObjectInstance.curTime.split(":");
         var hours:uint = int(timeAry1[0]);
         var date1:Date = new Date(year1,month1,day1,hours);
         if(date1.getTime() >= 1419472800000)
         {
            spp = new DoubleEgePresent();
            if(this.parent)
            {
               if(this.parent.parent)
               {
                  this.parent.parent.addChild(spp);
               }
               this.parent.removeChild(this);
            }
         }
         else
         {
            gc.ts.setTxt("双旦礼包将于12月25日开启，敬请期待");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function tybtnClick(e:MouseEvent) : void
      {
         var spp:* = null;
         var dayAry1:Array = gc.dataObjectInstance.curDate.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]) - 1;
         var day1:uint = int(dayAry1[2]);
         var timeAry1:Array = gc.dataObjectInstance.curTime.split(":");
         var hours:uint = int(timeAry1[0]);
         var date1:Date = new Date(year1,month1,day1,hours);
         if(date1.getTime() >= 1425607200000)
         {
            spp = new Tuya99Present();
            if(this.parent)
            {
               if(this.parent.parent)
               {
                  this.parent.parent.addChild(spp);
               }
               this.parent.removeChild(this);
            }
         }
         else
         {
            gc.ts.setTxt("99期涂鸦画板礼包将于3月6日开启，敬请期待");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function sdbtnClick(e:MouseEvent) : void
      {
         var yyla:YaoYaoLeActivity = new YaoYaoLeActivity();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(yyla);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function startPetClick(e:MouseEvent) : void
      {
         var spp:* = null;
         var dayAry1:Array = gc.dataObjectInstance.curDate.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]) - 1;
         var day1:uint = int(dayAry1[2]);
         var timeAry1:Array = gc.dataObjectInstance.curTime.split(":");
         var hours:uint = int(timeAry1[0]);
         var date1:Date = new Date(year1,month1,day1,hours);
         if(date1.getTime() >= 1417053600000)
         {
            spp = new StarPetPresent();
            if(this.parent)
            {
               if(this.parent.parent)
               {
                  this.parent.parent.addChild(spp);
               }
               this.parent.removeChild(this);
            }
         }
         else
         {
            gc.ts.setTxt("明星宠物礼包将于11月27日开启，敬请期待");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function tqlbClick(e:MouseEvent) : void
      {
         var tqp:TeQuanPresent = new TeQuanPresent();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(tqp);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function wsjClick(e:MouseEvent) : void
      {
         var hall:* = null;
         var dayAry1:Array = gc.dataObjectInstance.curDate.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]) - 1;
         var day1:uint = int(dayAry1[2]);
         var timeAry1:Array = gc.dataObjectInstance.curTime.split(":");
         var hours:uint = int(timeAry1[0]);
         var date1:Date = new Date(year1,month1,day1,hours);
         if(date1.getTime() >= 1414720800000)
         {
            hall = new HalloweenDay();
            if(this.parent)
            {
               if(this.parent.parent)
               {
                  this.parent.parent.addChild(hall);
               }
               this.parent.removeChild(this);
            }
         }
         else
         {
            gc.ts.setTxt("万圣节礼包将于10月31日开启，敬请期待");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function ndbtnClick(e:MouseEvent) : void
      {
         var sued:NuanDongPresent = new NuanDongPresent();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(sued);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function zm12Click(e:MouseEvent) : void
      {
         var sued:ZaoMengZhouNian12 = new ZaoMengZhouNian12();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(sued);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function ldClick(e:MouseEvent) : void
      {
         var drageonPresent:ZmliandongPresent = new ZmliandongPresent();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(drageonPresent);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function lnlbClick(e:MouseEvent) : void
      {
         var drageonPresent:ZaoMengPresent14 = new ZaoMengPresent14();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(drageonPresent);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function yyxClick(e:MouseEvent) : void
      {
         var sued:YouXiHeYunYouXiPresent = new YouXiHeYunYouXiPresent();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(sued);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function newYClick(e:MouseEvent) : void
      {
         var sued:NewYear2025Present = new NewYear2025Present();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(sued);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function qdlbClick(e:MouseEvent) : void
      {
         var sued:SignUpEveryDay = new SignUpEveryDay();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(sued);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function gzsClick(e:MouseEvent) : void
      {
         var sued:ZaoMengGongZuoPresent = new ZaoMengGongZuoPresent();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(sued);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function birBtnClick(e:MouseEvent) : void
      {
         var sued:NeightBirthdayPresent = new NeightBirthdayPresent();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(sued);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function bgYYLClick(e:MouseEvent) : void
      {
         var yyla:* = null;
         var dayAry1:Array = gc.dataObjectInstance.curDate.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]) - 1;
         var day1:uint = int(dayAry1[2]);
         var timeAry1:Array = gc.dataObjectInstance.curTime.split(":");
         var hours:uint = int(timeAry1[0]);
         var date1:Date = new Date(year1,month1,day1,hours);
         if(date1.getTime() >= 1429927200000)
         {
            yyla = new YaoYaoLeActivity3();
            if(this.parent)
            {
               if(this.parent.parent)
               {
                  this.parent.parent.addChild(yyla);
               }
               this.parent.removeChild(this);
            }
         }
         else
         {
            gc.ts.setTxt("摇摇乐每日礼包将于4月25日开启，敬请期待");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function zqlbClick(e:MouseEvent) : void
      {
         var mid:* = null;
         var dayAry1:Array = gc.dataObjectInstance.curDate.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]) - 1;
         var day1:uint = int(dayAry1[2]);
         var timeAry1:Array = gc.dataObjectInstance.curTime.split(":");
         var hours:uint = int(timeAry1[0]);
         var date1:Date = new Date(year1,month1,day1,hours);
         if(date1.getTime() >= 1409878800000)
         {
            mid = new MidAutumnActivity2014();
            if(this.parent)
            {
               if(this.parent.parent)
               {
                  this.parent.parent.addChild(mid);
               }
               this.parent.removeChild(this);
            }
         }
         else
         {
            gc.ts.setTxt("中秋礼包将于9月5日开启，敬请期待");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function nianClick(e:MouseEvent) : void
      {
         var nsp:* = null;
         var dayAry1:Array = gc.dataObjectInstance.curDate.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]) - 1;
         var day1:uint = int(dayAry1[2]);
         var timeAry1:Array = gc.dataObjectInstance.curTime.split(":");
         var hours:uint = int(timeAry1[0]);
         var date1:Date = new Date(year1,month1,day1,hours);
         if(date1.getTime() >= 1408582800000)
         {
            nsp = new NianShouPresent();
            if(this.parent)
            {
               if(this.parent.parent)
               {
                  this.parent.parent.addChild(nsp);
               }
               this.parent.removeChild(this);
            }
         }
         else
         {
            gc.ts.setTxt("年兽大礼包将于8月21日开启，敬请期待");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function dzpClick(e:MouseEvent) : void
      {
         var yyl:YaYaLeBitTurntableInterface = new YaYaLeBitTurntableInterface();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(yyl);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function zxlbClick(e:MouseEvent) : void
      {
         var gba:GameBoxActivity = new GameBoxActivity();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(gba);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function sjClick(e:MouseEvent) : void
      {
         var sh3:* = null;
         var dayAry1:Array = gc.dataObjectInstance.curDate.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]) - 1;
         var day1:uint = int(dayAry1[2]);
         var timeAry1:Array = gc.dataObjectInstance.curTime.split(":");
         var hours:uint = int(timeAry1[0]);
         var date1:Date = new Date(year1,month1,day1,hours);
         if(date1.getTime() >= 1406163600000)
         {
            sh3 = new SummerHoliday3();
            if(this.parent)
            {
               if(this.parent.parent)
               {
                  this.parent.parent.addChild(sh3);
               }
               this.parent.removeChild(this);
            }
         }
         else
         {
            gc.ts.setTxt("神兽大作战暑假礼包将于7月24日开启，敬请期待");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function wznClick(e:MouseEvent) : void
      {
         var sqfa:* = null;
         var dayAry1:Array = gc.dataObjectInstance.curDate.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]) - 1;
         var day1:uint = int(dayAry1[2]);
         var timeAry1:Array = gc.dataObjectInstance.curTime.split(":");
         var hours:uint = int(timeAry1[0]);
         var date1:Date = new Date(year1,month1,day1);
         if(date1.getTime() >= 1405353600000)
         {
            sqfa = new SheQuFiveYearActivity();
            if(this.parent)
            {
               if(this.parent.parent)
               {
                  this.parent.parent.addChild(sqfa);
               }
               this.parent.removeChild(this);
            }
         }
         else
         {
            gc.ts.setTxt("游戏吧五周年礼包将于7月15日开启，敬请期待");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function tyClick(e:MouseEvent) : void
      {
         var zzty:* = null;
         var dayAry1:Array = gc.dataObjectInstance.curDate.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]) - 1;
         var day1:uint = int(dayAry1[2]);
         var timeAry1:Array = gc.dataObjectInstance.curTime.split(":");
         var hours:uint = int(timeAry1[0]);
         var date1:Date = new Date(year1,month1,day1,hours);
         if(date1.getTime() >= 1404093600000)
         {
            zzty = new ZhuZhangTenYearActivity();
            if(this.parent)
            {
               if(this.parent.parent)
               {
                  this.parent.parent.addChild(zzty);
               }
               this.parent.removeChild(this);
            }
         }
         else
         {
            gc.ts.setTxt("4399十周年礼包将于6月30日开启，敬请期待");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function yktClick(e:MouseEvent) : void
      {
         var ykt:* = null;
         var dayAry1:Array = gc.dataObjectInstance.curDate.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]) - 1;
         var day1:uint = int(dayAry1[2]);
         var timeAry1:Array = gc.dataObjectInstance.curTime.split(":");
         var hours:uint = int(timeAry1[0]);
         var date1:Date = new Date(year1,month1,day1,hours);
         if(date1.getTime() >= 1402934400000)
         {
            ykt = new YiKaTongThreeYear();
            if(this.parent)
            {
               if(this.parent.parent)
               {
                  this.parent.parent.addChild(ykt);
               }
               this.parent.removeChild(this);
            }
         }
         else
         {
            gc.ts.setTxt("一卡通礼包活动将于6月17号开启");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function lzClick(e:MouseEvent) : void
      {
         var dw:DuanWuActivity = new DuanWuActivity();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(dw);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function zzClick(e:MouseEvent) : void
      {
         var dw:DuanWuPhoneActivity = new DuanWuPhoneActivity();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(dw);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function wuyiClick(e:MouseEvent) : void
      {
         var childDay:* = null;
         var dayAry1:Array = gc.dataObjectInstance.curDate.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]) - 1;
         var day1:uint = int(dayAry1[2]);
         var timeAry1:Array = gc.dataObjectInstance.curTime.split(":");
         var hours:uint = int(timeAry1[0]);
         var date1:Date = new Date(year1,month1,day1,hours);
         if(date1.getTime() >= 1430445600000)
         {
            childDay = new WuyiJieInterface();
            if(this.parent)
            {
               if(this.parent.parent)
               {
                  this.parent.parent.addChild(childDay);
               }
               this.parent.removeChild(this);
            }
         }
         else
         {
            gc.ts.setTxt("五一礼包活动将于5月1号开启,，敬请期待");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function wxtpClick(e:MouseEvent) : void
      {
         var wxVote:* = null;
         var dayAry1:Array = gc.dataObjectInstance.curDate.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]) - 1;
         var day1:uint = int(dayAry1[2]);
         var timeAry1:Array = gc.dataObjectInstance.curTime.split(":");
         var hours:uint = int(timeAry1[0]);
         var minutes:uint = int(timeAry1[1]);
         var date1:Date = new Date(year1,month1,day1,hours,minutes);
         if(date1.getTime() >= 1395394200000)
         {
            wxVote = new VoteActivity();
            if(this.parent)
            {
               if(this.parent.parent)
               {
                  this.parent.parent.addChild(wxVote);
               }
               this.parent.removeChild(this);
            }
         }
         else
         {
            gc.ts.setTxt("微信礼包活动将于3月21号开启");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function kfdClick(e:MouseEvent) : void
      {
         var pca:* = null;
         var dayAry1:Array = gc.dataObjectInstance.curDate.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]) - 1;
         var day1:uint = int(dayAry1[2]);
         var timeAry1:Array = gc.dataObjectInstance.curTime.split(":");
         var hours:uint = int(timeAry1[0]);
         var date1:Date = new Date(year1,month1,day1,hours);
         if(date1.getTime() >= 1394640000000)
         {
            pca = new PhoneClientActivity();
            if(this.parent)
            {
               if(this.parent.parent)
               {
                  this.parent.parent.addChild(pca);
               }
               this.parent.removeChild(this);
            }
         }
         else
         {
            gc.ts.setTxt("客户端专属礼包活动将于3月13号开启");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function rsgClick(e:MouseEvent) : void
      {
         var gfi:GinsengFruitInterface = new GinsengFruitInterface();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(gfi);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function gqClick(e:MouseEvent) : void
      {
         var ndi:* = null;
         var dayAry1:Array = gc.dataObjectInstance.curDate.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]) - 1;
         var day1:uint = int(dayAry1[2]);
         var timeAry1:Array = gc.dataObjectInstance.curTime.split(":");
         var hours:uint = int(timeAry1[0]);
         var date1:Date = new Date(year1,month1,day1,hours);
         if(date1.getTime() >= 1412042400000)
         {
            ndi = new NationalDayInterface2014();
            if(this.parent)
            {
               if(this.parent.parent)
               {
                  this.parent.parent.addChild(ndi);
               }
               this.parent.removeChild(this);
            }
         }
         else
         {
            gc.ts.setTxt("国庆礼包活动将于9月30日开启");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function zqClick(e:MouseEvent) : void
      {
         var maai:* = null;
         var dayAry1:Array = gc.dataObjectInstance.curDate.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]) - 1;
         var day1:uint = int(dayAry1[2]);
         var date1:Date = new Date(year1,month1,day1);
         if(date1.getTime() >= 1379347200000)
         {
            maai = new MidAutumnActivityInterface();
            if(this.parent)
            {
               if(this.parent.parent)
               {
                  this.parent.parent.addChild(maai);
               }
               this.parent.removeChild(this);
            }
         }
         else
         {
            gc.ts.setTxt("中秋礼包活动将于9月17号开启");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function jfClick(e:MouseEvent) : void
      {
         var mmbi:MiaoMiaoBaseInterface = new MiaoMiaoBaseInterface();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(mmbi);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function sdClick(e:MouseEvent) : void
      {
         var crInt:* = null;
         var dayAry1:Array = gc.dataObjectInstance.curDate.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]) - 1;
         var day1:uint = int(dayAry1[2]);
         var date1:Date = new Date(year1,month1,day1);
         if(date1.getTime() >= 1387555200000)
         {
            crInt = new ChristmasInterface();
            if(this.parent)
            {
               if(this.parent.parent)
               {
                  this.parent.parent.addChild(crInt);
               }
               this.parent.removeChild(this);
            }
         }
         else
         {
            gc.ts.setTxt("圣诞礼包活动将于12月21号开启");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function weiXinClick(e:MouseEvent) : void
      {
         var wx3:* = null;
         var dayAry1:Array = gc.dataObjectInstance.curDate.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]) - 1;
         var day1:uint = int(dayAry1[2]);
         var date1:Date = new Date(year1,month1,day1);
         if(date1.getTime() >= 1375286400000)
         {
            wx3 = new WeiXinInterface3();
            if(this.parent)
            {
               if(this.parent.parent)
               {
                  this.parent.parent.addChild(wx3);
               }
               this.parent.removeChild(this);
            }
         }
         else
         {
            gc.ts.setTxt("微信礼包活动将于8月1号开启");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function wxClick(e:MouseEvent) : void
      {
         var wxi:WeiXinInterface = new WeiXinInterface();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(wxi);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function princeClick(e:MouseEvent) : void
      {
         var pa:PrinceActivity = new PrinceActivity();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(pa);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function childClick(e:MouseEvent) : void
      {
         var cd:* = null;
         var dayAry1:Array = gc.dataObjectInstance.curDate.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]) - 1;
         var day1:uint = int(dayAry1[2]);
         var timeAry1:Array = gc.dataObjectInstance.curTime.split(":");
         var hours1:uint = int(timeAry1[0]);
         var minus1:uint = int(timeAry1[1]);
         var seconds1:uint = int(timeAry1[2]);
         var date1:Date = new Date(year1,month1,day1,hours1,minus1,seconds1);
         if(date1.getTime() >= 1369929599000)
         {
            cd = new ChildrenDay();
            if(this.parent)
            {
               if(this.parent.parent)
               {
                  this.parent.parent.addChild(cd);
               }
               this.parent.removeChild(this);
            }
         }
         else
         {
            gc.ts.setTxt("六一礼包活动将于5月31号开启");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function summerHolidayClick(e:MouseEvent) : void
      {
         var sh:* = null;
         var dayAry1:Array = gc.dataObjectInstance.curDate.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]) - 1;
         var day1:uint = int(dayAry1[2]);
         var timeAry1:Array = gc.dataObjectInstance.curTime.split(":");
         var hours:uint = int(timeAry1[0]);
         var date1:Date = new Date(year1,month1,day1,hours);
         if(date1.getTime() >= 1377136800000)
         {
            sh = new SummerHoliday();
            if(this.parent)
            {
               if(this.parent.parent)
               {
                  this.parent.parent.addChild(sh);
               }
               this.parent.removeChild(this);
            }
         }
         else
         {
            gc.ts.setTxt("暑假礼包活动将于8月22日上午10点再次开启");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function xClick(e:MouseEvent) : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function yylClick(e:MouseEvent) : void
      {
         var yylg:YaYaLeSaveHorsePresent = new YaYaLeSaveHorsePresent();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(yylg);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function phoneClick(e:MouseEvent) : void
      {
         var pa:PhoneActivity = new PhoneActivity();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(pa);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function jnhClick(e:MouseEvent) : void
      {
         var pcny:* = null;
         var dayAry1:Array = gc.dataObjectInstance.curDate.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]) - 1;
         var day1:uint = int(dayAry1[2]);
         var date1:Date = new Date(year1,month1,day1);
         if(date1.getTime() >= 1390665600000)
         {
            pcny = new PCNewYearPresent();
            if(this.parent)
            {
               if(this.parent.parent)
               {
                  this.parent.parent.addChild(pcny);
               }
               this.parent.removeChild(this);
            }
         }
         else
         {
            gc.ts.setTxt("嘉年华礼包活动将于1月26号开启");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function nyClick(e:MouseEvent) : void
      {
         var ny2014:* = null;
         var dayAry1:Array = gc.dataObjectInstance.curDate.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]) - 1;
         var day1:uint = int(dayAry1[2]);
         var timeAry1:Array = gc.dataObjectInstance.curTime.split(":");
         var hours:uint = int(timeAry1[0]);
         var date1:Date = new Date(year1,month1,day1,hours);
         if(date1.getTime() >= 1390806000000)
         {
            ny2014 = new NewYearPresent2014();
            if(this.parent)
            {
               if(this.parent.parent)
               {
                  this.parent.parent.addChild(ny2014);
               }
               this.parent.removeChild(this);
            }
         }
         else
         {
            gc.ts.setTxt("新春礼包活动将于1月27号开启");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function zpsClick(e:MouseEvent) : void
      {
         var czp:* = null;
         var dayAry1:Array = gc.dataObjectInstance.curDate.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]) - 1;
         var day1:uint = int(dayAry1[2]);
         var timeAry1:Array = gc.dataObjectInstance.curTime.split(":");
         var hours:uint = int(timeAry1[0]);
         var date1:Date = new Date(year1,month1,day1,hours);
         if(date1.getTime() >= 1390528800000)
         {
            czp = new ChengZhengPersonPresent();
            if(this.parent)
            {
               if(this.parent.parent)
               {
                  this.parent.parent.addChild(czp);
               }
               this.parent.removeChild(this);
            }
         }
         else
         {
            gc.ts.setTxt("作品书礼包活动将于1月24号开启");
            gc.stage.addChild(gc.ts);
         }
      }
   }
}
