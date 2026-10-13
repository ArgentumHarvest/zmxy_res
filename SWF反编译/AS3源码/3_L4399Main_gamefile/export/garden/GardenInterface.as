package export.garden
{
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import config.Config;
   import event.CommonEvent;
   import export.garden.petwarehouse.PetWareHouseInterface;
   import export.renewalse.RenewalseThisSZ;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import manager.PayManager;
   import my.ContinuitySignIn;
   import my.FinancialInfo;
   import my.MainGame;
   
   public class GardenInterface extends Sprite
   {
       
      
      public var land1:MovieClip;
      
      public var land2:MovieClip;
      
      public var land3:MovieClip;
      
      public var land4:MovieClip;
      
      public var land5:MovieClip;
      
      public var land6:MovieClip;
      
      public var land7:MovieClip;
      
      public var land8:MovieClip;
      
      public var land9:MovieClip;
      
      public var btn_close:SimpleButton;
      
      public var expmc:MovieClip;
      
      public var exptxt:TextField;
      
      public var titletxt:TextField;
      
      public var albtn:SimpleButton;
      
      public var acbtn:SimpleButton;
      
      public var ppbtn:SimpleButton;
      
      public var rlbtn:SimpleButton;
      
      public var sdbtn:SimpleButton;
      
      public var miaomc:MovieClip;
      
      public var tdm:Sprite;
      
      private var gc:Config;
      
      private var renewalse:RenewalseThisSZ;
      
      private var _anti:Antiwear;
      
      public function GardenInterface()
      {
         _anti = new Antiwear(new binaryEncrypt());
         super();
         gc = Config.getInstance();
         this._anti.needtopay = 100;
         this._anti.zero = 0;
         this._anti.one_hundred = 100;
         this._anti.three_hundred = 300;
         this._anti.six_hundred = 600;
         this._anti.one_one_thousand = 1100;
         this._anti.one_eight_thousand = 1800;
         this._anti.two_seven_thousand = 2700;
         this._anti.three_night_thousand = 3900;
         this._anti.five_four_thousand = 5400;
         this._anti.ten_thousand = 10000;
         this._anti.very_big = 10000000;
         this._anti.sixty = 60;
         this._anti.one_two_hundred = 120;
         this._anti.one_eight_hundred = 180;
         this._anti.two_four_hundred = 240;
         this._anti.renewalseType = -1;
         renewalse = new RenewalseThisSZ();
         renewalse.name = "renewalseThisSZ";
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         var i:* = 0;
         if(!gc.hasGetMoney)
         {
            if(GMain.serviceHold)
            {
               GMain.serviceHold.getBalance();
            }
         }
         for(i = uint(1); i <= 9; )
         {
            this["land" + i].buttonMode = true;
            i++;
         }
         this.initLand();
         this.setTxt();
         btn_close.addEventListener("click",xClick);
         gc.eventManger.addEventListener("REFRESHLANDSHOW",landShow);
         albtn.addEventListener("click",addLandClick);
         acbtn.addEventListener("click",achieveBlessClick);
         ppbtn.addEventListener("click",petPutClick);
         rlbtn.addEventListener("click",refreshLandClick);
         sdbtn.addEventListener("click",sdClick);
         gc.eventManger.addEventListener("BuySuccess",paymentSuccess);
         gc.eventManger.addEventListener("BuyFail",paymentFail);
         miaomc.addEventListener("rollOver",over);
         miaomc.addEventListener("rollOut",out);
         miaomc.buttonMode = true;
         tdm.visible = false;
         this.initLandGodShow();
         if(MainGame.getInstance())
         {
            MainGame.getInstance().destroyGame();
         }
      }
      
      private function removed(e:Event) : void
      {
         var i:* = 0;
         for(i = uint(1); i <= 9; )
         {
            this["land" + i].removeEventListener("click",landClick);
            i++;
         }
         btn_close.removeEventListener("click",xClick);
         gc.eventManger.removeEventListener("REFRESHLANDSHOW",landShow);
         albtn.removeEventListener("click",addLandClick);
         acbtn.removeEventListener("click",achieveBlessClick);
         ppbtn.removeEventListener("click",petPutClick);
         rlbtn.removeEventListener("click",refreshLandClick);
         sdbtn.removeEventListener("click",sdClick);
         gc.eventManger.removeEventListener("BuySuccess",paymentSuccess);
         gc.eventManger.removeEventListener("BuyFail",paymentFail);
         tdm.removeEventListener("rollOver",over);
         tdm.removeEventListener("rollOut",out);
         this._anti.renewalseType = -1;
      }
      
      private function initLandGodShow() : void
      {
         ppbtn.visible = false;
         rlbtn.visible = false;
         sdbtn.visible = false;
         if(gc.achieveLandGodLevel() >= 2)
         {
            rlbtn.visible = true;
         }
         if(gc.achieveLandGodLevel() >= 3)
         {
            ppbtn.visible = true;
         }
         if(gc.achieveLandGodLevel() >= 4)
         {
            sdbtn.visible = true;
         }
         this.setTxt();
      }
      
      private function setTxt() : void
      {
         var addString:String = gc.achieveLandLevel() >= 9 ? "(max)" : "";
         this.titletxt.text = "药园Lv." + gc.achieveLandLevel() + "" + addString;
         exptxt.text = gc.dataObject.gardenExp + "/" + this.getNextLevelExp(gc.achieveLandLevel()) + "(" + (int(gc.dataObject.gardenExp / this.getNextLevelExp(gc.achieveLandLevel()) * 100) + "%") + ")";
         expmc.gotoAndStop(int(gc.dataObject.gardenExp / this.getNextLevelExp(gc.achieveLandLevel()) * 100));
         miaomc.gotoAndStop(gc.achieveLandGodLevel());
      }
      
      private function over(e:MouseEvent) : void
      {
         tdm.visible = true;
         tdm["godexpmc"].gotoAndStop(int(gc.dataObject.landgodExp / this.getNextLandGodLevelExp(gc.achieveLandGodLevel()) * 100));
         tdm["godexptxt"].text = gc.dataObject.landgodExp + "/" + this.getNextLandGodLevelExp(gc.achieveLandGodLevel()) + "(" + (int(gc.dataObject.landgodExp / this.getNextLandGodLevelExp(gc.achieveLandGodLevel()) * 100) + "%") + ")";
         var addString:String = gc.achieveLandGodLevel() >= 4 ? "(max)" : "";
         tdm["titletxt"].text = "土地庙 Lv." + gc.achieveLandGodLevel() + "" + addString;
      }
      
      private function out(e:MouseEvent) : void
      {
         tdm.visible = false;
      }
      
      private function sdClick(e:MouseEvent) : void
      {
         var pfab:PetForgetAndBecomeChild = new PetForgetAndBecomeChild();
         this.addChild(pfab);
      }
      
      private function addLandClick(e:MouseEvent) : void
      {
         if(gc.achieveLandLevel() >= 9)
         {
            gc.ts.setTxt("无法再扩建土地");
            gc.stage.addChild(gc.ts);
            return;
         }
         this._anti.renewalseType = 0;
         this._anti.needtopay = 2 * (this.getNextLevelExp(gc.achieveLandLevel()) - this.getNextLevelExp(gc.achieveLandLevel() - 1));
         this.addRenewalseMask("您确定要花费" + this._anti.needtopay + "点券开启下一块土地");
      }
      
      private function achieveBlessClick(e:MouseEvent) : void
      {
         var lbi:* = null;
         if(this.getChildByName("LadnBlessInterface") != null)
         {
            this.removeChild(this.getChildByName("LadnBlessInterface"));
         }
         if(gc.dataObject.landgodbless == "false" || gc.dataObject.landgodbless == false)
         {
            lbi = new LadnBlessInterface();
            lbi.name = "LadnBlessInterface";
            this.addChild(lbi);
         }
         else
         {
            gc.ts.setTxt("您今天已经领取过土地公的祝福");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function petPutClick(e:MouseEvent) : void
      {
         if(this.getChildByName("PetWareHouseInterface") != null)
         {
            this.removeChild(this.getChildByName("PetWareHouseInterface"));
         }
         var pwhi:PetWareHouseInterface = new PetWareHouseInterface();
         pwhi.name = "PetWareHouseInterface";
         this.addChild(pwhi);
      }
      
      private function refreshLandClick(e:MouseEvent) : void
      {
         var num:uint = 0;
         for(var glen:uint = gc.gardenList.length; glen-- > 0; )
         {
            if(gc.gardenList[glen].type == 4)
            {
               num += 1;
            }
         }
         if(num != 0)
         {
            this._anti.renewalseType = 1;
            this._anti.needtopay = 400 * num;
            this.addRenewalseMask("您确定要花费" + this._anti.needtopay + "点券翻新土地");
         }
         else
         {
            gc.ts.setTxt("目前没有可翻新的土地");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function getNextLevelExp(curlevel:uint) : uint
      {
         if(curlevel == 0)
         {
            return this._anti.zero;
         }
         if(curlevel == 1)
         {
            return this._anti.one_hundred;
         }
         if(curlevel == 2)
         {
            return this._anti.three_hundred;
         }
         if(curlevel == 3)
         {
            return this._anti.six_hundred;
         }
         if(curlevel == 4)
         {
            return this._anti.one_one_thousand;
         }
         if(curlevel == 5)
         {
            return this._anti.one_eight_thousand;
         }
         if(curlevel == 6)
         {
            return this._anti.two_seven_thousand;
         }
         if(curlevel == 7)
         {
            return this._anti.three_night_thousand;
         }
         if(curlevel == 8)
         {
            return this._anti.five_four_thousand;
         }
         if(curlevel == 9)
         {
            return this._anti.ten_thousand;
         }
         return this._anti.very_big;
      }
      
      private function getNextLandGodLevelExp(cl:uint) : uint
      {
         if(cl == 0)
         {
            return 0;
         }
         if(cl == 1)
         {
            return this._anti.sixty;
         }
         if(cl == 2)
         {
            return this._anti.one_two_hundred;
         }
         if(cl == 3)
         {
            return this._anti.one_eight_hundred;
         }
         if(cl == 4)
         {
            return this._anti.two_four_hundred;
         }
         return this._anti.very_big;
      }
      
      private function initLand() : void
      {
         var i:* = 0;
         for(i = uint(1); i <= 9; )
         {
            this["land" + i].gotoAndStop(1);
            this["land" + i].removeEventListener("click",landClick);
            i++;
         }
         for(var glen:uint = gc.gardenList.length; glen-- > 0; )
         {
            if(this["land" + (glen + 1)])
            {
               this["land" + (glen + 1)].gotoAndStop(gc.gardenList[glen].type + 1);
               this["land" + (glen + 1)].addEventListener("click",landClick);
            }
         }
      }
      
      private function landShow(e:CommonEvent) : void
      {
         this.initLand();
         this.initLandGodShow();
      }
      
      private function landClick(e:MouseEvent) : void
      {
         var gst:* = null;
         var sep:* = null;
         var lid:uint = int(String(e.currentTarget.name).substr(4,1));
         var obj:Object = gc.findObjectByLandId(lid);
         if(obj)
         {
            if(obj.type == gc.dataObject.one)
            {
               gst = new GardenSelectType(lid);
               this.addChild(gst);
            }
            else if(obj.type == gc.dataObject.two || obj.type == gc.dataObject.five)
            {
               sep = new SelectEatPet(lid);
               this.addChild(sep);
            }
            else if(obj.type == gc.dataObject.three)
            {
               if(obj.plantingLevel == 4 || obj.plantingLevel == 5)
               {
                  if(ContinuitySignIn.getIns().getLeftSignOldDays() > 0)
                  {
                     ContinuitySignIn.getIns().signInOld();
                     obj.type = gc.dataObject.four;
                     obj.plantingLevel = gc.dataObject.one;
                     gc.ts.setTxt("补签成功");
                     gc.stage.addChild(gc.ts);
                     this.landShow(null);
                     if(gc.isHideDebug)
                     {
                        gc.memory.setStorage(gc.luanqibazaojiami.saveId);
                     }
                  }
                  else
                  {
                     if(gc.player1)
                     {
                        gc.player1.setLhValue(gc.player1.getLhValue() + 5000);
                     }
                     gc.ts.setTxt("获得5000灵魂");
                     obj.type = gc.dataObject.four;
                     obj.plantingLevel = gc.dataObject.one;
                     gc.stage.addChild(gc.ts);
                     this.landShow(null);
                     if(gc.isHideDebug)
                     {
                        gc.memory.setStorage(gc.luanqibazaojiami.saveId);
                     }
                  }
               }
               else
               {
                  if(gc.player1.roleid > 0)
                  {
                     gc.putQhsInBackPack(gc.player1,"wpmgh",obj.plantingLevel * 2);
                  }
                  gc.ts.setTxt("收获 玫瑰花x" + obj.plantingLevel * 2);
                  gc.stage.addChild(gc.ts);
                  obj.type = gc.dataObject.four;
                  obj.plantingLevel = gc.dataObject.one;
                  this.landShow(null);
                  if(gc.isHideDebug)
                  {
                     gc.memory.setStorage(gc.luanqibazaojiami.saveId);
                  }
               }
            }
            else if(obj.type == gc.dataObject.four)
            {
               gc.ts.setTxt("这块地今天已经种植过");
               gc.stage.addChild(gc.ts);
            }
         }
         else
         {
            gc.ts.setTxt("这块地有问题，请联系客服!");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function judgeBackPackDj(fname:String) : Boolean
      {
         var bool:Boolean = false;
         var str:String = "背包";
         if(gc.player1.getSomeOneEquipNumberByName(fname) <= 0 && gc.player1.djlist.length >= gc.player1.getMax())
         {
            str += "道具栏已满 ";
            bool = true;
         }
         if(bool)
         {
            gc.ts.setTxt(str);
            gc.stage.addChild(gc.ts);
         }
         return bool;
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
               PayManager.getInstance().pay(13,"道具13",gc.pay.money,1);
               gc.lastPaymentString = "GardenInterface";
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
         this._anti.renewalseType = -1;
      }
      
      private function paymentSuccess(e:CommonEvent) : void
      {
         var glen:* = 0;
         if(gc.lastPaymentString != "GardenInterface")
         {
            return;
         }
         var exictmask:Sprite = gc.stage.getChildByName("execuitionActionrenewalse") as Sprite;
         if(exictmask)
         {
            gc.stage.removeChild(exictmask);
            exictmask = null;
         }
         if(this._anti.renewalseType == -1)
         {
            return;
         }
         gc.lastPaymentString = "";
         gc.gameVip.dataObject.lastMoney = e.data[0];
         if(this._anti.renewalseType == 0)
         {
            trace("int(this._anti.needtopay/2) -->>" + int(this._anti.needtopay / 2));
            if(gc.achieveLandLevel() == 1)
            {
               FinancialInfo.sendInfoToFinancialServer(gc.logInfo.uid,[[{
                  "id":10440,
                  "ename":"custom"
               },1,1],[{
                  "id":10440,
                  "ename":"custom"
               },0,1]],gc.getTimeStamp(),gc.gameVip.dataObject.lastMoney);
            }
            else if(gc.achieveLandLevel() == 2)
            {
               FinancialInfo.sendInfoToFinancialServer(gc.logInfo.uid,[[{
                  "id":10450,
                  "ename":"custom"
               },1,1],[{
                  "id":10450,
                  "ename":"custom"
               },0,1]],gc.getTimeStamp(),gc.gameVip.dataObject.lastMoney);
            }
            else if(gc.achieveLandLevel() == 3)
            {
               FinancialInfo.sendInfoToFinancialServer(gc.logInfo.uid,[[{
                  "id":10460,
                  "ename":"custom"
               },1,1],[{
                  "id":10460,
                  "ename":"custom"
               },0,1]],gc.getTimeStamp(),gc.gameVip.dataObject.lastMoney);
            }
            else if(gc.achieveLandLevel() == 4)
            {
               FinancialInfo.sendInfoToFinancialServer(gc.logInfo.uid,[[{
                  "id":10470,
                  "ename":"custom"
               },1,1],[{
                  "id":10470,
                  "ename":"custom"
               },0,1]],gc.getTimeStamp(),gc.gameVip.dataObject.lastMoney);
            }
            else if(gc.achieveLandLevel() == 5)
            {
               FinancialInfo.sendInfoToFinancialServer(gc.logInfo.uid,[[{
                  "id":10480,
                  "ename":"custom"
               },1,1],[{
                  "id":10480,
                  "ename":"custom"
               },0,1]],gc.getTimeStamp(),gc.gameVip.dataObject.lastMoney);
            }
            else if(gc.achieveLandLevel() == 6)
            {
               FinancialInfo.sendInfoToFinancialServer(gc.logInfo.uid,[[{
                  "id":10490,
                  "ename":"custom"
               },1,1],[{
                  "id":10490,
                  "ename":"custom"
               },0,1]],gc.getTimeStamp(),gc.gameVip.dataObject.lastMoney);
            }
            else if(gc.achieveLandLevel() == 7)
            {
               FinancialInfo.sendInfoToFinancialServer(gc.logInfo.uid,[[{
                  "id":10500,
                  "ename":"custom"
               },1,1],[{
                  "id":10500,
                  "ename":"custom"
               },0,1]],gc.getTimeStamp(),gc.gameVip.dataObject.lastMoney);
            }
            else if(gc.achieveLandLevel() == 8)
            {
               FinancialInfo.sendInfoToFinancialServer(gc.logInfo.uid,[[{
                  "id":10510,
                  "ename":"custom"
               },1,1],[{
                  "id":10510,
                  "ename":"custom"
               },0,1]],gc.getTimeStamp(),gc.gameVip.dataObject.lastMoney);
            }
            this.updataGarden();
            this.setTxt();
         }
         else if(this._anti.renewalseType == 1)
         {
            for(glen = uint(gc.gardenList.length); glen-- > 0; )
            {
               if(gc.gardenList[glen].type == 4)
               {
                  gc.gardenList[glen].type = 1;
               }
            }
            FinancialInfo.sendInfoToFinancialServer(gc.logInfo.uid,[[{
               "id":10570,
               "ename":"custom"
            },1,1],[{
               "id":10570,
               "ename":"custom"
            },0,1]],gc.getTimeStamp(),gc.gameVip.dataObject.lastMoney);
         }
         this.initLand();
         this._anti.renewalseType = -1;
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
         this._anti.renewalseType = -1;
      }
      
      private function updataGarden() : void
      {
         var after:* = 0;
         var obj:* = null;
         var befour:uint = gc.achieveLandLevel();
         if(befour < 9)
         {
            gc.dataObject.gardenExp += int(this._anti.needtopay / 2);
            after = uint(gc.achieveLandLevel());
            while(after > befour)
            {
               obj = {};
               obj.gid = after;
               obj.date = gc.dataObjectInstance.curDate;
               obj.type = gc.dataObject.one;
               obj.plantingLevel = gc.dataObject.zero;
               gc.gardenList.push(obj);
               after--;
            }
         }
      }
      
      private function xClick(e:MouseEvent) : void
      {
         gc.eventManger.dispatchEvent(new CommonEvent("SelectOver"));
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
