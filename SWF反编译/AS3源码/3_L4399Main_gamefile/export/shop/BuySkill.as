package export.shop
{
   import config.Config;
   import event.CommonEvent;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import my.MainGame;
   import user.User;
   
   public class BuySkill extends Sprite
   {
       
      
      private var gc:Config;
      
      private var currentPlayer:User;
      
      private var player1:MovieClip;
      
      private var player2:MovieClip;
      
      public var btnback:SimpleButton;
      
      public var txtlh:TextField;
      
      public var passivebtn:SimpleButton;
      
      public var activebtn:SimpleButton;
      
      public var bossskillbtn:SimpleButton;
      
      public var state:String = "";
      
      public function BuySkill()
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
      
      private function added(e:Event) : void
      {
         this.player1 = null;
         this.player2 = null;
         var plen:uint = 3;
         var pnum:* = uint(1);
         while(plen > 0)
         {
            pnum = plen;
            if(gc["player" + plen].roleid > 0)
            {
               if(plen == 3)
               {
                  pnum = uint(2);
               }
               if(gc["player" + plen].getRoleName() == "孙悟空")
               {
                  this["player" + pnum] = AUtils.getNewObj("SelectWKMc") as MovieClip;
               }
               else if(gc["player" + plen].getRoleName() == "唐僧")
               {
                  this["player" + pnum] = AUtils.getNewObj("SelectTSMc") as MovieClip;
               }
               else if(gc["player" + plen].getRoleName() == "八戒")
               {
                  this["player" + pnum] = AUtils.getNewObj("SelectBJMc") as MovieClip;
               }
               else if(gc["player" + plen].getRoleName() == "沙僧")
               {
                  this["player" + pnum] = AUtils.getNewObj("SelectSSMc") as MovieClip;
               }
               this["player" + pnum].name = gc["player" + plen].controlPlayer + "";
               this["player" + pnum].gotoAndStop(1);
               this["player" + pnum].buttonMode = true;
               this["player" + pnum].addEventListener("click",playerBuy);
               this.addChild(this["player" + pnum]);
               this["player" + pnum].x = 50 + (pnum - 1) * 90;
               this["player" + pnum].y = 14.85;
            }
            plen--;
         }
         btnback.addEventListener("click",back);
         passivebtn.addEventListener("click",passiveFun);
         activebtn.addEventListener("click",activeFun);
         bossskillbtn.addEventListener("click",bossSkillFun);
         this.player1.dispatchEvent(new MouseEvent("click"));
         if(this.state == "gameing")
         {
            MainGame.getInstance().stopGame();
         }
         gc.eventManger.addEventListener("closeBuySkill",closeBuySkill);
      }
      
      private function removed(e:Event) : void
      {
         if(player1)
         {
            player1.removeEventListener("click",playerBuy);
         }
         if(player2)
         {
            player2.removeEventListener("click",playerBuy);
         }
         passivebtn.removeEventListener("click",passiveFun);
         activebtn.removeEventListener("click",activeFun);
         bossskillbtn.removeEventListener("click",bossSkillFun);
         btnback.removeEventListener("click",back);
         if(gc.isSingleGame())
         {
            if(MainGame.getInstance())
            {
               MainGame.getInstance().continueGame();
            }
         }
         gc.eventManger.removeEventListener("closeBuySkill",closeBuySkill);
      }
      
      private function playerBuy(e:MouseEvent) : void
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
         if(this.currentPlayer != null)
         {
            this.activeFun(null);
         }
         this.setTxtlh();
      }
      
      private function onWho(str:String) : User
      {
         var plen:uint = 3;
         while(plen > 0)
         {
            if(gc["player" + plen].roleid > 0)
            {
               if(gc["player" + plen].controlPlayer + "" == str)
               {
                  return gc["player" + plen] as User;
               }
            }
            plen--;
         }
         return null;
      }
      
      private function removeSkillCont() : void
      {
         var playerCon:* = this.getChildByName("playerControl");
         if(playerCon != null)
         {
            this.removeChild(playerCon);
            playerCon = null;
         }
      }
      
      private function passiveFun(e:*) : void
      {
         var playerCon:* = null;
         trace("---passiveFun---");
         this.removeSkillCont();
         if(currentPlayer != null)
         {
            playerCon = new PassiveSkillControl(currentPlayer);
            playerCon.name = "playerControl";
            this.addChild(playerCon);
         }
         else
         {
            trace("currentPlayer is null");
         }
      }
      
      private function activeFun(e:*) : void
      {
         var playerCon:* = null;
         trace("---activeFun---");
         this.removeSkillCont();
         if(currentPlayer != null)
         {
            playerCon = new SkillControl(currentPlayer);
            playerCon.name = "playerControl";
            this.addChild(playerCon);
         }
         else
         {
            trace("currentPlayer is null");
         }
      }
      
      private function bossSkillFun(e:MouseEvent) : void
      {
         var playerCon:* = null;
         this.removeSkillCont();
         if(currentPlayer != null)
         {
            playerCon = new SutraBossSkill(currentPlayer);
            playerCon.name = "playerControl";
            this.addChild(playerCon);
         }
         else
         {
            trace("currentPlayer is null");
         }
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
      
      private function closeBuySkill(evt:CommonEvent) : void
      {
         this.back(null);
      }
      
      private function back(e:*) : void
      {
         if(this.state == "gameing")
         {
            MainGame.getInstance().continueGame();
            gc.eventManger.dispatchEvent(new CommonEvent("InGameBuySkillOver"));
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
