package mvc.control.net.rm
{
   import com.superkaka.game.Const.GameConst;
   import com.superkaka.mvc.Control.net.SMessage;
   import com.superkaka.mvc.Control.net.rm.LoginReceiveControl;
   import com.superkaka.mvc.ControlFactory;
   import flash.utils.ByteArray;
   import mvc.control.SocketsSendControl;
   import mvc.controllor.MyUserManager;
   import mvc.net.sm.ChooseLine;
   import mvc.net.sm.ChoosePlayer;
   import mvc.net.sm.NewPlayer;
   import mvc.vo.Line;
   import mvc.vo.Player;
   
   public class MyLoginReceiveControl extends LoginReceiveControl
   {
       
      
      public function MyLoginReceiveControl()
      {
         super();
      }
      
      public function LoginSuccess(body:ByteArray) : void
      {
         var i:* = 0;
         var p:* = null;
         var player:* = null;
         var sm:* = null;
         var choosePlayer:* = null;
         trace("-------LoginSuccess----------");
         var str:String = body.readUTFBytes(body.bytesAvailable);
         trace("str:" + str);
         var jObj:Object = JSON.parse(str);
         var players:Vector.<Player> = new Vector.<Player>();
         for(i = uint(0); i < jObj.players.length; )
         {
            p = jObj.players[i];
            player = new Player();
            player.buildFromObject(p);
            players.push(player);
            i++;
         }
         var ssc:SocketsSendControl = ControlFactory.getIns().getControl(SocketsSendControl) as SocketsSendControl;
         if(players.length == 0)
         {
            choosePlayer = new Player();
            if(GameConst.LOG_DATA)
            {
               choosePlayer.name = GameConst.LOG_DATA.nickName;
            }
            else
            {
               choosePlayer.name = "测试";
            }
            sm = new NewPlayer(choosePlayer);
            ssc.send(sm);
         }
         else
         {
            sm = new ChoosePlayer(players[0]);
            ssc.send(sm);
         }
      }
      
      public function LoginFail(body:ByteArray) : void
      {
         trace("-------LoginFail----------");
      }
      
      public function ChoosePlayerReturn(body:ByteArray) : void
      {
         var p:* = null;
         var player:* = null;
         var ssc:* = null;
         var chooseLine:* = null;
         var sm:* = null;
         trace("-------ChoosePlayerReturn----------");
         var str:String = body.readUTFBytes(body.bytesAvailable);
         trace("str:" + str);
         var jObj:Object = JSON.parse(str);
         var result:int = jObj.result;
         if(result == 1)
         {
            p = jObj.player;
            player = new Player();
            player.buildFromObject(p);
            MyUserManager.getIns().socketPlayer = player;
            ssc = ControlFactory.getIns().getControl(SocketsSendControl) as SocketsSendControl;
            chooseLine = new Line();
            chooseLine.id = 1;
            sm = new ChooseLine(chooseLine);
            ssc.send(sm);
         }
      }
      
      public function PlayerBeKicked(body:ByteArray) : void
      {
         trace("帐号重复登录！请刷新页面！");
      }
      
      public function ServerStop(body:ByteArray) : void
      {
         trace("服务器维护中！");
      }
   }
}
