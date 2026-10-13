package export.huodong.qinglongjian
{
   import export.huodong.miaomiaoBase.MiaoMiaoBaseInterface;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class QingLongJianPresent extends MiaoMiaoBaseInterface
   {
       
      
      public function QingLongJianPresent()
      {
         super();
      }
      
      override protected function gClick(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://my.4399.com/forums-thread-tagid-80615-id-47525486.html"),"_blank");
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
            if(gc.player1.zblist.length >= gc.player1.getMax())
            {
               str += "装备栏已满 ";
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
               if(gc.player2.zblist.length >= gc.player2.getMax())
               {
                  str += "装备栏已满 ";
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
