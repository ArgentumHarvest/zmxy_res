package export.pack
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import loader.PlayerAssetsLoaderManager;
   
   public class HeadSprite extends Sprite
   {
      
      public static var HEAD_ROLE_1:uint = 1;
      
      public static var HEAD_ROLE_2:uint = 2;
      
      public static var HEAD_ROLE_3:uint = 3;
      
      public static var HEAD_ROLE_4:uint = 4;
       
      
      private var bbdc:BaseBitmapDataClip;
      
      private var type:uint;
      
      private var clothId:uint;
      
      private var weaponId:uint;
      
      private var txname:String;
      
      private var equipLoadingMc:MovieClip;
      
      public function HeadSprite(type:uint, clothId:uint, weaponId:uint, txname:String = "")
      {
         super();
         this.type = type;
         this.clothId = clothId;
         this.weaponId = weaponId;
         this.txname = txname;
         this.initBBC(clothId,weaponId,txname);
         this.addEventListener("enterFrame",__enterFrame);
      }
      
      private function initBBC(clothId:uint, weaponId:uint, txname:String = "") : void
      {
         var bmdArray:* = null;
         var equipName:* = null;
         var weaponName:* = null;
         var body:* = null;
         var equip:* = null;
         var img:* = undefined;
         if(type == 4)
         {
            if(!(weaponId == 4 || weaponId == 5 || weaponId == 7 || weaponId == 8 || weaponId == 9))
            {
               equipName = "ROLE4_SHOVEL_" + clothId;
               bmdArray = BaseBitmapDataPool.getBitmapDataArrayByName(equipName);
            }
            else
            {
               equipName = "ROLE4_ARROW_" + clothId;
               bmdArray = BaseBitmapDataPool.getBitmapDataArrayByName(equipName);
            }
         }
         else
         {
            equipName = "ROLE" + type + "_" + clothId;
            bmdArray = BaseBitmapDataPool.getBitmapDataArrayByName("ROLE" + type + "_" + clothId);
         }
         weaponName = "ROLE" + type + "_EQUIP_" + weaponId;
         var eqArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName(weaponName);
         var assetsArray:Array = [];
         if(!bmdArray)
         {
            this.addEquipLoading();
            PlayerAssetsLoaderManager.getInstance().addSingle(equipName + ".swf",assetsLoadComplete);
         }
         else
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            assetsArray.push(body);
         }
         if(!eqArray)
         {
            this.addEquipLoading();
            PlayerAssetsLoaderManager.getInstance().addSingle(weaponName + ".swf",assetsLoadComplete);
         }
         else
         {
            equip = {
               "name":"equip",
               "source":eqArray
            };
            assetsArray.push(equip);
         }
         if(assetsArray.length > 0)
         {
            if(type == 3)
            {
               bbdc = new BaseBitmapDataClip(assetsArray,300,200,new Point(0,0));
            }
            else
            {
               bbdc = new BaseBitmapDataClip(assetsArray,200,200,new Point(0,0));
            }
            if(type == 2)
            {
               bbdc.setOffsetXY(0,0);
            }
            else if(type == 3)
            {
               bbdc.setOffsetXY(-20,0);
            }
            else
            {
               bbdc.setOffsetXY(-10,-15);
            }
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[5,5]]);
            bbdc.setFrameCount([36,8]);
         }
         if(this.bbdc)
         {
            this.addChild(this.bbdc);
            this.bbdc.setState("wait");
         }
         try
         {
            if(this.getChildByName("Role_Title") != null)
            {
               this.removeChild(this.getChildByName("Role_Title"));
            }
            if(txname != "")
            {
               img = AUtils.getImageObj("role_title_" + txname);
               img.x = -38;
               img.y = -66;
               img.name = "Role_Title";
               this.addChild(img);
            }
         }
         catch(e:*)
         {
            trace("add tx image error");
         }
      }
      
      private function assetsLoadComplete() : void
      {
         this.refreshEquip(this.clothId,this.weaponId,this.txname);
         this.removeEquipLoading();
      }
      
      private function addEquipLoading() : void
      {
         if(!this.equipLoadingMc)
         {
            this.equipLoadingMc = AUtils.getNewObj("EquipLoading") as MovieClip;
            this.addChild(this.equipLoadingMc);
         }
      }
      
      private function removeEquipLoading() : void
      {
         if(this.equipLoadingMc)
         {
            if(this.contains(this.equipLoadingMc))
            {
               this.removeChild(this.equipLoadingMc);
            }
            this.equipLoadingMc = null;
         }
      }
      
      public function refreshEquip(clothId:uint, weaponId:uint, txname:String = "") : void
      {
         this.clothId = clothId;
         this.weaponId = weaponId;
         this.txname = txname;
         if(this.bbdc)
         {
            this.bbdc.destroy();
         }
         this.initBBC(clothId,weaponId,txname);
      }
      
      private function __enterFrame(evt:Event) : void
      {
         if(this.bbdc)
         {
            this.bbdc.step();
         }
      }
      
      public function destroy() : void
      {
         this.removeEquipLoading();
         if(this.bbdc)
         {
            this.bbdc.destroy();
         }
         this.removeEventListener("enterFrame",__enterFrame);
      }
   }
}
