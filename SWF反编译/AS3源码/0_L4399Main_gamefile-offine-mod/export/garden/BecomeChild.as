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
   import my.FinancialInfo;
   import petInfo.PetInfo;
   
   public class BecomeChild extends Sprite
   {
       
      
      public var hpqualitymc:MovieClip;
      
      public var mpqualitymc:MovieClip;
      
      public var atkqualitymc:MovieClip;
      
      public var defqualitymc:MovieClip;
      
      public var hpqualitytxt:TextField;
      
      public var mpqualitytxt:TextField;
      
      public var atkqualitytxt:TextField;
      
      public var defqualitytxt:TextField;
      
      public var gbtn:SimpleButton;
      
      public var zbtn:SimpleButton;
      
      public var cbtn:SimpleButton;
      
      public var sel1:MovieClip;
      
      public var sel2:MovieClip;
      
      public var sel3:MovieClip;
      
      public var sel4:MovieClip;
      
      private var pif:PetInfo;
      
      private var gc:Config;
      
      private var _anti:Antiwear;
      
      private var renewalse:RenewalseThisSZ;
      
      public function BecomeChild(_pif:PetInfo)
      {
         this._anti = new Antiwear(new binaryEncrypt());
         super();
         this._anti.nigthty = 90;
         this._anti.onehund = 100;
         this._anti.two_hundred = 200;
         this._anti.two_hundred_fifty = 250;
         this._anti.needtopay = 100;
         this._anti.currentSelect = 1;
         this._anti.gjneedexp = 0;
         this._anti.curPetLevel = 1;
         this._anti.curclickstring = "";
         this._anti.whichstate = 1;
         gc = Config.getInstance();
         this.pif = _pif;
         renewalse = new RenewalseThisSZ();
         renewalse.name = "renewalseThisSZ";
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         var i:* = 0;
         cbtn.addEventListener("click",cClick);
         zbtn.addEventListener("click",zClick);
         gbtn.addEventListener("click",gClick);
         i = 1;
         while(i <= 4)
         {
            this["sel" + i].buttonMode = true;
            this["sel" + i].addEventListener("click",selectOne);
            i++;
         }
         gc.eventManger.addEventListener("BuySuccess",paymentSuccess);
         gc.eventManger.addEventListener("BuyFail",paymentFail);
         this.setShow();
      }
      
      private function removed(e:Event) : void
      {
         var i:* = 0;
         i = 1;
         while(i <= 4)
         {
            this["sel" + i].removeEventListener("click",selectOne);
            i++;
         }
         cbtn.removeEventListener("click",cClick);
         zbtn.removeEventListener("click",zClick);
         gbtn.removeEventListener("click",gClick);
         gc.eventManger.removeEventListener("BuySuccess",paymentSuccess);
         gc.eventManger.removeEventListener("BuyFail",paymentFail);
      }
      
      private function selectOne(e:MouseEvent) : void
      {
         var sit:int = int(String(e.currentTarget.name).substr(3,1));
         trace("sit -->>" + sit);
         this._anti.currentSelect = sit;
         this.setShow();
      }
      
      private function cClick(e:MouseEvent) : void
      {
         if(this.pif)
         {
            if(this.pif.getpotential() >= this._anti.nigthty)
            {
               this._anti.needtopay = 90;
               this._anti.curclickstring = "cClick";
               this.addRenewalseMask("您确定花费" + this._anti.needtopay + "潜力点,将" + this.pif.getPetChinaName() + "还童成1级，并随机增加100点资质");
            }
            else
            {
               gc.ts.setTxt("该宠物潜力点不足90点");
               gc.stage.addChild(gc.ts);
            }
         }
         else
         {
            gc.ts.setTxt("请选择要还童的宠物");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function zClick(e:MouseEvent) : void
      {
         if(this.pif)
         {
            this._anti.needtopay = 1000;
            this._anti.curclickstring = "zClick";
            this.addRenewalseMask("您确定花费" + this._anti.needtopay + "点券,将" + this.pif.getPetChinaName() + "还童成1级，并随机增加200点资质");
         }
         else
         {
            gc.ts.setTxt("请选择要还童的宠物");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function gClick(e:MouseEvent) : void
      {
         if(this.pif)
         {
            this._anti.needtopay = 2000;
            this._anti.curclickstring = "gClick";
            this.addRenewalseMask("您确定花费" + this._anti.needtopay + "点券,将" + this.pif.getPetChinaName() + "保持等级还童，并随机增加250点资质");
         }
         else
         {
            gc.ts.setTxt("请选择要还童的宠物");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function setShow() : void
      {
         var i:* = 0;
         if(this.pif)
         {
            if(pif.getdefExp() > 0)
            {
               this.defqualitytxt.text = pif.getdefQuality(true) + "+" + pif.getdefExp();
            }
            else
            {
               this.defqualitytxt.text = pif.getdefQuality(true) + "";
            }
            if(pif.getatkExp() > 0)
            {
               this.atkqualitytxt.text = pif.getatkQuality(true) + "+" + pif.getatkExp();
            }
            else
            {
               this.atkqualitytxt.text = pif.getatkQuality(true) + "";
            }
            if(pif.getmpExp() > 0)
            {
               this.mpqualitytxt.text = pif.getmpQuality(true) + "+" + pif.getmpExp();
            }
            else
            {
               this.mpqualitytxt.text = pif.getmpQuality(true) + "";
            }
            if(pif.gethpExp() > 0)
            {
               this.hpqualitytxt.text = pif.gethpQuality(true) + "+" + pif.gethpExp();
            }
            else
            {
               this.hpqualitytxt.text = pif.gethpQuality(true) + "";
            }
            defqualitymc.gotoAndStop(Math.round(20 * pif.getdefQuality() / 2000) + 1);
            atkqualitymc.gotoAndStop(Math.round(20 * pif.getatkQuality() / 2000) + 1);
            mpqualitymc.gotoAndStop(Math.round(20 * pif.getmpQuality() / 2000) + 1);
            hpqualitymc.gotoAndStop(Math.round(20 * pif.gethpQuality() / 2000) + 1);
            i = 1;
            while(i <= 4)
            {
               this["sel" + i].gotoAndStop(1);
               i++;
            }
            this["sel" + this._anti.currentSelect].gotoAndStop(2);
         }
         else
         {
            this.defqualitytxt.text = "";
            this.atkqualitytxt.text = "";
            this.mpqualitytxt.text = "";
            this.hpqualitytxt.text = "";
            defqualitymc.gotoAndStop(1);
            atkqualitymc.gotoAndStop(1);
            mpqualitymc.gotoAndStop(1);
            hpqualitymc.gotoAndStop(1);
         }
      }
      
      public function addRenewalseMask(inst:String) : void
      {
         renewalse["txt"].text = inst;
         GMain.getInstance().getMainSence().addChild(renewalse);
         renewalse["okbtn"].addEventListener("click",renewalseOk);
         renewalse["nobtn"].addEventListener("click",renewalseChange);
      }
      
      private function renewalseOk(e:MouseEvent) : void
      {
         var enough:Boolean = false;
         renewalse["okbtn"].removeEventListener("click",renewalseOk);
         renewalse["nobtn"].removeEventListener("click",renewalseChange);
         if(renewalse && GMain.getInstance().getMainSence().contains(renewalse))
         {
            GMain.getInstance().getMainSence().removeChild(renewalse);
         }
         if(this._anti.curclickstring == "cClick")
         {
            this.pif.setpotential(this.pif.getpotential() - this._anti.needtopay);
            this.pif.makePetBecomeChildWithPetLevel(this._anti.onehund,this._anti.currentSelect);
            gc.ts.setTxt("还童成功");
            gc.stage.addChild(gc.ts);
            this.setShow();
            gc.eventManger.dispatchEvent(new CommonEvent("BECOMECHILDSUCCESS"));
         }
         else if(this._anti.curclickstring == "zClick" || this._anti.curclickstring == "gClick")
         {
            gc.lastPaymentString = "BecomeChild";
            gc.eventManger.dispatchEvent(new CommonEvent("BuySuccess",[100000]));
         }
      }
      
      private function renewalseChange(e:MouseEvent) : void
      {
         renewalse["okbtn"].removeEventListener("click",renewalseOk);
         renewalse["nobtn"].removeEventListener("click",renewalseChange);
         if(renewalse && GMain.getInstance().getMainSence().contains(renewalse))
         {
            GMain.getInstance().getMainSence().removeChild(renewalse);
         }
      }
      
      private function paymentSuccess(e:CommonEvent) : void
      {
         var preState:int = 0;
         if(gc.lastPaymentString != "BecomeChild")
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
         gc.ts.setTxt("还童成功");
         gc.stage.addChild(gc.ts);
         if(this._anti.curclickstring == "zClick")
         {
            this.pif.makePetBecomeChildWithPetLevel(this._anti.two_hundred,this._anti.currentSelect);
            FinancialInfo.sendInfoToFinancialServer(gc.logInfo.uid,[[{
               "id":10580,
               "ename":"custom"
            },1,1],[{
               "id":10580,
               "ename":"custom"
            },0,1]],gc.getTimeStamp(),gc.gameVip.dataObject.lastMoney);
         }
         else if(this._anti.curclickstring == "gClick")
         {
            FinancialInfo.sendInfoToFinancialServer(gc.logInfo.uid,[[{
               "id":10590,
               "ename":"custom"
            },1,1],[{
               "id":10590,
               "ename":"custom"
            },0,1]],gc.getTimeStamp(),gc.gameVip.dataObject.lastMoney);
            this._anti.curPetLevel = this.pif.getLevel();
            this._anti.gjneedexp = this.pif.getCurExper();
            preState = int(this.pif.getPetName().charAt(this.pif.getPetName().length - 1));
            this._anti.whichstate = preState;
            trace("curExp -->>" + this._anti.gjneedexp);
            this.pif.makePetBecomeChildWithPetLevel(this._anti.two_hundred_fifty,this._anti.currentSelect);
            this.getNeedExpByPetLevel();
            this.pif.setCurExper(this._anti.gjneedexp);
            trace("this._anti.whichstate ->" + this._anti.whichstate);
            if(this._anti.whichstate == 4)
            {
               this.pif.theFourShape();
            }
            else if(this._anti.whichstate == 5)
            {
               this.pif.theFiveShape(true);
            }
         }
         this.setShow();
         gc.eventManger.dispatchEvent(new CommonEvent("BECOMECHILDSUCCESS"));
         if(gc.isHideDebug)
         {
            gc.memory.setStorage(gc.luanqibazaojiami.saveId);
         }
      }
      
      private function getNeedExpByPetLevel() : void
      {
         var i:* = 0;
         i = 1;
         while(i < this._anti.curPetLevel)
         {
            this._anti.gjneedexp += this.getPetNextExper(i);
            i++;
         }
         trace("this._anti.gjneedexp -->>" + this._anti.gjneedexp);
      }
      
      public function getPetNextExper(level:uint) : int
      {
         var nexper:int = 0;
         if(level <= 10)
         {
            nexper = level * 50;
         }
         else
         {
            nexper = (level + 1) * (level + 1) * (5 + (level - 10) * 2);
         }
         return nexper;
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
      
      public function changePetInfo(_pif:PetInfo) : void
      {
         this.pif = _pif;
         this.setShow();
      }
   }
}
