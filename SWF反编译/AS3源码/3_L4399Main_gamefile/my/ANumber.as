package my
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   
   public class ANumber extends Sprite
   {
       
      
      public var isUse:Boolean = false;
      
      var stime:uint = 0;
      
      var sid:uint;
      
      public function ANumber()
      {
         super();
      }
      
      public function aNumMC(name:String, num:int, x:int, y:int, distance:int) : *
      {
         var i:* = undefined;
         var j:* = 0;
         var obj:* = null;
         this.removeAllChildren();
         for(i = 0; i < String(num).length; )
         {
            j = uint(int(String(num).charAt(i)));
            obj = AUtils.getNewObj(name + j) as DisplayObject;
            obj.x = i * distance;
            addChild(obj);
            i++;
         }
         this.x = x;
         this.y = y;
         this.isUse = true;
      }
      
      public function aNumImage(name:String, num:int, x:int, y:int, distance:int) : *
      {
         var i:* = undefined;
         var j:* = 0;
         var obj:* = undefined;
         this.removeAllChildren();
         for(i = 0; i < String(num).length; )
         {
            j = uint(int(String(num).charAt(i)));
            obj = AUtils.getImageObj(name + j);
            obj.x = i * distance;
            addChild(obj);
            i++;
         }
         sid = setInterval(update,40);
         this.x = x;
         this.y = y;
         this.isUse = true;
      }
      
      private function removeAllChildren() : void
      {
         while(this.numChildren > 0)
         {
            this.removeChildAt(0);
         }
      }
      
      public function update() : *
      {
         y -= 3;
         stime++;
         if(stime > 30)
         {
            this.isUse = false;
            this.removeAllChildren();
            stime = 0;
            clearInterval(sid);
            if(this.parent)
            {
               this.parent.removeChild(this);
            }
            return;
         }
      }
   }
}
