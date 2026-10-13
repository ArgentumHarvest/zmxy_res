package export.pack
{
   import config.Config;
   import export.huodong.mysterious.DragonSingleShop;
   import export.microshop.Micropayment;
   import export.rank.RankTopInterface;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.geom.Point;
   import my.MyEquipObj;
   
   public class ShowObj extends Sprite
   {
       
      
      private var tubiao;
      
      private var myEquipObj:MyEquipObj;
      
      private var mianban:AttributeCon;
      
      private var gc:Config;
      
      public function ShowObj(obj:MyEquipObj)
      {
         super();
         gc = Config.getInstance();
         this.name = "curzb";
         myEquipObj = obj;
         tubiao = AUtils.getImageObj(myEquipObj.getFillName());
         addChild(tubiao);
         this.buttonMode = true;
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:*) : void
      {
         this.addEventListener("rollOver",showattribute);
         this.addEventListener("rollOut",removeattribute);
         if(this.parent)
         {
            if(this.parent.parent)
            {
               if(this.parent.parent.parent)
               {
                  if(this.parent.parent.parent is Micropayment)
                  {
                     if(this.myEquipObj.type == "zbsz")
                     {
                        this.removeEventListener("rollOver",showattribute);
                        this.removeEventListener("rollOut",removeattribute);
                     }
                  }
               }
            }
         }
         if(this.parent)
         {
            if(this.parent.parent)
            {
               if(this.parent.parent is DragonSingleShop)
               {
                  if(this.myEquipObj.type == "zbfb")
                  {
                     this.removeEventListener("rollOver",showattribute);
                     this.removeEventListener("rollOut",removeattribute);
                  }
               }
            }
         }
      }
      
      private function removed(e:*) : void
      {
         this.removeEventListener("rollOver",showattribute);
         this.removeEventListener("rollOut",removeattribute);
         this.pulbiremoved();
      }
      
      private function showattribute(e:*) : void
      {
         var dio:DisplayObjectContainer = this.parent;
         while(dio && !(dio is RankTopInterface))
         {
            dio = dio.parent;
         }
         var mousePoint:Point = this.parent.localToGlobal(new Point(this.x,this.y));
         if(dio)
         {
            mianban = new AttributeCon(this.myEquipObj);
            mianban.x = mousePoint.x + 60;
            mianban.y = 590 - mianban.height > mousePoint.y ? mousePoint.y : 590 - mianban.height;
            dio.addChild(mianban);
         }
         else
         {
            mianban = new AttributeCon(this.myEquipObj);
            mianban.x = mousePoint.x + 50;
            mianban.y = 590 - mianban.height > mousePoint.y ? mousePoint.y : 590 - mianban.height;
            dio = this.parent;
            while(!(dio is Stage))
            {
               dio = dio.parent;
            }
            dio.addChild(mianban);
            if(this.parent is PackThings)
            {
               PackThings(this.parent).setTxtVisible(false);
            }
         }
      }
      
      public function removemouselisten() : void
      {
         this.removeEventListener("rollOver",showattribute);
         this.removeEventListener("rollOut",removeattribute);
      }
      
      private function removeattribute(e:*) : void
      {
         this.pulbiremoved();
         if(this.parent is PackThings)
         {
            PackThings(this.parent).setTxtVisible(true);
         }
      }
      
      public function pulbiremoved() : void
      {
         if(mianban && mianban.parent)
         {
            mianban.parent.removeChild(mianban);
            mianban = null;
         }
      }
      
      public function getMyEquipObj() : MyEquipObj
      {
         return this.myEquipObj;
      }
      
      public function setMyEquipObj(newEquip:MyEquipObj) : void
      {
         this.myEquipObj = newEquip;
      }
      
      public function getmianban() : AttributeCon
      {
         return this.mianban;
      }
   }
}
