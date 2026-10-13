package export.huodong.starPet
{
   import export.huodong.miaomiaoBase.MiaoMiaoBaseInterface;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class StarPetPresent extends MiaoMiaoBaseInterface
   {
       
      
      public function StarPetPresent()
      {
         super();
      }
      
      override protected function gClick(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://my.4399.com/forums-thread-tagid-80615-id-44786885.html"),"_blank");
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
