package mvc.control.net.rm
{
   import base.BaseHero;
   import com.superkaka.Tools.DebugArea;
   import com.superkaka.game.Const.GameConst;
   import com.superkaka.mvc.Control.net.rm.GameReceiveControl;
   import com.superkaka.mvc.ProxyFactory;
   import config.Config;
   import flash.utils.ByteArray;
   import mvc.controllor.PlayerDatasControllor;
   import mvc.controllor.RandomControllor;
   import mvc.controllor.SocketConnectManager;
   import mvc.proxy.FbSocketProxy;
   import my.MainGame;
   
   public class MyRoomReceiveControl extends GameReceiveControl
   {
       
      
      public function MyRoomReceiveControl()
      {
         super();
      }
      
      public function JoinRoomSuccess(body:ByteArray) : void
      {
         trace("-----JoinRoomSuccess-----");
      }
      
      public function JoinRoomFail(body:ByteArray) : void
      {
         trace("-----JoinRoomFail-----");
      }
      
      public function LeftRoomSuccess(body:ByteArray) : void
      {
         trace("-----LeftRoomSuccess-----");
      }
      
      public function ReceiveOperation(command:ByteArray) : void
      {
         var len:int = 0;
         var index:int = 0;
         var curHero:* = null;
         var keyCode:int = 0;
         var operation:int = 0;
         var temp:ByteArray = new ByteArray();
         temp.endian = "littleEndian";
         command.readBytes(temp);
         temp.position = 0;
         while(temp.bytesAvailable)
         {
            len = temp.readShort();
            index = temp.readInt();
            len -= 4;
            for each(var bh in Config.getInstance().getPlayerArray())
            {
               if(bh.getPlayer().index == index)
               {
                  curHero = bh;
                  break;
               }
            }
            if(!curHero)
            {
               break;
            }
            while(len > 0)
            {
               keyCode = temp.readShort();
               operation = temp.readShort();
               if(keyCode > 0)
               {
                  if(operation == 0)
                  {
                     curHero.execKeyboardDown(keyCode);
                  }
                  else if(operation == 1)
                  {
                     curHero.execKeyboardUp(keyCode);
                  }
               }
               len -= 8;
            }
            curHero = null;
         }
         MainGame.getInstance().renderGame();
      }
      
      public function StartGame(body:ByteArray) : void
      {
         trace("-------StartGame----------");
         var str:String = body.readUTFBytes(body.bytesAvailable);
         trace("str:" + str);
         var jObj:Object = JSON.parse(str);
         var result:int = jObj.result;
         var random:int = jObj.random;
         var datas:Array = jObj.datas;
         RandomControllor.getIns().randomIndex = random;
         RandomControllor.getIns().clearString();
         if(result == 1)
         {
            Config.getInstance().isFramePk = true;
            PlayerDatasControllor.getIns().playerDatas = datas;
            for each(var pl in PlayerDatasControllor.getIns().playerDatas)
            {
               if(int(pl.data.uid) == GameConst.UID)
               {
                  Config.getInstance().player1.index = pl.index;
               }
               else
               {
                  Config.getInstance().player2.index = pl.index;
               }
            }
         }
      }
      
      public function RoomChanged(body:ByteArray) : void
      {
         trace("-------RoomChanged----------");
      }
      
      public function CreateRoomReturn(body:ByteArray) : void
      {
         trace("-------CreateRoomReturn----------");
         var str:String = body.readUTFBytes(body.bytesAvailable);
         var jObj:Object = JSON.parse(str);
         var err:String = jObj.err;
         var type:int = jObj.type;
         var key:String = jObj.key;
         var roomId:int = jObj.roomId;
         var ip:String = jObj.ip;
         var port:int = jObj.port;
         if(type == 0)
         {
            if(err == null)
            {
               ProxyFactory.getIns().destroyProxy(FbSocketProxy);
               GameConst.roomId = roomId;
               GameConst.roomKey = key;
               SocketConnectManager.getIns().connectToFb(ip,port);
            }
         }
         else
         {
            if(type != 1)
            {
               throw new Error("创建/加入房间出错！");
            }
            if(err == null)
            {
               ProxyFactory.getIns().destroyProxy(FbSocketProxy);
               GameConst.roomId = roomId;
               GameConst.roomKey = key;
               SocketConnectManager.getIns().connectToFb(ip,port);
            }
         }
      }
      
      public function JoinRoomReturn(body:ByteArray) : void
      {
         trace("-------JoinRoomReturn----------");
      }
      
      public function LeftRoomReturn(body:ByteArray) : void
      {
         trace("-------LeftRoomReturn----------");
      }
      
      public function AutoPipeiReturn(body:ByteArray) : void
      {
         trace("-------AutoPipeiReturn----------");
      }
      
      public function CancelAutoPipeiReturn(body:ByteArray) : void
      {
         trace("-------CancelAutoPipeiReturn----------");
      }
      
      public function GameAccount(body:ByteArray) : void
      {
         DebugArea.getIns().showInfo("-------GameAccount----------");
         var str:String = body.readUTFBytes(body.bytesAvailable);
         trace("str:" + str);
         var jObj:Object = JSON.parse(str);
         var data:Object = jObj.data;
         var result:int = data.result;
         var type:int = data.type;
         if(data.result == 1)
         {
            trace("胜利");
         }
         else
         {
            trace("失败");
         }
      }
   }
}
