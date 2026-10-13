package export.level.StageListener151Child
{
   import base.BaseHero;
   import config.Config;
   import flash.display.Sprite;
   import flash.text.TextField;
   import my.MyEquipObj;
   
   public class Stage151Info extends Sprite
   {
       
      
      public var longHunTf:TextField;
      
      public var upRateTf:TextField;
      
      private var gc:Config;
      
      public function Stage151Info(longhun:uint)
      {
         super();
         gc = Config.getInstance();
         this.longHunTf.text = longhun.toString();
         var upRate:Number = longhun / 10;
         if(upRate > 2.4)
         {
            upRate = 2.4;
         }
         else if(upRate < 0.5)
         {
            upRate = 0.5;
         }
         this.upRateTf.text = upRate.toString();
         var equip:MyEquipObj = gc.allEquip.findByName("qljfb");
         equip.setEupdata(upRate);
         for each(var bh in gc.getPlayerArray())
         {
            bh.getPlayer().zblist.push(equip);
         }
      }
      
      public function destroy() : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
