package export.level.StageListener131Children
{
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import com.greensock.TweenMax;
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
   import my.MainGame;
   import my.MyEquipObj;
   
   public class Stage13ResultSprite extends Sprite
   {
       
      
      public var resetBtn_0:SimpleButton;
      
      public var resetBtn_1:SimpleButton;
      
      public var resetBtn_2:SimpleButton;
      
      public var resetBtn_3:SimpleButton;
      
      public var resetBtn_4:SimpleButton;
      
      public var resetBtn_5:SimpleButton;
      
      public var resetBtn_6:SimpleButton;
      
      public var transferBtn_0:SimpleButton;
      
      public var transferBtn_1:SimpleButton;
      
      public var transferBtn_2:SimpleButton;
      
      public var transferBtn_3:SimpleButton;
      
      public var transferBtn_4:SimpleButton;
      
      public var transferBtn_5:SimpleButton;
      
      public var transferBtn_6:SimpleButton;
      
      public var mc_0:MovieClip;
      
      public var mc_1:MovieClip;
      
      public var mc_2:MovieClip;
      
      public var mc_3:MovieClip;
      
      public var mc_4:MovieClip;
      
      public var mc_5:MovieClip;
      
      public var mc_6:MovieClip;
      
      public var tf_0:TextField;
      
      public var tf_1:TextField;
      
      public var tf_2:TextField;
      
      public var tf_3:TextField;
      
      public var tf_4:TextField;
      
      public var tf_5:TextField;
      
      public var tf_6:TextField;
      
      public var tf_p_0:TextField;
      
      public var tf_p_1:TextField;
      
      public var tf_p_2:TextField;
      
      public var tf_p_3:TextField;
      
      public var tf_p_4:TextField;
      
      public var tf_p_5:TextField;
      
      public var tf_p_6:TextField;
      
      public var closeBtn:SimpleButton;
      
      public var equipInfo:TextField;
      
      private var resultArray:Array;
      
      private var prizeResult:MovieClip;
      
      private var prizeType:uint = 0;
      
      private var prizeRoleId:uint = 0;
      
      private var totalWave:uint = 1;
      
      private var renewalse:RenewalseThisSZ;
      
      private var buyType:int = 0;
      
      private var changeLuckType:uint = 0;
      
      private var equip:MyEquipObj;
      
      private var _anti:Antiwear;
      
      private var gc:Config;
      
      public function Stage13ResultSprite(result:Array, type:uint, roleId:uint, totalWave:uint)
      {
         resultArray = [];
         _anti = new Antiwear(new binaryEncrypt());
         super();
         this.prizeType = type;
         this.resultArray = result;
         this.prizeRoleId = roleId;
         this._anti.maxTotalWave = 100;
         if(totalWave > this._anti.maxTotalWave)
         {
            totalWave = this._anti.maxTotalWave;
         }
         this._anti.totalWave = totalWave;
         this._anti.resetPropertyCost = 50;
         this._anti.resetPropertyCost2 = 100;
         gc = Config.getInstance();
         renewalse = new RenewalseThisSZ();
         renewalse.name = "renewalseThisSZ";
         this.addEventListener("addedToStage",__added,false,0,true);
         this.addEventListener("removedFromStage",__removed,false,0,true);
      }
      
      private function __added(evt:Event) : void
      {
         evt = evt;
         if(!gc.hasGetMoney)
         {
            if(GMain.serviceHold)
            {
               GMain.serviceHold.getBalance();
            }
         }
         this.closeBtn.addEventListener("click",__closeClick);
         gc.eventManger.addEventListener("BuySuccess",buySuccess);
         gc.eventManger.addEventListener("BuyFail",paymentFail);
         for(var i:uint = 0; i < this.resultArray.length; )
         {
            SimpleButton(this["resetBtn_" + i]).addEventListener("click",__changeLuckClick);
            SimpleButton(this["transferBtn_" + i]).addEventListener("click",__transferClick);
            i++;
         }
         this.showResult();
         TweenMax.delayedCall(0.5,function():*
         {
            MainGame.getInstance().stopGame();
         });
      }
      
      private function __removed(evt:Event) : void
      {
         var i:* = 0;
         this.closeBtn.removeEventListener("click",__closeClick);
         gc.eventManger.removeEventListener("BuySuccess",buySuccess);
         gc.eventManger.removeEventListener("BuyFail",paymentFail);
         for(i = uint(0); i < this.resultArray.length; )
         {
            SimpleButton(this["resetBtn_" + i]).removeEventListener("click",__changeLuckClick);
            SimpleButton(this["transferBtn_" + i]).removeEventListener("click",__transferClick);
            i++;
         }
      }
      
      private function paymentFail(e:CommonEvent) : void
      {
         gc.renewalseFail();
         this.renewalseChange(null);
      }
      
      private function __changeLuckClick(evt:MouseEvent) : void
      {
         var btnName:String = evt.target.name;
         this.changeLuckType = int(btnName.charAt(btnName.length - 1));
         if(gc.isHideDebug)
         {
            this.addRenewalseMask("您确定花50点券进行属性重置吗？",0);
         }
         else
         {
            this.countEquipProperty(this.equip,this.changeLuckType);
         }
      }
      
      private function __transferClick(evt:MouseEvent) : void
      {
         var btnName:String = evt.target.name;
         this.changeLuckType = int(btnName.charAt(btnName.length - 1));
         if(gc.isHideDebug)
         {
            this.addRenewalseMask("您确定花100点券进行属性转移吗？",1);
         }
         else
         {
            this.transferProperty(this.equip,this.changeLuckType);
         }
      }
      
      private function buySuccess(evt:CommonEvent) : void
      {
         if(gc.lastPaymentString != "Stage13ResultSprite")
         {
            return;
         }
         var exictmask:Sprite = gc.stage.getChildByName("execuitionActionrenewalse") as Sprite;
         if(exictmask)
         {
            gc.stage.removeChild(exictmask);
            exictmask = null;
         }
         gc.lastPaymentString = "";
         if(this.buyType == 0)
         {
            FinancialInfo.sendInfoToFinancialServer(gc.logInfo.uid,[[{
               "id":10630,
               "ename":"custom"
            },1,1],[{
               "id":10630,
               "ename":"custom"
            },0,1]],gc.getTimeStamp(),gc.gameVip.dataObject.lastMoney);
            this.countEquipProperty(this.equip,this.changeLuckType);
         }
         else if(this.buyType == 1)
         {
            FinancialInfo.sendInfoToFinancialServer(gc.logInfo.uid,[[{
               "id":10640,
               "ename":"custom"
            },1,1],[{
               "id":10640,
               "ename":"custom"
            },0,1]],gc.getTimeStamp(),gc.gameVip.dataObject.lastMoney);
            this.transferProperty(this.equip,this.changeLuckType);
         }
         if(renewalse && this.contains(renewalse))
         {
            this.removeChild(renewalse);
         }
      }
      
      public function addRenewalseMask(inst:String, type:int) : void
      {
         this.buyType = type;
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
         if(gc.gameVip.dataObject.lastMoney < this._anti.resetPropertyCost)
         {
            gc.ts.setTxt("账户余额不足");
            gc.stage.addChild(gc.ts);
            enough = false;
         }
         if(this.buyType == 0)
         {
            gc.pay.money = this._anti.resetPropertyCost;
         }
         else
         {
            gc.pay.money = this._anti.resetPropertyCost2;
         }
         if(enough)
         {
            if(GMain.serviceHold)
            {
               PayManager.getInstance().pay(25,"道具25",gc.pay.money,1);
               gc.lastPaymentString = "Stage13ResultSprite";
               gc.addActionMask("renewalse");
            }
         }
         else if(renewalse && this.contains(renewalse))
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
      
      private function __closeClick(evt:MouseEvent) : void
      {
         if(this.equip)
         {
            if(gc.player1.roleid == this.prizeRoleId)
            {
               gc.player1.zblist.push(this.equip);
               gc.ts.setTxt("装备已经放入背包");
               gc.stage.addChild(gc.ts);
            }
            if(gc.player2.roleid == this.prizeRoleId)
            {
               gc.player2.zblist.push(this.equip);
               gc.ts.setTxt("装备已经放入背包");
               gc.stage.addChild(gc.ts);
            }
         }
         this.closeBtn.removeEventListener("click",__closeClick);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         this._anti = null;
         this.dispatchEvent(new CommonEvent("close",[]));
      }
      
      private function showResult() : void
      {
         var hour:* = 0;
         var abilityByLevel:* = 0;
         this.showResultByResultArray();
         var equipType:uint = 0;
         if(this.prizeType == 0)
         {
            equipType = 0;
            this.prizeResult = AUtils.getNewObj("Stage13ResultPrizeWQ") as MovieClip;
         }
         else
         {
            hour = uint((gc.dataObjectInstance.curTime as String).split(":")[0]);
            if(hour >= 18 || hour < 6)
            {
               equipType = 1;
               this.prizeResult = AUtils.getNewObj("Stage13ResultPrizeFJ") as MovieClip;
            }
            else
            {
               equipType = 0;
               this.prizeResult = AUtils.getNewObj("Stage13ResultPrizeWQ") as MovieClip;
            }
         }
         if(this.prizeResult)
         {
            this.prizeResult.gotoAndStop(this.prizeRoleId);
            this.prizeResult.x = 395;
            this.prizeResult.y = 100;
         }
         this._anti.equipName = "";
         if(this.prizeRoleId == 1)
         {
            if(equipType == 0)
            {
               this._anti.equipName = "qlg";
            }
            else
            {
               this._anti.equipName = "qlj";
            }
         }
         else if(this.prizeRoleId == 2)
         {
            if(equipType == 0)
            {
               this._anti.equipName = "plz";
            }
            else
            {
               this._anti.equipName = "plp";
            }
         }
         else if(this.prizeRoleId == 3)
         {
            if(equipType == 0)
            {
               this._anti.equipName = "ylh";
            }
            else
            {
               this._anti.equipName = "ylk";
            }
         }
         else if(this.prizeRoleId == 4)
         {
            if(equipType == 0)
            {
               if(RandomControllor.getIns().getRandom() < 0.5)
               {
                  this._anti.equipName = "jlg";
               }
               else
               {
                  this.prizeResult.gotoAndStop(5);
                  this._anti.equipName = "jlc";
               }
            }
            else
            {
               this._anti.equipName = "jlj";
            }
         }
         this.addChild(this.prizeResult);
         if(this._anti.totalWave < 30)
         {
            if(equipType == 0)
            {
               this._anti.coefficient = 3;
            }
            else if(equipType == 1)
            {
               this._anti.coefficient = 1;
            }
         }
         else if(this._anti.totalWave < 50)
         {
            if(equipType == 0)
            {
               this._anti.coefficient = 4;
            }
            else if(equipType == 1)
            {
               this._anti.coefficient = 2;
            }
         }
         else if(equipType == 0)
         {
            this._anti.coefficient = 5;
         }
         else if(equipType == 1)
         {
            this._anti.coefficient = 3;
         }
         this._anti.bashiwu = 85;
         this._anti.liangbai = 200;
         this._anti.wu = 5;
         this._anti.shi = 10;
         this._anti.sanshi = 30;
         this._anti.shier = 12;
         this._anti.lingdianlingyi = 0.01;
         this._anti.lingdianlinger = 0.02;
         this._anti.shiwu = 15;
         this._anti.sishi = 40;
         this._anti.yi = 1;
         this._anti.er = 2;
         this._anti.san = 3;
         this.equip = gc.allEquip.findByName(this._anti.equipName);
         if(this.equip)
         {
            this.equipInfo.selectable = false;
            this.equipInfo.text = this.equip.ename + "\r";
            abilityByLevel = uint(this._anti.totalWave);
            if(abilityByLevel > 70)
            {
               abilityByLevel = uint(70);
            }
            if(equipType == 0)
            {
               this.equip.seteatt(abilityByLevel * this._anti.coefficient);
               this.equipInfo.text += "攻击力 +" + this.equip.geteatt();
            }
            else
            {
               this.equip.setedef(abilityByLevel * this._anti.coefficient);
               this.equipInfo.text += "防御力 +" + this.equip.getedef();
            }
            this.countEquipProperty(this.equip);
         }
      }
      
      private function showResultByResultArray() : void
      {
         var i:* = 0;
         for(i = uint(0); i < this.resultArray.length; )
         {
            if(this.resultArray[i] > 0)
            {
               MovieClip(this["mc_" + i]).gotoAndStop(1);
               SimpleButton(this["resetBtn_" + i]).visible = true;
               SimpleButton(this["transferBtn_" + i]).visible = true;
               TextField(this["tf_" + i]).visible = true;
               TextField(this["tf_" + i]).text = "X " + this.resultArray[i];
               TextField(this["tf_p_" + i]).visible = true;
            }
            else
            {
               MovieClip(this["mc_" + i]).gotoAndStop(2);
               SimpleButton(this["resetBtn_" + i]).visible = false;
               SimpleButton(this["transferBtn_" + i]).visible = false;
               TextField(this["tf_" + i]).visible = false;
               TextField(this["tf_p_" + i]).visible = false;
               TextField(this["tf_" + i]).text = "";
            }
            i++;
         }
      }
      
      private function transferProperty(equip:MyEquipObj, type:uint) : void
      {
         var addHp:* = 0;
         var addCrit:Number = NaN;
         var addValue:* = 0;
         var addAhp:* = 0;
         var addAmp:* = 0;
         var addMp:* = 0;
         var addMiss:Number = NaN;
         var sourceNum:uint = this.resultArray[this.changeLuckType];
         var targetArray:Array = [0,1,2,3,4,5,6];
         var idx:int = targetArray.indexOf(this.changeLuckType);
         if(idx != -1)
         {
            targetArray.splice(idx,1);
         }
         var targetType:int = targetArray[int(RandomControllor.getIns().getRandom() * targetArray.length)];
         this.resultArray[this.changeLuckType] = 0;
         this.resultArray[targetType] += sourceNum;
         this.showResultByResultArray();
         if(this.changeLuckType == 0)
         {
            equip.setehp(0);
         }
         else if(this.changeLuckType == 1)
         {
            equip.setecrit(0);
         }
         else if(this.changeLuckType == 2)
         {
            if(equip.type == "zbwq")
            {
               equip.setedef(0);
            }
            else if(equip.type == "zbfj")
            {
               equip.seteatt(0);
            }
         }
         else if(this.changeLuckType == 3)
         {
            equip.seteahp(0);
         }
         else if(this.changeLuckType == 4)
         {
            equip.seteamp(0);
         }
         else if(this.changeLuckType == 5)
         {
            equip.setemp(0);
         }
         else if(this.changeLuckType == 6)
         {
            equip.setemiss(0);
         }
         if(targetType == 0)
         {
            addHp = uint(sourceNum * (this._anti.bashiwu + RandomControllor.getIns().getRandom() * (this._anti.liangbai - this._anti.bashiwu)));
            equip.setehp(equip.getehp(true) + addHp);
         }
         else if(targetType == 1)
         {
            addCrit = sourceNum * (this._anti.lingdianlingyi + RandomControllor.getIns().getRandom() * (this._anti.lingdianlinger - this._anti.lingdianlingyi));
            equip.setecrit(equip.getecrit(true) + addCrit);
         }
         else if(targetType == 2)
         {
            addValue = uint(0);
            if(equip.type == "zbwq")
            {
               addValue = uint(sourceNum * (this._anti.wu + RandomControllor.getIns().getRandom() * (this._anti.shier - this._anti.wu)));
               equip.setedef(equip.getedef(true) + addValue);
            }
            else if(equip.type == "zbfj")
            {
               addValue = uint(sourceNum * (this._anti.shi + RandomControllor.getIns().getRandom() * (this._anti.sanshi - this._anti.shi)));
               equip.seteatt(equip.geteatt(true) + addValue);
            }
         }
         else if(targetType == 3)
         {
            addAhp = uint(sourceNum * Math.round(this._anti.yi + RandomControllor.getIns().getRandom() * (this._anti.san - this._anti.yi)));
            equip.seteahp(equip.geteahp(true) + addAhp);
         }
         else if(targetType == 4)
         {
            addAmp = uint(sourceNum * Math.round(this._anti.yi + RandomControllor.getIns().getRandom() * (this._anti.er - this._anti.yi)));
            equip.seteamp(equip.geteamp(true) + addAmp);
         }
         else if(targetType == 5)
         {
            addMp = uint(sourceNum * (this._anti.bashiwu + RandomControllor.getIns().getRandom() * (this._anti.liangbai - this._anti.bashiwu)));
            equip.setemp(equip.getemp(true) + addMp);
         }
         else if(targetType == 6)
         {
            addMiss = sourceNum * (this._anti.lingdianlingyi + RandomControllor.getIns().getRandom() * (this._anti.lingdianlinger - this._anti.lingdianlingyi));
            equip.setemiss(equip.getemiss(true) + addMiss);
         }
         this.refreshEquipProperty();
      }
      
      private function countEquipProperty(equip:MyEquipObj, type:uint = 7) : void
      {
         var i:* = 0;
         var count:* = 0;
         var addHp:* = 0;
         var addCrit:Number = NaN;
         var addValue:* = 0;
         var addAhp:* = 0;
         var addAmp:* = 0;
         var addMp:* = 0;
         var addMiss:Number = NaN;
         for(i = uint(0); i < this.resultArray.length; )
         {
            count = uint(this.resultArray[i]);
            if(count > 0)
            {
               if(i == 0 && (type == 7 || type == i))
               {
                  addHp = uint(this._anti.bashiwu * count + RandomControllor.getIns().getRandom() * ((this._anti.liangbai - this._anti.bashiwu) * count));
                  equip.setehp(addHp);
               }
               else if(i == 1 && (type == 7 || type == i))
               {
                  addCrit = this._anti.lingdianlingyi * count + RandomControllor.getIns().getRandom() * ((this._anti.lingdianlinger - this._anti.lingdianlingyi) * count);
                  equip.setecrit(addCrit);
               }
               else if(i == 2 && (type == 7 || type == i))
               {
                  addValue = uint(0);
                  if(equip.type == "zbwq")
                  {
                     addValue = uint(this._anti.wu * count + RandomControllor.getIns().getRandom() * ((this._anti.shier - this._anti.wu) * count));
                     equip.setedef(addValue);
                  }
                  else if(equip.type == "zbfj")
                  {
                     addValue = uint(this._anti.shi * count + RandomControllor.getIns().getRandom() * ((this._anti.sanshi - this._anti.shi) * count));
                     equip.seteatt(addValue);
                  }
               }
               else if(i == 3 && (type == 7 || type == i))
               {
                  addAhp = uint(Math.round(this._anti.yi * count + RandomControllor.getIns().getRandom() * ((this._anti.san - this._anti.yi) * count)));
                  equip.seteahp(addAhp);
               }
               else if(i == 4 && (type == 7 || type == i))
               {
                  addAmp = uint(Math.round(this._anti.yi * count + RandomControllor.getIns().getRandom() * ((this._anti.er - this._anti.yi) * count)));
                  equip.seteamp(addAmp);
               }
               else if(i == 5 && (type == 7 || type == i))
               {
                  addMp = uint(this._anti.bashiwu * count + RandomControllor.getIns().getRandom() * ((this._anti.liangbai - this._anti.bashiwu) * count));
                  equip.setemp(addMp);
               }
               else if(i == 6 && (type == 7 || type == i))
               {
                  addMiss = this._anti.lingdianlingyi * count + RandomControllor.getIns().getRandom() * ((this._anti.lingdianlinger - this._anti.lingdianlingyi) * count);
                  equip.setemiss(addMiss);
               }
            }
            i++;
         }
         this.refreshEquipProperty();
      }
      
      private function refreshEquipProperty() : void
      {
         if(this.equip)
         {
            this.tf_p_0.text = "生命 +" + this.equip.getehp().toString();
            this.tf_p_1.text = "暴击 +" + (int(this.equip.getecrit() * 100)).toString() + "%";
            if(this.equip.type == "zbwq")
            {
               this.tf_p_2.text = "防御 +" + this.equip.getedef().toString();
            }
            else
            {
               this.tf_p_2.text = "攻击 +" + this.equip.geteatt().toString();
            }
            this.tf_p_3.text = "回血 +" + this.equip.geteahp().toString();
            this.tf_p_4.text = "回蓝 +" + this.equip.geteamp().toString();
            this.tf_p_5.text = "魔法 +" + this.equip.getemp().toString();
            this.tf_p_6.text = "闪避 +" + (int(this.equip.getemiss() * 100)).toString() + "%";
         }
      }
   }
}
