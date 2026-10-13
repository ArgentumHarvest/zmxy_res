package export.huodong.fruit
{
   import config.Config;
   import event.CommonEvent;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.TextField;
   import mvc.controllor.RandomControllor;
   import my.MyEquipObj;
   import petInfo.PetInfo;
   
   public class GinsengFruitInterface extends Sprite
   {
       
      
      private var urlLoader:URLLoader;
      
      private var gc:Config;
      
      public var xbtn:SimpleButton;
      
      public var lqbtn:SimpleButton;
      
      public var gbtn:SimpleButton;
      
      public var dhtxt:TextField;
      
      public var greenBtn:SimpleButton;
      
      public var blueBtn:SimpleButton;
      
      public var redBtn:SimpleButton;
      
      public var contenttxt:TextField;
      
      private var currentColor:int = 0;
      
      private var lastBtn:String = "";
      
      private var btnState;
      
      public function GinsengFruitInterface()
      {
         super();
         gc = Config.getInstance();
         this.addEventListener("addedToStage",added);
         this.addEventListener("removedFromStage",removed);
      }
      
      private function added(e:Event) : void
      {
         this.removeEventListener("addedToStage",added);
         xbtn.addEventListener("click",xClick);
         lqbtn.addEventListener("click",lqClick);
         gbtn.addEventListener("click",gClick);
         greenBtn.addEventListener("click",greenClick);
         blueBtn.addEventListener("click",blueClick);
         redBtn.addEventListener("click",redClick);
         gbtn.visible = false;
      }
      
      private function removed(e:Event) : void
      {
         this.removeEventListener("removedFromStage",removed);
         xbtn.removeEventListener("click",xClick);
         lqbtn.removeEventListener("click",lqClick);
         gbtn.removeEventListener("click",gClick);
         greenBtn.removeEventListener("click",greenClick);
         blueBtn.removeEventListener("click",blueClick);
         redBtn.removeEventListener("click",redClick);
      }
      
      private function greenClick(e:MouseEvent) : void
      {
         this.currentColor = 1;
         if(btnState)
         {
            if(lastBtn != "")
            {
               this[lastBtn].upState = btnState;
            }
         }
         lastBtn = "greenBtn";
         btnState = e.target.upState;
         e.target.upState = e.target.downState;
         this.contenttxt.text = "绿色礼包内容：摇光石x3，龙女的眼泪x10";
      }
      
      private function blueClick(e:MouseEvent) : void
      {
         this.currentColor = 2;
         if(btnState)
         {
            if(lastBtn != "")
            {
               this[lastBtn].upState = btnState;
            }
         }
         lastBtn = "blueBtn";
         btnState = e.target.upState;
         e.target.upState = e.target.downState;
         this.contenttxt.text = "蓝色礼包内容：牛魔王的怒吼x1,转轮王的哀嚎x1";
      }
      
      private function redClick(e:MouseEvent) : void
      {
         this.currentColor = 3;
         if(btnState)
         {
            if(lastBtn != "")
            {
               this[lastBtn].upState = btnState;
            }
         }
         lastBtn = "redBtn";
         btnState = e.target.upState;
         e.target.upState = e.target.downState;
         this.contenttxt.text = "红色礼包内容：丑牛元帅";
      }
      
      private function gClick(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://t.huodong.4399.com/zmxy/renshenguo/"),"_blank");
      }
      
      private function lqClick(e:MouseEvent) : void
      {
         var urlReuest:* = null;
         if(this.currentColor <= 0)
         {
            gc.ts.setTxt("请选择礼包颜色");
            gc.stage.addChild(gc.ts);
            return;
         }
         if(this.currentColor == 1)
         {
            if((gc.player1.getSomeOneEquipNumberByName("wplvdyl") <= 0 || gc.player1.getSomeOneEquipNumberByName("wpygs") <= 0) && gc.player1.djlist.length >= gc.player1.getMax())
            {
               gc.ts.setTxt("道具栏已满");
               gc.stage.addChild(gc.ts);
               return;
            }
         }
         else if(this.currentColor == 2)
         {
            if(gc.player1.zblist.length >= gc.player1.getMax())
            {
               gc.ts.setTxt("装备栏已满");
               gc.stage.addChild(gc.ts);
               return;
            }
         }
         else if(this.currentColor == 3)
         {
            if(gc.gameVip.getVipLevel() >= 3)
            {
               if(gc.player1.petsAry.length >= 10)
               {
                  gc.ts.setTxt("宠物栏已满");
                  gc.stage.addChild(gc.ts);
                  return;
               }
            }
            else if(gc.player1.petsAry.length >= 5)
            {
               gc.ts.setTxt("宠物栏已满");
               gc.stage.addChild(gc.ts);
               return;
            }
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
            urlReuest = new URLRequest("https://huodong3.4399.com/zmxy/renshenguo/api.php?color=" + this.currentColor + "&code=" + cid + "&rnd=" + RandomControllor.getIns().getRandom());
            urlLoader.load(urlReuest);
         }
      }
      
      private function completeHandler(e:Event) : void
      {
         var exictmask:Sprite = gc.stage.getChildByName("execuitionActionrenewalse") as Sprite;
         if(exictmask)
         {
            gc.stage.removeChild(exictmask);
            exictmask = null;
         }
         urlLoader.removeEventListener("complete",completeHandler);
         urlLoader.removeEventListener("ioError",errorHandle);
         urlLoader.removeEventListener("securityError",errorHandle);
         var ary:Array = String(urlLoader.data).split("|");
         if(ary[0] == "1")
         {
            this.getPresent();
            if(gc.isHideDebug)
            {
               gc.memory.setStorage(gc.luanqibazaojiami.saveId);
            }
         }
         else
         {
            if(ary[1] == "002")
            {
               gc.ts.setTxt("已经结束兑换");
            }
            else if(ary[1] == "003")
            {
               gc.ts.setTxt("未登录");
            }
            else if(ary[1] == "004")
            {
               gc.ts.setTxt("兑换码无效");
            }
            else if(ary[1] == "005")
            {
               gc.ts.setTxt("参数有误");
            }
            else
            {
               gc.ts.setTxt("领取失败");
            }
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function getPresent() : void
      {
         var eq:* = null;
         var eq2:* = null;
         if(this.currentColor == 1)
         {
            if(gc.player1.roleid > 0)
            {
               gc.putQhsInBackPack(gc.player1,"wpygs",3);
               gc.putQhsInBackPack(gc.player1,"wplvdyl",10);
               gc.ts.setTxt("成功领取摇光石x3，龙女的眼泪x10");
               gc.stage.addChild(gc.ts);
            }
         }
         else if(this.currentColor == 2)
         {
            eq = gc.allEquip.findByName("nmwdnh");
            gc.player1.zblist.push(eq);
            eq2 = gc.allEquip.findByName("zlwdah");
            gc.player1.zblist.push(eq2);
            gc.ts.setTxt("成功领取牛魔王的怒吼x1,转轮王的哀嚎x1");
            gc.stage.addChild(gc.ts);
         }
         else if(this.currentColor == 3)
         {
            if(gc.player1.roleid > 0)
            {
               gc.player1.petsAry.push(this.getNeatPetInfo());
            }
            gc.ts.setTxt("成功领取丑牛元帅");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function getNeatPetInfo() : PetInfo
      {
         var pif:PetInfo = new PetInfo();
         pif.setPetNameAndLevel("neat1",1);
         pif.setperception(gc.dataObject.two + Math.round(RandomControllor.getIns().getRandom() * gc.dataObject.three));
         pif.setwarpower(gc.dataObject.two + Math.round(RandomControllor.getIns().getRandom() * gc.dataObject.two));
         pif.settechnique(gc.dataObject.two + Math.round(RandomControllor.getIns().getRandom() * gc.dataObject.two));
         pif.sethpQuality((1100 + Math.round(RandomControllor.getIns().getRandom() * 300)) * 1.3);
         pif.setmpQuality((100 + Math.round(RandomControllor.getIns().getRandom() * 100)) * 1.3);
         pif.setatkQuality((1000 + Math.round(RandomControllor.getIns().getRandom() * 400)) * 1.3);
         pif.setdefQuality((100 + Math.round(RandomControllor.getIns().getRandom() * 300)) * 1.3);
         pif.setHp(1200);
         pif.setMp(200);
         pif.setAtk(60);
         pif.setDef(8);
         pif.setSHp(pif.getHp());
         pif.setSMp(pif.getMp());
         return pif;
      }
      
      private function errorHandle(e:Event) : void
      {
         var exictmask:Sprite = gc.stage.getChildByName("execuitionActionrenewalse") as Sprite;
         if(exictmask)
         {
            gc.stage.removeChild(exictmask);
            exictmask = null;
         }
         urlLoader.removeEventListener("complete",completeHandler);
         urlLoader.removeEventListener("ioError",errorHandle);
         urlLoader.removeEventListener("securityError",errorHandle);
      }
      
      private function xClick(e:MouseEvent) : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         gc.eventManger.dispatchEvent(new CommonEvent("OPEN_HUODONG_INTERFACE"));
      }
   }
}
