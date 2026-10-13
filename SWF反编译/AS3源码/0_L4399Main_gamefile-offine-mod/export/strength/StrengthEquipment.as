package export.strength
{
   import com.hexagonstar.util.debug.Debug;
   import config.Config;
   import event.CommonEvent;
   import export.pack.BackPackElement;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import my.MainGame;
   import user.User;
   
   public class StrengthEquipment extends Sprite
   {
       
      
      private var gc:Config;
      
      private var player1:MovieClip;
      
      private var player2:MovieClip;
      
      public var state:String = "";
      
      private var currentPlayer:User;
      
      private var backpackagemc:BackPackElement;
      
      public var btnback:SimpleButton;
      
      public var strengthbtn:SimpleButton;
      
      public var mixturebtn:SimpleButton;
      
      public var makingbtn:SimpleButton;
      
      public var resolutionbtn:SimpleButton;
      
      public var recastbtn:SimpleButton;
      
      public var txtlh:TextField;
      
      public var prePage:SimpleButton;
      
      public var nextPage:SimpleButton;
      
      public var thirdPage:SimpleButton;
      
      private var isfirst:Boolean = true;
      
      private var tag:Boolean = true;
      
      private var btnState;
      
      private var lastBtn:String = "";
      
      private var btnState2;
      
      private var lastBtn2:String = "";
      
      public function StrengthEquipment()
      {
         super();
         gc = Config.getInstance();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      public function setCurrentState(str:String) : void
      {
         this.state = str;
      }
      
      public function getUser() : User
      {
         return this.currentPlayer;
      }
      
      private function added(e:Event) : void
      {
         var plen:* = 0;
         if(this.tag)
         {
            this.tag = false;
            this.player1 = null;
            this.player2 = null;
            plen = uint(gc.playNum);
            while(plen > 0)
            {
               if(gc["player" + plen].getRoleName() == "孙悟空")
               {
                  this["player" + plen] = AUtils.getNewObj("SelectWKMc") as MovieClip;
                  this["player" + plen].name = "孙悟空";
               }
               else if(gc["player" + plen].getRoleName() == "唐僧")
               {
                  this["player" + plen] = AUtils.getNewObj("SelectTSMc") as MovieClip;
                  this["player" + plen].name = "唐僧";
               }
               else if(gc["player" + plen].getRoleName() == "八戒")
               {
                  this["player" + plen] = AUtils.getNewObj("SelectBJMc") as MovieClip;
                  this["player" + plen].name = "八戒";
               }
               else if(gc["player" + plen].getRoleName() == "沙僧")
               {
                  this["player" + plen] = AUtils.getNewObj("SelectSSMc") as MovieClip;
                  this["player" + plen].name = "沙僧";
               }
               this["player" + plen].gotoAndStop(1);
               this["player" + plen].buttonMode = true;
               this["player" + plen].addEventListener("click",equipStrength);
               this.addChild(this["player" + plen]);
               this["player" + plen].x = 50 + (plen - 1) * 90;
               this["player" + plen].y = 14.85;
               plen--;
            }
            btnback.addEventListener("click",back);
            strengthbtn.addEventListener("click",strMethod);
            mixturebtn.addEventListener("click",mixMethod);
            resolutionbtn.addEventListener("click",resMethod);
            recastbtn.addEventListener("click",recatsMethod);
            makingbtn.addEventListener("click",makeMethod);
            prePage.addEventListener("click",prePageClick);
            nextPage.addEventListener("click",nextPageClick);
            thirdPage.addEventListener("click",thirdPageClick);
            thirdPage.visible = false;
            this.player1.dispatchEvent(new MouseEvent("click"));
            if(this.state == "gameing")
            {
               MainGame.getInstance().stopGame();
            }
         }
      }
      
      private function removed(e:Event) : void
      {
         if(player1)
         {
            player1.removeEventListener("click",equipStrength);
         }
         if(player2)
         {
            player2.removeEventListener("click",equipStrength);
         }
         btnback.removeEventListener("click",back);
         strengthbtn.removeEventListener("click",strMethod);
         mixturebtn.removeEventListener("click",mixMethod);
         resolutionbtn.removeEventListener("click",resMethod);
         recastbtn.removeEventListener("click",recatsMethod);
         makingbtn.removeEventListener("click",makeMethod);
         prePage.removeEventListener("click",prePageClick);
         nextPage.removeEventListener("click",nextPageClick);
         thirdPage.removeEventListener("click",thirdPageClick);
         btnState = null;
         btnState2 = null;
      }
      
      private function prePageClick(e:MouseEvent) : void
      {
         if(backpackagemc)
         {
            backpackagemc.setCurPage(1);
         }
         if(btnState2)
         {
            if(lastBtn2 != "")
            {
               this[lastBtn2].upState = btnState2;
            }
         }
         lastBtn2 = "prePage";
         btnState2 = e.target.upState;
         e.target.upState = e.target.downState;
      }
      
      private function nextPageClick(e:MouseEvent) : void
      {
         if(backpackagemc)
         {
            backpackagemc.setCurPage(2);
         }
         if(btnState2)
         {
            if(lastBtn2 != "")
            {
               this[lastBtn2].upState = btnState2;
            }
         }
         lastBtn2 = "nextPage";
         btnState2 = e.target.upState;
         e.target.upState = e.target.downState;
      }
      
      private function thirdPageClick(e:MouseEvent) : void
      {
         if(backpackagemc)
         {
            backpackagemc.setCurPage(3);
         }
         if(btnState2)
         {
            if(lastBtn2 != "")
            {
               this[lastBtn2].upState = btnState2;
            }
         }
         lastBtn2 = "thirdPage";
         btnState2 = e.target.upState;
         e.target.upState = e.target.downState;
      }
      
      private function equipStrength(e:MouseEvent) : void
      {
         if(this.player1)
         {
            if(this.player1.currentFrame == 2)
            {
               this.player1.gotoAndStop(1);
            }
         }
         else
         {
            trace("player1 not found!");
         }
         if(this.player2)
         {
            if(this.player2.currentFrame == 2)
            {
               this.player2.gotoAndStop(1);
            }
         }
         else
         {
            trace("player2 not found!");
         }
         e.currentTarget.gotoAndStop(2);
         this.currentPlayer = this.onWho(String(e.currentTarget.name));
         this.addBackPackAgeMc();
         if(this.currentPlayer)
         {
            strengthbtn.dispatchEvent(new MouseEvent("click"));
         }
         this.setTxtlh();
         if(this.currentPlayer.getCurLevel() >= 50)
         {
            thirdPage.visible = true;
         }
      }
      
      private function addBackPackAgeMc() : void
      {
         if(this.backpackagemc != null && contains(this.backpackagemc))
         {
            this.removeChild(this.backpackagemc);
            this.backpackagemc = null;
         }
         backpackagemc = new BackPackElement();
         this.isfirst = true;
         this.addChild(backpackagemc);
         backpackagemc.setPlayer(this.currentPlayer);
         this.backpackagemc.x = 513.8;
         this.backpackagemc.y = 130;
      }
      
      private function onWho(str:String) : User
      {
         var plen:uint = gc.playNum;
         while(plen > 0)
         {
            if(gc["player" + plen].getRoleName() == str)
            {
               return gc["player" + plen] as User;
            }
            plen--;
         }
         return null;
      }
      
      public function setTxtlh() : void
      {
         if(this.currentPlayer)
         {
            this.txtlh.text = this.currentPlayer.getLhValue() + "";
         }
         else
         {
            trace("set lhValue text: error reason:\'this.currentPlayer is null\'");
         }
      }
      
      private function strMethod(e:MouseEvent) : void
      {
         var playerCon:* = null;
         Debug.trace("---strMethod----");
         this.removeEquipCont();
         if(currentPlayer != null)
         {
            playerCon = new Strength(currentPlayer);
            playerCon.name = "playerControl";
            playerCon.x = 175.6;
            playerCon.y = 128.45;
            this.addChild(playerCon);
         }
         else
         {
            trace("currentPlayer is null");
         }
         if(btnState)
         {
            if(lastBtn != "")
            {
               this[lastBtn].upState = btnState;
            }
         }
         lastBtn = "strengthbtn";
         btnState = e.target.upState;
         e.target.upState = e.target.downState;
      }
      
      private function mixMethod(e:MouseEvent) : void
      {
         var playerCon:* = null;
         this.removeEquipCont();
         if(currentPlayer != null)
         {
            playerCon = new Fusion(currentPlayer);
            playerCon.name = "playerControl";
            playerCon.x = 175.6;
            playerCon.y = 128.45;
            this.addChild(playerCon);
         }
         else
         {
            trace("currentPlayer is null");
         }
         if(btnState)
         {
            if(lastBtn != "")
            {
               this[lastBtn].upState = btnState;
            }
         }
         lastBtn = "mixturebtn";
         btnState = e.target.upState;
         e.target.upState = e.target.downState;
      }
      
      private function resMethod(e:MouseEvent) : void
      {
         var playerCon:* = null;
         this.removeEquipCont();
         if(currentPlayer != null)
         {
            playerCon = new Resolution(currentPlayer);
            playerCon.name = "playerControl";
            playerCon.x = 175.6;
            playerCon.y = 128.45;
            this.addChild(playerCon);
         }
         else
         {
            trace("currentPlayer is null");
         }
         if(btnState)
         {
            if(lastBtn != "")
            {
               this[lastBtn].upState = btnState;
            }
         }
         lastBtn = "resolutionbtn";
         btnState = e.target.upState;
         e.target.upState = e.target.downState;
      }
      
      private function recatsMethod(e:MouseEvent) : void
      {
         var playerCon:* = null;
         this.removeEquipCont();
         if(currentPlayer != null)
         {
            playerCon = new Recasting(currentPlayer);
            playerCon.name = "playerControl";
            playerCon.x = 145;
            playerCon.y = 130;
            this.addChild(playerCon);
         }
         else
         {
            trace("currentPlayer is null");
         }
         if(btnState)
         {
            if(lastBtn != "")
            {
               this[lastBtn].upState = btnState;
            }
         }
         lastBtn = "recastbtn";
         btnState = e.target.upState;
         e.target.upState = e.target.downState;
      }
      
      private function makeMethod(e:MouseEvent) : void
      {
         var playerCon:* = null;
         this.removeEquipCont();
         if(currentPlayer != null)
         {
            playerCon = new Making(currentPlayer);
            playerCon.name = "playerControl";
            playerCon.x = 175.6;
            playerCon.y = 110.45;
            this.addChild(playerCon);
         }
         else
         {
            trace("currentPlayer is null");
         }
         if(btnState)
         {
            if(lastBtn != "")
            {
               this[lastBtn].upState = btnState;
            }
         }
         lastBtn = "makingbtn";
         btnState = e.target.upState;
         e.target.upState = e.target.downState;
      }
      
      private function removeEquipCont() : void
      {
         Debug.trace("----removeEquipCont-----");
         Debug.trace("----isfirst----- " + isfirst);
         var playerCon:* = this.getChildByName("playerControl");
         if(playerCon != null)
         {
            this.removeChild(playerCon);
            playerCon = null;
         }
         if(!isfirst)
         {
            gc.eventManger.dispatchEvent(new CommonEvent("GETANDREFRESHBACKPACKAGE"));
         }
         isfirst = false;
      }
      
      private function back(e:*) : void
      {
         if(this.state == "gameing")
         {
            MainGame.getInstance().continueGame();
         }
         else if(this.state == "maping")
         {
            gc.eventManger.dispatchEvent(new CommonEvent("SelectOver"));
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
