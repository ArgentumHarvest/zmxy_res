package export.pack
{
   import config.Config;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import my.MyEquipObj;
   import user.User;
   
   public class PackThings extends Sprite
   {
       
      
      private var gc:Config;
      
      private var sobj:ShowObj;
      
      private var who:uint;
      
      private var threebtn:Sprite;
      
      public function PackThings()
      {
         super();
         this.gc = Config.getInstance();
         this.addEventListener(Event.ADDED_TO_STAGE,this.added,false,0,true);
         this.addEventListener(Event.REMOVED_FROM_STAGE,this.removed,false,0,true);
      }
      
      private function added(param1:*) : void
      {
         this.addEventListener(MouseEvent.ROLL_OUT,this.outHandle);
         this.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function removed(param1:*) : void
      {
         this.addEventListener(MouseEvent.ROLL_OUT,this.outHandle);
         this.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function outHandle(param1:*) : void
      {
         this.removeThreebtn();
      }
      
      private function onClick(param1:*) : void
      {
         if(this.sobj != null)
         {
            this.sobj.pulbiremoved();
         }
      }
      
      public function setObj(param1:*, param2:uint) : void
      {
         if(param1 != null)
         {
            this.sobj = new ShowObj(param1);
            this.sobj.y = -2;
            this.addChild(this.sobj);
            this.who = param2;
            this.sobj.addEventListener(MouseEvent.CLICK,this.clickHandler);
         }
      }
      
      public function removeSobj() : void
      {
         this.sobj.removeEventListener(MouseEvent.CLICK,this.clickHandler);
         this.removeChild(this.sobj);
         var _loc1_:MyEquipObj = this.sobj.getMyEquipObj();
         var _loc2_:int = this.gc["player" + this.who].zblist.indexOf(_loc1_);
         this.gc["player" + this.who].zblist.splice(_loc2_,1);
         _loc1_ = null;
         this.sobj = null;
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         if(this.sobj && contains(this.sobj))
         {
            this.removeThreebtn();
            this.threebtn = AUtils.getNewObj("threebtn");
            this.threebtn.x = 25;
            this.threebtn.y = 25;
            this.addChild(this.threebtn);
            this.threebtn["bzb"].addEventListener(MouseEvent.CLICK,this.zbClick);
            this.threebtn["bgy"].addEventListener(MouseEvent.CLICK,this.gyClick);
            this.threebtn["bmd"].addEventListener(MouseEvent.CLICK,this.mdClick);
            if(this.gc.playNum == 1)
            {
               this.threebtn["bgy"].gotoAndStop(2);
               this.threebtn["bgy"].removeEventListener(MouseEvent.CLICK,this.gyClick);
            }
            if(this.sobj.getMyEquipObj().user != "")
            {
               if(this.gc["hero" + this.who].userType != this.sobj.getMyEquipObj().user)
               {
                  this.threebtn["bzb"].gotoAndStop(2);
                  this.threebtn["bzb"].removeEventListener(MouseEvent.CLICK,this.zbClick);
               }
            }
         }
      }
      
      private function zbClick(param1:MouseEvent) : *
      {
         this.usezb();
         this.removeThreebtn();
      }
      
      private function gyClick(param1:MouseEvent) : *
      {
         if(this.who == 1)
         {
            this.gc.player2.zblist.push(this.sobj.getMyEquipObj());
         }
         else if(this.who == 2)
         {
            this.gc.player1.zblist.push(this.sobj.getMyEquipObj());
         }
         this.removeThreebtn();
         this.removeSobj();
      }
      
      private function mdClick(param1:MouseEvent) : *
      {
         if(this.parent.parent is BackPack)
         {
            User(this.gc["player" + this.who]).protectedObject = AUtils.clone(User(this.gc["player" + this.who]).protectedObject);
            User(this.gc["player" + this.who]).protectedObject.lhValue = User(this.gc["player" + this.who]).protectedObject.lhValue + this.sobj.getMyEquipObj().value;
            User(this.gc["player" + this.who]).protectedObject.myscore = User(this.gc["player" + this.who]).protectedObject.myscore + this.sobj.getMyEquipObj().value;
            BackPack(this.parent.parent).setInfoTxt();
         }
         this.removeThreebtn();
         this.removeSobj();
      }
      
      public function removeThreebtn() : void
      {
         if(this.threebtn && contains(this.threebtn))
         {
            this.threebtn["bzb"].removeEventListener(MouseEvent.CLICK,this.zbClick);
            this.threebtn["bgy"].removeEventListener(MouseEvent.CLICK,this.gyClick);
            this.threebtn["bmd"].removeEventListener(MouseEvent.CLICK,this.mdClick);
            this.removeChild(this.threebtn);
            this.threebtn = null;
         }
      }
      
      private function usezb() : void
      {
         var _loc1_:MyEquipObj = null;
         if(this.parent.parent is BackPack)
         {
            _loc1_ = this.sobj.getMyEquipObj();
            this.removeSobj();
            BackPack(this.parent.parent).equip(_loc1_.type,_loc1_);
         }
      }
   }
}
