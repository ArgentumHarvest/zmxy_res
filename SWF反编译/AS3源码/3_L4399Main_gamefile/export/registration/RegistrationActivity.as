package export.registration
{
   import config.Config;
   import event.CommonEvent;
   import export.renewalse.RenewalseThisSZ;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import manager.PayManager;
   import mvc.controllor.RandomControllor;
   import my.ContinuitySignIn;
   import my.MyEquipObj;
   import my.SingleSavedBuff;
   import petInfo.PetInfo;
   
   public class RegistrationActivity extends Sprite
   {
       
      
      public var xbtn:SimpleButton;
      
      public var regbtn:SimpleButton;
      
      public var reregbtn:SimpleButton;
      
      public var prebtn:SimpleButton;
      
      public var nextbtn:SimpleButton;
      
      public var lbbtn1:MovieClip;
      
      public var lbbtn2:MovieClip;
      
      public var lbbtn3:MovieClip;
      
      public var lbbtn4:MovieClip;
      
      public var daymc:MovieClip;
      
      public var daytxt:TextField;
      
      public var signTimetxt:TextField;
      
      public var oldSigntxt:TextField;
      
      public var daymc0:MovieClip;
      
      public var daymc1:MovieClip;
      
      public var daymc2:MovieClip;
      
      public var daymc3:MovieClip;
      
      public var daymc4:MovieClip;
      
      public var daymc5:MovieClip;
      
      public var daymc6:MovieClip;
      
      public var daymc7:MovieClip;
      
      public var daymc8:MovieClip;
      
      public var daymc9:MovieClip;
      
      public var daymc10:MovieClip;
      
      public var daymc11:MovieClip;
      
      public var daymc12:MovieClip;
      
      public var daymc13:MovieClip;
      
      public var daymc14:MovieClip;
      
      public var daymc15:MovieClip;
      
      public var daymc16:MovieClip;
      
      public var daymc17:MovieClip;
      
      public var daymc18:MovieClip;
      
      public var daymc19:MovieClip;
      
      public var daymc20:MovieClip;
      
      public var daymc21:MovieClip;
      
      public var daymc22:MovieClip;
      
      public var daymc23:MovieClip;
      
      public var daymc24:MovieClip;
      
      public var daymc25:MovieClip;
      
      public var daymc26:MovieClip;
      
      public var daymc27:MovieClip;
      
      public var daymc28:MovieClip;
      
      public var daymc29:MovieClip;
      
      public var daymc30:MovieClip;
      
      public var daymc31:MovieClip;
      
      public var daymc32:MovieClip;
      
      public var daymc33:MovieClip;
      
      public var daymc34:MovieClip;
      
      private var curPage:uint = 1;
      
      private var gc:Config;
      
      private var renewalse:RenewalseThisSZ;
      
      public function RegistrationActivity()
      {
         super();
         gc = Config.getInstance();
         renewalse = new RenewalseThisSZ();
         renewalse.name = "renewalseThisSZ";
         this.addEventListener("addedToStage",added);
         this.addEventListener("removedFromStage",removed);
      }
      
      private function added(e:Event) : void
      {
         this.removeEventListener("addedToStage",added);
         if(!gc.hasGetMoney)
         {
            if(GMain.serviceHold)
            {
               GMain.serviceHold.getBalance();
            }
         }
         this.xbtn.addEventListener("click",xClick);
         this.prebtn.addEventListener("click",pageClick);
         this.nextbtn.addEventListener("click",pageClick);
         this.regbtn.addEventListener("click",signInClick);
         this.reregbtn.addEventListener("click",reSignInClick);
         gc.eventManger.addEventListener("BuySuccess",paymentSuccess);
         var ary:Array = String(gc.dataObjectInstance.curDate).split("-");
         if(ary[1] == "07" || ary[1] == "7")
         {
            this.prebtn.dispatchEvent(new MouseEvent("click"));
         }
         else
         {
            this.nextbtn.dispatchEvent(new MouseEvent("click"));
         }
         this.addEventListener("click",__mcClick);
      }
      
      private function removed(e:Event) : void
      {
         this.removeEventListener("removedFromStage",removed);
         this.xbtn.removeEventListener("click",xClick);
         this.prebtn.removeEventListener("click",pageClick);
         this.nextbtn.removeEventListener("click",pageClick);
         this.regbtn.removeEventListener("click",signInClick);
         this.reregbtn.removeEventListener("click",reSignInClick);
         renewalse = null;
         gc.eventManger.removeEventListener("BuySuccess",paymentSuccess);
         this.removeEventListener("click",__mcClick);
      }
      
      protected function __mcClick(evt:MouseEvent) : void
      {
         var clickIndex:int = 0;
         var today:* = 0;
         var delay:* = 0;
         var smonth:* = 0;
         var todayIndex:int = 0;
         if(String(evt.target.name).indexOf("daymc") != -1)
         {
            if(String(evt.target.name) != "daymc")
            {
               clickIndex = int(String(evt.target.name).substr(5));
               today = uint(ContinuitySignIn.getIns().getDayDiffFromStartDayToToday());
               delay = uint(0);
               smonth = uint(0);
               if(this.curPage == 1)
               {
                  delay = uint(11);
                  smonth = uint(0);
               }
               else
               {
                  delay = uint(1);
                  smonth = uint(18);
               }
               todayIndex = today + delay - smonth;
               if(clickIndex == todayIndex)
               {
                  this.regbtn.dispatchEvent(new MouseEvent("click"));
               }
            }
         }
      }
      
      private function signInClick(e:MouseEvent) : void
      {
         var today:uint = ContinuitySignIn.getIns().getDayDiffFromStartDayToToday();
         if(today >= 49)
         {
            gc.ts.setTxt("活动已结束");
            gc.stage.addChild(gc.ts);
            return;
         }
         if(!ContinuitySignIn.getIns().hasSignInToday())
         {
            ContinuitySignIn.getIns().signInToday();
            this.randomPresent();
            this.reSetInterface();
            if(gc.isHideDebug)
            {
               gc.memory.setStorage(gc.luanqibazaojiami.saveId);
            }
         }
         else
         {
            gc.ts.setTxt("您今天已经签到过");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function reSignInClick(e:MouseEvent) : void
      {
         if(!gc.isHideDebug)
         {
            ContinuitySignIn.getIns().signInOld();
            this.reSetInterface();
            return;
         }
         if(ContinuitySignIn.getIns().getLeftSignOldDays() > 0)
         {
            this.addRenewalseMask("您确定花100点券补签一次吗？");
         }
         else
         {
            gc.ts.setTxt("您不需要补签");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function setAllDayMc() : void
      {
         var i:* = 0;
         var curIdx:int = 0;
         var sit:int = 0;
         var delay:uint = 0;
         var smonth:uint = 0;
         var maxLen:uint = 0;
         if(this.curPage == 1)
         {
            delay = 11;
            smonth = 0;
            maxLen = 18;
         }
         else
         {
            delay = 1;
            smonth = 18;
            maxLen = 30;
         }
         var sAry:Array = ContinuitySignIn.getIns().signedArray;
         var today:uint = ContinuitySignIn.getIns().getDayDiffFromStartDayToToday();
         for(i = uint(0); i < 35; )
         {
            if(i >= delay)
            {
               if(!(i > today + delay - smonth || i > maxLen + delay))
               {
                  curIdx = i - delay + smonth;
                  sit = sAry.indexOf(curIdx);
                  if(this["daymc" + i])
                  {
                     if(sit != -1)
                     {
                        this["daymc" + i].gotoAndStop(3);
                        this["daymc" + i].buttonMode = true;
                     }
                     else
                     {
                        this["daymc" + i].gotoAndStop(2);
                        this["daymc" + i].buttonMode = true;
                     }
                  }
               }
            }
            i++;
         }
      }
      
      private function reSetInterface() : void
      {
         var i:* = 0;
         for(i = uint(0); i < 35; )
         {
            if(this["daymc" + i])
            {
               this["daymc" + i].gotoAndStop(1);
               this["daymc" + i].buttonMode = false;
            }
            i++;
         }
         this.setAllDayMc();
         this.lbbtn1.removeEventListener("click",lqClick);
         this.lbbtn1.buttonMode = false;
         if(ContinuitySignIn.getIns().hasArrive5DaysPrize())
         {
            if(ContinuitySignIn.getIns().hasGet5DaysPrize())
            {
               this.lbbtn1.gotoAndStop(3);
            }
            else
            {
               this.lbbtn1.gotoAndStop(2);
               this.lbbtn1.addEventListener("click",lqClick);
               this.lbbtn1.buttonMode = true;
            }
         }
         else
         {
            this.lbbtn1.gotoAndStop(1);
         }
         this.lbbtn2.removeEventListener("click",lqClick);
         this.lbbtn2.buttonMode = false;
         if(ContinuitySignIn.getIns().hasArrive15DayPrize())
         {
            if(ContinuitySignIn.getIns().hasGet15DayPrize())
            {
               this.lbbtn2.gotoAndStop(3);
            }
            else
            {
               this.lbbtn2.gotoAndStop(2);
               this.lbbtn2.addEventListener("click",lqClick);
               this.lbbtn2.buttonMode = true;
            }
         }
         else
         {
            this.lbbtn2.gotoAndStop(1);
         }
         this.lbbtn3.removeEventListener("click",lqClick);
         this.lbbtn3.buttonMode = false;
         if(ContinuitySignIn.getIns().hasArrive30DaysPrize())
         {
            if(ContinuitySignIn.getIns().hasGet30DaysPrize())
            {
               this.lbbtn3.gotoAndStop(3);
            }
            else
            {
               this.lbbtn3.gotoAndStop(2);
               this.lbbtn3.addEventListener("click",lqClick);
               this.lbbtn3.buttonMode = true;
            }
         }
         else
         {
            this.lbbtn3.gotoAndStop(1);
         }
         this.lbbtn4.removeEventListener("click",lqClick);
         this.lbbtn4.buttonMode = false;
         if(ContinuitySignIn.getIns().hasArrive50DaysPrize())
         {
            if(ContinuitySignIn.getIns().hasGet50DaysPrize())
            {
               this.lbbtn4.gotoAndStop(3);
            }
            else
            {
               this.lbbtn4.gotoAndStop(2);
               this.lbbtn4.addEventListener("click",lqClick);
               this.lbbtn4.buttonMode = true;
            }
         }
         else
         {
            this.lbbtn4.gotoAndStop(1);
         }
         this.signTimetxt.text = ContinuitySignIn.getIns().getSigninDays() + "";
         this.oldSigntxt.text = ContinuitySignIn.getIns().getLeftSignOldDays() + "";
      }
      
      private function lqClick(e:MouseEvent) : void
      {
         trace("e.currentTarget.name ---->>" + e.currentTarget.name);
         switch(e.currentTarget.name)
         {
            case "lbbtn1":
               ContinuitySignIn.getIns().get5DaysPrize();
               this.get5DaysPresent();
               break;
            case "lbbtn2":
               if(this.judgePet())
               {
                  return;
               }
               if(this.judgePetBackPack())
               {
                  return;
               }
               ContinuitySignIn.getIns().get15DaysPrize();
               this.get15DaysPresent();
               break;
            case "lbbtn3":
               if(this.judgeSz())
               {
                  return;
               }
               if(this.judgeZb())
               {
                  return;
               }
               ContinuitySignIn.getIns().get30DaysPrize();
               this.get30DaysPresent();
               break;
            case "lbbtn4":
               if(this.judgeSz())
               {
                  return;
               }
               if(this.judgeZb())
               {
                  return;
               }
               ContinuitySignIn.getIns().get50DaysPrize();
               this.get50DaysPresent();
               break;
         }
         this.reSetInterface();
         if(gc.isHideDebug)
         {
            gc.memory.setStorage(gc.luanqibazaojiami.saveId);
         }
      }
      
      private function get5DaysPresent() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.player1.zblist.push(this.getEquip(true));
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.zblist.push(this.getEquip(true));
         }
         gc.ts.setTxt("成功领取 阴阳斩龙剑x1");
         gc.stage.addChild(gc.ts);
      }
      
      private function getEquip(_wx:Boolean = true, _fname:String = "yyzlj") : MyEquipObj
      {
         var equip:MyEquipObj = gc.allEquip.findByName(_fname);
         equip.setEupdata(2.4);
         if(_wx)
         {
            equip.setWX({
               "jin":false,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
         }
         return equip;
      }
      
      private function get15DaysPresent() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.player1.petsAry.push(this.getPetInfo());
            gc.player1.plist.push(gc.allEquip.findByName("p_cycnjl"));
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.petsAry.push(this.getPetInfo());
            gc.player2.plist.push(gc.allEquip.findByName("p_cycnjl"));
         }
         gc.ts.setTxt("成功领取宠物 丑牛元帅x1、丑牛精灵x1");
         gc.stage.addChild(gc.ts);
      }
      
      private function getPetInfo() : PetInfo
      {
         var pif:PetInfo = new PetInfo();
         pif.setPetNameAndLevel("neat1",1);
         pif.setperception(5);
         pif.setwarpower(4);
         pif.settechnique(4);
         pif.sethpQuality(1700);
         pif.setmpQuality(200);
         pif.setatkQuality(1800);
         pif.setdefQuality(500);
         pif.setHp(1200);
         pif.setMp(200);
         pif.setAtk(60);
         pif.setDef(8);
         pif.setSHp(pif.getHp());
         pif.setSMp(pif.getMp());
         return pif;
      }
      
      private function getSorryPresent() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.player1.petsAry.push(this.getNeatPetInfo());
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.petsAry.push(this.getNeatPetInfo());
         }
         gc.ts.setTxt("成功领取宠物 丑牛元帅");
         gc.stage.addChild(gc.ts);
         if(gc.isHideDebug)
         {
            gc.memory.setStorage(gc.luanqibazaojiami.saveId);
         }
      }
      
      private function getNeatPetInfo() : PetInfo
      {
         var pif:PetInfo = new PetInfo();
         pif.setPetNameAndLevel("neat1",1);
         pif.setperception(gc.dataObject.two + Math.round(RandomControllor.getIns().getRandom() * gc.dataObject.three));
         pif.setwarpower(gc.dataObject.two + Math.round(RandomControllor.getIns().getRandom() * gc.dataObject.two));
         pif.settechnique(gc.dataObject.two + Math.round(RandomControllor.getIns().getRandom() * gc.dataObject.two));
         pif.sethpQuality((1100 + Math.round(RandomControllor.getIns().getRandom() * 300)) * 1.3);
         pif.setmpQuality((100 + Math.round(RandomControllor.getIns().getRandom() * 100)) * 1.3);
         pif.setatkQuality((1000 + Math.round(RandomControllor.getIns().getRandom() * 400)) * 1.3);
         pif.setdefQuality((100 + Math.round(RandomControllor.getIns().getRandom() * 300)) * 1.3);
         pif.setHp(1200);
         pif.setMp(200);
         pif.setAtk(60);
         pif.setDef(8);
         pif.setSHp(pif.getHp());
         pif.setSMp(pif.getMp());
         return pif;
      }
      
      private function get30DaysPresent() : void
      {
         var gcxdyy:* = null;
         if(gc.player1.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("ptttzssz");
            gcxdyy.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(gcxdyy);
            gc.player1.zblist.push(gc.allEquip.findByName("_ptjsxstx"));
         }
         if(gc.player2.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("ptttzssz");
            gcxdyy.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(gcxdyy);
            gc.player2.zblist.push(gc.allEquip.findByName("_ptjsxstx"));
         }
         gc.ts.setTxt("成功领取 天庭战神时装x1、救世星宿头衔x1");
         gc.stage.addChild(gc.ts);
      }
      
      private function get50DaysPresent() : void
      {
         var equip:* = null;
         if(gc.player1.roleid > 0)
         {
            equip = gc.allEquip.findByName("ptzqsz");
            equip.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(equip);
            gc.player1.zblist.push(gc.allEquip.findByName("_jsyxpt"));
         }
         if(gc.player2.roleid > 0)
         {
            equip = gc.allEquip.findByName("ptzqsz");
            equip.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(equip);
            gc.player2.zblist.push(gc.allEquip.findByName("_jsyxpt"));
         }
         gc.ts.setTxt("成功领取 中秋时装×1、救世英雄头衔×1");
         gc.stage.addChild(gc.ts);
      }
      
      private function judgePetBackPack() : Boolean
      {
         var str:* = null;
         str = null;
         var exictmask:* = null;
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
            exictmask = gc.stage.getChildByName("execuitionActionrenewalse") as Sprite;
            if(exictmask)
            {
               gc.stage.removeChild(exictmask);
               exictmask = null;
            }
            gc.ts.setTxt(str);
            gc.stage.addChild(gc.ts);
         }
         return bool;
      }
      
      private function judgePet() : Boolean
      {
         var str:* = null;
         str = null;
         var bool:Boolean = false;
         if(gc.player1.roleid > 0)
         {
            str = "1P";
            if(gc.gameVip.getVipLevel() >= 3)
            {
               if(gc.player1.petsAry.length >= 10)
               {
                  str += "宠物栏已满";
               }
            }
            else if(gc.player1.petsAry.length >= 5)
            {
               str += "宠物栏已满";
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
               if(gc.gameVip.getVipLevel() >= 3)
               {
                  if(gc.player2.petsAry.length >= 10)
                  {
                     str += "宠物栏已满";
                  }
               }
               else if(gc.player2.petsAry.length >= 5)
               {
                  str += "宠物栏已满";
               }
               if(str != "2P")
               {
                  bool = true;
               }
            }
         }
         if(bool)
         {
            str += ",请确保宠物栏有空位再来领取";
            gc.ts.setTxt(str);
            gc.stage.addChild(gc.ts);
         }
         return bool;
      }
      
      private function judgeSz() : Boolean
      {
         var str:* = null;
         str = null;
         var bool:Boolean = false;
         if(gc.player1.roleid > 0)
         {
            str = "1P";
            if(gc.player1.szlist.length >= gc.player1.getMax())
            {
               str += "时装栏已满";
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
               if(gc.player2.szlist.length >= gc.player2.getMax())
               {
                  str += "时装栏已满";
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
      
      private function judgeZb() : Boolean
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
      
      private function pageClick(e:MouseEvent) : void
      {
         if(e.currentTarget.name == "prebtn")
         {
            this.daymc.gotoAndStop(1);
            this.daytxt.text = "2016年7月";
            this.curPage = 1;
         }
         else if(e.currentTarget.name == "nextbtn")
         {
            this.daymc.gotoAndStop(2);
            this.daytxt.text = "2016年8月";
            this.curPage = 2;
         }
         this.reSetInterface();
      }
      
      private function randomPresent() : void
      {
         var equip:* = null;
         var mary:Array = ["wpqhs1","mfs1","gjs1","fys1","lhys","sms1","doubleexp"];
         var rd:int = Math.round(RandomControllor.getIns().getRandom() * 6);
         if(mary[rd] == "doubleexp")
         {
            gc.savedBuff.addBuff(SingleSavedBuff.BUFF_EXP_ADD,2,gc.frameClips * 3600);
            gc.ts.setTxt("成功签到，领取1小时双倍经验buff");
            gc.stage.addChild(gc.ts);
         }
         else
         {
            equip = gc.allEquip.findByName(mary[rd]);
            if(equip)
            {
               gc.putQhsInBackPack(gc.player1,mary[rd],1);
               gc.ts.setTxt("成功签到，领取1个" + equip.ename);
               gc.stage.addChild(gc.ts);
            }
         }
      }
      
      public function addRenewalseMask(inst:String) : void
      {
         renewalse["txt"].text = inst;
         this.addChild(renewalse);
         renewalse["okbtn"].addEventListener("click",renewalseOk);
         renewalse["nobtn"].addEventListener("click",renewalseChange);
      }
      
      private function renewalseOk(e:MouseEvent) : void
      {
         renewalse["okbtn"].removeEventListener("click",renewalseOk);
         renewalse["nobtn"].removeEventListener("click",renewalseChange);
         var enough:Boolean = true;
         if(gc.gameVip.dataObject.lastMoney < 100)
         {
            gc.ts.setTxt("账户余额不足");
            gc.stage.addChild(gc.ts);
            enough = false;
         }
         gc.pay.money = 100;
         if(enough)
         {
            if(GMain.serviceHold)
            {
               PayManager.getInstance().pay(22,"道具22",gc.pay.money,1);
               gc.lastPaymentString = "RegistrationActivity";
               gc.addActionMask("renewalse");
            }
         }
         if(renewalse && this.contains(renewalse))
         {
            this.removeChild(renewalse);
         }
      }
      
      private function renewalseChange(e:MouseEvent) : void
      {
         renewalse["okbtn"].removeEventListener("click",renewalseOk);
         renewalse["nobtn"].removeEventListener("click",renewalseChange);
         if(renewalse && this.contains(renewalse))
         {
            this.removeChild(renewalse);
         }
      }
      
      private function paymentSuccess(e:CommonEvent) : void
      {
         if(gc.lastPaymentString != "RegistrationActivity")
         {
            return;
         }
         var exictmask:Sprite = gc.stage.getChildByName("execuitionActionrenewalse") as Sprite;
         if(exictmask)
         {
            gc.stage.removeChild(exictmask);
            exictmask = null;
         }
         gc.gameVip.dataObject.lastMoney = e.data[0];
         gc.lastPaymentString = "";
         ContinuitySignIn.getIns().signInOld();
         this.reSetInterface();
         if(gc.isHideDebug)
         {
            gc.memory.setStorage(gc.luanqibazaojiami.saveId);
         }
      }
      
      private function paymentFail(e:CommonEvent) : void
      {
         var exictmask:Sprite = gc.stage.getChildByName("execuitionActionrenewalse") as Sprite;
         if(exictmask)
         {
            gc.stage.removeChild(exictmask);
            exictmask = null;
         }
      }
      
      private function xClick(e:MouseEvent) : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
