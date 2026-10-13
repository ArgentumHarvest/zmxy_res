package export
{
   import AssetsClass.ErshibaXX;
   import AssetsClass.HundunDoor;
   import AssetsClass.ZLSaintsInterfaceAssets;
   import com.greensock.TweenMax;
   import com.greensock.easing.Sine;
   import config.Config;
   import event.CommonEvent;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class NewWorldSelectPlace extends Sprite
   {
       
      
      private var gc:Config;
      
      private var stageAry:Array;
      
      public var s20_1:MovieClip;
      
      public var s21_1:MovieClip;
      
      public var s21_2:MovieClip;
      
      public var s21_3:MovieClip;
      
      public var s22_1:MovieClip;
      
      public var s22_2:MovieClip;
      
      public var s22_3:MovieClip;
      
      public var s23_1:MovieClip;
      
      public var s23_2:MovieClip;
      
      public var s23_3:MovieClip;
      
      public var hdbtn:MovieClip;
      
      public var drugbtn:MovieClip;
      
      public var constelbtn:MovieClip;
      
      public var bygbtn:MovieClip;
      
      private var cbs:int;
      
      private var cbl:int;
      
      public function NewWorldSelectPlace()
      {
         stageAry = [1,3,3,4];
         super();
         gc = Config.getInstance();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
         this.init();
      }
      
      private function init() : void
      {
         this.s20_1.buttonMode = true;
         this.s21_1.buttonMode = true;
         this.s21_2.buttonMode = true;
         this.s21_3.buttonMode = true;
         this.s22_1.buttonMode = true;
         this.s22_2.buttonMode = true;
         this.s22_3.buttonMode = true;
         this.s23_1.buttonMode = true;
      }
      
      private function added(e:Event) : void
      {
         var i:* = 0;
         var k:* = 0;
         var j:* = 0;
         i = 0;
         var dio:* = null;
         gc.isintheselectmap = true;
         cbs = gc.curBigStage;
         cbl = gc.curBigLevel;
         if(!gc.isHideDebug)
         {
            cbs = 23;
            cbl = 1;
         }
         if(cbs < 20)
         {
            gc.curBigStage = 20;
            gc.curBigLevel = 1;
            cbs = 20;
            cbl = 1;
         }
         else if(cbs > 23)
         {
            cbs = 23;
            cbl = 2;
         }
         for(i = uint(20); i <= cbs; )
         {
            k = uint(this.stageAry[i - 20]);
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
         if(gc.curBigStage <= 23)
         {
            if(this["s" + cbs + "_" + cbl])
            {
               this["s" + cbs + "_" + cbl].gotoAndStop(2);
            }
         }
         hdbtn.buttonMode = true;
         hdbtn.addEventListener("click",newWorldClick);
         hdbtn.addEventListener("rollOver",mOver);
         hdbtn.addEventListener("rollOut",mOut);
         drugbtn.buttonMode = true;
         drugbtn.gotoAndStop(2);
         drugbtn.addEventListener("click",drugClick);
         drugbtn.addEventListener("rollOver",mOver);
         drugbtn.addEventListener("rollOut",mOut);
         constelbtn.buttonMode = true;
         constelbtn.gotoAndStop(2);
         constelbtn.addEventListener("click",constelClick);
         constelbtn.addEventListener("rollOver",mOver);
         constelbtn.addEventListener("rollOut",mOut);
         bygbtn.buttonMode = true;
         bygbtn.gotoAndStop(2);
         bygbtn.addEventListener("click",theThirdWorldClick);
         bygbtn.addEventListener("rollOver",mOver);
         bygbtn.addEventListener("rollOut",mOut);
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
      
      private function removed(e:Event) : void
      {
         gc.isintheselectmap = false;
         this.s20_1.removeEventListener("rollOver",mOver);
         this.s20_1.removeEventListener("rollOut",mOut);
         this.s20_1.removeEventListener("click",onSelected);
         this.s21_1.removeEventListener("rollOver",mOver);
         this.s21_1.removeEventListener("rollOut",mOut);
         this.s21_1.removeEventListener("click",onSelected);
         this.s21_2.removeEventListener("rollOver",mOver);
         this.s21_2.removeEventListener("rollOut",mOut);
         this.s21_2.removeEventListener("click",onSelected);
         this.s22_1.removeEventListener("rollOver",mOver);
         this.s22_1.removeEventListener("rollOut",mOut);
         this.s22_1.removeEventListener("click",onSelected);
         this.s22_2.removeEventListener("rollOver",mOver);
         this.s22_2.removeEventListener("rollOut",mOut);
         this.s22_2.removeEventListener("click",onSelected);
         this.s22_3.removeEventListener("rollOver",mOver);
         this.s22_3.removeEventListener("rollOut",mOut);
         this.s22_3.removeEventListener("click",onSelected);
         this.s23_1.removeEventListener("rollOver",mOver);
         this.s23_1.removeEventListener("rollOut",mOut);
         this.s23_1.removeEventListener("click",onSelected);
         gc.eventManger.removeEventListener("ShowOtherScene",showOtherScene);
         gc.eventManger.removeEventListener("ChanllengeBossInster",chanllenge);
         drugbtn.removeEventListener("click",drugClick);
         drugbtn.removeEventListener("rollOver",mOver);
         drugbtn.removeEventListener("rollOut",mOut);
         constelbtn.removeEventListener("click",constelClick);
         constelbtn.removeEventListener("rollOver",mOver);
         constelbtn.removeEventListener("rollOut",mOut);
         hdbtn.removeEventListener("click",newWorldClick);
         hdbtn.removeEventListener("rollOver",mOver);
         hdbtn.removeEventListener("rollOut",mOut);
         bygbtn.removeEventListener("click",theThirdWorldClick);
         bygbtn.removeEventListener("rollOver",mOver);
         bygbtn.removeEventListener("rollOut",mOut);
      }
      
      private function onSelected(e:MouseEvent) : void
      {
         gc.curStageAndCurLevel.curStage = int(String(e.currentTarget.name).substr(1,2));
         gc.curStageAndCurLevel.curLevel = int(String(e.currentTarget.name).substr(4,1));
         gc.eventManger.dispatchEvent(new CommonEvent("selectStageOver"));
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
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
      
      private function newWorldClick(e:MouseEvent) : void
      {
         var aned:HundunDoor = new HundunDoor();
         this.addChild(aned);
      }
      
      private function drugClick(e:MouseEvent) : void
      {
         var zlsi:ZLSaintsInterfaceAssets = new ZLSaintsInterfaceAssets();
         this.addChild(zlsi);
      }
      
      private function constelClick(e:MouseEvent) : void
      {
         var twe:ErshibaXX = new ErshibaXX();
         this.addChild(twe);
      }
      
      private function theThirdWorldClick(e:MouseEvent) : void
      {
         if(gc.player1.getSomeOneEquipNumberByName("ttsl") >= 1)
         {
            if(gc.playNum == 2)
            {
               if(gc.player1.getCurLevel() < 50 || gc.player2.getCurLevel() < 50)
               {
                  gc.ts.setTxt("玩家的等级必须都大于50级才可以进入");
                  gc.stage.addChild(gc.ts);
                  return;
               }
            }
            else if(gc.player1.getCurLevel() < 50)
            {
               gc.ts.setTxt("玩家的等级必须都大于50级才可以进入");
               gc.stage.addChild(gc.ts);
               return;
            }
            GMain.getInstance().switchSence("showThirdStageMap");
            return;
         }
         gc.ts.setTxt("需要通天赦令");
         gc.stage.addChild(gc.ts);
      }
      
      private function complete1(param:Sprite) : void
      {
         TweenMax.to(param,1.5,{
            "alpha":0,
            "ease":Sine.easeIn,
            "onComplete":complete2
         });
      }
      
      private function complete2() : void
      {
         var third:ThirdWorldSelectPlace = this.getChildByName("hasThirdWorldSelectPlace") as ThirdWorldSelectPlace;
         if(third && this.contains(third))
         {
            this.removeChild(third);
            third = null;
         }
      }
   }
}
