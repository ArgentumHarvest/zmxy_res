package export
{
   import com.multi4399.ResponseEvent;
   import com.multi4399.Utils;
   import config.Config;
   import event.CommonEvent;
   import export.muti.LineTitle;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   import my.MainGame;
   
   public class LineChoose extends Sprite
   {
       
      
      private var gc:Config;
      
      public var pageSize:uint = 8;
      
      public var pageIndex:uint = 0;
      
      public var curChildNodeMaxVis:uint = 0;
      
      public var curNodeMaxVisitors:uint = 0;
      
      public var curNodeNumChildren:uint = 0;
      
      private var lineArray:Array;
      
      private var refreshTimer:Timer;
      
      public var prePageBtn:SimpleButton;
      
      public var nextPageBtn:SimpleButton;
      
      public var backBtn:SimpleButton;
      
      public var group:MovieClip;
      
      private var __mask:Sprite;
      
      private var posArray:Array;
      
      public function LineChoose()
      {
         lineArray = [];
         refreshTimer = new Timer(1500);
         posArray = [[100,105],[475,105],[100,195],[475,195],[100,285],[475,285],[100,375],[475,375]];
         super();
         gc = Config.getInstance();
         refreshTimer.addEventListener("timer",__timer);
         if(!gc.isDirectGoToRoomChoose)
         {
            refreshTimer.start();
         }
         backBtn.addEventListener("click",__back);
         backBtn.enabled = false;
         backBtn.mouseEnabled = false;
         prePageBtn.addEventListener("click",__prePage);
         nextPageBtn.addEventListener("click",__nextPage);
         group.buttonMode = true;
         group.addEventListener("click",__gotoGroup);
         gc.eventManger.addEventListener("cheat",__cheat);
      }
      
      protected function __cheat(event:Event) : void
      {
         this.destroy();
      }
      
      private function __gotoGroup(evt:MouseEvent) : void
      {
         gc.openUrl("https://my.4399.com/space-199596142-do-thread-id-2360329-tagid-80615.html");
      }
      
      private function __prePage(evt:MouseEvent) : void
      {
         if(this.pageIndex > 0)
         {
            this.pageIndex--;
         }
      }
      
      private function __nextPage(evt:MouseEvent) : void
      {
         if(this.pageIndex < this.curNodeNumChildren / this.pageSize - 1)
         {
            this.pageIndex++;
         }
      }
      
      private function __back(evt:MouseEvent) : void
      {
         this.destroy();
         gc.closeScoket();
         if(MainGame.getInstance())
         {
            MainGame.getInstance().destroyGame();
         }
         gc.curStageAndCurLevel.curStage = 41;
         gc.curStageAndCurLevel.curLevel = 1;
         gc.eventManger.dispatchEvent(new CommonEvent("selectStageOver"));
      }
      
      private function __timer(evt:TimerEvent) : void
      {
         if(gc.server && gc.isServerOk)
         {
            gc.server.ins_fetch_page(this.pageSize,this.pageIndex);
            gc.server.ins_return_to_param(2,true);
            gc.server.ins_fetch_child_nodes(1024 | 2048,new ByteArray());
            gc.server.submit(256);
         }
      }
      
      public function continueTimer() : void
      {
         this.refreshTimer.start();
      }
      
      public function __lineClick(evt:MouseEvent) : void
      {
         var str:* = null;
         var index:* = 0;
         var sprite:* = null;
         if(gc.server && gc.isServerOk)
         {
            refreshTimer.stop();
            str = (evt.currentTarget as Sprite).name;
            index = uint(parseInt(str));
            gc.server.ins_goto_child(index);
            gc.server.ins_set_user(4,gc.getSaveInfo());
            gc.server.submit(257);
            sprite = new Sprite();
            sprite.name = "mask";
            sprite.graphics.beginFill(16777215,0.5);
            sprite.graphics.drawRect(0,0,940,590);
            sprite.graphics.endFill();
            this.addChild(sprite);
         }
      }
      
      public function goToFirstLine() : void
      {
         gc.server.ins_goto_child(0);
         gc.server.ins_set_user(4,gc.getSaveInfo());
         gc.server.submit(257);
      }
      
      public function goToFbLine() : void
      {
         gc.server.ins_goto_child(1);
         gc.server.ins_set_user(4,gc.getSaveInfo());
         gc.server.submit(257);
      }
      
      public function joinFail() : void
      {
         var sp:Sprite = this.getChildByName("mask") as Sprite;
         if(sp)
         {
            this.removeChild(sp);
         }
         this.mouseChildren = true;
         this.mouseEnabled = true;
         this.continueTimer();
         this.__back(null);
      }
      
      public function refreshData(e:ResponseEvent) : void
      {
         var mc:* = null;
         var i:int = 0;
         var curPlayerNum:* = 0;
         var maxPlayerNum:* = 0;
         var aa:* = 0;
         var point:* = null;
         if(!backBtn.enabled)
         {
            backBtn.enabled = true;
            backBtn.mouseEnabled = true;
         }
         for each(var li in this.lineArray)
         {
            if(this.contains(li))
            {
               this.removeChild(li);
            }
         }
         this.lineArray.length = 0;
         var lineIdArr:Array = Utils.byte2_to_ints(e.values[0]);
         var len:int = lineIdArr.length;
         for(i = 0; i < len; )
         {
            if(this.lineArray[i] == undefined || !this.lineArray[i])
            {
               curPlayerNum = uint(parseInt(e.values[i * 2 + 2]));
               maxPlayerNum = uint(parseInt(e.values[i * 2 + 3]));
               mc = new LineTitle();
               mc.setPlayerNum(curPlayerNum,maxPlayerNum);
               mc.setLineNameMc(this.pageIndex + 1);
               mc.setLineIdxMc(i + 1);
               mc.name = (i + this.pageIndex * this.pageSize).toString();
               mc.mouseChildren = false;
               mc.buttonMode = true;
               mc.addEventListener("click",__lineClick);
               aa = uint(this.lineArray.length % 8);
               point = this.posArray[aa];
               mc.x = point[0];
               mc.y = point[1];
               mc.buttonMode = true;
               this.addChild(mc);
               this.lineArray.push(mc);
            }
            i++;
         }
      }
      
      public function scoketError() : void
      {
         if(!backBtn.enabled)
         {
            backBtn.enabled = true;
            backBtn.mouseEnabled = true;
         }
         this.__back(null);
      }
      
      public function addMask() : void
      {
         this.__mask = AUtils.getNewObj("SavingGameInterface");
         this.addChild(this.__mask);
      }
      
      public function clearMask() : void
      {
         if(this.__mask)
         {
            if(this.__mask.parent)
            {
               this.__mask.parent.removeChild(this.__mask);
            }
            this.__mask = null;
         }
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         var mc:* = null;
         gc.eventManger.removeEventListener("cheat",__cheat);
         for(i = 0; i < this.lineArray.length; )
         {
            mc = this.lineArray[i] as LineTitle;
            mc.removeEventListener("click",__lineClick);
            i++;
         }
         backBtn.removeEventListener("click",__back);
         prePageBtn.removeEventListener("click",__prePage);
         nextPageBtn.removeEventListener("click",__nextPage);
         group.removeEventListener("click",__gotoGroup);
         this.refreshTimer.stop();
         this.refreshTimer.removeEventListener("timer",__timer);
         this.refreshTimer = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         this.clearMask();
         gc.keyboardControl.continueAllControl();
      }
   }
}
