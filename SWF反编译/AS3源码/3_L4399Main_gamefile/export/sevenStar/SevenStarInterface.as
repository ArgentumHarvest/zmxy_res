package export.sevenStar
{
   import config.Config;
   import event.CommonEvent;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import mvc.controllor.RandomControllor;
   import my.MainGame;
   
   public class SevenStarInterface extends Sprite
   {
       
      
      public var xbtn:SimpleButton;
      
      public var intobtn:SimpleButton;
      
      public var fbbgmc:MovieClip;
      
      private var urlLoader:URLLoader;
      
      private var _monId:int;
      
      private var gc:Config;
      
      public function SevenStarInterface()
      {
         super();
         gc = Config.getInstance();
         this.addEventListener("addedToStage",added);
         this.addEventListener("removedFromStage",removed);
      }
      
      private function added(e:Event) : void
      {
         this.removeEventListener("addedToStage",added);
         fbbgmc.visible = false;
         this.requestData();
         this.xbtn.addEventListener("click",xClick);
      }
      
      private function removed(e:Event) : void
      {
         this.removeEventListener("removedFromStage",removed);
         this.xbtn.removeEventListener("click",xClick);
      }
      
      private function requestData() : void
      {
         urlLoader = new URLLoader();
         urlLoader.dataFormat = "text";
         urlLoader.addEventListener("complete",completeHandler);
         urlLoader.addEventListener("ioError",__requestDataError);
         urlLoader.addEventListener("securityError",__requestDataError);
         urlLoader.load(new URLRequest("https://save.api.4399.com/?ac=get_time&" + RandomControllor.getIns().getRandom()));
      }
      
      private function __requestDataError(evt:Event) : void
      {
         urlLoader.load(new URLRequest("https://save.api.4399.com/?ac=get_time&" + RandomControllor.getIns().getRandom()));
      }
      
      private function completeHandler(e:*) : void
      {
         var bname:* = null;
         fbbgmc.visible = true;
         urlLoader.removeEventListener("complete",completeHandler);
         urlLoader.removeEventListener("ioError",__requestDataError);
         urlLoader.removeEventListener("securityError",__requestDataError);
         var jObj:Object = JSON.parse(urlLoader.data);
         var ary:Array = String(jObj["time"]).split(" ");
         var timeArr:Array = ary[1].split(":");
         var hour:int = timeArr[0];
         var random:int = int(RandomControllor.getIns().getRandom() * 3);
         if(gc.dataObject.beidouqixing >= 1)
         {
            if(hour >= 18 && hour < 19)
            {
               gc.qixingMonsterId = 177;
               fbbgmc.gotoAndStop(1);
            }
            else if(hour >= 19 && hour < 20)
            {
               gc.qixingMonsterId = 178;
               fbbgmc.gotoAndStop(2);
            }
            else if(hour >= 20 && hour < 21)
            {
               gc.qixingMonsterId = 179;
               fbbgmc.gotoAndStop(3);
            }
            else
            {
               gc.qixingMonsterId = 177 + random;
               fbbgmc.gotoAndStop(4);
            }
         }
         else if(gc.dataObject.guoqingFB >= 1)
         {
            bname = ["醉翁","白面猿猴","七香车","聚宝天官"];
            gc.randomMonster = int(RandomControllor.getIns().getRandom() * 4);
            fbbgmc.gotoAndStop(bname[gc.randomMonster]);
            if(gc.randomMonster == 0)
            {
               gc.guoqingMonsterId = 183;
            }
            else if(gc.randomMonster == 1)
            {
               gc.guoqingMonsterId = 182;
            }
            else if(gc.randomMonster == 2)
            {
               gc.guoqingMonsterId = 184;
            }
            else if(gc.randomMonster == 3)
            {
               gc.guoqingMonsterId = 185;
            }
         }
         else
         {
            gc.qixingMonsterId = 177 + random;
            fbbgmc.gotoAndStop(4);
         }
         this.intobtn.addEventListener("click",intoClick);
      }
      
      private function intoClick(e:MouseEvent) : void
      {
         if(gc.dataObject.beidouqixing >= 1)
         {
            if(MainGame.getInstance())
            {
               MainGame.getInstance().destroyGame();
            }
            gc.curStageAndCurLevel.curStage = 55;
            gc.curStageAndCurLevel.curLevel = 1;
            gc.dataObject.beidouqixing--;
            gc.eventManger.dispatchEvent(new CommonEvent("selectStageOver"));
            gc.eventManger.dispatchEvent(new CommonEvent("ShowOtherScene"));
            if(gc.isHideDebug)
            {
               gc.memory.setStorage(gc.luanqibazaojiami.saveId);
            }
         }
         else if(gc.dataObject.guoqingFB >= 1)
         {
            if(MainGame.getInstance())
            {
               MainGame.getInstance().destroyGame();
            }
            gc.curStageAndCurLevel.curStage = 56;
            gc.curStageAndCurLevel.curLevel = 1;
            gc.dataObject.guoqingFB--;
            gc.eventManger.dispatchEvent(new CommonEvent("selectStageOver"));
            gc.eventManger.dispatchEvent(new CommonEvent("ShowOtherScene"));
            if(gc.isHideDebug)
            {
               gc.memory.setStorage(gc.luanqibazaojiami.saveId);
            }
         }
         else
         {
            gc.ts.setTxt("您今天已经挑战过该副本");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function xClick(e:MouseEvent) : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
