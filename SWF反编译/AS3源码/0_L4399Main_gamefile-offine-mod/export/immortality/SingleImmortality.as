package export.immortality
{
   import config.Config;
   import event.CommonEvent;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import user.User;
   
   public class SingleImmortality extends Sprite
   {
       
      
      private var gc:Config;
      
      public var eatbtn:SimpleButton;
      
      private var player:User;
      
      private var imid:uint;
      
      private var immname:String = "";
      
      public function SingleImmortality()
      {
         super();
         gc = Config.getInstance();
         this.setBtnVisible(false);
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         eatbtn.addEventListener("click",eatClick);
      }
      
      private function removed(e:Event) : void
      {
         eatbtn.removeEventListener("click",eatClick);
      }
      
      public function setUser(_player:User) : void
      {
         this.player = _player;
      }
      
      private function eatClick(e:MouseEvent) : void
      {
         this.setBtnVisible(false);
         if(this.player)
         {
            this.player.immortalitylist[this.imid - 1].usenum += 1;
            this.player.removeSomeOneDJByFillName(this.immname + this.imid);
            ImmortalityInterface(this.parent).refreshInterface();
            gc.eventManger.dispatchEvent(new CommonEvent("RefreshPill"));
         }
      }
      
      public function setImmortalityId(id:uint, fname:String) : void
      {
         this.imid = id;
         this.immname = fname;
      }
      
      public function setBtnVisible(_visible:Boolean) : void
      {
         this.eatbtn.visible = _visible;
      }
      
      public function setImage(iname:String) : void
      {
         var img:* = undefined;
         if(this.getChildByName("showhaseatimmortality") == null)
         {
            img = AUtils.getImageObj(iname);
            img.name = "showhaseatimmortality";
            img.x = 2;
            img.y = 2;
            this.addChild(img);
         }
      }
      
      public function setUnUseable() : void
      {
         this.setBtnVisible(false);
      }
   }
}
