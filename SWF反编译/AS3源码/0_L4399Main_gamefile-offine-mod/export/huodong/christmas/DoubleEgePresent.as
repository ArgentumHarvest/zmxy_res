package export.huodong.christmas
{
   import export.huodong.miaomiaoBase.MiaoMiaoBaseInterface;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class DoubleEgePresent extends MiaoMiaoBaseInterface
   {
       
      
      public function DoubleEgePresent()
      {
         super();
      }
      
      override protected function gClick(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://my.4399.com/forums-thread-tagid-80615-id-45109806.html"),"_blank");
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
            if(gc.player1.getSomeOneEquipNumberByName("wphlz") <= 0 && gc.player1.djlist.length >= gc.player1.getMax())
            {
               str += "道具栏已满 ";
            }
            if(gc.player1.getSomeOneEquipNumberByName("wpcsd") <= 0 && gc.player1.djlist.length >= gc.player1.getMax())
            {
               str += "道具栏已满 ";
            }
            if(gc.player1.getSomeOneEquipNumberByName("wplwl") <= 0 && gc.player1.djlist.length >= gc.player1.getMax())
            {
               str += "道具栏已满 ";
            }
            if(gc.player1.getSomeOneEquipNumberByName("wpygs") <= 0 && gc.player1.djlist.length >= gc.player1.getMax())
            {
               str += "道具栏已满 ";
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
               if(gc.player2.getSomeOneEquipNumberByName("wphlz") <= 0 && gc.player2.djlist.length >= gc.player2.getMax())
               {
                  str += "道具栏已满 ";
               }
               if(gc.player2.getSomeOneEquipNumberByName("wpcsd") <= 0 && gc.player2.djlist.length >= gc.player2.getMax())
               {
                  str += "道具栏已满 ";
               }
               if(gc.player2.getSomeOneEquipNumberByName("wplwl") <= 0 && gc.player2.djlist.length >= gc.player2.getMax())
               {
                  str += "道具栏已满 ";
               }
               if(gc.player2.getSomeOneEquipNumberByName("wpygs") <= 0 && gc.player2.djlist.length >= gc.player2.getMax())
               {
                  str += "道具栏已满 ";
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
