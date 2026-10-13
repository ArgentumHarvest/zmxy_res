package export.constellations
{
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import config.Config;
   import event.CommonEvent;
   import export.animalarray.FourMarixInterface;
   import export.renewalse.RenewalseThisSZ;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import my.FinancialInfo;
   import my.SingleSavedBuff;
   
   public class TwelveConstellations extends Sprite
   {
      
      public static const CONSTELLATIONS_NUMBER:uint = 14;
       
      
      public var xbtn:SimpleButton;
      
      public var btn_1:SimpleButton;
      
      public var btn_2:SimpleButton;
      
      public var btn_3:SimpleButton;
      
      public var btn_4:SimpleButton;
      
      public var btn_5:SimpleButton;
      
      public var btn_6:SimpleButton;
      
      public var btn_7:SimpleButton;
      
      public var btn_8:SimpleButton;
      
      public var btn_9:SimpleButton;
      
      public var btn_10:SimpleButton;
      
      public var btn_11:SimpleButton;
      
      public var btn_12:SimpleButton;
      
      public var btn_13:SimpleButton;
      
      public var btn_14:SimpleButton;
      
      public var edbtn:SimpleButton;
      
      public var zfbtn:SimpleButton;
      
      public var txt_1:TextField;
      
      public var txt_2:TextField;
      
      public var txt_3:TextField;
      
      public var txt_4:TextField;
      
      public var txt_5:TextField;
      
      public var txt_6:TextField;
      
      public var txt_7:TextField;
      
      public var cstxt:TextField;
      
      public var westbtn:SimpleButton;
      
      public var eastbtn:SimpleButton;
      
      public var southbtn:SimpleButton;
      
      public var northbtn:SimpleButton;
      
      private var gc:Config;
      
      private var lastShowConstellations:String = "south";
      
      private var curLevel:uint;
      
      private var renewalse:RenewalseThisSZ;
      
      private var _anti:Antiwear;
      
      public function TwelveConstellations()
      {
         this._anti = new Antiwear(new binaryEncrypt());
         super();
         gc = Config.getInstance();
         renewalse = new RenewalseThisSZ();
         renewalse.name = "renewalseThisSZ";
         this._anti.needtopay = 100;
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         if(!gc.hasGetMoney)
         {
            if(GMain.serviceHold)
            {
               GMain.serviceHold.getBalance();
            }
         }
         westbtn.visible = false;
         eastbtn.visible = false;
         southbtn.addEventListener("click",direClick);
         northbtn.addEventListener("click",direClick);
         edbtn.addEventListener("click",everyDayClick);
         xbtn.addEventListener("click",xClick);
         zfbtn.addEventListener("click",zfClick);
         gc.eventManger.addEventListener("BuySuccess",paymentSuccess);
         gc.eventManger.addEventListener("BuyFail",paymentFail);
         this.addButtonListener();
         this.setTxt();
         this.setDiecBtnVisible();
      }
      
      private function removed(e:Event) : void
      {
         var i:* = 0;
         southbtn.removeEventListener("click",direClick);
         northbtn.removeEventListener("click",direClick);
         edbtn.removeEventListener("click",everyDayClick);
         xbtn.removeEventListener("click",xClick);
         zfbtn.removeEventListener("click",zfClick);
         gc.eventManger.removeEventListener("BuySuccess",paymentSuccess);
         gc.eventManger.removeEventListener("BuyFail",paymentFail);
         i = 1;
         while(i <= 14)
         {
            if(this["btn_" + i] != undefined)
            {
               this["btn_" + i].removeEventListener("click",buttonClick);
            }
            i++;
         }
         renewalse = null;
      }
      
      private function addButtonListener() : void
      {
         var i:* = 0;
         var s:* = 0;
         var n:* = 0;
         i = 1;
         while(i <= 14)
         {
            if(this["btn_" + i] != undefined)
            {
               this["btn_" + i].removeEventListener("click",buttonClick);
               this["btn_" + i].visible = false;
            }
            i++;
         }
         if(this.lastShowConstellations == "south")
         {
            s = 1;
            while(s <= 7)
            {
               if(this["btn_" + s] != undefined)
               {
                  this["btn_" + s].visible = true;
                  this["btn_" + s].addEventListener("click",buttonClick);
               }
               s++;
            }
         }
         else if(this.lastShowConstellations == "north")
         {
            n = 8;
            while(n <= 14)
            {
               if(this["btn_" + n] != undefined)
               {
                  this["btn_" + n].visible = true;
                  this["btn_" + n].addEventListener("click",buttonClick);
               }
               n++;
            }
         }
      }
      
      private function direClick(e:MouseEvent) : void
      {
         if(e.target.name == "southbtn")
         {
            this.lastShowConstellations = "south";
         }
         else if(e.target.name == "northbtn")
         {
            this.lastShowConstellations = "north";
         }
         this.addButtonListener();
         this.setDiecBtnVisible();
         this.setTxt();
      }
      
      private function setDiecBtnVisible() : void
      {
         southbtn.visible = true;
         northbtn.visible = true;
         zfbtn.visible = true;
         if(this.lastShowConstellations == "south")
         {
            southbtn.visible = false;
            edbtn.visible = true;
            zfbtn.visible = true;
         }
         else if(this.lastShowConstellations == "north")
         {
            northbtn.visible = false;
            edbtn.visible = true;
            zfbtn.visible = true;
         }
      }
      
      private function buttonClick(e:MouseEvent) : void
      {
         var ary:Array = String(e.target.name).split("_") as Array;
         this.curLevel = int(ary[1]);
         if(gc.dataObject.constellationTimes > 0)
         {
            gc.dataObject.constellationTimes--;
            this.goInto();
         }
         else
         {
            this.addRenewalseMask("您的免费次数已用完，您确定要花费" + this._anti.needtopay + "点券挑战此Boss?");
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
         gc.lastPaymentString = "TwelveConstellations";
         gc.eventManger.dispatchEvent(new CommonEvent("BuySuccess",[100000]));
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
         if(gc.lastPaymentString != "TwelveConstellations")
         {
            return;
         }
         var exictmask:Sprite = gc.stage.getChildByName("execuitionActionrenewalse") as Sprite;
         if(exictmask)
         {
            gc.stage.removeChild(exictmask);
            exictmask = null;
         }
         FinancialInfo.sendInfoToFinancialServer(gc.logInfo.uid,[[{
            "id":10720,
            "ename":"custom"
         },1,1],[{
            "id":10720,
            "ename":"custom"
         },0,1]],gc.getTimeStamp(),gc.gameVip.dataObject.lastMoney);
         gc.lastPaymentString = "";
         gc.gameVip.dataObject.lastMoney = e.data[0];
         this.goInto();
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
      
      private function goInto() : void
      {
         gc.curStageAndCurLevel.curStage = 47;
         gc.curStageAndCurLevel.curLevel = this.curLevel;
         gc.eventManger.dispatchEvent(new CommonEvent("selectStageOver"));
         if(gc.isHideDebug)
         {
            gc.memory.setStorage(gc.luanqibazaojiami.saveId);
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function everyDayClick(e:MouseEvent) : void
      {
         var hpAdd:int = 0;
         var defAdd:int = 0;
         if(!gc.isGetEveryDayPresent)
         {
            hpAdd = gc.getAllAnalyzeConstellationsLevelSum() * 100;
            defAdd = gc.getAllAnalyzeConstellationsLevelSum() * 5;
            if(hpAdd == 0)
            {
               gc.ts.setTxt("请先挑战二十八星宿");
               gc.stage.addChild(gc.ts);
            }
            gc.ts.setTxt("领取一小时生命加成：" + hpAdd + " 防御加成：" + defAdd);
            gc.stage.addChild(gc.ts);
            gc.savedBuff.addBuff(SingleSavedBuff.BUFF_HP_ADD_28_BUFF,hpAdd,86400);
            gc.savedBuff.addBuff(SingleSavedBuff.BUFF_DEF_ADD_28_BUFF,defAdd,86400);
            gc.isGetEveryDayPresent = true;
         }
         else
         {
            gc.ts.setTxt("您今天已经领取过了");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function zfClick(e:MouseEvent) : void
      {
         var fmi:FourMarixInterface = new FourMarixInterface(this.lastShowConstellations);
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(fmi);
               this.parent.removeChild(this);
            }
         }
      }
      
      private function setTxt() : void
      {
         var i:* = 0;
         var ary:Array = null;
         this.cstxt.text = gc.dataObject.constellationTimes + "";
         var showAdd:uint = 0;
         i = 1;
         while(i <= 7)
         {
            this["txt_" + i].text = "";
            ary = (this["txt_" + i].name as String).split("_") as Array;
            if(this.lastShowConstellations == "south")
            {
               showAdd = 0;
            }
            else if(this.lastShowConstellations == "north")
            {
               showAdd = 7;
            }
            showAdd += int(ary[1]);
            if(gc.getAnalyzeConstellationsLevel(showAdd) >= 1)
            {
               this["txt_" + i].text = "最高击败" + this.changeChinaNnmber(gc.getAnalyzeConstellationsLevel(showAdd)) + "阶";
            }
            i++;
         }
      }
      
      private function changeChinaNnmber(num:uint) : String
      {
         var ary:Array = ["一","二","三","四","五","六","七","八","九","十"];
         if(num > 10)
         {
            num = 10;
         }
         return ary[num - 1];
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
