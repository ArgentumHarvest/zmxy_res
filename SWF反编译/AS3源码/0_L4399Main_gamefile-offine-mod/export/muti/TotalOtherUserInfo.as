package export.muti
{
   import config.Config;
   import flash.display.Sprite;
   import user.MutiUser;
   
   public class TotalOtherUserInfo extends Sprite
   {
       
      
      public var o1:Sprite;
      
      public var o2:Sprite;
      
      public var o3:Sprite;
      
      public var o4:Sprite;
      
      public var o5:Sprite;
      
      public var o6:Sprite;
      
      private var gc:Config;
      
      private var posArray:Array;
      
      private var singArray:Array;
      
      public function TotalOtherUserInfo()
      {
         var j:* = 0;
         var sing:* = null;
         var i:* = 0;
         posArray = [[11,13],[75,13],[153,13],[218,13],[297,13],[360,13]];
         singArray = [];
         super();
         for(j = uint(0); j < 6; )
         {
            sing = new SingleOtherUserInfo();
            sing.x = posArray[j][0];
            sing.y = posArray[j][1];
            this.addChild(sing);
            this.singArray.push(sing);
            j++;
         }
         gc = Config.getInstance();
         switch(gc.nodeInfo.GameMode)
         {
            case ArenaSprite.ARENASPRITE_MODE_1V1:
               for(i = uint(1 * gc.nodeInfo.singleIdPlayerNum); i < 6; )
               {
                  SingleOtherUserInfo(singArray[i]).close();
                  i++;
               }
               break;
            case ArenaSprite.ARENASPRITE_MODE_HUNZHAN:
               for(i = uint(3 * gc.nodeInfo.singleIdPlayerNum); i < 6; )
               {
                  SingleOtherUserInfo(singArray[i]).close();
                  i++;
               }
               break;
            case ArenaSprite.ARENASPRITE_FUBEN1:
               for(i = uint(1 * gc.nodeInfo.singleIdPlayerNum); i < 6; )
               {
                  SingleOtherUserInfo(singArray[i]).close();
                  i++;
               }
               break;
            case ArenaSprite.ARENASPRITE_FUBEN2:
               for(i = uint(3 * gc.nodeInfo.singleIdPlayerNum); i < 6; )
               {
                  SingleOtherUserInfo(singArray[i]).close();
                  i++;
               }
         }
      }
      
      public function step() : void
      {
         var i:* = 0;
         for(i = uint(0); i < 6; )
         {
            SingleOtherUserInfo(singArray[i]).step();
            i++;
         }
      }
      
      public function addOne(mutiUser:MutiUser) : void
      {
         var i:* = 0;
         trace("TotalOtherUserInfo-->addOne->sid：" + mutiUser.sid);
         for(i = uint(0); i < 6; )
         {
            if(SingleOtherUserInfo(singArray[i]).isEmptyd())
            {
               SingleOtherUserInfo(singArray[i]).addMutiUserInfo(mutiUser);
               break;
            }
            if(SingleOtherUserInfo(singArray[i]).mutiUsers == mutiUser)
            {
               return;
            }
            i++;
         }
      }
      
      public function removeOne(sid:int) : void
      {
         var i:* = 0;
         trace("TotalOtherUserInfo-->removeOne->sid：" + sid);
         for(i = uint(0); i < 6; )
         {
            if(SingleOtherUserInfo(singArray[i]).getSid() == sid)
            {
               SingleOtherUserInfo(singArray[i]).setEmpty();
            }
            i++;
         }
      }
      
      public function clear() : void
      {
         var i:* = 0;
         for(i = uint(0); i < 6; )
         {
            SingleOtherUserInfo(singArray[i]).setEmpty();
            i++;
         }
      }
   }
}
