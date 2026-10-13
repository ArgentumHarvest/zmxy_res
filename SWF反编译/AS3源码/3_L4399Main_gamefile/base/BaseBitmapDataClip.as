package base
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class BaseBitmapDataClip extends Sprite
   {
       
      
      protected var frameStopCount:Array;
      
      protected var frameCount:Array;
      
      protected var frameCountMaxLen:uint;
      
      protected var curFrameStopCount:int;
      
      protected var curPoint:Point;
      
      protected var curKeyFrameIndex:uint = 0;
      
      protected var enterFrameFunc:Function;
      
      protected var exitFrameFunc:Function;
      
      protected var addFrameScriptWhenFrameOver:Function;
      
      protected var bm:Bitmap;
      
      protected var bmWidth:int;
      
      protected var bmHeight:int;
      
      protected var offsetX:int;
      
      protected var offsetY:int;
      
      protected var state:String = "wait";
      
      public var isStopFrame:Boolean = false;
      
      protected var bmdArray:Array;
      
      private var direct:int = 0;
      
      public var bmSprite:Sprite;
      
      public function BaseBitmapDataClip(_bmdArray:Array, _w:int, _h:int, _startPoint:Point)
      {
         frameStopCount = [[4,4,4,4],[4,4,4,4],[4,4,4,4],[4,4,4,4],[4,4,4,4],[4,4,4,4],[4,4,4,4],[4,4,4,4]];
         frameCount = [4,6,6,6,6,6,6,6];
         bmdArray = [];
         bmSprite = new Sprite();
         super();
         this.curPoint = _startPoint;
         this.bmWidth = _w;
         this.bmHeight = _h;
         this.bmdArray = _bmdArray;
         this.addChild(bmSprite);
      }
      
      protected function frameShow() : void
      {
         this.curFrameStopCount = this.frameStopCount[this.curPoint.y][this.curPoint.x];
         this.refreshCurFrame();
      }
      
      protected function refreshCurFrame() : void
      {
         var bm:* = null;
         var j:* = 0;
         for(j = uint(0); j < this.bmSprite.numChildren; )
         {
            bm = this.bmSprite.getChildAt(0) as Bitmap;
            bm.bitmapData.dispose();
            this.bmSprite.removeChild(bm);
            j++;
         }
         bm = new Bitmap(this.getCurFrameBitmapData());
         this.bmSprite.addChild(bm);
      }
      
      protected function getCurFrameBitmapData() : BitmapData
      {
         var i:* = 0;
         var obj:* = null;
         var arr:* = null;
         var tempLeft:* = null;
         var tempRight:* = null;
         var leftBmdArray:* = null;
         var rightBmdArray:* = null;
         var bmd:BitmapData = new BitmapData(this.bmWidth,this.bmHeight,true,16711680);
         for(i = uint(0); i < this.bmdArray.length; )
         {
            obj = this.bmdArray[i] as Object;
            if(obj)
            {
               arr = obj.source as Array;
               if(arr.length == 2)
               {
                  if(arr[0] is BitmapData)
                  {
                     tempLeft = arr[0] as BitmapData;
                     tempRight = arr[1] as BitmapData;
                     this.frameCountMaxLen = tempLeft.width / this.bmWidth;
                     if(this.curPoint.x <= this.frameCountMaxLen - 1)
                     {
                        if(this.direct == 1)
                        {
                           bmd.copyPixels(tempRight,new Rectangle(this.bmWidth * (frameCountMaxLen - (this.curPoint.x + 1)),this.bmHeight * this.curPoint.y,this.bmWidth,this.bmHeight),new Point(0,0),null,null,true);
                        }
                        else
                        {
                           bmd.copyPixels(tempLeft,new Rectangle(this.bmWidth * this.curPoint.x,this.bmHeight * this.curPoint.y,this.bmWidth,this.bmHeight),new Point(0,0),null,null,true);
                        }
                     }
                  }
                  else if(arr[0] is Array)
                  {
                     leftBmdArray = arr[0] as Array;
                     rightBmdArray = arr[1] as Array;
                     tempLeft = leftBmdArray[this.curPoint.y][this.curPoint.x];
                     tempRight = rightBmdArray[this.curPoint.y][this.curPoint.x];
                     if(tempLeft && tempRight)
                     {
                        if(this.direct == 1)
                        {
                           bmd.copyPixels(tempRight,tempRight.rect,new Point(0,0),null,null,true);
                        }
                        else
                        {
                           bmd.copyPixels(tempLeft,tempLeft.rect,new Point(0,0),null,null,true);
                        }
                     }
                  }
               }
            }
            i++;
         }
         return bmd;
      }
      
      protected function addFrameScriptEnterEveryFrame() : void
      {
         if(this.enterFrameFunc != null)
         {
            this.enterFrameFunc(this.curPoint);
         }
      }
      
      protected function addFrameScriptExitEveryFrame() : void
      {
         if(this.exitFrameFunc != null)
         {
            this.exitFrameFunc(this.curPoint);
         }
      }
      
      public function setEnterFrameCallBack(fun1:Function, fun2:Function) : void
      {
         this.enterFrameFunc = fun1;
         this.exitFrameFunc = fun2;
      }
      
      public function setAddScriptWhenFrameOver(fun1:Function) : void
      {
         this.addFrameScriptWhenFrameOver = fun1;
      }
      
      public function setFramePointX(xx:int) : void
      {
         this.curPoint.x = xx;
         this.frameShow();
      }
      
      public function setFramePointY(yy:int) : void
      {
         this.curPoint.y = yy;
         this.frameShow();
      }
      
      public function step() : void
      {
         var totalCount:* = 0;
         var arr:* = null;
         var curActionTotalKeyFrames:* = 0;
         if(!this.isStopFrame)
         {
            this.addFrameScriptEnterEveryFrame();
            if(this.curFrameStopCount > 1)
            {
               this.curFrameStopCount--;
            }
            else
            {
               if(this.frameCount[this.curPoint.y] is Array)
               {
                  arr = this.frameCount[this.curPoint.y] as Array;
                  totalCount = uint(arr[this.curPoint.x] - 1);
               }
               else
               {
                  totalCount = uint(this.frameCount[this.curPoint.y] - 1);
               }
               if(this.curKeyFrameIndex >= totalCount)
               {
                  if(this.addFrameScriptWhenFrameOver != null)
                  {
                     this.addFrameScriptWhenFrameOver(this.curPoint.y);
                  }
                  this.curKeyFrameIndex = 0;
               }
               else
               {
                  curActionTotalKeyFrames = uint((this.frameStopCount[this.curPoint.y] as Array).length);
                  if(this.curPoint.x >= curActionTotalKeyFrames - 1)
                  {
                     this.curPoint.x = 0;
                  }
                  else
                  {
                     this.curPoint.x++;
                  }
                  this.curKeyFrameIndex++;
                  this.frameShow();
               }
            }
            this.addFrameScriptExitEveryFrame();
         }
      }
      
      public function setState(s:String) : void
      {
         if(this.state != s)
         {
            this.state = s;
            this.curKeyFrameIndex = 0;
         }
      }
      
      public function getState() : String
      {
         return this.state;
      }
      
      public function setFrameStopCount(f:Array) : void
      {
         this.frameStopCount = f;
      }
      
      public function getFrameStopCount() : Array
      {
         return this.frameStopCount;
      }
      
      public function setFrameCount(f:Array) : void
      {
         this.frameCount = f;
      }
      
      public function getCurPoint() : Point
      {
         return this.curPoint;
      }
      
      public function resetCurFrameStopCount() : void
      {
         this.curFrameStopCount = this.frameStopCount[this.curPoint.y][this.curPoint.x];
      }
      
      public function getCurFrameCount() : int
      {
         return this.curFrameStopCount;
      }
      
      public function setCurFrameCount(c:int) : void
      {
         this.curFrameStopCount = c;
      }
      
      public function stopFrame() : void
      {
         this.isStopFrame = true;
      }
      
      public function continueFrame() : void
      {
         this.isStopFrame = false;
      }
      
      public function turnRight() : void
      {
         this.setDirect(1);
      }
      
      public function turnLeft() : void
      {
         this.setDirect(0);
      }
      
      public function setOffsetXY(offsetX:int, offsetY:int) : void
      {
         this.offsetX = offsetX;
         this.offsetY = offsetY;
         this.setXYByDirect();
      }
      
      public function setXYByDirect() : void
      {
         if(this.direct == 0)
         {
            this.x = -this.bmWidth / 2 - this.offsetX;
         }
         else
         {
            this.x = -this.bmWidth / 2 + this.offsetX;
         }
         this.y = -this.bmHeight / 2 + this.offsetY;
      }
      
      public function replaceBitmapDataByName(name:String, bmdArray:Array) : void
      {
         var obj:* = null;
         var i:* = 0;
         for(i = uint(0); i < this.bmdArray.length; )
         {
            obj = this.bmdArray[i] as Object;
            if(obj.name == name)
            {
               obj.source = bmdArray;
            }
            this.bmdArray[i] = obj;
            i++;
         }
      }
      
      public function hide() : void
      {
         this.visible = false;
      }
      
      public function show() : void
      {
         this.visible = true;
      }
      
      public function setDirect(d:uint) : void
      {
         if(this.getDirect() != d)
         {
            this.direct = d;
            this.setXYByDirect();
            this.refreshCurFrame();
         }
      }
      
      public function getCurKeyFrameIndex() : uint
      {
         return this.curKeyFrameIndex;
      }
      
      public function getDirect() : uint
      {
         return this.direct;
      }
      
      public function destroy() : void
      {
         this.bmdArray.length = 0;
         this.enterFrameFunc = null;
         this.exitFrameFunc = null;
         this.addFrameScriptWhenFrameOver = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
