package export.muti
{
   import base.BaseHero;
   import com.greensock.TweenMax;
   import com.multi4399.ResponseEvent;
   import com.multi4399.Utils;
   import config.Config;
   import event.CommonEvent;
   import export.ChatSprite;
   import export.muti.MyComponent.MapChoose;
   import export.muti.MyComponent.MyComboBox;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   import my.MainGame;
   
   public class ArenaSprite extends Sprite
   {
      
      public static var ARENASPRITE_MODE_ALL:uint = 0;
      
      public static var ARENASPRITE_MODE_1V1:uint = 1;
      
      public static var ARENASPRITE_MODE_HUNZHAN:uint = 2;
      
      public static var ARENASPRITE_FUBEN1:uint = 3;
      
      public static var ARENASPRITE_FUBEN2:uint = 4;
       
      
      private var gc:Config;
      
      public var pageSize:uint = 6;
      
      public var pageIndex:uint = 0;
      
      public var curChildNodeMaxVis:uint = 0;
      
      public var curNodeMaxVisitors:uint = 0;
      
      public var curNodeNumChildren:uint = 0;
      
      private var roomArray:Array;
      
      private var refreshTimer:Timer;
      
      private var posArray:Array;
      
      public var prePageBtn:SimpleButton;
      
      public var nextPageBtn:SimpleButton;
      
      public var backBtn:SimpleButton;
      
      public var createRoomBtn:SimpleButton;
      
      public var roomNameInput:TextField;
      
      public var chatSprite:ChatSprite;
      
      public var RoomList:MovieClip;
      
      public var modeChooseFilterMCB:MyComboBox;
      
      public var modeChooseCreateMCB:MyComboBox;
      
      public var group:MovieClip;
      
      private var mapc:MapChoose;
      
      public function ArenaSprite()
      {
         roomArray = [];
         refreshTimer = new Timer(1500);
         posArray = [[100,115],[475,115],[100,195],[475,195],[100,275],[475,275]];
         super();
         gc = Config.getInstance();
         backBtn.addEventListener("click",__back);
         createRoomBtn.addEventListener("click",__createRoom);
         prePageBtn.addEventListener("click",__prePage);
         nextPageBtn.addEventListener("click",__nextPage);
         group.buttonMode = true;
         group.addEventListener("click",__gotoGroup);
         modeChooseFilterMCB = new MyComboBox();
         if(gc.nodeInfo.PK_OR_FB == 0)
         {
            modeChooseFilterMCB.setData([{
               "label":MyComboBox.MYCOMBOBOX_ALL,
               "value":ARENASPRITE_MODE_ALL
            },{
               "label":MyComboBox.MYCOMBOBOX_HUNZHAN,
               "value":ARENASPRITE_MODE_1V1
            },{
               "label":MyComboBox.MYCOMBOBOX_DANTIAO,
               "value":ARENASPRITE_MODE_HUNZHAN
            }]);
         }
         else if(gc.playNum == 1)
         {
            modeChooseFilterMCB.setData([{
               "label":MyComboBox.MYCOMBOBOX_ALL,
               "value":ARENASPRITE_MODE_ALL
            },{
               "label":MyComboBox.MYCOMBOBOX_FUBEN1,
               "value":ARENASPRITE_FUBEN1
            },{
               "label":MyComboBox.MYCOMBOBOX_FUBEN2,
               "value":ARENASPRITE_FUBEN2
            }]);
         }
         else
         {
            modeChooseFilterMCB.setData([{
               "label":MyComboBox.MYCOMBOBOX_ALL,
               "value":ARENASPRITE_MODE_ALL
            },{
               "label":MyComboBox.MYCOMBOBOX_FUBEN1,
               "value":ARENASPRITE_FUBEN1
            }]);
         }
         modeChooseFilterMCB.x = 230 + modeChooseFilterMCB.width / 2;
         modeChooseFilterMCB.y = 69 + modeChooseFilterMCB.height / 2;
         this.addChild(modeChooseFilterMCB);
         modeChooseCreateMCB = new MyComboBox();
         if(gc.nodeInfo.PK_OR_FB == 0)
         {
            modeChooseCreateMCB.setData([{
               "label":MyComboBox.MYCOMBOBOX_DANTIAO,
               "value":ARENASPRITE_MODE_1V1
            },{
               "label":MyComboBox.MYCOMBOBOX_HUNZHAN,
               "value":ARENASPRITE_MODE_HUNZHAN
            }]);
         }
         else if(gc.playNum == 1)
         {
            modeChooseCreateMCB.setData([{
               "label":MyComboBox.MYCOMBOBOX_FUBEN1,
               "value":ARENASPRITE_FUBEN1
            },{
               "label":MyComboBox.MYCOMBOBOX_FUBEN2,
               "value":ARENASPRITE_FUBEN2
            }]);
         }
         else
         {
            modeChooseCreateMCB.setData([{
               "label":MyComboBox.MYCOMBOBOX_FUBEN1,
               "value":ARENASPRITE_FUBEN1
            }]);
         }
         modeChooseCreateMCB.x = 598 + modeChooseCreateMCB.width / 2;
         modeChooseCreateMCB.y = 446 + modeChooseCreateMCB.height / 2;
         this.addChild(modeChooseCreateMCB);
         roomNameInput.x = 620;
         roomNameInput.y = 407;
         roomNameInput.type = "dynamic";
         roomNameInput.selectable = false;
         if(gc.logInfo)
         {
            roomNameInput.text = gc.logInfo.name + " 的房间";
         }
         else
         {
            roomNameInput.text = gc.sid + " 的房间";
         }
         if(this.checkZuobi())
         {
            gc.ts.setTxt("您的游戏数据可能被修改，有问题请联系客服！");
            gc.stage.addChild(gc.ts);
            TweenMax.delayedCall(2,function():*
            {
               MainGame.getInstance().levelClear();
            });
            return;
         }
         refreshTimer.addEventListener("timer",__timer);
         refreshTimer.start();
         if(gc.nodeInfo.PK_OR_FB == 1)
         {
            var bm:Bitmap = AUtils.getImageObj("FB_TITLE");
            bm.x = 350;
            bm.y = 0;
            this.addChild(bm);
         }
         mapc = new MapChoose();
         if(gc.nodeInfo.PK_OR_FB == 0)
         {
            mapc.setData([{
               "value":1001,
               "resource":AUtils.getImageObj("map1001")
            }]);
         }
         else
         {
            mapc.setData([{
               "value":2001,
               "resource":AUtils.getImageObj("map2001")
            },{
               "value":2002,
               "resource":AUtils.getImageObj("map2002")
            },{
               "value":2003,
               "resource":AUtils.getImageObj("map2003")
            }]);
         }
         mapc.x = 697;
         mapc.y = 445;
         this.addChild(mapc);
         gc.eventManger.addEventListener("cheat",__cheat);
      }
      
      protected function __cheat(event:Event) : void
      {
         this.destroy();
      }
      
      private function checkZuobi() : Boolean
      {
         return false;
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
         if(this.pageIndex < this.curNodeNumChildren)
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
            gc.server.ins_fetch_page(this.pageSize,this.pageIndex,2);
            gc.server.ins_return_to_param(2,true);
            gc.server.ins_fetch_child_nodes(1 | 4 | 1024 | 4096,new ByteArray());
            gc.server.submit(272);
         }
      }
      
      public function continueTimer() : void
      {
         if(this.refreshTimer)
         {
            this.refreshTimer.start();
         }
      }
      
      public function __lineClick(evt:MouseEvent) : void
      {
         var str:* = null;
         var index:* = 0;
         var sprite:* = null;
         var rt:RoomTitle = evt.currentTarget as RoomTitle;
         if(gc.playNum != rt.getPlayersPerId())
         {
            gc.ts.setTxt("进入房间失败-->游戏人数模式不对!");
            gc.stage.addChild(gc.ts);
            return;
         }
         if(gc.server && gc.isServerOk)
         {
            if(this.refreshTimer)
            {
               refreshTimer.stop();
            }
            str = rt.name;
            gc.nodeInfo.mpInfo = rt.getMapInfo();
            index = uint(parseInt(str));
            trace("102-->index:" + index);
            gc.server.ins_goto_child(index,2);
            gc.server.ins_get_node(2);
            gc.server.ins_get_node(4);
            gc.server.ins_get_node(1024);
            gc.server.ins_get_node(4096);
            gc.server.ins_get_node(2048);
            gc.server.submit(258);
            sprite = new Sprite();
            sprite.name = "mask";
            sprite.graphics.beginFill(16777215,0.5);
            sprite.graphics.drawRect(0,0,940,590);
            sprite.graphics.endFill();
            this.addChild(sprite);
         }
      }
      
      public function refreshData(e:ResponseEvent) : void
      {
         var str:* = null;
         var textField:* = null;
         var mc:* = null;
         var i:int = 0;
         var mode:* = 0;
         var aa:* = 0;
         var point:* = null;
         var index:* = 0;
         var data:* = null;
         var curNumVisitors:* = 0;
         var maxVisitors:* = 0;
         if(!(e.values[0] is ByteArray))
         {
            return;
         }
         var lineIdArr:Array = Utils.byte2_to_ints(e.values[0]);
         for each(var rt in this.roomArray)
         {
            if(this.RoomList.contains(rt))
            {
               this.RoomList.removeChild(rt);
            }
         }
         this.roomArray.length = 0;
         var len:int = lineIdArr.length;
         for(i = 0; i < len; )
         {
            mode = uint(parseInt(e.values[i * 4 + 3].toString().split(",")[1]));
            if(!(modeChooseFilterMCB.getCurValue() != ARENASPRITE_MODE_ALL && modeChooseFilterMCB.getCurValue() != mode))
            {
               if(this.roomArray[i] == undefined || !this.roomArray[i])
               {
                  mc = new RoomTitle();
                  mc.mouseChildren = false;
                  mc.buttonMode = true;
                  mc.addEventListener("click",__lineClick);
                  aa = uint(this.roomArray.length % 6);
                  point = this.posArray[aa];
                  mc.x = point[0] - RoomList.x;
                  mc.y = point[1] - RoomList.y;
                  mc.buttonMode = true;
                  mc.setMaxPlayerNum(this.curNodeMaxVisitors);
                  this.RoomList.addChild(mc);
                  this.roomArray.push(mc);
                  index = uint(e.values[i * 4 + 2]);
                  mc.name = index.toString();
                  trace("mc.name:" + mc.name);
                  data = e.values[i * 4 + 3];
                  curNumVisitors = uint(e.values[i * 4 + 4]);
                  maxVisitors = uint(e.values[i * 4 + 5]);
                  mc.updateInfo(index,curNumVisitors,maxVisitors,data);
               }
            }
            i++;
         }
      }
      
      public function joinOrCreateFail() : void
      {
         var sp:Sprite = this.getChildByName("mask") as Sprite;
         if(sp)
         {
            this.removeChild(sp);
         }
      }
      
      private function __createRoom(evt:MouseEvent) : void
      {
         var maxRoomPlayer:* = 0;
         switch(modeChooseCreateMCB.getCurValue())
         {
            case ARENASPRITE_MODE_1V1:
               maxRoomPlayer = uint(2);
               break;
            case ARENASPRITE_MODE_HUNZHAN:
               maxRoomPlayer = uint(4);
               break;
            case ARENASPRITE_FUBEN1:
               maxRoomPlayer = uint(2);
               break;
            case ARENASPRITE_FUBEN2:
               maxRoomPlayer = uint(4);
               break;
            default:
               maxRoomPlayer = uint(99999);
         }
         gc.nodeInfo.mpInfo = mapc.getChooseValue();
         trace("=========maxRoomPlayer:" + maxRoomPlayer);
         gc.createRoom([roomNameInput.text,modeChooseCreateMCB.getCurValue(),gc.nodeInfo.mpInfo],maxRoomPlayer);
         var sprite:Sprite = new Sprite();
         sprite.name = "mask";
         sprite.graphics.beginFill(16777215,0.5);
         sprite.graphics.drawRect(0,0,940,590);
         sprite.graphics.endFill();
         this.addChild(sprite);
      }
      
      public function updateAllInfo(_roomName:*, _gameMode:*, _mpInfo:*, _maxPlayers:*, _averLevel:*) : void
      {
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         var mc:* = null;
         trace("---ArenaSprite---destroy---");
         gc.eventManger.removeEventListener("cheat",__cheat);
         this.backBtn.removeEventListener("click",__back);
         this.nextPageBtn.removeEventListener("click",__prePage);
         this.prePageBtn.removeEventListener("click",__nextPage);
         this.group.removeEventListener("click",__gotoGroup);
         for(i = 0; i < this.roomArray.length; )
         {
            mc = this.roomArray[i] as RoomTitle;
            mc.removeEventListener("click",__lineClick);
            i++;
         }
         if(this.refreshTimer)
         {
            this.refreshTimer.stop();
            this.refreshTimer.removeEventListener("timer",__timer);
            this.refreshTimer = null;
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         if(this.chatSprite)
         {
            this.chatSprite.destroy();
         }
         if(this.mapc)
         {
            this.mapc.destroy();
            this.mapc = null;
         }
         gc.keyboardControl.continueAllControl();
      }
   }
}
