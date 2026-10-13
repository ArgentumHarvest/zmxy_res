package export.animalarray
{
   import config.Config;
   import event.CommonEvent;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import my.MyTextField;
   
   public class Basaltic extends Sprite
   {
       
      
      private var gc:Config;
      
      public var qfbtn:SimpleButton;
      
      public var q1:MovieClip;
      
      public var q2:MovieClip;
      
      public var q3:MovieClip;
      
      public var q4:MovieClip;
      
      public var q5:MovieClip;
      
      public var q6:MovieClip;
      
      public var q7:MovieClip;
      
      public var q8:MovieClip;
      
      public var q9:MovieClip;
      
      public var q10:MovieClip;
      
      private var leftBtn:SimpleButton;
      
      private var rightBtn:SimpleButton;
      
      private var attributetxt:MyTextField;
      
      private var zqjytxt:MyTextField;
      
      private var zqymtxt:MyTextField;
      
      public function Basaltic()
      {
         attributetxt = new MyTextField(16777215,"FZCuYuan-M03S",16);
         zqjytxt = new MyTextField(16777215,"FZCuYuan-M03S",16);
         zqymtxt = new MyTextField(16777215,"FZCuYuan-M03S",16);
         super();
         gc = Config.getInstance();
         this.addEventListener("addedToStage",added);
         this.addEventListener("removedFromStage",removed);
      }
      
      private function added(e:Event) : void
      {
         this.removeEventListener("addedToStage",added);
         attributetxt.x = 477.95;
         attributetxt.y = 144.1;
         this.addChild(attributetxt);
         zqjytxt.x = 538.95;
         zqjytxt.y = 228.95;
         this.addChild(zqjytxt);
         zqymtxt.x = 538.95;
         zqymtxt.y = 296.8;
         this.addChild(zqymtxt);
         qfbtn.addEventListener("click",qfClick);
         leftBtn = AUtils.getNewObj("marLeftBtn") as SimpleButton;
         leftBtn.x = 179.95;
         leftBtn.y = 375.3;
         this.addChild(leftBtn);
         rightBtn = AUtils.getNewObj("marRightBtn") as SimpleButton;
         rightBtn.x = 324.5;
         rightBtn.y = 375.3;
         this.addChild(rightBtn);
         leftBtn.addEventListener("click",leftClickHandler);
         rightBtn.addEventListener("click",rightClickHandler);
         this.setMcShow();
         this.setTxtShow();
      }
      
      protected function rightClickHandler(event:MouseEvent) : void
      {
      }
      
      protected function leftClickHandler(event:MouseEvent) : void
      {
         gc.eventManger.dispatchEvent(new CommonEvent("ChangeMarix","basaltic_left"));
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function removed(e:Event) : void
      {
         this.removeEventListener("removedFromStage",removed);
         leftBtn.removeEventListener("click",leftClickHandler);
         rightBtn.removeEventListener("click",rightClickHandler);
      }
      
      private function setMcShow() : void
      {
         var i:* = 0;
         var j:* = 0;
         for(i = uint(1); i <= 10; )
         {
            this["q" + i].gotoAndStop(1);
            i++;
         }
         var fary:Array = String(gc.dataObject.fourPhalanx).split("_") as Array;
         var ary:Array = String(fary[1]).split("-") as Array;
         if(ary[1] != 0)
         {
            for(j = uint(1); j <= ary[1]; )
            {
               this["q" + j].gotoAndStop(2);
               j++;
            }
         }
      }
      
      private function setTxtShow() : void
      {
         attributetxt.text = gc.petFormation.getTotalInfoByFormation(1);
         attributetxt.width = attributetxt.textWidth + 7;
         attributetxt.height = attributetxt.textHeight + 7;
         var needAry:Array = gc.petFormation.getNeedStoneByType(1);
         var stoneAry:Array = gc.getPhalanxStone(1);
         zqjytxt.text = stoneAry[0] + "/" + needAry[0];
         zqjytxt.width = zqjytxt.textWidth + 7;
         zqjytxt.height = zqjytxt.textHeight + 7;
         zqymtxt.text = stoneAry[1] + "/" + needAry[1];
         zqymtxt.width = zqymtxt.textWidth + 7;
         zqymtxt.height = zqymtxt.textHeight + 7;
      }
      
      private function qfClick(e:MouseEvent) : void
      {
         var stoneAry:* = null;
         var needAry:* = null;
         if(!gc.judgeFourPhalanx(1))
         {
            stoneAry = gc.getPhalanxStone(1);
            needAry = gc.petFormation.getNeedStoneByType(1);
            if(gc.isHideDebug)
            {
               if(stoneAry[0] >= needAry[0] && stoneAry[1] >= needAry[1])
               {
                  gc.setAnalyzeFourPhalanx(1);
                  this.depleteCliffordStone(-needAry[0],-needAry[1]);
                  gc.petFormation.setSaveData(gc.dataObject.fourPhalanx);
                  this.setMcShow();
                  this.setTxtShow();
               }
               else
               {
                  gc.ts.setTxt("材料不足");
                  gc.stage.addChild(gc.ts);
               }
            }
            else
            {
               gc.setAnalyzeFourPhalanx(1);
               gc.petFormation.setSaveData(gc.dataObject.fourPhalanx);
               this.setMcShow();
               this.setTxtShow();
            }
         }
         else
         {
            gc.ts.setTxt("已经无法再祈福");
            gc.stage.addChild(gc.ts);
         }
      }
      
      public function depleteCliffordStone(stone1:int, stone2:int) : void
      {
         var cary:Array = String(gc.dataObject.cliffordStone).split("_") as Array;
         var tag:uint = 0;
         var stoneName1:String = "xwjystone";
         var stoneName2:String = "xwljstone";
         var ary:Array = String(cary[1]).split("-") as Array;
         if(ary[0] >= stone1 && ary[1] >= stone2)
         {
            gc.setCliffordStone(stoneName1,stone1);
            gc.setCliffordStone(stoneName2,stone2);
         }
      }
   }
}
