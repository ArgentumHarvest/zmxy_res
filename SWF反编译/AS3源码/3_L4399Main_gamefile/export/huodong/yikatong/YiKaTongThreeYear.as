package export.huodong.yikatong
{
   import com.adobe.crypto.MD5;
   import export.huodong.miaomiaoBase.MiaoMiaoBaseInterface;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.net.navigateToURL;
   
   public class YiKaTongThreeYear extends MiaoMiaoBaseInterface
   {
       
      
      public var cjxbtn:SimpleButton;
      
      public var cjdbtn:SimpleButton;
      
      public var dhxbtn:SimpleButton;
      
      public var dhdbtn:SimpleButton;
      
      private var lastBtn:String = "";
      
      private var btnState;
      
      public function YiKaTongThreeYear()
      {
         super();
      }
      
      override protected function added(e:Event) : void
      {
         super.added(e);
         cjxbtn.addEventListener("click",btnClick);
         cjdbtn.addEventListener("click",btnClick);
         dhxbtn.addEventListener("click",btnClick);
         dhdbtn.addEventListener("click",btnClick);
         cjxbtn.dispatchEvent(new MouseEvent("click"));
      }
      
      override protected function removed(e:Event) : void
      {
         super.removed(e);
         cjxbtn.removeEventListener("click",btnClick);
         cjdbtn.removeEventListener("click",btnClick);
         dhxbtn.removeEventListener("click",btnClick);
         dhdbtn.removeEventListener("click",btnClick);
      }
      
      private function btnClick(e:MouseEvent) : void
      {
         if(btnState)
         {
            if(lastBtn != "")
            {
               this[lastBtn].upState = btnState;
            }
         }
         lastBtn = e.target.name;
         btnState = e.target.upState;
         e.target.upState = e.target.downState;
         if(lastBtn == "cjxbtn")
         {
            gc.dataObject.yktusewhichlb = 1;
         }
         else if(lastBtn == "cjdbtn")
         {
            gc.dataObject.yktusewhichlb = 2;
         }
         else if(lastBtn == "dhxbtn")
         {
            gc.dataObject.yktusewhichlb = 3;
         }
         else if(lastBtn == "dhdbtn")
         {
            gc.dataObject.yktusewhichlb = 4;
         }
      }
      
      override protected function gClick(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://web.4399.com/card/3year/"),"_blank");
      }
      
      override protected function lqClick(e:MouseEvent) : void
      {
         var exictmask:* = null;
         var urlVariables:* = null;
         var key:* = null;
         var token:* = null;
         var urlReuest:* = null;
         var bool:Boolean = false;
         var str:String = "1P";
         if(gc.dataObject.yktusewhichlb == 1)
         {
            if(gc.player1.roleid > 0)
            {
               if(gc.player1.getSomeOneEquipNumberByName("mpyj") <= 0 && gc.player1.djlist.length >= gc.player1.getMax())
               {
                  str += "道具栏已满 ";
               }
               else if(gc.player1.getSomeOneEquipNumberByName("lhys") <= 0 && gc.player1.djlist.length >= gc.player1.getMax())
               {
                  str += "道具栏已满 ";
               }
            }
            if(str != "1P")
            {
               bool = true;
            }
         }
         else if(gc.dataObject.yktusewhichlb == 2)
         {
            if(gc.player1.roleid > 0)
            {
               if(gc.player1.getSomeOneEquipNumberByName("wpsh_1") <= 0 && gc.player1.djlist.length >= gc.player1.getMax())
               {
                  str += "道具栏已满 ";
               }
               else if(gc.player1.getSomeOneEquipNumberByName("wpst_1") <= 0 && gc.player1.djlist.length >= gc.player1.getMax())
               {
                  str += "道具栏已满 ";
               }
            }
            if(str != "1P")
            {
               bool = true;
            }
         }
         else if(gc.dataObject.yktusewhichlb == 3)
         {
            if(gc.player1.roleid > 0)
            {
               if(gc.player1.getSomeOneEquipNumberByName("sbjyd") <= 0 && gc.player1.djlist.length >= gc.player1.getMax())
               {
                  str += "道具栏已满 ";
               }
            }
            if(str != "1P")
            {
               bool = true;
            }
         }
         else if(gc.dataObject.yktusewhichlb == 4)
         {
            if(gc.player1.roleid > 0)
            {
               if(gc.player1.getSomeOneEquipNumberByName("wpsh_2") <= 0 && gc.player1.djlist.length >= gc.player1.getMax())
               {
                  str += "道具栏已满 ";
               }
               else if(gc.player1.getSomeOneEquipNumberByName("wpst_2") <= 0 && gc.player1.djlist.length >= gc.player1.getMax())
               {
                  str += "道具栏已满 ";
               }
               else if(gc.player1.getSomeOneEquipNumberByName("wpsh_3") <= 0 && gc.player1.djlist.length >= gc.player1.getMax())
               {
                  str += "道具栏已满 ";
               }
               else if(gc.player1.getSomeOneEquipNumberByName("wpst_3") <= 0 && gc.player1.djlist.length >= gc.player1.getMax())
               {
                  str += "道具栏已满 ";
               }
            }
            if(str != "1P")
            {
               bool = true;
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
         var cid:String = this.dhtxt.text;
         for(var clen:uint = cid.length; clen-- > 0; )
         {
            cid = cid.replace(" ","");
         }
         if(cid != "")
         {
            gc.addActionMask("renewalse");
            urlLoader = new URLLoader();
            urlLoader.dataFormat = "text";
            urlLoader.addEventListener("complete",completeHandler);
            urlLoader.addEventListener("ioError",errorHandle);
            urlLoader.addEventListener("securityError",errorHandle);
            urlVariables = new URLVariables();
            urlVariables.activation = cid;
            urlVariables.uid = gc.logInfo.uid;
            urlVariables.type = "1";
            key = "";
            if(gc.dataObject.yktusewhichlb == 1)
            {
               key = "b71f28eb0a4f2f07c7ccd1503b9784bf";
               urlVariables.product_id = 1628;
            }
            else if(gc.dataObject.yktusewhichlb == 2)
            {
               key = "5ad93295909401f78c21a3dcca3be92b";
               urlVariables.product_id = 1630;
            }
            else if(gc.dataObject.yktusewhichlb == 3)
            {
               key = "3e8d6ed7d0c6914438b9965659adeb9d";
               urlVariables.product_id = 1632;
            }
            else if(gc.dataObject.yktusewhichlb == 4)
            {
               key = "fe78253fde8c585a04623ed8f13e2bf0";
               urlVariables.product_id = 1634;
            }
            token = MD5.hash(urlVariables.activation + urlVariables.product_id + urlVariables.type + urlVariables.uid + key);
            urlVariables.token = token;
            urlReuest = new URLRequest("https://my.4399.com/jifen/api-apply");
            urlReuest.method = "POST";
            urlReuest.data = urlVariables;
            urlLoader.load(urlReuest);
         }
      }
      
      override protected function getPresent(_result:uint) : void
      {
         if(gc.dataObject.yktusewhichlb == 1)
         {
            this.cjSmallPresent();
         }
         else if(gc.dataObject.yktusewhichlb == 2)
         {
            this.cjBigPresent();
         }
         else if(gc.dataObject.yktusewhichlb == 3)
         {
            this.dhSmallPresent();
         }
         else if(gc.dataObject.yktusewhichlb == 4)
         {
            this.dhBigPresent();
         }
         if(gc.isHideDebug)
         {
            gc.memory.setStorage(gc.luanqibazaojiami.saveId);
         }
      }
      
      private function cjSmallPresent() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"mpyj",1);
            gc.putQhsInBackPack(gc.player1,"lhys",1);
            gc.dataObject.worldtransfromTimes += 3;
         }
         gc.ts.setTxt("成功领取孟婆药剂x1、灵魂药水x1、世界传送x3");
         gc.stage.addChild(gc.ts);
      }
      
      private function cjBigPresent() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpsh_1",1);
            gc.putQhsInBackPack(gc.player1,"wpst_1",1);
            gc.dataObject.worldtransfromTimes += 9;
         }
         gc.ts.setTxt("成功领取一重神火x1、一重神铁x1、世界传送x9");
         gc.stage.addChild(gc.ts);
      }
      
      private function dhSmallPresent() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"sbjyd",1);
            gc.dataObject.worldtransfromTimes += 6;
         }
         gc.ts.setTxt("成功领取双倍经验丹x1、世界传送x6");
         gc.stage.addChild(gc.ts);
      }
      
      private function dhBigPresent() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpsh_2",1);
            gc.putQhsInBackPack(gc.player1,"wpst_2",1);
            gc.putQhsInBackPack(gc.player1,"wpsh_3",1);
            gc.putQhsInBackPack(gc.player1,"wpst_3",1);
         }
         gc.ts.setTxt("成功领取二重神火x1、二重神铁x1、三重神火x1、三重神铁x1");
         gc.stage.addChild(gc.ts);
      }
   }
}
