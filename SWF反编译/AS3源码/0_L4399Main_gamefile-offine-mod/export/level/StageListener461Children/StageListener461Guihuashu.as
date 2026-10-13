package export.level.StageListener461Children
{
   import base.BaseBullet;
   import base.BaseMonster;
   import config.Config;
   import export.level.StageListener461;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import my.HitTest;
   
   public class StageListener461Guihuashu extends Sprite
   {
       
      
      private var fatherCount:uint = 0;
      
      private var maxDrop:uint = 20;
      
      private var gc:Config;
      
      public function StageListener461Guihuashu()
      {
         super();
         gc = Config.getInstance();
         this.init();
      }
      
      private function init() : void
      {
         this.graphics.beginFill(16711680,0);
         this.graphics.drawRect(0,0,60,120);
         this.graphics.endFill();
      }
      
      private function show() : void
      {
         if(this.maxDrop > 0)
         {
            if(gc.pWorld.getBaseLevelListener() is StageListener461)
            {
               (gc.pWorld.getBaseLevelListener() as StageListener461).fallGuihua();
            }
            this.maxDrop--;
         }
      }
      
      public function step() : void
      {
         var img:* = null;
         if(this.fatherCount > 0)
         {
            this.fatherCount--;
         }
         var monsterArray:Array = gc.pWorld.monsterArray;
         for each(var bm in monsterArray)
         {
            for each(var bb in bm.magicBulletArray)
            {
               if(!bb.isDisabled)
               {
                  if(HitTest.complexHitTestObject(this,bb))
                  {
                     if(this.fatherCount == 0)
                     {
                        this.fatherCount = 24;
                        img = AUtils.getNewObj("HeroBeHurt");
                        img.x = 47;
                        img.y = 85;
                        this.addChild(img);
                        this.show();
                     }
                  }
               }
            }
         }
      }
   }
}
