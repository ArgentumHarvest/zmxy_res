package export
{
   import config.Config;
   import event.CommonEvent;
   import export.level.StageListener253;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class ThirdWorldSelectPlace extends Sprite
   {
       
      
      private var gc:Config;
      
      private var stageAry:Array;
      
      public var s24_1:MovieClip;
      
      public var s24_2:MovieClip;
      
      public var s24_3:MovieClip;
      
      public var s25_1:MovieClip;
      
      public var s25_2:MovieClip;
      
      public var s25_3:MovieClip;
      
      public var s26_1:MovieClip;
      
      private var cbs:int;
      
      private var cbl:int;
      
      public function ThirdWorldSelectPlace()
      {
         stageAry = [3,3,3,3];
         super();
         gc = Config.getInstance();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
         this.init();
      }
      
      private function init() : void
      {
         this.s24_1.buttonMode = true;
         this.s24_2.buttonMode = true;
         this.s24_3.buttonMode = true;
         this.s25_1.buttonMode = true;
         this.s25_2.buttonMode = true;
         this.s25_3.buttonMode = true;
         this.s26_1.buttonMode = true;
      }
      
      private function added(e:Event) : void
      {
         var i:* = 0;
         var k:* = 0;
         var j:* = 0;
         i = 0;
         var dio:* = null;
         gc.isintheselectmap = true;
         if(!gc.isHideDebug)
         {
            gc.curBigStage = 26;
            gc.curBigLevel = 1;
         }
         cbs = gc.curBigStage;
         cbl = gc.curBigLevel;
         if(cbs < 24)
         {
            gc.curBigStage = 24;
            gc.curBigLevel = 1;
            cbs = 24;
            cbl = 1;
         }
         for(i = uint(24); i <= cbs; )
         {
            k = uint(this.stageAry[i - 24]);
            if(i == cbs)
            {
               k = uint(cbl);
            }
            for(j = uint(0); j < k; )
            {
               this["s" + i + "_" + (j + 1)].addEventListener("rollOver",mOver);
               this["s" + i + "_" + (j + 1)].addEventListener("rollOut",mOut);
               this["s" + i + "_" + (j + 1)].addEventListener("click",onSelected);
               j++;
            }
            i++;
         }
         if(this["s" + cbs + "_" + cbl])
         {
            this["s" + cbs + "_" + cbl].gotoAndStop(2);
         }
         for(i = uint(0); i < this.numChildren; )
         {
            dio = this.getChildAt(i);
            if(dio is MapMenu)
            {
               this.removeChild(dio);
            }
            i++;
         }
         var menu:MapMenu = new MapMenu();
         menu.x = -1;
         menu.y = 0;
         this.addChild(menu);
         menu.hideSomeBtn();
         gc.eventManger.addEventListener("ShowOtherScene",showOtherScene);
         gc.eventManger.addEventListener("ChanllengeBossInster",chanllenge);
      }
      
      private function mOver(e:MouseEvent) : void
      {
         e.currentTarget.gotoAndStop(3);
      }
      
      private function mOut(e:MouseEvent) : void
      {
         if(e.currentTarget != this["s" + cbs + "_" + cbl])
         {
            e.currentTarget.gotoAndStop(1);
         }
         else
         {
            e.currentTarget.gotoAndStop(2);
         }
      }
      
      private function onSelected(e:MouseEvent) : void
      {
         gc.curStageAndCurLevel.curStage = int(String(e.currentTarget.name).substr(1,2));
         gc.curStageAndCurLevel.curLevel = int(String(e.currentTarget.name).substr(4,1));
         if(gc.curStageAndCurLevel.curStage == 25 && gc.curStageAndCurLevel.curLevel == 3)
         {
            StageListener253.curType1 = 0;
            StageListener253.curType2 = 0;
            StageListener253.curType3 = 0;
         }
         gc.eventManger.dispatchEvent(new CommonEvent("selectStageOver"));
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function removed(e:Event) : void
      {
         gc.isintheselectmap = false;
         this.s24_1.removeEventListener("rollOver",mOver);
         this.s24_1.removeEventListener("rollOut",mOut);
         this.s24_1.removeEventListener("click",onSelected);
         this.s24_2.removeEventListener("rollOver",mOver);
         this.s24_2.removeEventListener("rollOut",mOut);
         this.s24_2.removeEventListener("click",onSelected);
         this.s24_3.removeEventListener("rollOver",mOver);
         this.s24_3.removeEventListener("rollOut",mOut);
         this.s24_3.removeEventListener("click",onSelected);
         this.s25_1.removeEventListener("rollOver",mOver);
         this.s25_1.removeEventListener("rollOut",mOut);
         this.s25_1.removeEventListener("click",onSelected);
         this.s25_2.removeEventListener("rollOver",mOver);
         this.s25_2.removeEventListener("rollOut",mOut);
         this.s25_2.removeEventListener("click",onSelected);
         this.s25_3.removeEventListener("rollOver",mOver);
         this.s25_3.removeEventListener("rollOut",mOut);
         this.s25_3.removeEventListener("click",onSelected);
         this.s26_1.removeEventListener("rollOver",mOver);
         this.s26_1.removeEventListener("rollOut",mOut);
         this.s26_1.removeEventListener("click",onSelected);
         gc.eventManger.removeEventListener("ShowOtherScene",showOtherScene);
         gc.eventManger.removeEventListener("ChanllengeBossInster",chanllenge);
      }
      
      private function showOtherScene(e:CommonEvent) : void
      {
         trace("remove--newworld-selectplace");
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function chanllenge(e:CommonEvent) : void
      {
         gc.eventManger.dispatchEvent(new CommonEvent("selectStageOver"));
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
