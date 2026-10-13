package export.shop
{
   import base.BaseHero;
   import config.*;
   import event.*;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.*;
   import my.*;
   
   public class BuySkill extends Sprite
   {
       
      
      private var gc:Config;
      
      public var player1:MovieClip;
      
      public var player2:MovieClip;
      
      public var btnback:SimpleButton;
      
      public var state:String = "";
      
      var playerCon:SkillControl;
      
      public function BuySkill()
      {
         super();
         this.player1.buttonMode = true;
         this.player2.buttonMode = true;
         this.gc = Config.getInstance();
         this.addEventListener(Event.ADDED_TO_STAGE,this.added,false,0,true);
         this.addEventListener(Event.REMOVED_FROM_STAGE,this.removed,false,0,true);
      }
      
      public function setCurrentState(param1:String) : void
      {
         this.state = param1;
      }
      
      private function added(param1:Event) : void
      {
         if(this.gc.playNum == 1)
         {
            if(this.gc.hero1.roleName == "孙悟空")
            {
               this.player2.gotoAndStop(3);
               this.player1.addEventListener(MouseEvent.CLICK,this.playerBuy);
               this.player1.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            }
            else if(this.gc.hero1.roleName == "唐僧")
            {
               this.player1.gotoAndStop(3);
               this.player2.addEventListener(MouseEvent.CLICK,this.playerBuy);
               this.player2.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            }
         }
         else
         {
            this.player1.addEventListener(MouseEvent.CLICK,this.playerBuy);
            this.player2.addEventListener(MouseEvent.CLICK,this.playerBuy);
            this.player1.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
         this.btnback.addEventListener(MouseEvent.CLICK,this.back);
         if(this.state == "gameing")
         {
            MainGame.getInstance().stopGame();
         }
      }
      
      private function removed(param1:Event) : void
      {
         this.player1.removeEventListener(MouseEvent.CLICK,this.playerBuy);
         this.player2.removeEventListener(MouseEvent.CLICK,this.playerBuy);
         this.btnback.removeEventListener(MouseEvent.CLICK,this.back);
      }
      
      private function playerBuy(param1:MouseEvent) : void
      {
         if(this.player1.currentFrame == 2)
         {
            this.player1.gotoAndStop(1);
         }
         if(this.player2.currentFrame == 2)
         {
            this.player2.gotoAndStop(1);
         }
         param1.currentTarget.gotoAndStop(2);
         this.removeSkillCont();
         var _loc2_:BaseHero = this.onWho(String(param1.currentTarget.name));
         if(_loc2_ != null)
         {
            this.playerCon = new SkillControl(_loc2_);
            this.addChild(this.playerCon);
         }
      }
      
      private function onWho(param1:String) : BaseHero
      {
         var _loc2_:String = "";
         if(param1 == "player1")
         {
            _loc2_ = "孙悟空";
         }
         else if(param1 == "player2")
         {
            _loc2_ = "唐僧";
         }
         var _loc3_:uint = this.gc.getPlayerArray().length;
         while(_loc3_-- > 0)
         {
            if(this.gc.getPlayerArray()[_loc3_].roleName == _loc2_)
            {
               return this.gc.getPlayerArray()[_loc3_];
            }
         }
         return null;
      }
      
      private function removeSkillCont() : void
      {
         if(this.playerCon && contains(this.playerCon))
         {
            this.removeChild(this.playerCon);
            this.playerCon = null;
         }
      }
      
      private function back(param1:*) : void
      {
         if(this.state == "gameing")
         {
            MainGame.getInstance().continueGame();
         }
         else if(this.state == "maping")
         {
            this.gc.eventManger.dispatchEvent(new CommonEvent("SelectOver"));
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
