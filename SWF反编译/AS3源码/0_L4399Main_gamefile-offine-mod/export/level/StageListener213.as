package export.level
{
   import base.BaseLevelListenering;
   import export.level.StageListener213Children.StageListener213jiguan;
   import export.level.StageListener213Children.StageListener213stone;
   
   public class StageListener213 extends BaseLevelListenering
   {
       
      
      private var lightPointArray:Array;
      
      private var jiguanArray:Array;
      
      private var stone:StageListener213stone;
      
      public function StageListener213()
      {
         lightPointArray = [[1844,250],[2582,250],[3350,250],[4260,250]];
         jiguanArray = [];
         super();
         waitForRegisterDataArray = ["Monster119","Monster126","Monster125"];
      }
      
      override public function step() : void
      {
         var flag:Boolean = false;
         super.step();
         if(this.jiguanArray.length > 0)
         {
            flag = true;
            for each(var jiguan in this.jiguanArray)
            {
               jiguan.step();
               if(jiguan.state == 0)
               {
                  flag = false;
               }
            }
            if(!this.stone)
            {
               if(flag == true)
               {
                  this.stone = new StageListener213stone();
                  this.stone.x = 3852;
                  this.stone.y = 85;
                  gc.gameSence.addChild(this.stone);
               }
            }
         }
         if(this.stone)
         {
            this.stone.step();
         }
      }
      
      override public function start() : void
      {
         var jiguan:* = null;
         for each(var p in this.lightPointArray)
         {
            jiguan = new StageListener213jiguan();
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
