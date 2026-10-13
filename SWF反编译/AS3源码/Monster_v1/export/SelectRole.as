package export
{
   import base.BaseHero;
   import config.Config;
   import event.CommonEvent;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class SelectRole extends Sprite
   {
       
      
      public var btn1:SimpleButton;
      
      public var btn2:SimpleButton;
      
      public var curSelected:uint = 1;
      
      private var gc:Config;
      
      public function SelectRole()
      {
         super();
         this.gc = Config.getInstance();
         this.addEventListener(Event.ADDED_TO_STAGE,this.added,false,0,true);
         this.addEventListener(Event.REMOVED_FROM_STAGE,this.removed,false,0,true);
      }
      
      private function added(param1:*) : void
      {
         this.btn1.addEventListener(MouseEvent.ROLL_OVER,this.over);
         this.btn1.addEventListener(MouseEvent.ROLL_OUT,this.out);
         this.btn2.addEventListener(MouseEvent.ROLL_OVER,this.over);
         this.btn2.addEventListener(MouseEvent.ROLL_OUT,this.out);
         this.btn1.addEventListener(MouseEvent.CLICK,this.onClick);
         this.btn2.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function removed(param1:*) : void
      {
         this.btn1.removeEventListener(MouseEvent.ROLL_OVER,this.over);
         this.btn1.removeEventListener(MouseEvent.ROLL_OUT,this.out);
         this.btn2.removeEventListener(MouseEvent.ROLL_OVER,this.over);
         this.btn2.removeEventListener(MouseEvent.ROLL_OUT,this.out);
         this.btn1.removeEventListener(MouseEvent.CLICK,this.onClick);
         this.btn2.removeEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function over(param1:MouseEvent) : void
      {
         var _loc2_:* = AUtils.getImageObj(this.curSelected + "P");
         _loc2_.name = "arrow" + this.curSelected;
         _loc2_.x = param1.currentTarget.x - 30;
         _loc2_.y = 40;
         this.addChild(_loc2_);
      }
      
      private function out(param1:MouseEvent) : void
      {
         if(this.getChildByName("arrow" + this.curSelected) != null)
         {
            this.removeChild(this.getChildByName("arrow" + this.curSelected));
         }
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         param1.currentTarget.removeEventListener(MouseEvent.ROLL_OUT,this.out);
         param1.currentTarget.removeEventListener(MouseEvent.ROLL_OVER,this.over);
         param1.currentTarget.removeEventListener(MouseEvent.CLICK,this.onClick);
         var _loc2_:uint = int(String(param1.currentTarget.name).substr(3,1));
         if(this.gc.playNum == 1)
         {
            this.newRole(_loc2_);
            this.gc.gameMode = Config.MODE1;
            this.doAfterChangeOut();
            if(this.parent)
            {
               this.parent.removeChild(this);
            }
         }
         else if(this.gc.playNum == 2)
         {
            this.newRole(_loc2_);
            if(this.curSelected == 2)
            {
               this.gc.gameMode = Config.MODE2;
               this.doAfterChangeOut();
               if(this.parent)
               {
                  this.parent.removeChild(this);
               }
            }
            ++this.curSelected;
         }
         param1.target.upState = param1.target.downState;
      }
      
      public function doAfterChangeOut() : void
      {
         this.gc.eventManger.dispatchEvent(new CommonEvent("SelectOver"));
      }
      
      public function doAfterChangeIn() : void
      {
         this.visible = true;
      }
      
      private function newRole(param1:uint) : void
      {
         if(this.curSelected == 1)
         {
            this.gc.hero1 = AUtils.getNewObj("export.hero.Role" + param1) as BaseHero;
            this.gc.hero1.x = 300;
            this.gc.hero1.y = 100;
            this.gc.hero1.name = "1";
            this.gc.hero1.setPlayer(this.gc.player1);
            this.gc.player1.roleid = param1;
         }
         else if(this.curSelected == 2)
         {
            this.gc.hero2 = AUtils.getNewObj("export.hero.Role" + param1) as BaseHero;
            this.gc.hero2.x = 400;
            this.gc.hero2.y = 100;
            this.gc.hero2.name = "2";
            this.gc.hero2.setPlayer(this.gc.player2);
            this.gc.player2.roleid = param1;
         }
      }
   }
}
