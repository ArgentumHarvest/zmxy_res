package export.garden.petwarehouse
{
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import config.Config;
   import event.CommonEvent;
   import export.renewalse.RenewalseThisSZ;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import my.FinancialInfo;
   import petInfo.PetInfo;
   import user.User;
   
   public class PetWareHouseInterface extends Sprite
   {
       
      
      public var p1btn:SimpleButton;
      
      public var p2btn:SimpleButton;
      
      public var btn_close:SimpleButton;
      
      public var apbtn:SimpleButton;
      
      public var releasebtn1:SimpleButton;
      
      public var releasebtn2:SimpleButton;
      
      private var gc:Config;
      
      private var player:User;
      
      private var btnState;
      
      private var lastBtn:String = "";
      
      private var pif:PetInfo;
      
      private var sp:StoragePet;
      
      private var rp:RetrievePet;
      
      private var renewalse:RenewalseThisSZ;
      
      private var _anti:Antiwear;
      
      private var confirmType:uint = 0;
      
      private var releaseType:uint = 0;
      
      public function PetWareHouseInterface()
      {
         this._anti = new Antiwear(new binaryEncrypt());
         super();
         gc = Config.getInstance();
         this._anti.needtopay = 1000;
         renewalse = new RenewalseThisSZ();
         renewalse.name = "renewalseThisSZ";
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         p1btn.addEventListener("click",player1Click);
         p2btn.addEventListener("click",player2Click);
         btn_close.addEventListener("click",xClick);
         apbtn.addEventListener("click",apClick);
         releasebtn1.addEventListener("click",release1Click);
         releasebtn2.addEventListener("click",release2Click);
         gc.eventManger.addEventListener("BuySuccess",paymentSuccess);
         gc.eventManger.addEventListener("BuyFail",paymentFail);
         sp = new StoragePet();
         sp.x = 223.15;
         sp.y = 166;
         this.addChild(sp);
         rp = new RetrievePet();
         rp.x = 473.1;
         rp.y = 166;
         this.addChild(rp);
         if(gc.playNum == 1)
         {
            p1btn.visible = true;
            p2btn.visible = false;
         }
         else
         {
            p1btn.visible = true;
            p2btn.visible = true;
         }
         if(gc.dataObject.hasbuypetsecondwarehouse == 3)
         {
            apbtn.visible = false;
         }
         p1btn.dispatchEvent(new MouseEvent("click"));
      }
      
      private function removed(e:Event) : void
      {
         p1btn.removeEventListener("click",player1Click);
         p2btn.removeEventListener("click",player2Click);
         btn_close.removeEventListener("click",xClick);
         apbtn.removeEventListener("click",apClick);
         releasebtn1.removeEventListener("click",release1Click);
         releasebtn2.removeEventListener("click",release2Click);
         gc.eventManger.removeEventListener("BuySuccess",paymentSuccess);
         gc.eventManger.removeEventListener("BuyFail",paymentFail);
      }
      
      protected function release2Click(evt:MouseEvent) : void
      {
         var petinfo:PetInfo = rp.getPif();
         if(petinfo)
         {
            this.confirmType = 1;
            this.releaseType = 1;
            this.addRenewalseMask("您确定要放生这只可爱的宠物吗？");
         }
         else
         {
            gc.ts.setTxt("未选择宠物");
            gc.stage.addChild(gc.ts);
         }
      }
      
      protected function release1Click(evt:MouseEvent) : void
      {
         var petinfo:PetInfo = sp.getPif();
         if(petinfo)
         {
            this.confirmType = 1;
            this.releaseType = 0;
            this.addRenewalseMask("您确定要放生这只可爱的宠物吗？");
         }
         else
         {
            gc.ts.setTxt("未选择宠物");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function releasePet1() : void
      {
         var idx:int = 0;
         var petinfo:PetInfo = sp.getPif();
         if(petinfo)
         {
            if(this.player)
            {
               idx = int(this.player.petsAry.indexOf(petinfo));
               this.player.petsAry.splice(idx,1);
               sp.setPetList();
            }
         }
         else
         {
            gc.ts.setTxt("未选择宠物");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function releasePet2() : void
      {
         var idx:int = 0;
         var petinfo:PetInfo = rp.getPif();
         if(petinfo)
         {
            idx = int(gc.petlist.indexOf(petinfo));
            gc.petlist.splice(idx,1);
            rp.setPetList();
         }
         else
         {
            gc.ts.setTxt("未选择宠物");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function setTxt() : void
      {
         if(pif != null)
         {
         }
      }
      
      private function player1Click(e:MouseEvent) : void
      {
         if(gc.player1)
         {
            this.player = gc.player1;
            sp.setPlayer(this.player);
            rp.setPlayer(this.player);
            if(btnState)
            {
               if(lastBtn != "")
               {
                  this[lastBtn].upState = btnState;
               }
            }
            lastBtn = "p1btn";
            btnState = e.currentTarget.upState;
            e.currentTarget.upState = e.currentTarget.downState;
         }
      }
      
      private function player2Click(e:MouseEvent) : void
      {
         if(gc.player2)
         {
            this.player = gc.player2;
            sp.setPlayer(this.player);
            rp.setPlayer(this.player);
            if(btnState)
            {
               if(lastBtn != "")
               {
                  this[lastBtn].upState = btnState;
               }
            }
            lastBtn = "p2btn";
            btnState = e.currentTarget.upState;
            e.currentTarget.upState = e.currentTarget.downState;
         }
      }
      
      private function apClick(e:MouseEvent) : void
      {
         this.confirmType = 0;
         this.addRenewalseMask("您确定要花费" + this._anti.needtopay + "点券扩充宠物仓库");
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
         if(this.confirmType == 0)
         {
            gc.lastPaymentString = "PetWareHouseInterface";
            gc.eventManger.dispatchEvent(new CommonEvent("BuySuccess",[100000]));
         }
         else if(releaseType == 0)
         {
            this.releasePet1();
         }
         else
         {
            this.releasePet2();
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
         if(gc.lastPaymentString != "PetWareHouseInterface")
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
            "id":10670,
            "ename":"custom"
         },1,1],[{
            "id":10670,
            "ename":"custom"
         },0,1]],gc.getTimeStamp(),gc.gameVip.dataObject.lastMoney);
         gc.gameVip.dataObject.lastMoney = e.data[0];
         gc.dataObject.hasbuypetsecondwarehouse += 1;
         if(gc.dataObject.hasbuypetsecondwarehouse == 3)
         {
            apbtn.visible = false;
         }
         this.rp.setPageBtn();
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
