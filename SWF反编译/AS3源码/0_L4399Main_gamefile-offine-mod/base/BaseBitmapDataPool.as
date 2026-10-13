package base
{
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class BaseBitmapDataPool
   {
      
      public static var infoDict:Dictionary = new Dictionary();
      
      public static var mcToBitmapDataArrayDict:Dictionary = new Dictionary();
       
      
      public function BaseBitmapDataPool()
      {
         super();
      }
      
      public static function getBitmapDataArrayByName(str:String) : Array
      {
         var register:* = null;
         if(!hasRegisteredData(str))
         {
            register = registerData(str);
            if(register)
            {
               return register;
            }
            return null;
         }
         return infoDict[str];
      }
      
      public static function registerData(str:String) : Array
      {
         var temp:* = undefined;
         var arr:* = null;
         var bmd1:* = null;
         var bmd2:* = null;
         var mc:* = null;
         var arr2:* = null;
         if(hasRegisteredData(str))
         {
            return null;
         }
         try
         {
            temp = AUtils.getNewObj(str);
         }
         catch(e:*)
         {
            return null;
         }
         if(temp is BitmapData)
         {
            arr = [];
            bmd1 = temp as BitmapData;
            arr.push(bmd1);
            bmd2 = new BitmapData(bmd1.width,bmd1.height,true,0);
            bmd2.draw(bmd1,new Matrix(-1,0,0,1,bmd1.width,0));
            arr.push(bmd2);
            infoDict[str] = arr;
            return arr;
         }
         if(temp is MovieClip)
         {
            mc = temp as MovieClip;
            arr2 = analysisMcToBitmapDataArrayByString(mc);
            infoDict[str] = arr2;
            return arr2;
         }
         return null;
      }
      
      public static function analysisMcToBitmapDataArrayByString(mc:MovieClip) : Array
      {
         var i:* = 0;
         var child:* = null;
         var childLen:* = 0;
         var j:* = 0;
         var currentLeftBitmapData:* = null;
         var currentRightBitmapData:* = null;
         var rect:* = null;
         var returnArr:Array = [];
         mc.gotoAndStop(1);
         var totalFrames:uint = mc.totalFrames;
         var leftTemp:Array = [];
         var rightTemp:Array = [];
         for(i = uint(1); i <= totalFrames; )
         {
            leftTemp[i - 1] = [];
            rightTemp[i - 1] = [];
            mc.gotoAndStop(i);
            child = mc.getChildAt(0) as MovieClip;
            if(child)
            {
               childLen = uint(child.totalFrames);
               for(j = uint(1); j <= childLen; )
               {
                  child.gotoAndStop(j);
                  currentLeftBitmapData = new BitmapData(mc.width,mc.height,true,16777215);
                  currentRightBitmapData = new BitmapData(mc.width,mc.height,true,16777215);
                  rect = child.getBounds(mc);
                  currentLeftBitmapData.draw(child,new Matrix(1,0,0,1,-rect.x + child.x,-rect.y + child.y),null,null,null,true);
                  leftTemp[i - 1][j - 1] = currentLeftBitmapData;
                  currentRightBitmapData.draw(child,new Matrix(-1,0,0,1,rect.x + rect.width - child.x,-rect.y + child.y),null,null,null,true);
                  rightTemp[i - 1][j - 1] = currentRightBitmapData;
                  j++;
               }
            }
            i++;
         }
         returnArr.push(leftTemp,rightTemp);
         return returnArr;
      }
      
      public static function hasRegisteredData(str:String) : Boolean
      {
         return infoDict[str] != undefined && infoDict[str] != null;
      }
      
      public static function removeData(str:String) : void
      {
         var bmd:* = null;
         var i:int = 0;
         trace("=====================================removeData->str:" + str);
         var arr:Array = infoDict[str] as Array;
         if(arr)
         {
            for(i = 0; i < arr.length; )
            {
               if(arr[i] is BitmapData)
               {
                  bmd = arr[i] as BitmapData;
                  bmd.dispose();
                  bmd = null;
               }
               else if(arr[i] is Array)
               {
                  (arr[i] as Array).length = 0;
               }
               i++;
            }
         }
         infoDict[str] = null;
         delete infoDict[str];
         trace("=========infoDict==========");
         for(var key in infoDict)
         {
            trace("key:" + key);
         }
      }
      
      public static function removeScoketOtherHeroData() : void
      {
         var keyTemp:Array = [];
         for(var key in infoDict)
         {
            if(key.indexOf("ROLE1_") != -1 || key.indexOf("ROLE2_") != -1 || key.indexOf("ROLE3_") != -1 || key.indexOf("ROLE4_") != -1)
            {
               keyTemp.push(key);
            }
         }
         for each(var temp in keyTemp)
         {
            removeData(temp);
         }
         keyTemp.length = 0;
      }
   }
}
