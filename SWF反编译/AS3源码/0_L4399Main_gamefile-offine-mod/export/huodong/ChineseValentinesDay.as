package export.huodong
{
   import com.adobe.crypto.MD5;
   import config.Config;
   import event.CommonEvent;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public class ChineseValentinesDay extends Sprite
   {
       
      
      public var btn_x:SimpleButton;
      
      public var btn_go:SimpleButton;
      
      private var gc:Config;
      
      private var urlLoader:URLLoader;
      
      public function ChineseValentinesDay()
      {
         super();
         gc = Config.getInstance();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         btn_x.addEventListener("click",backClick);
      }
      
      private function removed(e:Event) : void
      {
         btn_x.removeEventListener("click",backClick);
      }
      
      private function backClick(e:*) : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function getNormalEquipByRoleId(rid:int) : Array
      {
         if(rid == 1)
         {
            return [gc.allEquip.findByName("ptdxzf"),gc.allEquip.findByName("ptdxzg"),gc.allEquip.findByName("mysz")];
         }
         if(rid == 2)
         {
            return [gc.allEquip.findByName("ptdjs"),gc.allEquip.findByName("ptdcz"),gc.allEquip.findByName("mysz")];
         }
         if(rid == 3)
         {
            return [gc.allEquip.findByName("ptddp"),gc.allEquip.findByName("ptdcs"),gc.allEquip.findByName("mysz")];
         }
         if(rid == 4)
         {
            return [gc.allEquip.findByName("ptdyyc"),gc.allEquip.findByName("ptdcp"),gc.allEquip.findByName("mysz")];
         }
         return null;
      }
      
      private function requestData() : void
      {
         var maskSprite:Sprite = new Sprite();
         maskSprite.name = "maskSprite";
         maskSprite.graphics.beginFill(16777215,0.5);
         maskSprite.graphics.drawRect(0,0,940,590);
         maskSprite.graphics.endFill();
         this.addChild(maskSprite);
         urlLoader = new URLLoader();
         urlLoader.dataFormat = "text";
         urlLoader.addEventListener("complete",completeHandler);
         urlLoader.load(new URLRequest("https://save.api.4399.com/?ac=get_time"));
         urlLoader.addEventListener("ioError",ioErrorHandler);
      }
      
      private function ioErrorHandler(e:IOErrorEvent) : void
      {
         urlLoader.load(new URLRequest("https://save.api.4399.com/?ac=get_time"));
      }
      
      private function completeHandler(e:*) : void
      {
         var sphs:* = undefined;
         var maskSprite:Sprite = gc.stage.getChildByName("maskSprite") as Sprite;
         if(maskSprite && gc.stage.contains(maskSprite))
         {
            gc.stage.removeChild(maskSprite);
         }
         urlLoader.removeEventListener("ioError",ioErrorHandler);
         urlLoader.removeEventListener("complete",completeHandler);
         var jObj:* = JSON.parse(urlLoader.data);
         var date:String = jObj["time"];
         var vaild:String = date.substr(0,10);
         var hash:String = MD5.hash(vaild);
         if(gc.hdInfo.indexOf(hash) == -1)
         {
            gc.ts.setTxt("欢迎参加活动");
            gc.hdInfo.push(hash);
            gc.curStageAndCurLevel.curStage = 9;
            gc.curStageAndCurLevel.curLevel = 1;
            gc.eventManger.dispatchEvent(new CommonEvent("selectStageOver"));
            if(this.parent)
            {
               this.parent.removeChild(this);
            }
            sphs = GMain.getInstance().getMainSence().getChildByName("SelectPlaceHasShow");
            if(sphs)
            {
               GMain.getInstance().getMainSence().removeChild(sphs);
               gc.isintheselectmap = false;
            }
         }
         else
         {
            gc.ts.setTxt("您已经参加过活动了，请明天再来吧");
         }
         gc.stage.addChild(gc.ts);
      }
   }
}
