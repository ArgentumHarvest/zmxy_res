package export.vip
{
   import AssetsClass.VipTransfromAssets;
   import config.Config;
   import event.CommonEvent;
   import export.RechargeTips;
   import export.warehouse.WareHouse;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import my.MyEquipObj;
   import my.SingleSavedBuff;
   
   public class GameVipInterface extends Sprite
   {
       
      
      private var gc:Config;
      
      public var btn_cz:SimpleButton;
      
      public var vipexp:MovieClip;
      
      public var txt_exp:TextField;
      
      public var txt_level:TextField;
      
      public var txt_nextins:TextField;
      
      public var achievebtn:SimpleButton;
      
      public var achieveexpbtn:SimpleButton;
      
      public var passbtn:SimpleButton;
      
      public var openwhbtn:SimpleButton;
      
      public var btn_close:SimpleButton;
      
      public var sgzzbtn:SimpleButton;
      
      private var vpbtn1:SimpleButton;
      
      private var vpbtn2:SimpleButton;
      
      private var vpbtn3:SimpleButton;
      
      private var vpbtn4:SimpleButton;
      
      private var vpbtn5:SimpleButton;
      
      public var v1_1:MovieClip;
      
      public var v1_2:MovieClip;
      
      public var v1_3:MovieClip;
      
      public var v2_1:MovieClip;
      
      public var v2_2:MovieClip;
      
      public var v2_3:MovieClip;
      
      public var v3_1:MovieClip;
      
      public var v3_2:MovieClip;
      
      public var v3_3:MovieClip;
      
      public var v4_1:MovieClip;
      
      public var v4_2:MovieClip;
      
      public var v4_3:MovieClip;
      
      public var v5_1:MovieClip;
      
      public var v5_2:MovieClip;
      
      public var v5_3:MovieClip;
      
      private var payMoneyVar:PayMoneyVar;
      
      private var vipuplevelary:Array;
      
      private var issave:Boolean = false;
      
      public function GameVipInterface()
      {
         vipuplevelary = [1000,5000,10000,20000,50000];
         super();
         gc = Config.getInstance();
         payMoneyVar = PayMoneyVar.getInstance();
         if(!gc.hasGetMoney)
         {
            if(GMain.serviceHold)
            {
               GMain.serviceHold.getBalance();
            }
         }
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      public function test() : void
      {
         trace("==============tt=t=t=t=t=t======");
      }
      
      private function added(e:Event) : void
      {
         var i:* = 0;
         var dio:* = null;
         for(i = uint(0); i < this.numChildren; )
         {
            dio = this.getChildAt(i);
            if(dio is SimpleButton)
            {
               if(dio != btn_cz && dio != btn_close)
               {
                  dio.visible = false;
               }
            }
            i++;
         }
         trace("GameVipInterface -------add-----");
         this.setAllMc();
         payMoneyVar.money = 2000;
         btn_cz.addEventListener("click",czClick);
         achievebtn.addEventListener("click",giftPackage);
         achieveexpbtn.addEventListener("click",expAddClick);
         passbtn.addEventListener("click",worldTransport);
         openwhbtn.addEventListener("click",openWH);
         sgzzbtn.addEventListener("click",sgzzClick);
         btn_close.addEventListener("click",xClick);
         gc.eventManger.addEventListener("GetMoneySuccess",getMoneySuccess);
         this.txt_nextins.visible = false;
         this.setTxt();
         this.addVipPresentButton();
      }
      
      private function removed(e:Event) : void
      {
         btn_cz.removeEventListener("click",czClick);
         achievebtn.removeEventListener("click",giftPackage);
         achieveexpbtn.removeEventListener("click",expAddClick);
         passbtn.removeEventListener("click",worldTransport);
         openwhbtn.removeEventListener("click",openWH);
         sgzzbtn.removeEventListener("click",sgzzClick);
         btn_close.removeEventListener("click",xClick);
         gc.eventManger.removeEventListener("GetMoneySuccess",getMoneySuccess);
         if(vpbtn1)
         {
            vpbtn1.removeEventListener("click",newVipPresentClick);
         }
         if(vpbtn2)
         {
            vpbtn2.removeEventListener("click",newVipPresentClick);
         }
         if(vpbtn3)
         {
            vpbtn3.removeEventListener("click",newVipPresentClick);
         }
         if(vpbtn4)
         {
            vpbtn4.removeEventListener("click",newVipPresentClick);
         }
         if(vpbtn5)
         {
            vpbtn5.removeEventListener("click",newVipPresentClick);
         }
         if(this.issave)
         {
            if(gc.isHideDebug)
            {
               gc.memory.setStorage(gc.luanqibazaojiami.saveId);
            }
         }
      }
      
      private function addVipPresentButton() : void
      {
         if(gc.gameVip.getVipLevel() >= 1)
         {
            if(this.getVipPresentString(1) == "false")
            {
               vpbtn1 = AUtils.getNewObj("VipGetPresentButton") as SimpleButton;
               vpbtn1.x = 228.4;
               vpbtn1.y = 178.35;
               vpbtn1.visible = true;
               vpbtn1.name = "vpbtn1";
               this.addChild(vpbtn1);
               vpbtn1.addEventListener("click",newVipPresentClick);
            }
         }
         if(gc.gameVip.getVipLevel() >= 2)
         {
            if(this.getVipPresentString(2) == "false")
            {
               vpbtn2 = AUtils.getNewObj("VipGetPresentButton") as SimpleButton;
               vpbtn2.x = 228.4;
               vpbtn2.y = 262.35;
               vpbtn2.name = "vpbtn2";
               vpbtn2.visible = true;
               this.addChild(vpbtn2);
               vpbtn2.addEventListener("click",newVipPresentClick);
            }
         }
         if(gc.gameVip.getVipLevel() >= 3)
         {
            if(this.getVipPresentString(3) == "false")
            {
               vpbtn3 = AUtils.getNewObj("VipGetPresentButton") as SimpleButton;
               vpbtn3.x = 226.55;
               vpbtn3.y = 352.35;
               vpbtn3.visible = true;
               vpbtn3.name = "vpbtn3";
               this.addChild(vpbtn3);
               vpbtn3.addEventListener("click",newVipPresentClick);
            }
         }
         if(gc.gameVip.getVipLevel() >= 4)
         {
            if(this.getVipPresentString(4) == "false")
            {
               vpbtn4 = AUtils.getNewObj("VipGetPresentButton") as SimpleButton;
               vpbtn4.x = 227.55;
               vpbtn4.y = 437.3;
               vpbtn4.visible = true;
               vpbtn4.name = "vpbtn4";
               this.addChild(vpbtn4);
               vpbtn4.addEventListener("click",newVipPresentClick);
            }
         }
         if(gc.gameVip.getVipLevel() >= 5)
         {
            if(this.getVipPresentString(5) == "false")
            {
               vpbtn5 = AUtils.getNewObj("VipGetPresentButton") as SimpleButton;
               vpbtn5.x = 227.55;
               vpbtn5.y = 518.3;
               vpbtn5.visible = true;
               vpbtn5.name = "vpbtn5";
               this.addChild(vpbtn5);
               vpbtn5.addEventListener("click",newVipPresentClick);
            }
         }
      }
      
      private function getMoneySuccess(e:CommonEvent) : void
      {
         this.setTxt();
         this.setAllMc();
      }
      
      private function setTxt() : void
      {
         if(gc.gameVip.getVipLevel() <= 0)
         {
            txt_level.text = " ";
         }
         else
         {
            txt_level.text = "VIP" + gc.gameVip.getVipLevel() + "会员";
         }
         if(gc.gameVip.getVipLevel() < 5)
         {
            txt_exp.text = gc.gameVip.getAllMoney() + "/" + this.findNextVipExp();
            txt_nextins.text = "再充值" + (this.findNextVipExp() - gc.gameVip.getAllMoney()) + "点券，您将成为VIP" + (gc.gameVip.getVipLevel() + 1);
         }
         else
         {
            txt_exp.text = gc.gameVip.getAllMoney() + "/~";
         }
      }
      
      private function setAllMc() : void
      {
         var i:* = 0;
         if(gc.gameVip.getVipLevel() < 5)
         {
            vipexp.gotoAndStop(Math.round(20 * (gc.gameVip.getAllMoney() / this.findNextVipExp())) + 1);
         }
         else
         {
            vipexp.gotoAndStop(1);
         }
         for(i = uint(1); i <= 3; )
         {
            if(gc.gameVip.getVipLevel() >= 1)
            {
               this["v1_" + i].gotoAndStop(2);
               if(!achievebtn.visible)
               {
                  achievebtn.visible = true;
               }
            }
            if(gc.gameVip.getVipLevel() >= 2)
            {
               this["v2_" + i].gotoAndStop(2);
               if(!achieveexpbtn.visible)
               {
                  achieveexpbtn.visible = true;
               }
            }
            if(gc.gameVip.getVipLevel() >= 3)
            {
               this["v3_" + i].gotoAndStop(2);
            }
            if(gc.gameVip.getVipLevel() >= 4)
            {
               this["v4_" + i].gotoAndStop(2);
               if(!passbtn.visible)
               {
                  passbtn.visible = true;
               }
            }
            if(gc.gameVip.getVipLevel() >= 5)
            {
               this["v5_" + i].gotoAndStop(2);
               if(!openwhbtn.visible)
               {
                  openwhbtn.visible = true;
               }
               if(!sgzzbtn.visible)
               {
                  sgzzbtn.visible = true;
               }
            }
            i++;
         }
      }
      
      private function czClick(e:MouseEvent) : void
      {
         var rechargeTips:* = null;
         if(gc.isAirGame)
         {
            gc.isczclick = true;
            gc.openPay();
            return;
         }
         if(GMain.serviceHold)
         {
            if(gc.checkWebUid())
            {
               gc.isczclick = true;
               GMain.serviceHold.payMoney_As3(payMoneyVar);
               rechargeTips = new RechargeTips();
               this.parent.addChild(rechargeTips);
            }
            else
            {
               gc.ts.setTxt("当前游戏帐号不是最新登录的帐号！请刷新游戏");
               gc.stage.addChild(gc.ts);
            }
         }
      }
      
      private function giftPackage(e:MouseEvent) : void
      {
         if(gc.gameVip.getVipLevel() >= 1)
         {
            if(gc.gameVip.vipsavelist[0] == false)
            {
               gc.gameVip.vipsavelist[0] = true;
               trace("领取成功");
               if(gc.player1.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"wpqhs1",1);
               }
               if(gc.player2.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player2,"wpqhs1",1);
               }
               this.issave = true;
               gc.ts.setTxt("领取成功!");
               gc.stage.addChild(gc.ts);
            }
            else
            {
               trace("您的礼包已经领取过");
               gc.ts.setTxt("您的礼包已经领取过!");
               gc.stage.addChild(gc.ts);
            }
         }
         else
         {
            trace("您的VIP等级不够");
            gc.ts.setTxt("您的VIP等级不够");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function expAddClick(e:MouseEvent) : void
      {
         if(gc.gameVip.getVipLevel() >= 2)
         {
            if(gc.gameVip.vipsavelist[2] == false)
            {
               gc.gameVip.vipsavelist[2] = true;
               this.issave = true;
               gc.savedBuff.addBuff(SingleSavedBuff.BUFF_EXP_ADD,2,3600 * gc.frameClips);
               gc.ts.setTxt("领取双倍经验一小时");
               gc.stage.addChild(gc.ts);
            }
            else
            {
               trace("已经领取过");
               gc.ts.setTxt("已经领取过!");
               gc.stage.addChild(gc.ts);
            }
         }
         else
         {
            trace("您的VIP等级不够");
            gc.ts.setTxt("您的VIP等级不够");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function worldTransport(e:MouseEvent) : void
      {
         var viptfrom:* = null;
         trace("worldTransport");
         if(gc.gameVip.getVipLevel() >= 4)
         {
            viptfrom = new VipTransfromAssets();
            gc.stage.addChild(viptfrom);
            this.delloc();
         }
         else
         {
            gc.ts.setTxt("您的VIP等级不够");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function openWH(e:MouseEvent) : void
      {
         trace("openWH");
         var wh:WareHouse = new WareHouse();
         gc.stage.addChild(wh);
         this.delloc();
      }
      
      private function sgzzClick(e:MouseEvent) : void
      {
         var tbi:TimeBoatInterface = new TimeBoatInterface();
         gc.stage.addChild(tbi);
         this.delloc();
      }
      
      private function findNextVipExp() : int
      {
         return this.vipuplevelary[gc.gameVip.getVipLevel()];
      }
      
      private function newVipPresentClick(e:MouseEvent) : void
      {
         var ename:String = String(e.currentTarget.name);
         trace("ename --------->>" + ename);
         var cvl:uint = int(String(ename).charAt(ename.length - 1));
         trace("cvl ----->>>" + cvl);
         if(this.getVipPresentString(cvl) == "false")
         {
            this.getNewVipPresent(cvl);
            e.currentTarget.removeEventListener("click",newVipPresentClick);
            e.currentTarget.visible = false;
         }
         else
         {
            gc.ts.setTxt("您已经领取过VIP" + cvl + "等级的奖励");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function getNewVipPresent(_vipLevel:uint) : void
      {
         var equip:* = null;
         equip = null;
         var equip1:* = null;
         var equip2:* = null;
         var bool:Boolean = false;
         switch(int(_vipLevel) - 1)
         {
            case 0:
               if(!this.judgeZBBackPack())
               {
                  if(gc.player1.roleid > 0)
                  {
                     equip = gc.allEquip.findByName("_zmxyptxnkl2014");
                     gc.player1.zblist.push(equip);
                  }
                  if(gc.player2.roleid > 0)
                  {
                     equip = gc.allEquip.findByName("_zmxyptxnkl2014");
                     gc.player2.zblist.push(equip);
                  }
                  this.setVipPresentString(_vipLevel,"true");
                  gc.ts.setTxt("成功领取2014新年快乐头衔");
                  gc.stage.addChild(gc.ts);
                  bool = true;
               }
               break;
            case 1:
               if(!this.judgeZBBackPack())
               {
                  if(gc.player1.roleid > 0)
                  {
                     equip1 = gc.allEquip.findByName("xhhhl");
                     gc.player1.zblist.push(equip1);
                  }
                  if(gc.player2.roleid > 0)
                  {
                     equip2 = gc.allEquip.findByName("xhhhl");
                     gc.player2.zblist.push(equip2);
                  }
                  this.setVipPresentString(_vipLevel,"true");
                  gc.ts.setTxt("成功领取宣花红葫芦");
                  gc.stage.addChild(gc.ts);
                  bool = true;
               }
               break;
            case 2:
               if(!this.judgeDJBackPack("nianqld"))
               {
                  if(gc.player1.roleid > 0)
                  {
                     gc.putQhsInBackPack(gc.player1,"nianqld");
                  }
                  if(gc.player2.roleid > 0)
                  {
                     gc.putQhsInBackPack(gc.player2,"nianqld");
                  }
                  this.setVipPresentString(_vipLevel,"true");
                  gc.ts.setTxt("成功领取年兽潜力丹");
                  gc.stage.addChild(gc.ts);
                  bool = true;
               }
               break;
            case 3:
               if(!this.judgePetBackPack())
               {
                  if(gc.player1.roleid > 0)
                  {
                     gc.player1.plist.push(gc.allEquip.findByName("p_cynsjl"));
                  }
                  if(gc.player2.roleid > 0)
                  {
                     gc.player2.plist.push(gc.allEquip.findByName("p_cynsjl"));
                  }
                  this.setVipPresentString(_vipLevel,"true");
                  gc.ts.setTxt("成功领取年兽精灵");
                  gc.stage.addChild(gc.ts);
                  bool = true;
               }
               break;
            case 4:
               if(!this.judgeDJBackPack("nianjhd"))
               {
                  if(gc.player1.roleid > 0)
                  {
                     gc.putQhsInBackPack(gc.player1,"nianjhd");
                  }
                  if(gc.player2.roleid > 0)
                  {
                     gc.putQhsInBackPack(gc.player2,"nianjhd");
                  }
                  this.setVipPresentString(_vipLevel,"true");
                  gc.ts.setTxt("成功领取年兽进化丹");
                  gc.stage.addChild(gc.ts);
                  bool = true;
               }
         }
         if(bool)
         {
            if(gc.isHideDebug)
            {
               gc.memory.setStorage(gc.luanqibazaojiami.saveId);
            }
         }
      }
      
      private function getVipPresentString(_vipLevel:uint) : String
      {
         var vary:Array = String(gc.dataObject.getVIPPresent).split("_") as Array;
         return vary[_vipLevel - 1];
      }
      
      private function setVipPresentString(_vipLevel:uint, _bool:String) : void
      {
         var i:* = 0;
         var vary:Array = String(gc.dataObject.getVIPPresent).split("_") as Array;
         var _value:* = _bool;
         vary[_vipLevel - 1] = _value;
         var vlen:uint = vary.length;
         gc.dataObject.getVIPPresent = "";
         for(i = uint(0); i < vlen; )
         {
            gc.dataObject.getVIPPresent += vary[i] + "";
            if(i != vlen - 1)
            {
               gc.dataObject.getVIPPresent += "_";
            }
            i++;
         }
      }
      
      private function judgePetBackPack() : Boolean
      {
         var str:* = null;
         str = null;
         var bool:Boolean = false;
         if(gc.player1.roleid > 0)
         {
            str = "1P";
            if(gc.player1.plist.length >= 15)
            {
               str += "宠物装备栏已满 ";
            }
            if(str != "1P")
            {
               bool = true;
            }
         }
         if(!bool)
         {
            if(gc.player2.roleid > 0)
            {
               str = "2P";
               if(gc.player2.plist.length >= 15)
               {
                  str += "宠物装备栏已满 ";
               }
               if(str != "2P")
               {
                  bool = true;
               }
            }
         }
         if(bool)
         {
            gc.ts.setTxt(str);
            gc.stage.addChild(gc.ts);
         }
         return bool;
      }
      
      private function judgeDJBackPack(wpName:String) : Boolean
      {
         var str:* = null;
         str = null;
         var bool:Boolean = false;
         if(gc.player1.roleid > 0)
         {
            str = "1P";
            if(gc.player1.getSomeOneEquipNumberByName(wpName) <= 0 && gc.player1.djlist.length >= gc.player1.getMax())
            {
               str += "道具栏已满 ";
            }
            if(str != "1P")
            {
               bool = true;
            }
         }
         if(!bool)
         {
            if(gc.player2.roleid > 0)
            {
               str = "2P";
               if(gc.player2.getSomeOneEquipNumberByName(wpName) <= 0 && gc.player2.djlist.length >= gc.player2.getMax())
               {
                  str += "道具栏已满 ";
               }
               if(str != "2P")
               {
                  bool = true;
               }
            }
         }
         if(bool)
         {
            gc.ts.setTxt(str);
            gc.stage.addChild(gc.ts);
         }
         return bool;
      }
      
      private function judgeZBBackPack() : Boolean
      {
         var str:* = null;
         str = null;
         var bool:Boolean = false;
         if(gc.player1.roleid > 0)
         {
            str = "1P";
            if(gc.player1.zblist.length >= gc.player1.getMax())
            {
               str += "装备栏已满 ";
            }
            if(str != "1P")
            {
               bool = true;
            }
         }
         if(!bool)
         {
            if(gc.player2.roleid > 0)
            {
               str = "2P";
               if(gc.player2.zblist.length >= gc.player2.getMax())
               {
                  str += "装备栏已满 ";
               }
               if(str != "2P")
               {
                  bool = true;
               }
            }
         }
         if(bool)
         {
            gc.ts.setTxt(str);
            gc.stage.addChild(gc.ts);
         }
         return bool;
      }
      
      private function xClick(e:MouseEvent) : void
      {
         this.delloc();
      }
      
      private function delloc() : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
