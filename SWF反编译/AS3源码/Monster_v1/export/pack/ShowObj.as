package export.pack
{
   import config.Config;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import my.MyEquipObj;
   
   public class ShowObj extends Sprite
   {
       
      
      private var tubiao;
      
      private var myEquipObj:MyEquipObj;
      
      private var mianban:AttributeCon;
      
      private var gc:Config;
      
      public function ShowObj(param1:*)
      {
         super();
         this.gc = Config.getInstance();
         this.name = "curzb";
         this.myEquipObj = param1;
         this.tubiao = AUtils.getImageObj(this.myEquipObj.fillName);
         addChild(this.tubiao);
         this.buttonMode = true;
         this.addEventListener(Event.ADDED_TO_STAGE,this.added,false,0,true);
         this.addEventListener(Event.REMOVED_FROM_STAGE,this.removed,false,0,true);
      }
      
      private function added(param1:*) : void
      {
         this.addEventListener(MouseEvent.ROLL_OVER,this.showattribute);
         this.addEventListener(MouseEvent.ROLL_OUT,this.removeattribute);
      }
      
      private function removed(param1:*) : void
      {
         this.removeEventListener(MouseEvent.ROLL_OVER,this.showattribute);
         this.removeEventListener(MouseEvent.ROLL_OUT,this.removeattribute);
      }
      
      private function showattribute(param1:*) : void
      {
         this.mianban = new AttributeCon(this.myEquipObj);
         this.mianban.x = 25;
         this.mianban.y = 30;
         addChild(this.mianban);
      }
      
      private function removeattribute(param1:*) : void
      {
         this.pulbiremoved();
      }
      
      public function pulbiremoved() : void
      {
         if(this.mianban && contains(this.mianban))
         {
            removeChild(this.mianban);
            this.mianban = null;
         }
      }
      
      public function getMyEquipObj() : MyEquipObj
      {
         return this.myEquipObj;
      }
      
      public function getmianban() : AttributeCon
      {
         return this.mianban;
      }
   }
}
