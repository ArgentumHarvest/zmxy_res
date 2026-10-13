package export.garden
{
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
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
   import my.FinancialInfo;
   import user.User;
   
   public class SelectPlantInterface extends Sprite
   {
       
      
      public var btn_close:SimpleButton;
      
      public var plantbtn:SimpleButton;
      
      public var lhupbtn:SimpleButton;
      
      public var dqupbtn:SimpleButton;
      
      public var aexptxt:TextField;
      
      public var ctimetxt:TextField;
      
      public var lhtxt:TextField;
      
      public var dqtxt:TextField;
      
      public var p1:MovieClip;
      
      public var p2:MovieClip;
      
      public var p3:MovieClip;
      
      public var p4:MovieClip;
      
      public var p5:MovieClip;
      
      private var gc:Config;
      
      private var _anti:Antiwear;
      
      private var renewalse:RenewalseThisSZ;
      
      public function SelectPlantInterface(_whichplant:uint, _landId:uint)
      {
         _anti = new Antiwear(new binaryEncrypt());
         super();
         gc = Config.getInstance();
         renewalse = new RenewalseThisSZ();
         renewalse.name = "renewalseThisSZ";
         this._anti.landId = _landId;
         this._anti.whichplant = _whichplant;
         this._anti.five_hundred = 500;
         this._anti.five_three_four = 534;
         this._anti.zero_point_three = 0.4;
         this._anti.zero_point_onefive = 0.2;
         this._anti.zero_point_zeroseven = 0.1;
         this._anti.selectId = 1;
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
         btn_close.addEventListener("click",xClick);
         plantbtn.addEventListener("click",plantClick);
         lhupbtn.addEventListener("click",lhClick);
         dqupbtn.addEventListener("click",dqClick);
         gc.eventManger.addEventListener("BuySuccess",paymentSuccess);
         gc.eventManger.addEventListener("BuyFail",paymentFail);
         gc.eventManger.addEventListener("GetMoneySuccess",getMoneySuccess);
         this.showPlantLevel();
         this.setTxt();
      }
      
      private function removed(e:Event) : void
      {
         btn_close.removeEventListener("click",xClick);
         plantbtn.removeEventListener("click",plantClick);
         lhupbtn.removeEventListener("click",lhClick);
         dqupbtn.removeEventListener("click",dqClick);
         gc.eventManger.removeEventListener("BuySuccess",paymentSuccess);
         gc.eventManger.removeEventListener("BuyFail",paymentFail);
         gc.eventManger.removeEventListener("GetMoneySuccess",getMoneySuccess);
      }
      
      private function getMoneySuccess(e:CommonEvent) : void
      {
         this.setTxt();
      }
      
      private function showPlantLevel() : void
      {
         var i:* = 0;
         for(i = uint(5); i > 0; )
         {
            this["p" + i].gotoAndStop(this._anti.whichplant);
            i--;
         }
         this["p" + this._anti.selectId].gotoAndStop(this._anti.whichplant + 1);
      }
      
      private function setTxt() : void
      {
         if(this._anti.whichplant == gc.dataObject.one)
         {
            this.aexptxt.text = "收获经验:" + this.getPlantExpByPlantLevel(this._anti.selectId);
         }
         else if(this._anti.whichplant == gc.dataObject.three)
         {
            this.aexptxt.text = "收获潜力:" + this.getPlantPotentialByPlantLevel(this._anti.selectId);
         }
         else if(this._anti.whichplant == gc.dataObject.five)
         {
            this.aexptxt.text = this.getFivePlantInstruduce(this._anti.selectId) + "";
         }
         if(gc.playNum == 1)
         {
            this.lhtxt.text = "1P灵魂:" + gc.player1.getLhValue();
         }
         else
         {
            this.lhtxt.text = "1P灵魂:" + gc.player1.getLhValue() + " 2P灵魂:" + gc.player2.getLhValue();
         }
         this.dqtxt.text = "点券:" + gc.gameVip.dataObject.lastMoney;
         this.ctimetxt.text = "成熟时间:立刻成熟";
      }
      
      private function xClick(e:MouseEvent) : void
      {
         this._anti.renewalseType = 1;
         this.addRenewalseMask("关掉此页面将不保存经验树等级信息，确定关闭吗？");
      }
      
      private function plantClick(e:MouseEvent) : void
      {
         var obj:Object = gc.findObjectByLandId(this._anti.landId);
         if(this._anti.whichplant == gc.dataObject.one)
         {
            obj.type = gc.dataObject.two;
         }
         else if(this._anti.whichplant == gc.dataObject.three)
         {
            obj.type = gc.dataObject.five;
         }
         if(this._anti.whichplant == gc.dataObject.five)
         {
            obj.type = gc.dataObject.three;
         }
         obj.plantingLevel = this._anti.selectId;
         obj.date = gc.dataObjectInstance.curDate;
         if(gc.achieveLandGodLevel() < 4)
         {
            gc.dataObject.landgodExp += this._anti.selectId;
         }
         gc.eventManger.dispatchEvent(new CommonEvent("REFRESHLANDSHOW"));
         if(gc.isHideDebug)
         {
            gc.memory.setStorage(gc.luanqibazaojiami.saveId);
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function lhClick(e:MouseEvent) : void
      {
         trace("---lhClick---");
         if(gc.playNum == 1)
         {
            if(this._anti.selectId < 4)
            {
               if(gc.player1.getLhValue() >= this._anti.five_hundred)
               {
                  this.lhUpMethod(gc.player1);
               }
               else
               {
                  gc.ts.setTxt("灵魂不够");
                  gc.stage.addChild(gc.ts);
               }
            }
            else
            {
               gc.ts.setTxt("该等级无法用灵魂升级");
               gc.stage.addChild(gc.ts);
            }
         }
         else if(this._anti.selectId < 4)
         {
            if(gc.player1.getLhValue() >= this._anti.five_hundred)
            {
               this.lhUpMethod(gc.player1);
            }
            else if(gc.player2.getLhValue() >= this._anti.five_hundred)
            {
               this.lhUpMethod(gc.player2);
            }
            else
            {
               gc.ts.setTxt("需要至少一位玩家灵魂数大于500");
               gc.stage.addChild(gc.ts);
            }
         }
         else
         {
            gc.ts.setTxt("该等级无法用灵魂升级");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function lhUpMethod(_player:User) : void
      {
         if(_player.getLhValue() >= this._anti.five_hundred)
         {
            _player.setLhValue(_player.getLhValue() - this._anti.five_hundred);
            if(this._anti.selectId == gc.dataObject.one)
            {
               if(RandomControllor.getIns().getRandom() <= this._anti.zero_point_three)
               {
                  this._anti.selectId++;
                  gc.ts.setTxt("升级成功");
                  gc.stage.addChild(gc.ts);
               }
               else
               {
                  gc.ts.setTxt("升级失败");
                  gc.stage.addChild(gc.ts);
               }
            }
            else if(this._anti.selectId == gc.dataObject.two)
            {
               if(RandomControllor.getIns().getRandom() <= this._anti.zero_point_onefive)
               {
                  this._anti.selectId++;
                  gc.ts.setTxt("升级成功");
                  gc.stage.addChild(gc.ts);
               }
               else
               {
                  this._anti.selectId--;
                  gc.ts.setTxt("升级失败");
                  gc.stage.addChild(gc.ts);
               }
            }
            else if(this._anti.selectId == gc.dataObject.three)
            {
               if(RandomControllor.getIns().getRandom() <= this._anti.zero_point_zeroseven)
               {
                  this._anti.selectId++;
                  gc.ts.setTxt("升级成功");
                  gc.stage.addChild(gc.ts);
               }
               else
               {
                  this._anti.selectId--;
                  gc.ts.setTxt("升级失败");
                  gc.stage.addChild(gc.ts);
               }
            }
            this.showPlantLevel();
            this.setTxt();
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
         var enough:Boolean = false;
         if(this._anti.renewalseType == 0)
         {
            renewalse["okbtn"].removeEventListener("click",renewalseOk);
            renewalse["nobtn"].removeEventListener("click",renewalseChange);
            enough = true;
            if(gc.gameVip.dataObject.lastMoney < this._anti.needtopay)
            {
               gc.ts.setTxt("账户余额不足");
               gc.stage.addChild(gc.ts);
               enough = false;
            }
            gc.pay.money = this._anti.needtopay;
            if(enough)
            {
               if(GMain.serviceHold)
               {
                  PayManager.getInstance().pay(24,"道具24",gc.pay.money,1);
                  gc.lastPaymentString = "SelectPlantInterface";
                  gc.addActionMask("renewalse");
               }
            }
            if(renewalse && this.contains(renewalse))
            {
               this.removeChild(renewalse);
            }
         }
         else if(this.parent)
         {
            this.parent.removeChild(this);
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
         if(gc.lastPaymentString != "SelectPlantInterface")
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
         if(this._anti.selectId == 1)
         {
            FinancialInfo.sendInfoToFinancialServer(gc.logInfo.uid,[[{
               "id":10530,
               "ename":"custom"
            },1,1],[{
               "id":10530,
               "ename":"custom"
            },0,1]],gc.getTimeStamp(),gc.gameVip.dataObject.lastMoney);
         }
         else if(this._anti.selectId == 2)
         {
            FinancialInfo.sendInfoToFinancialServer(gc.logInfo.uid,[[{
               "id":10540,
               "ename":"custom"
            },1,1],[{
               "id":10540,
               "ename":"custom"
            },0,1]],gc.getTimeStamp(),gc.gameVip.dataObject.lastMoney);
         }
         else if(this._anti.selectId == 3)
         {
            FinancialInfo.sendInfoToFinancialServer(gc.logInfo.uid,[[{
               "id":10550,
               "ename":"custom"
            },1,1],[{
               "id":10550,
               "ename":"custom"
            },0,1]],gc.getTimeStamp(),gc.gameVip.dataObject.lastMoney);
         }
         else if(this._anti.selectId == 4)
         {
            FinancialInfo.sendInfoToFinancialServer(gc.logInfo.uid,[[{
               "id":10560,
               "ename":"custom"
            },1,1],[{
               "id":10560,
               "ename":"custom"
            },0,1]],gc.getTimeStamp(),gc.gameVip.dataObject.lastMoney);
         }
         this._anti.selectId++;
         gc.ts.setTxt("升级成功");
         gc.stage.addChild(gc.ts);
         this.showPlantLevel();
         this.setTxt();
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
      
      private function dqClick(e:MouseEvent) : void
      {
         trace("this._anti.selectId -->>" + this._anti.selectId);
         if(this._anti.selectId == gc.dataObject.one)
         {
            this._anti.needtopay = 20;
            this._anti.renewalseType = 0;
            this.addRenewalseMask("您确定要花费20点券升级种植作物?");
         }
         else if(this._anti.selectId == gc.dataObject.two)
         {
            this._anti.needtopay = 50;
            this._anti.renewalseType = 0;
            this.addRenewalseMask("您确定要花费50点券升级种植作物?");
         }
         else if(this._anti.selectId == gc.dataObject.three)
         {
            this._anti.needtopay = 100;
            this._anti.renewalseType = 0;
            this.addRenewalseMask("您确定要花费100点券升级种植作物?");
         }
         else if(this._anti.selectId == gc.dataObject.four)
         {
            this._anti.needtopay = 200;
            this._anti.renewalseType = 0;
            this.addRenewalseMask("您确定要花费200点券升级种植作物?");
         }
         else
         {
            gc.ts.setTxt("植物已经满级");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function getPlantExpByPlantLevel(plevel:uint) : int
      {
         if(plevel == gc.dataObject.one)
         {
            return this._anti.five_three_four * this.getAverLevel();
         }
         if(plevel == gc.dataObject.two)
         {
            return this._anti.five_three_four * this.getAverLevel() * gc.dataObject.two;
         }
         if(plevel == gc.dataObject.three)
         {
            return this._anti.five_three_four * this.getAverLevel() * gc.dataObject.three;
         }
         if(plevel == gc.dataObject.four)
         {
            return this._anti.five_three_four * this.getAverLevel() * gc.dataObject.five;
         }
         if(plevel == gc.dataObject.five)
         {
            return this._anti.five_three_four * this.getAverLevel() * gc.dataObject.seven;
         }
         return gc.dataObject.zero;
      }
      
      private function getPlantPotentialByPlantLevel(plevel:uint) : int
      {
         if(plevel == gc.dataObject.one)
         {
            return gc.dataObject.one;
         }
         if(plevel == gc.dataObject.two)
         {
            return gc.dataObject.two;
         }
         if(plevel == gc.dataObject.three)
         {
            return gc.dataObject.three;
         }
         if(plevel == gc.dataObject.four)
         {
            return gc.dataObject.five;
         }
         if(plevel == gc.dataObject.five)
         {
            return gc.dataObject.ten;
         }
         return gc.dataObject.zero;
      }
      
      private function getFivePlantInstruduce(plevel:uint) : String
      {
         if(plevel >= 4)
         {
            return "补签+1或5000灵魂";
         }
         return "收获玫瑰花：" + 2 * plevel + "个";
      }
      
      private function getAverLevel() : int
      {
         if(gc.playNum == 1)
         {
            return gc.player1.getCurLevel();
         }
         return (gc.player1.getCurLevel() + gc.player2.getCurLevel()) / 2;
      }
   }
}
