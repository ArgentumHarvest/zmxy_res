package export.muti
{
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class RoomTitle extends Sprite
   {
       
      
      private var maxPlayerNum:uint;
      
      public var playerNumTxt:TextField;
      
      public var roomIdTxt:TextField;
      
      public var roomNameTxt:TextField;
      
      public var roomMode:MovieClip;
      
      public var playersPerIdTxt:TextField;
      
      public var levelTxt:TextField;
      
      public var mapInfo:uint;
      
      private var mapImg:Bitmap;
      
      private var _level:uint;
      
      private var _playersPerId:uint;
      
      public function RoomTitle()
      {
         super();
      }
      
      public function updateInfo(index:uint, curNumVisitors:uint, maxVisitors:uint, data:String) : void
      {
         var params:* = null;
         var roomId:* = null;
         if(data != "")
         {
            params = data.split(",");
            if(index < 9)
            {
               roomId = "0" + (index + 1);
            }
            else
            {
               roomId = (index + 1).toString();
            }
            this.roomIdTxt.text = roomId + "";
            this.playerNumTxt.text = "(" + curNumVisitors + "/" + maxVisitors + ")";
            this.roomNameTxt.text = "房间->" + params[0] + "";
            this.roomMode.gotoAndStop(parseInt(params[1]));
            this.mapInfo = parseInt(params[2]);
            this.levelTxt.text = "lv." + params[3] + "";
            this._level = parseInt(params[3]);
            this.playersPerIdTxt.text = parseInt(params[4]) == 1 ? "单人房" : "双人房";
            this._playersPerId = parseInt(params[4]);
            this.mapImg = AUtils.getImageObj("map" + this.mapInfo);
            this.mapImg.x = 255;
            this.mapImg.y = 35;
            this.addChild(this.mapImg);
         }
      }
      
      public function setMaxPlayerNum(m:uint) : void
      {
         this.maxPlayerNum = m;
      }
      
      public function getMapInfo() : uint
      {
         return this.mapInfo;
      }
      
      public function getLevel() : uint
      {
         return this._level;
      }
      
      public function getPlayersPerId() : uint
      {
         return this._playersPerId;
      }
   }
}
