package export.level
{
   import base.BaseBullet;
   import base.BaseHero;
   import base.BaseLevelListenering;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import my.HitTest;
   import my.MainGame;
   
   public class StageListener231 extends BaseLevelListenering
   {
       
      
      private var door:Sprite;
      
      private var hitCount:int = 4;
      
      private var hitInterval:int = 12;
      
      private var doorPoint:Point;
      
      public function StageListener231()
      {
         super();
         waitForRegisterDataArray = ["Monster186"];
      }
      
      override public function step() : void
      {
         var img:* = null;
         super.step();
         if(this.door)
         {
            if(hitInterval == 0)
            {
               for each(var bh in gc.getPlayerArray())
               {
                  for each(var bb in bh.magicBulletArray)
                  {
                     if(!bb.isDisabled)
                     {
                        if(HitTest.complexHitTestObject(bb,this.door))
                        {
                           img = AUtils.getNewObj("HeroBeHurt");
                           img.x = 0;
                           img.y = 0;
                           this.door.addChild(img);
                           hitInterval = 12;
                           if(hitCount > 0)
                           {
                              hitCount--;
                              if(hitCount == 0)
                              {
                                 this.destroyDoor();
                              }
                           }
                        }
                     }
                  }
               }
            }
            else
            {
               hitInterval--;
            }
         }
         else if(this.doorPoint)
         {
            for each(bh in gc.getPlayerArray())
            {
               if(AUtils.GetDisBetweenTwoObj(bh,this.doorPoint) <= 50)
               {
                  MainGame.getInstance().fbEnter();
                  return;
               }
            }
         }
      }
      
      private function destroyDoor() : void
      {
         if(this.door)
         {
            if(this.door.parent)
            {
               this.door.parent.removeChild(door);
            }
            this.door = null;
         }
      }
      
      override public function start() : void
      {
         super.start();
         var data:Bitmap = new Bitmap(AUtils.getNewObj("bg231door") as BitmapData);
         this.door = new Sprite();
         data.x = -data.width / 2;
         data.y = -data.height / 2;
         this.door.addChild(data);
         this.door.x = 2420 - data.x;
         this.door.y = 304 - data.y;
         gc.gameSence.bgContainer.addChildAt(this.door,0);
         this.doorPoint = new Point(this.door.x,this.door.y);
      }
      
      override public function destroy() : void
      {
         if(this.door)
         {
            if(this.door.parent)
            {
               this.door.parent.removeChild(door);
            }
            this.door = null;
         }
         super.destroy();
      }
   }
}
