package export.muti
{
   import config.Config;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.text.TextField;
   import user.MutiUser;
   
   public class SingleOtherUserInfo extends Sprite
   {
       
      
      public var bg:MovieClip;
      
      public var headSprite:MovieClip;
      
      public var uName:TextField;
      
      public var level:TextField;
      
      public var mutiUsers:MutiUser;
      
      private var hpShape:Shape;
      
      private var isClose:Boolean = false;
      
      private var isEmpty:Boolean = true;
      
      private var gc:Config;
      
      public function SingleOtherUserInfo()
      {
         super();
         gc = Config.getInstance();
         this.hpShape = new Shape();
         this.hpShape.x = 3;
         this.hpShape.y = 2;
         this.addChild(this.hpShape);
         this.uName.selectable = false;
         this.level.selectable = false;
         this.uName.text = "";
         this.level.text = "";
      }
      
      public function close() : void
      {
         this.isClose = true;
         this.mutiUsers = null;
         this.hpShape.graphics.clear();
         this.headSprite.gotoAndStop(1);
         this.uName.text = "";
         this.level.text = "";
         bg.gotoAndStop(2);
      }
      
      public function open() : void
      {
         this.isClose = false;
         bg.gotoAndStop(1);
      }
      
      public function setEmpty() : void
      {
         this.isEmpty = true;
         this.headSprite.gotoAndStop(1);
         this.uName.text = "";
         this.level.text = "";
         this.hpShape.graphics.clear();
         this.mutiUsers = null;
      }
      
      public function isEmptyd() : Boolean
      {
         return this.isEmpty;
      }
      
      public function isClosed() : Boolean
      {
         return this.isClose;
      }
      
      public function addMutiUserInfo(mutiUser:MutiUser) : void
      {
         this.isEmpty = false;
         this.mutiUsers = mutiUser;
         this.headSprite.gotoAndStop(this.mutiUsers.roleId + 1);
         this.uName.text = this.mutiUsers.uName;
         this.level.text = this.mutiUsers.level.toString();
      }
      
      public function getSid() : uint
      {
         if(this.mutiUsers)
         {
            return this.mutiUsers.sid;
         }
         return 0;
      }
      
      public function step() : void
      {
         if(this.isClose || this.isEmpty)
         {
            return;
         }
         if(gc.nodeInfo.isStartIng())
         {
            this.drawHp();
         }
      }
      
      private function drawHp() : void
      {
         var rate:Number = NaN;
         var height:Number = NaN;
         var totalHp:uint = 0;
         var totalsHp:uint = 0;
         this.hpShape.graphics.clear();
         if(this.mutiUsers)
         {
            rate = this.mutiUsers.hp / this.mutiUsers.shp;
            if(rate >= 0 && rate <= 1)
            {
               height = rate * 60;
               this.hpShape.graphics.beginFill(16711680,0.5);
               this.hpShape.graphics.drawRect(0,60 - height,59,height);
               this.hpShape.graphics.endFill();
            }
         }
      }
   }
}
