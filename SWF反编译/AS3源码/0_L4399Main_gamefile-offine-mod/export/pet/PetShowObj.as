package export.pet
{
   import config.Config;
   import flash.display.Bitmap;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import my.PetEquipObj;
   
   public class PetShowObj extends Sprite
   {
       
      
      private var tubiao:Bitmap;
      
      private var petEquipObj:PetEquipObj;
      
      private var mianban:PetEquipAttribute;
      
      private var gc:Config;
      
      public function PetShowObj(obj:PetEquipObj)
      {
         super();
         gc = Config.getInstance();
         this.name = "curzb";
         petEquipObj = obj;
         tubiao = AUtils.getImageObj(petEquipObj.getFillName());
         addChild(tubiao);
         this.buttonMode = true;
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         this.addEventListener("rollOver",showattribute);
         this.addEventListener("rollOut",removeattribute);
      }
      
      private function removed(e:Event) : void
      {
         this.removeEventListener("rollOver",showattribute);
         this.removeEventListener("rollOut",removeattribute);
         this.pulbiremoved();
      }
      
      private function showattribute(e:*) : void
      {
         var mousePoint:Point = this.parent.localToGlobal(new Point(this.x,this.y));
         mianban = new PetEquipAttribute(this.petEquipObj);
         var p:Point = this.localToGlobal(new Point(tubiao.x,tubiao.y));
         mianban.x = p.x + tubiao.width + 5;
         mianban.y = 590 - mianban.height > mousePoint.y ? mousePoint.y : 590 - mianban.height;
         var dio:DisplayObjectContainer = this.parent;
         while(!(dio is PetInterface))
         {
            dio = dio.parent;
         }
         dio.addChild(mianban);
      }
      
      public function removemouselisten() : void
      {
         this.removeEventListener("rollOver",showattribute);
         this.removeEventListener("rollOut",removeattribute);
      }
      
      private function removeattribute(e:*) : void
      {
         this.pulbiremoved();
      }
      
      public function pulbiremoved() : void
      {
         var dio:DisplayObjectContainer = this.parent;
         while(!(dio is PetInterface))
         {
            dio = dio.parent;
         }
         if(mianban && dio.contains(mianban))
         {
            dio.removeChild(mianban);
            mianban = null;
         }
      }
      
      public function getPetEquipObj() : PetEquipObj
      {
         return this.petEquipObj;
      }
      
      public function setMyEquipObj(newEquip:PetEquipObj) : void
      {
         this.petEquipObj = newEquip;
      }
      
      public function getmianban() : PetEquipAttribute
      {
         return this.mianban;
      }
   }
}
