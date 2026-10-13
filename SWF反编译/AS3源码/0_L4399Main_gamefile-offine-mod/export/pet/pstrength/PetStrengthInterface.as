package export.pet.pstrength
{
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import config.Config;
   import event.CommonEvent;
   import export.pet.PetShowObj;
   import export.renewalse.RenewalseThisSZ;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import my.FinancialInfo;
   import my.PetEquipObj;
   import user.User;
   
   public class PetStrengthInterface extends Sprite
   {
       
      
      public var strbtn:SimpleButton;
      
      public var expmc:MovieClip;
      
      public var zbmc:Sprite;
      
      public var protxt:TextField;
      
      public var ttxt:TextField;
      
      public var atxt:TextField;
      
      public var ntxt:TextField;
      
      public var etxt:TextField;
      
      public var buyqh:SimpleButton;
      
      public var dtxt:TextField;
      
      private var curPetEquip:PetEquipObj;
      
      private var gc:Config;
      
      private var player:User;
      
      private var renewalse:RenewalseThisSZ;
      
      private var _anti:Antiwear;
      
      public function PetStrengthInterface(_player:User)
      {
         this._anti = new Antiwear(new binaryEncrypt());
         super();
         gc = Config.getInstance();
         this.player = _player;
         this._anti.needtopay = 100;
         renewalse = new RenewalseThisSZ();
         renewalse.name = "renewalseThisSZ";
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
         if(player != gc.player3)
         {
            strbtn.visible = true;
            buyqh.visible = true;
            strbtn.addEventListener("click",strClick);
            buyqh.addEventListener("click",buyClick);
         }
         else
         {
            strbtn.visible = false;
            buyqh.visible = false;
         }
         gc.eventManger.addEventListener("STRENGTHPETEQUIPMENT",strengthEvent);
         gc.eventManger.addEventListener("BuySuccess",paymentSuccess);
         gc.eventManger.addEventListener("BuyFail",paymentFail);
         gc.eventManger.addEventListener("GetMoneySuccess",getMoneySucc);
         ttxt.selectable = false;
         ttxt.tabEnabled = false;
         atxt.selectable = false;
         atxt.tabEnabled = false;
         ntxt.selectable = false;
         ntxt.tabEnabled = false;
         etxt.selectable = false;
         etxt.tabEnabled = false;
         dtxt.selectable = false;
         dtxt.tabEnabled = false;
      }
      
      private function removed(e:Event) : void
      {
         strbtn.removeEventListener("click",strClick);
         gc.eventManger.removeEventListener("STRENGTHPETEQUIPMENT",strengthEvent);
         buyqh.removeEventListener("click",buyClick);
         gc.eventManger.removeEventListener("BuySuccess",paymentSuccess);
         gc.eventManger.removeEventListener("BuyFail",paymentFail);
         gc.eventManger.removeEventListener("GetMoneySuccess",getMoneySucc);
      }
      
      private function strClick(e:MouseEvent) : void
      {
         var newPetEquip:PetEquipObj = null;
         if(this.curPetEquip)
         {
            if(this.player.dataObject.strenthtimes > 0)
            {
               if(this.player.getLhValue() >= 1000)
               {
                  if(this.curPetEquip.quality == "史 诗")
                  {
                     if(this.curPetEquip.getStrengthLevel() >= 9)
                     {
                        gc.ts.setTxt("强化等级已满");
                        gc.stage.addChild(gc.ts);
                        return;
                     }
                  }
                  this.curPetEquip.setStrengthValue(this.curPetEquip.getStrengthValue() + 5);
                  if(this.curPetEquip.getStrengthLevel() > 9)
                  {
                     newPetEquip = gc.allEquip.findByName(this.getNextQualityName(this.curPetEquip.getFillName()));
                     newPetEquip.setehp(newPetEquip.getehp() + this.curPetEquip.getehp());
                     newPetEquip.setemp(newPetEquip.getemp() + this.curPetEquip.getemp());
                     newPetEquip.seteatt(newPetEquip.geteatt() + this.curPetEquip.geteatt());
                     newPetEquip.setedef(newPetEquip.getedef() + this.curPetEquip.getedef());
                     newPetEquip.setecrit(newPetEquip.getecrit() + this.curPetEquip.getecrit());
                     newPetEquip.setemiss(newPetEquip.getemiss() + this.curPetEquip.getemiss());
                     newPetEquip.seteahp(newPetEquip.geteahp() + this.curPetEquip.geteahp());
                     newPetEquip.seteamp(newPetEquip.geteamp() + this.curPetEquip.geteamp());
                     newPetEquip.setmagicdef(newPetEquip.getmagicdef() + this.curPetEquip.getmagicdef());
                     newPetEquip.setspeed(newPetEquip.getspeed() + this.curPetEquip.getspeed());
                     newPetEquip.seteatblood(newPetEquip.geteatblood() + this.curPetEquip.geteatblood());
                     newPetEquip.setPetInfo(this.curPetEquip.getPetInfo());
                     this.curPetEquip = null;
                     this.curPetEquip = newPetEquip;
                     gc.ts.setTxt("装备已升级");
                     gc.stage.addChild(gc.ts);
                  }
                  gc.eventManger.dispatchEvent(new CommonEvent("STRENGTHUPDATECHANGEEQUIP",[this.curPetEquip.type,this.curPetEquip]));
                  this.player.dataObject.strenthtimes--;
                  this.player.setLhValue(this.player.getLhValue() - 1000);
                  this.setShow();
               }
               else
               {
                  gc.ts.setTxt("灵魂不够");
                  gc.stage.addChild(gc.ts);
               }
            }
            else
            {
               gc.ts.setTxt("强化数不够");
               gc.stage.addChild(gc.ts);
            }
         }
         else
         {
            gc.ts.setTxt("请选择需要强化的装备");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function getNextQualityName(cfname:String) : String
      {
         var f1:String = null;
         var end1:String = null;
         var sname:String = null;
         var len:uint = uint(cfname.length);
         if(this.curPetEquip.quality == "优 秀")
         {
            f1 = cfname.substr(0,2);
            end1 = cfname.substr(2,len - 2);
            return f1 + "jl" + end1;
         }
         sname = cfname.replace("jl","ss");
         trace("sname -->>>" + sname);
         return sname;
      }
      
      private function setShow() : void
      {
         var sz:PetShowObj = null;
         var sobj:PetShowObj = null;
         atxt.text = "" + this.player.getLhValue();
         ttxt.text = "" + this.player.dataObject.strenthtimes;
         dtxt.text = "" + gc.gameVip.dataObject.lastMoney;
         if(this.curPetEquip)
         {
            etxt.text = this.curPetEquip.getEname() + "(+" + this.curPetEquip.getStrengthLevel() + ")";
            ntxt.text = "1000";
            protxt.text = this.curPetEquip.getStrengthProgress() + "/" + this.curPetEquip.getNextNeedValue();
            expmc.gotoAndStop(int(this.curPetEquip.getStrengthProgress() / this.curPetEquip.getNextNeedValue() * 50));
            sz = zbmc.getChildByName("curzb") as PetShowObj;
            if(sz)
            {
               zbmc.removeChild(sz);
            }
            sobj = new PetShowObj(this.curPetEquip);
            sobj.x = 4;
            sobj.y = 5;
            zbmc.addChild(sobj);
         }
      }
      
      private function strengthEvent(e:CommonEvent) : void
      {
         trace("-- strengthEvent --");
         this.setPetEquipObj(e.data[0]);
      }
      
      public function setPetEquipObj(pequip:PetEquipObj) : void
      {
         this.curPetEquip = pequip;
         this.setShow();
      }
      
      private function buyClick(e:MouseEvent) : void
      {
         this.addRenewalseMask("您确定要花费" + this._anti.needtopay + "点券购买5个强化点");
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
         renewalse["okbtn"].removeEventListener("click",renewalseOk);
         renewalse["nobtn"].removeEventListener("click",renewalseChange);
         gc.lastPaymentString = "PetStrengthInterface";
         gc.eventManger.dispatchEvent(new CommonEvent("BuySuccess",[100000]));
         if(renewalse && GMain.getInstance().getMainSence().contains(renewalse))
         {
            GMain.getInstance().getMainSence().removeChild(renewalse);
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
         if(gc.lastPaymentString != "PetStrengthInterface")
         {
            return;
         }
         gc.lastPaymentString = "";
         var exictmask:Sprite = gc.stage.getChildByName("execuitionActionrenewalse") as Sprite;
         if(exictmask)
         {
            gc.stage.removeChild(exictmask);
            exictmask = null;
         }
         gc.gameVip.dataObject.lastMoney = e.data[0];
         this.player.dataObject.strenthtimes += 5;
         FinancialInfo.sendInfoToFinancialServer(gc.logInfo.uid,[[{
            "id":10700,
            "ename":"custom"
         },1,1],[{
            "id":10700,
            "ename":"custom"
         },0,1]],gc.getTimeStamp(),gc.gameVip.dataObject.lastMoney);
         this.setShow();
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
      
      private function getMoneySucc(e:CommonEvent) : void
      {
         this.setShow();
      }
   }
}
