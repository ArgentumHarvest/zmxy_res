package my
{
   import base.BaseHero;
   import base.BaseObject;
   import com.greensock.TweenMax;
   import config.Config;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   
   public class FallEquipObj extends BaseObject
   {
       
      
      private var jObj;
      
      private var urlLoader:URLLoader;
      
      private var newMyEquip:MyEquipObj;
      
      private var eobj:Object;
      
      private var tcount:uint = 0;
      
      private var bosslist:Array;
      
      var isfirst:Boolean = true;
      
      public function FallEquipObj(param1:Object)
      {
         this.bosslist = ["dslj","dsyj","dsqz","tsgl","tsyp","tsyj","xhyk","xhxh","xhmj","qxsh","jhcz","ryjgb","zljs","dszk","bhz","qld","xwj","qlp","zqj","jcsz","jcbj","jcys"];
         super();
         gc = Config.getInstance();
         this.eobj = param1;
         var _loc2_:* = AUtils.getImageObj("fall_" + this.eobj.name);
         _loc2_.x = -_loc2_.width / 2;
         _loc2_.y = -_loc2_.height / 2;
         this.colipse = new MovieClip();
         this.colipse.addChild(_loc2_);
         addChild(this.colipse);
      }
      
      override public function step() : void
      {
         var _loc2_:BaseHero = null;
         var _loc3_:int = 0;
         this.checkCanMove();
         var _loc1_:uint = gc.getPlayerArray().length;
         while(_loc1_-- > 0)
         {
            _loc2_ = gc.getPlayerArray()[_loc1_];
            if(!(Math.abs(this.x - _loc2_.x) > 700 || _loc2_.isDead()))
            {
               if(Math.abs(this.y - _loc2_.y) < 200)
               {
                  this.colwho(_loc2_);
               }
            }
         }
         if(this.tcount++ >= 240)
         {
            this.tcount = 0;
            _loc3_ = this.bosslist.indexOf(this.eobj.name);
            if(_loc3_ == -1)
            {
               this.remove();
            }
         }
      }
      
      protected function colwho(param1:BaseHero) : void
      {
         if(this.isfirst)
         {
            if(param1.body)
            {
               if(!this.hitTestObject(param1.colipse))
               {
                  return;
               }
               if(HitTest.complexHitTestObject(this,param1.colipse))
               {
                  switch(this.eobj.bigtype)
                  {
                     case "zb":
                        if(param1.getPlayer().zblist.length < 25)
                        {
                           gc.allEquip.newMyEquipObj();
                           this.newMyEquip = gc.allEquip.findByName(this.eobj.name);
                           param1.getPlayer().zblist.push(this.newMyEquip);
                           break;
                        }
                        return;
                        break;
                     case "dj":
                        break;
                     case "rw":
                  }
                  this.isfirst = false;
                  TweenMax.to(this,0.8,{
                     "y":this.y - 100,
                     "alpha":0,
                     "onComplete":this.remove
                  });
               }
            }
         }
      }
      
      private function remove() : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         var _loc1_:int = gc.otherList.indexOf(this);
         if(_loc1_ != -1)
         {
            gc.otherList.splice(_loc1_,1);
            this.bosslist = null;
            delete global[this];
         }
         this.urlLoader = null;
         this.jObj = null;
         this.newMyEquip = null;
      }
      
      override protected function checkOver() : void
      {
         this.remove();
      }
      
      private function requestData() : void
      {
         this.urlLoader = new URLLoader();
         this.urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
         this.urlLoader.addEventListener(Event.COMPLETE,this.completeHandler);
         this.urlLoader.load(new URLRequest("http://save.api.4399.com/?ac=get_time"));
      }
      
      private function completeHandler(param1:*) : void
      {
         this.urlLoader.removeEventListener(Event.COMPLETE,this.completeHandler);
         this.jObj = JSON.parse(this.urlLoader.data);
         this.newMyEquip.setInstruction(this.jObj["time"]);
      }
   }
}
