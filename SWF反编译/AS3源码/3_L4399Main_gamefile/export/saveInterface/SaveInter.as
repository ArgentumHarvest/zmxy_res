package export.saveInterface
{
   import config.Config;
   import event.CommonEvent;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class SaveInter extends Sprite
   {
       
      
      private var gc:Config;
      
      private var iscover:Sprite;
      
      private var index:int;
      
      public var state:String = "";
      
      public var btn_x:SimpleButton;
      
      public var btn_1:MovieClip;
      
      public var btn_2:MovieClip;
      
      public var btn_3:MovieClip;
      
      public var btn_4:MovieClip;
      
      public var btn_5:MovieClip;
      
      public var btn_0:MovieClip;
      
      public var infotxt:TextField;
      
      public function SaveInter()
      {
         super();
         gc = Config.getInstance();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:*) : void
      {
         var j:* = 0;
         if(GMain.serviceHold)
         {
            if(gc.currentRead == 0)
            {
               GMain.serviceHold.getList();
            }
            else
            {
               GMain.serviceHold.getSecondarySaveList();
            }
         }
         if(!gc.dealAlert)
         {
            gc.dealAlert = AUtils.getNewObj("Dealing");
            gc.dealAlert.name = "DealingAlert";
            this.addChild(gc.dealAlert);
         }
         if(!this.iscover)
         {
            this.iscover = AUtils.getNewObj("IsCover");
         }
         if(gc.isnew)
         {
            this.infotxt.text = "第一次进入游戏请选择存档";
         }
         else
         {
            this.infotxt.text = "";
         }
         this.btn_1.buttonMode = true;
         this.btn_2.buttonMode = true;
         this.btn_3.buttonMode = true;
         this.btn_4.buttonMode = true;
         this.btn_5.buttonMode = true;
         this.btn_0.buttonMode = true;
         btn_x.addEventListener("click",xClick);
         btn_1.addEventListener("click",onClick);
         btn_2.addEventListener("click",onClick);
         btn_3.addEventListener("click",onClick);
         btn_4.addEventListener("click",onClick);
         btn_5.addEventListener("click",onClick);
         btn_0.addEventListener("click",onClick);
         btn_1.addEventListener("rollOver",over);
         btn_2.addEventListener("rollOver",over);
         btn_3.addEventListener("rollOver",over);
         btn_4.addEventListener("rollOver",over);
         btn_5.addEventListener("rollOver",over);
         btn_0.addEventListener("rollOver",over);
         btn_1.addEventListener("rollOut",out);
         btn_2.addEventListener("rollOut",out);
         btn_3.addEventListener("rollOut",out);
         btn_4.addEventListener("rollOut",out);
         btn_5.addEventListener("rollOut",out);
         btn_0.addEventListener("rollOut",out);
         j = 0;
         while(j < 6)
         {
            this["btn_" + j]["txt_name"]["text"] = "空存档";
            this["btn_" + j]["txt_time"]["text"] = "";
            j++;
         }
         this.tabChildren = false;
         this.tabEnabled = false;
         btn_x.tabEnabled = false;
      }
      
      private function removed(e:*) : void
      {
         gc.currentRead = 0;
         btn_x.removeEventListener("click",xClick);
         btn_1.removeEventListener("click",onClick);
         btn_2.removeEventListener("click",onClick);
         btn_3.removeEventListener("click",onClick);
         btn_4.removeEventListener("click",onClick);
         btn_5.removeEventListener("click",onClick);
         btn_0.removeEventListener("click",onClick);
         btn_1.removeEventListener("rollOver",over);
         btn_2.removeEventListener("rollOver",over);
         btn_3.removeEventListener("rollOver",over);
         btn_4.removeEventListener("rollOver",over);
         btn_5.removeEventListener("rollOver",over);
         btn_0.removeEventListener("rollOver",over);
         btn_1.removeEventListener("rollOut",out);
         btn_2.removeEventListener("rollOut",out);
         btn_3.removeEventListener("rollOut",out);
         btn_4.removeEventListener("rollOut",out);
         btn_5.removeEventListener("rollOut",out);
         btn_0.removeEventListener("rollOut",out);
      }
      
      private function over(e:MouseEvent) : void
      {
         MovieClip(e.target).gotoAndStop(2);
      }
      
      private function out(e:MouseEvent) : void
      {
         MovieClip(e.target).gotoAndStop(1);
      }
      
      public function setIndex(array:Array) : void
      {
         var j:* = 0;
         var i:* = 0;
         var obj:Object = null;
         var e_icon:Sprite = null;
         trace("--setIndex--");
         j = 0;
         while(j < 6)
         {
            this["btn_" + j]["txt_name"]["text"] = "空存档";
            this["btn_" + j]["txt_time"]["text"] = "";
            this.removeExceptionIcom(this["btn_" + j]);
            j++;
         }
         var alen:uint = array.length;
         if(alen >= 6)
         {
            alen = 6;
         }
         i = 0;
         while(i < alen)
         {
            obj = array[i];
            if(!(obj == null || obj == ""))
            {
               trace("obj.title -->>" + obj.title + "  obj.index-->>" + obj.index);
               if(obj.title != "WareHouse")
               {
                  if(this["btn_" + obj.index])
                  {
                     if(obj)
                     {
                        if(obj.status != undefined)
                        {
                           if(obj.status != 0)
                           {
                              e_icon = AUtils.getImageSprite("account_exception_icon") as Sprite;
                              e_icon.name = "Name_account_exception_icon";
                              e_icon.x = 200;
                              e_icon.y = 23;
                              MovieClip(this["btn_" + obj.index]).tabChildren = false;
                              MovieClip(this["btn_" + obj.index]).tabEnabled = false;
                              MovieClip(this["btn_" + obj.index]).addChild(e_icon);
                           }
                        }
                        this["btn_" + obj.index]["txt_name"]["text"] = obj.title + "";
                        this["btn_" + obj.index]["txt_time"]["text"] = obj.datetime + "";
                     }
                  }
               }
            }
            i++;
         }
      }
      
      private function removeExceptionIcom(mc:MovieClip) : void
      {
         var icon:Sprite = mc.getChildByName("Name_account_exception_icon") as Sprite;
         if(icon != null)
         {
            mc.removeChild(icon);
            icon = null;
         }
      }
      
      public function clearTxt() : void
      {
         var j:* = 0;
         j = 0;
         while(j < 6)
         {
            this["btn_" + j]["txt_name"]["text"] = "空存档";
            this["btn_" + j]["txt_time"]["text"] = "";
            j++;
         }
      }
      
      private function onClick(e:MouseEvent) : void
      {
         var sgi:Sprite = null;
         index = int(String(e.currentTarget.name).substr(4,1));
         if(state == "save")
         {
            if(e.currentTarget["txt_name"]["text"] as String != "" && e.currentTarget["txt_name"]["text"] as String != "空存档")
            {
               this.addChild(iscover);
               iscover.name = "iscover";
               iscover["btn_ok"].addEventListener("click",okClick);
               iscover["btn_change"].addEventListener("click",changeClick);
            }
            else
            {
               gc.eventManger.dispatchEvent(new CommonEvent("SaveGame",[index,false]));
            }
         }
         else if(state == "read")
         {
            if(e.currentTarget["txt_name"]["text"] as String != "" && e.currentTarget["txt_name"]["text"] as String != "空存档")
            {
               gc.eventManger.dispatchEvent(new CommonEvent("ReadGame",[index]));
               this.destory();
            }
         }
      }
      
      private function okClick(e:*) : void
      {
         iscover["btn_ok"].removeEventListener("click",okClick);
         iscover["btn_change"].removeEventListener("click",changeClick);
         gc.eventManger.dispatchEvent(new CommonEvent("SaveGame",[index,true]));
         if(getChildByName("iscover") != null)
         {
            this.removeChild(iscover);
         }
         var sgi:Sprite = AUtils.getNewObj("SavingGameInterface");
         sgi.name = "SavingGameMask";
         this.addChild(sgi);
      }
      
      private function changeClick(e:*) : void
      {
         iscover["btn_ok"].removeEventListener("click",okClick);
         iscover["btn_change"].removeEventListener("click",changeClick);
         if(getChildByName("iscover") != null)
         {
            this.removeChild(iscover);
         }
      }
      
      private function xClick(e:MouseEvent) : void
      {
         this.destory();
      }
      
      private function destory() : void
      {
         if(this.state == "save")
         {
            gc.initData();
            GMain.getInstance().switchSence("GameMenu");
         }
         if(this.parent)
         {
            stage.dispatchEvent(new Event("MVC_CLOSE_PANEL"));
            this.parent.removeChild(this);
         }
      }
   }
}
