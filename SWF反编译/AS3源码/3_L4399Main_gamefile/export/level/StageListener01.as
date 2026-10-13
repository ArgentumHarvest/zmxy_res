package export.level
{
   import base.BaseMutiLevelListenering;
   import export.level.StageListener461Children.StageListener461Guihua;
   import flash.display.MovieClip;
   import my.ChatInFb;
   
   public class StageListener01 extends BaseMutiLevelListenering
   {
       
      
      private var rwDoor:MovieClip;
      
      private var pkDoor:MovieClip;
      
      private var guihuaArray:Array;
      
      public function StageListener01()
      {
         guihuaArray = [];
         waitForRegisterDataArray = ["Monster2001"];
         super();
      }
      
      override public function start() : void
      {
         super.start();
         ChatInFb.getIns().init();
      }
      
      public function loadGameSenceSource() : void
      {
         var i:* = 0;
         var obj:* = null;
         var len:uint = gc.gameSence.numChildren;
         for(i = uint(0); i < len; )
         {
            obj = gc.gameSence.getChildAt(i);
            if(obj is MovieClip)
            {
               if(MovieClip(obj).name == "rwDoor")
               {
                  this.rwDoor = obj as MovieClip;
                  this.rwDoor.buttonMode = true;
                  this.rwDoor.tabEnabled = false;
               }
               else if(MovieClip(obj).name == "pkDoor")
               {
                  this.pkDoor = obj as MovieClip;
                  this.pkDoor.buttonMode = true;
                  this.pkDoor.tabEnabled = false;
               }
            }
            i++;
         }
      }
      
      public function checkRwOrPk() : void
      {
      }
      
      override public function step() : void
      {
         var idx:int = 0;
         super.step();
         var temp:Array = [];
         for each(var gh in this.guihuaArray)
         {
            if(!gh.isDestroy)
            {
               gh.step();
               if(gh.y > 465)
               {
                  gh.y = 465;
               }
            }
            if(gh.isDestroy)
            {
               temp.push(gh);
            }
         }
         for each(gh in temp)
         {
            idx = this.guihuaArray.indexOf(gh);
            if(idx != -1)
            {
               this.guihuaArray.splice(idx,1);
            }
         }
      }
      
      public function fallGuihua(xx:Number, yy:Number) : void
      {
         if(xx < 100)
         {
            xx = 100;
         }
         else if(xx > 800)
         {
            xx = 800;
         }
         var guihua:StageListener461Guihua = new StageListener461Guihua();
         guihua.x = xx;
         guihua.y = yy - 100;
         gc.gameSence.addChild(guihua);
         this.guihuaArray.push(guihua);
      }
      
      override public function destroy() : void
      {
         super.destroy();
         for each(var gh in this.guihuaArray)
         {
            gh.destroy();
         }
         this.guihuaArray.length = 0;
      }
   }
}
