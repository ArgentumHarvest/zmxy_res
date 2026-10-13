package my
{
   import config.Config;
   import flash.display.Bitmap;
   import flash.utils.setTimeout;
   
   public class NewPlayerGuide
   {
       
      
      private var gc:Config;
      
      public function NewPlayerGuide()
      {
         super();
         gc = Config.getInstance();
      }
      
      public function checkPlayerIsAttach(id:uint) : Boolean
      {
         var flag:Boolean = false;
         switch(int(id) - 1)
         {
            case 0:
               if(gc.getAverageLevel() >= 13)
               {
                  flag = true;
               }
               break;
            case 1:
               if(gc.getAverageLevel() >= 16 && gc.curBigStage >= 3)
               {
                  flag = true;
               }
               break;
            case 2:
               if(gc.getAverageLevel() >= 19 && gc.curBigStage >= 4)
               {
                  flag = true;
               }
               break;
            case 3:
               if(gc.getAverageLevel() >= 38 && gc.curBigStage >= 4)
               {
                  flag = true;
               }
               break;
            case 4:
               if(gc.getAverageLevel() >= 10)
               {
                  flag = true;
               }
               break;
            case 5:
               if(gc.getAverageLevel() >= 20)
               {
                  flag = true;
               }
               break;
            case 6:
               if(gc.getAverageLevel() >= 30)
               {
                  flag = true;
               }
               break;
            case 7:
               if(gc.getAverageLevel() >= 40)
               {
                  flag = true;
               }
               break;
            case 8:
               if(gc.curBigStage >= 3 || gc.curBigStage == 2 && gc.curBigLevel > 2)
               {
                  flag = true;
               }
         }
         return flag;
      }
      
      public function checkIsNeedToFlash(idx:int) : Boolean
      {
         return gc.selectplaceGuideInfo.charAt(idx - 1) == "1";
      }
      
      public function setNoNeedToFlash(idx:int) : void
      {
         var selectplaceArr:Array = gc.selectplaceGuideInfo.split("");
         selectplaceArr[idx - 1] = 0;
         gc.selectplaceGuideInfo = selectplaceArr.join("");
      }
      
      public function checkNewGuide() : void
      {
         var i:* = 0;
         var flag:int = 0;
         var selectplaceArr:Array = gc.selectplaceGuideInfo.split("");
         var arr:Array = gc.newGuideInfo.split("");
         var len:int = arr.length;
         for(i = uint(0); i < len; )
         {
            flag = arr[i];
            if(flag == 0)
            {
               if(this.checkPlayerIsAttach(i + 1))
               {
                  arr[i] = 1;
                  selectplaceArr[i] = 1;
                  this.showSingleNewGuide(i + 1);
               }
            }
            i++;
         }
         trace("arr:" + arr);
         gc.newGuideInfo = arr.join("");
         gc.selectplaceGuideInfo = selectplaceArr.join("");
      }
      
      public function showNewGuide10() : void
      {
         this.showSingleNewGuide(10);
      }
      
      private function showSingleNewGuide(idx:int) : void
      {
         idx = idx;
         var bm:Bitmap = AUtils.getImageObj("newGuide" + idx);
         bm.x = 220;
         bm.y = 200;
         gc.stage.addChild(bm);
         setTimeout(function(... args):*
         {
            var _bm:Bitmap = args[0];
            if(_bm.parent)
            {
               _bm.parent.removeChild(_bm);
            }
         },3000,bm);
      }
   }
}
