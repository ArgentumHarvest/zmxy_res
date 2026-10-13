package export
{
   import config.Config;
   import flash.display.Sprite;
   import flash.text.TextFormat;
   
   public class HeroBuff extends Sprite
   {
      
      public static var HPUPBUFF:String = "hpupbuff";
       
      
      private var gc:Config;
      
      private var currentBuffEffectArray:Array;
      
      private var ttf:TextFormat;
      
      public function HeroBuff()
      {
         currentBuffEffectArray = [];
         super();
         gc = Config.getInstance();
         this.ttf = new TextFormat();
         this.ttf.size = 20;
         this.ttf.color = 16711680;
         this.ttf.font = "FZCuYuan-M03S";
      }
      
      public function step() : void
      {
         var i:* = 0;
         var obj:* = null;
         for(i = uint(0); i < gc.heroBuffArray.length; )
         {
            obj = gc.heroBuffArray[i];
            if(obj.count > 0)
            {
               obj.count--;
            }
            i++;
         }
      }
      
      public function addBuff(kind:int) : void
      {
         if(this.currentBuffEffectArray.indexOf(kind) == -1)
         {
            this.currentBuffEffectArray.push(kind);
         }
      }
      
      public function removeBuff(kind:int) : void
      {
      }
   }
}
