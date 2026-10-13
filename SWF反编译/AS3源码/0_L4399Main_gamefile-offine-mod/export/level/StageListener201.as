package export.level
{
   import base.BaseHero;
   import base.BaseLevelListenering;
   import com.greensock.TweenMax;
   import export.level.StageListener201Children.StageListener201jiguan;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import my.MainGame;
   
   public class StageListener201 extends BaseLevelListenering
   {
       
      
      private var jiguanPointArray:Array;
      
      private var jiguanArray:Array;
      
      public function StageListener201()
      {
         jiguanPointArray = [[118.5,104.5],[704.65,101.55],[2625.65,100]];
         jiguanArray = [];
         super();
         waitForRegisterDataArray = ["Monster110","Monster111","Monster113","Monster112"];
      }
      
      override public function step() : void
      {
         super.step();
         if(this.jiguanArray.length > 0)
         {
            var flag:Boolean = true;
            for each(jiguan in this.jiguanArray)
            {
               jiguan.step();
               if(jiguan.state == 0)
               {
                  flag = false;
               }
            }
            if(flag == true)
            {
               this.jiguanArray.length = 0;
               var mc:MovieClip = AUtils.getNewObj("Monster127Bullet3") as MovieClip;
               mc.x = 500;
               mc.y = 150;
               gc.bg1.addChild(mc);
               var g:Point = gc.bg1.localToGlobal(new Point(500,150));
               var p:Point = gc.gameSence.globalToLocal(g);
               for each(bh in gc.getPlayerArray())
               {
                  TweenMax.to(bh,1,{
                     "x":p.x,
                     "y":p.y,
                     "onComplete":function():*
                     {
                        MainGame.getInstance().fbEnter();
                     }
                  });
               }
            }
         }
      }
      
      override public function start() : void
      {
         var jiguan:* = null;
         for each(var p in this.jiguanPointArray)
         {
            jiguan = new StageListener201jiguan();
            jiguan.x = p[0];
            jiguan.y = p[1];
            gc.gameSence.addChild(jiguan);
            this.jiguanArray.push(jiguan);
         }
         super.start();
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}
