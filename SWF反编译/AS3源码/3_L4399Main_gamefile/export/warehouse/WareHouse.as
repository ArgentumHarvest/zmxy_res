package export.warehouse
{
   import config.Config;
   import event.CommonEvent;
   import export.pack.BackPackElement;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import my.MyEquipObj;
   import user.User;
   
   public class WareHouse extends Sprite
   {
       
      
      public var btn_close:SimpleButton;
      
      public var btn_play1:SimpleButton;
      
      public var btn_play2:SimpleButton;
      
      private var lastBtn2:String = "";
      
      private var btnState2;
      
      public var prePage:SimpleButton;
      
      public var nextPage:SimpleButton;
      
      public var thirdPage:SimpleButton;
      
      private var lastBtn:String = "";
      
      private var btnState;
      
      private var gc:Config;
      
      private var player:User;
      
      public var whwhe:WareHouseElement;
      
      public var bpe:BackPackElement;
      
      private var hassave:Boolean = false;
      
      private var isClickXButton:Boolean = false;
      
      private var maskSprite:Sprite;
      
      private var vipCanekuDaojishi:MovieClip;
      
      private var loadDelayTimer:Timer;
      
      public function WareHouse()
      {
         loadDelayTimer = new Timer(1000);
         super();
         gc = Config.getInstance();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         this.player = gc.player1;
         this.btn_close.addEventListener("click",xClick);
         this.btn_play1.addEventListener("click",play1Click);
         this.btn_play2.addEventListener("click",play2Click);
         this.prePage.addEventListener("click",prePageClick);
         this.nextPage.addEventListener("click",nextPageClick);
         this.thirdPage.addEventListener("click",thirdPageClick);
         this.thirdPage.visible = false;
         this.addBackPackAgeMc();
         this.btn_play1.dispatchEvent(new MouseEvent("click"));
         gc.eventManger.addEventListener("SAVESEVENTSUCCESS",savesuccess);
         gc.eventManger.addEventListener("READSEVENOBJECT",readSeven);
         gc.eventManger.addEventListener("REACHIEVEVIPWAREHOUSE",reReadWareHouse);
         gc.eventManger.addEventListener("DEACTIVATE",__deactivate);
         loadDelayTimer.addEventListener("timer",__timer);
         if(gc.playNum == 1)
         {
            this.btn_play2.removeEventListener("click",play2Click);
            this.btn_play2.visible = false;
         }
         if(gc.isHideDebug)
         {
            gc.memory.readSevenObject();
         }
      }
      
      private function removed(e:Event) : void
      {
         this.btn_close.removeEventListener("click",xClick);
         this.btn_play1.removeEventListener("click",play1Click);
         this.btn_play2.removeEventListener("click",play2Click);
         this.prePage.removeEventListener("click",prePageClick);
         this.nextPage.removeEventListener("click",nextPageClick);
         this.thirdPage.removeEventListener("click",thirdPageClick);
         gc.eventManger.removeEventListener("SAVESEVENTSUCCESS",savesuccess);
         gc.eventManger.removeEventListener("READSEVENOBJECT",readSeven);
         gc.eventManger.removeEventListener("REACHIEVEVIPWAREHOUSE",reReadWareHouse);
         gc.eventManger.removeEventListener("DEACTIVATE",__deactivate);
         this.btnState = null;
         this.btnState2 = null;
      }
      
      private function __deactivate(evt:Event) : void
      {
         var maskBm:* = null;
         loadDelayTimer.stop();
         loadDelayTimer.reset();
         if(!this.maskSprite)
         {
            maskBm = AUtils.getImageObj("VIPCKMASK") as Bitmap;
            this.maskSprite = new Sprite();
            this.maskSprite.addChild(maskBm);
            this.addChild(this.maskSprite);
            this.vipCanekuDaojishi = AUtils.getNewObj("VipCangkuDaojishi") as MovieClip;
            this.vipCanekuDaojishi.x = 470;
            this.vipCanekuDaojishi.y = 480;
            this.vipCanekuDaojishi.gotoAndStop(1);
            this.maskSprite.addChild(this.vipCanekuDaojishi);
         }
         else if(this.vipCanekuDaojishi)
         {
            this.vipCanekuDaojishi.gotoAndStop(1);
         }
      }
      
      private function reReadWareHouse(e:CommonEvent) : *
      {
         loadDelayTimer.start();
      }
      
      private function __timer(evt:TimerEvent) : void
      {
         if(loadDelayTimer.currentCount < 3)
         {
            if(this.vipCanekuDaojishi)
            {
               this.vipCanekuDaojishi.gotoAndStop(loadDelayTimer.currentCount + 1);
            }
         }
         if(loadDelayTimer.currentCount == 3)
         {
            gc.memory.readSevenObject();
            if(this.maskSprite)
            {
               if(this.maskSprite.parent)
               {
                  this.maskSprite.parent.removeChild(this.maskSprite);
               }
               this.vipCanekuDaojishi = null;
               this.maskSprite = null;
            }
            loadDelayTimer.stop();
         }
      }
      
      private function savesuccess(e:CommonEvent) : void
      {
         if(this.isClickXButton)
         {
            if(this.parent)
            {
               this.parent.removeChild(this);
            }
         }
      }
      
      private function savefail(e:CommonEvent) : void
      {
         gc.memory.saveSevenData(this.whwhe.getSaveObj());
      }
      
      private function readSeven(e:CommonEvent) : void
      {
         whwhe.setSaveObj(e.data);
      }
      
      private function xClick(e:MouseEvent) : void
      {
         this.isClickXButton = true;
         if(hassave)
         {
            if(gc.isHideDebug)
            {
               gc.memory.saveSevenData(this.whwhe.getSaveObj());
            }
         }
         else if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function play1Click(e:MouseEvent) : void
      {
         bpe.setPlayer(gc.player1);
         gc.eventManger.dispatchEvent(new CommonEvent("GETANDREFRESHBACKPACKAGE"));
         if(btnState2)
         {
            if(lastBtn2 != "")
            {
               this[lastBtn2].upState = btnState2;
            }
         }
         lastBtn2 = "btn_play1";
         btnState2 = e.target.upState;
         e.target.upState = e.target.downState;
         if(gc.player1.getCurLevel() >= 50)
         {
            thirdPage.visible = true;
         }
      }
      
      private function play2Click(e:MouseEvent) : void
      {
         bpe.setPlayer(gc.player2);
         gc.eventManger.dispatchEvent(new CommonEvent("GETANDREFRESHBACKPACKAGE"));
         if(btnState2)
         {
            if(lastBtn2 != "")
            {
               this[lastBtn2].upState = btnState2;
            }
         }
         lastBtn2 = "btn_play2";
         btnState2 = e.target.upState;
         e.target.upState = e.target.downState;
         if(gc.player2.getCurLevel() >= 50)
         {
            thirdPage.visible = true;
         }
      }
      
      private function prePageClick(e:MouseEvent) : void
      {
         if(bpe)
         {
            bpe.setCurPage(1);
         }
         if(btnState)
         {
            if(lastBtn != "")
            {
               this[lastBtn].upState = btnState;
            }
         }
         lastBtn = "prePage";
         btnState = e.target.upState;
         e.target.upState = e.target.downState;
      }
      
      private function nextPageClick(e:MouseEvent) : void
      {
         if(bpe)
         {
            bpe.setCurPage(2);
         }
         if(btnState)
         {
            if(lastBtn != "")
            {
               this[lastBtn].upState = btnState;
            }
         }
         lastBtn = "nextPage";
         btnState = e.target.upState;
         e.target.upState = e.target.downState;
      }
      
      private function thirdPageClick(e:MouseEvent) : void
      {
         if(bpe)
         {
            bpe.setCurPage(3);
         }
         if(btnState)
         {
            if(lastBtn != "")
            {
               this[lastBtn].upState = btnState;
            }
         }
         lastBtn = "thirdPage";
         btnState = e.target.upState;
         e.target.upState = e.target.downState;
      }
      
      private function addBackPackAgeMc() : void
      {
         var idx:int = 0;
         if(this.bpe != null && contains(this.bpe))
         {
            this.removeChild(this.bpe);
            this.bpe = null;
         }
         bpe = new BackPackElement();
         if(this.whwhe)
         {
            idx = this.getChildIndex(this.whwhe);
            this.addChildAt(bpe,idx);
         }
         else
         {
            this.addChild(bpe);
         }
         bpe.setPlayer(this.player);
         this.bpe.x = 473.45;
         this.bpe.y = 102.5;
      }
      
      public function operatingPack(whichpack:String, equip:MyEquipObj) : void
      {
         var sit:int = 0;
         sit = 0;
         sit = 0;
         hassave = true;
         if(whichpack == "BackPackElement")
         {
            this.whwhe.addMyEquipmentToList(equip);
         }
         else if(whichpack == "WareHouseElement")
         {
            this.bpe.addMyEquipmentToList(equip);
            if(equip.type == "zbwq" || equip.type == "zbfj" || equip.type == "zbfb" || equip.type == "zbsp" || equip.type == "zbtx")
            {
               sit = gc.zblist.indexOf(equip);
               gc.zblist.splice(sit,1);
            }
            else if(equip.type == "zbsz")
            {
               sit = gc.szlist.indexOf(equip);
               gc.szlist.splice(sit,1);
            }
            else
            {
               sit = gc.djlist.indexOf(equip);
               gc.djlist.splice(sit,1);
            }
            gc.eventManger.dispatchEvent(new CommonEvent("REFRESHWAREHOUSE"));
         }
         if(gc.isHideDebug)
         {
            gc.memory.saveSevenData(this.whwhe.getSaveObj());
         }
      }
      
      public function getUser() : User
      {
         return this.player;
      }
   }
}
