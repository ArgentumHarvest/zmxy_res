package export.huodong.miaomiaoBase
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class MonkeyYearPresent2016 extends MiaoMiaoBaseInterface
   {
       
      
      public function MonkeyYearPresent2016()
      {
         super();
      }
      
      override protected function gClick(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://my.4399.com/events/2016/newyear/index-ref-57"),"_blank");
      }
      
      override protected function lqClick(e:MouseEvent) : void
      {
         var str:* = null;
         str = null;
         var exictmask:* = null;
         var bool:Boolean = false;
         if(gc.player1.roleid > 0)
         {
            str = "1P";
            if(gc.gameVip.getVipLevel() >= 3)
            {
               if(gc.player1.petsAry.length >= 10)
               {
                  str += "宠物栏已满";
               }
            }
            else if(gc.player1.petsAry.length >= 5)
            {
               str += "宠物栏已满";
            }
            if(gc.player1.zblist.length >= gc.player1.getMax())
            {
               str += "装备栏已满  ";
            }
            if(gc.player1.szlist.length >= gc.player1.getMax())
            {
               str += "时装栏已满  ";
            }
            if(str != "1P")
            {
               bool = true;
            }
         }
         if(!bool)
         {
            if(gc.player2.roleid > 0)
            {
               str = "2P";
               if(gc.gameVip.getVipLevel() >= 3)
               {
                  if(gc.player2.petsAry.length >= 10)
                  {
                     str += "宠物栏已满";
                  }
               }
               else if(gc.player2.petsAry.length >= 5)
               {
                  str += "宠物栏已满";
               }
               if(gc.player2.zblist.length >= gc.player2.getMax())
               {
                  str += "装备栏已满  ";
               }
               if(gc.player2.szlist.length >= gc.player2.getMax())
               {
                  str += "时装栏已满  ";
               }
               if(str != "2P")
               {
                  bool = true;
               }
            }
         }
         if(bool)
         {
            exictmask = gc.stage.getChildByName("execuitionActionrenewalse") as Sprite;
            if(exictmask)
            {
               gc.stage.removeChild(exictmask);
               exictmask = null;
            }
            gc.ts.setTxt(str);
            gc.stage.addChild(gc.ts);
            return;
         }
         super.lqClick(e);
      }
   }
}
