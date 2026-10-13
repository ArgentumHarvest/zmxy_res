package export.huodong
{
   import config.*;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.*;
   import flash.net.*;
   
   public class NightYears extends Sprite
   {
       
      
      public var btn_x:SimpleButton;
      
      public var btn_1:SimpleButton;
      
      public var btn_2:SimpleButton;
      
      public var btn_3:SimpleButton;
      
      private var gc:Config;
      
      private var urlLoader:URLLoader;
      
      public function NightYears()
      {
         super();
         this.gc = Config.getInstance();
         this.addEventListener(Event.ADDED_TO_STAGE,this.added,false,0,true);
         this.addEventListener(Event.REMOVED_FROM_STAGE,this.removed,false,0,true);
      }
      
      private function added(param1:Event) : void
      {
         this.btn_1.addEventListener(MouseEvent.CLICK,this.zhuwei_1);
         this.btn_2.addEventListener(MouseEvent.CLICK,this.zhuwei_2);
         this.btn_3.addEventListener(MouseEvent.CLICK,this.zhuwei_3);
         this.btn_x.addEventListener(MouseEvent.CLICK,this.backClick);
      }
      
      private function removed(param1:Event) : void
      {
         this.btn_1.removeEventListener(MouseEvent.CLICK,this.zhuwei_1);
         this.btn_2.removeEventListener(MouseEvent.CLICK,this.zhuwei_2);
         this.btn_3.removeEventListener(MouseEvent.CLICK,this.zhuwei_3);
         this.btn_x.removeEventListener(MouseEvent.CLICK,this.backClick);
      }
      
      private function backClick(param1:*) : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function zhuwei_1(param1:*) : void
      {
         navigateToURL(new URLRequest("http://my.4399.com/forums/mtag-84526"),"_blank");
         if(this.gc.zhuwei_1_times < this.gc.ZHUWEI_1_PER_DAY_TIMES)
         {
            ++this.gc.zhuwei_1_times;
            this.gc.gongxun += 10;
            this.gc.showFloatTip("获得 战功 + " + 10);
            if(this.gc.isHideDebug)
            {
               this.gc.memory.setStorage(this.gc.saveId);
            }
         }
      }
      
      private function zhuwei_2(param1:*) : void
      {
         navigateToURL(new URLRequest("http://bbs.4399.cn/forums-mtag-84541"),"_blank");
         if(this.gc.zhuwei_2_times < this.gc.ZHUWEI_2_PER_DAY_TIMES)
         {
            ++this.gc.zhuwei_2_times;
            this.gc.gongxun += 10;
            this.gc.showFloatTip("获得 战功 + " + 10);
            if(this.gc.isHideDebug)
            {
               this.gc.memory.setStorage(this.gc.saveId);
            }
         }
      }
      
      private function zhuwei_3(param1:*) : void
      {
         navigateToURL(new URLRequest("http://huodong2.4399.com/2020/zmxyonline/"),"_blank");
         if(this.gc.zhuwei_3_times < this.gc.ZHUWEI_3_PER_DAY_TIMES)
         {
            ++this.gc.zhuwei_3_times;
            this.gc.gongxun += 10;
            this.gc.showFloatTip("获得 战功 + " + 10);
            if(this.gc.isHideDebug)
            {
               this.gc.memory.setStorage(this.gc.saveId);
            }
         }
      }
   }
}
