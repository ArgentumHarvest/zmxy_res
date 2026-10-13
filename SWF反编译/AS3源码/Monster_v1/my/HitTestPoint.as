package my
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.filters.BevelFilter;
   import flash.filters.BlurFilter;
   import flash.filters.GlowFilter;
   
   public class HitTestPoint extends MovieClip
   {
       
      
      private var mGra:Sprite;
      
      private var num1:Sprite;
      
      private var num2:Sprite;
      
      private var num3:Sprite;
      
      private var num4:Sprite;
      
      private var blurFilter:BlurFilter;
      
      private var bevelFilter:BevelFilter;
      
      private var glowFliter:GlowFilter;
      
      private var filterArray:Array;
      
      private var direct:String = "right";
      
      public function HitTestPoint()
      {
         super();
         this.mGra = new Sprite();
         this.mGra.y = 200;
         this.addChild(this.mGra);
         this.num1 = new Sprite();
         this.num1.x = 10;
         this.mGra.addChild(this.num1);
         this.num2 = new Sprite();
         this.num2.x = 140;
         this.mGra.addChild(this.num2);
         this.num3 = new Sprite();
         this.num3.x = 270;
         this.mGra.addChild(this.num3);
         this.num4 = new Sprite();
         this.num4.x = 390;
         this.mGra.addChild(this.num4);
         this.blurFilter = new BlurFilter(5,5,3);
         this.bevelFilter = new BevelFilter();
         this.glowFliter = new GlowFilter(16711680,0.8);
         this.filterArray = [this.blurFilter,this.bevelFilter,this.glowFliter];
         this.mGra.filters = this.filterArray;
      }
      
      public function destroy() : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      public function step() : void
      {
         this.num1.graphics.clear();
         this.num2.graphics.clear();
         this.num3.graphics.clear();
         this.num4.graphics.clear();
         this.num1.graphics.lineStyle(2,16711680,0);
         this.num1.graphics.beginFill(65280,1);
         this.num1.graphics.drawRect(0,0,20,60);
         this.num1.graphics.drawRect(0,60,90,20);
         this.num1.graphics.drawRect(40,0,20,60);
         this.num1.graphics.drawRect(40,80,20,40);
         this.num1.graphics.endFill();
         this.num2.graphics.beginFill(65280,1);
         this.num2.graphics.drawRect(0,0,80,20);
         this.num2.graphics.drawRect(60,20,20,100);
         this.num2.graphics.drawRect(10,50,50,20);
         this.num2.graphics.drawRect(0,100,60,20);
         this.num2.graphics.endFill();
         this.num3.graphics.beginFill(65280,1);
         this.num3.graphics.drawRect(0,0,80,20);
         this.num3.graphics.drawRect(0,20,20,30);
         this.num3.graphics.drawRect(60,20,20,30);
         this.num3.graphics.drawRect(0,50,80,20);
         this.num3.graphics.drawRect(60,70,20,50);
         this.num3.graphics.drawRect(0,100,60,20);
         this.num3.graphics.endFill();
         this.num4.graphics.beginFill(65280,1);
         this.num4.graphics.drawRect(0,0,80,20);
         this.num4.graphics.drawRect(0,20,20,30);
         this.num4.graphics.drawRect(60,20,20,30);
         this.num4.graphics.drawRect(0,50,80,20);
         this.num4.graphics.drawRect(60,70,20,50);
         this.num4.graphics.drawRect(0,100,60,20);
         this.num4.graphics.endFill();
         if(this.direct == "right")
         {
            ++this.mGra.x;
            if(this.mGra.x >= 200)
            {
               this.direct = "left";
            }
         }
         else
         {
            --this.mGra.x;
            if(this.mGra.x <= 0)
            {
               this.direct = "right";
            }
         }
         this.blurFilter.blurX += (Math.random() - 0.5) * 2;
         this.blurFilter.blurY += (Math.random() - 0.5) * 2;
         if(this.blurFilter.blurX > 15)
         {
            this.blurFilter.blurX = 15;
         }
         if(this.blurFilter.blurY > 15)
         {
            this.blurFilter.blurY = 15;
         }
         this.bevelFilter.blurX += (Math.random() - 0.5) * 2;
         this.bevelFilter.blurY += (Math.random() - 0.5) * 2;
         if(this.bevelFilter.blurX > 15)
         {
            this.bevelFilter.blurX = 15;
         }
         if(this.bevelFilter.blurY > 15)
         {
            this.bevelFilter.blurY = 15;
         }
         this.glowFliter.blurX += (Math.random() - 0.5) * 2;
         this.glowFliter.blurY += (Math.random() - 0.5) * 2;
         if(this.glowFliter.blurX > 15)
         {
            this.glowFliter.blurX = 15;
         }
         if(this.glowFliter.blurY > 15)
         {
            this.glowFliter.blurY = 15;
         }
         this.mGra.filters = this.filterArray;
      }
   }
}
