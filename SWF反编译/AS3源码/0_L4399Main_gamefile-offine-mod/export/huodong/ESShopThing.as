package export.huodong
{
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import config.Config;
   import event.CommonEvent;
   import export.renewalse.RenewalseThisSZ;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.text.TextField;
   import mvc.controllor.RandomControllor;
   import my.MyEquipObj;
   import petInfo.PetInfo;
   import user.User;
   
   public class ESShopThing extends Sprite
   {
       
      
      private var gc:Config;
      
      private var _anti:Antiwear;
      
      private var urlLoader:URLLoader;
      
      private var renewalse:RenewalseThisSZ;
      
      public var btn_buy:SimpleButton;
      
      public var txt_name:TextField;
      
      public var txt_price:TextField;
      
      private var curObj:Object;
      
      private var player:User;
      
      public function ESShopThing()
      {
         _anti = new Antiwear(new binaryEncrypt());
         curObj = {};
         super();
         gc = Config.getInstance();
         this._anti.one_point_6 = 1.6;
         this._anti.zero_point_8 = 0.8;
         renewalse = new RenewalseThisSZ();
         renewalse.name = "renewalseThisSZ";
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         btn_buy.addEventListener("click",buyClick);
      }
      
      private function removed(e:Event) : void
      {
         btn_buy.removeEventListener("click",buyClick);
      }
      
      public function setEquipment(obj:Object) : void
      {
         this.curObj = obj;
         this.txt_name.text = obj.cname + " ";
      }
      
      public function setScore(v:int) : void
      {
         this._anti.score = v;
         this.txt_price.text = v + "积分";
      }
      
      public function setImg(v:String) : void
      {
         var p:* = null;
         this._anti.img = v;
         var img:Sprite = AUtils.getImageSprite(v);
         img.name = "score_show_image";
         img.x = 15;
         if(this._anti.img == "dollImg")
         {
            img.y = 10;
         }
         else
         {
            img.y = 20;
         }
         this.addChild(img);
         if(this._anti.img == "dollImg")
         {
            p = new Point();
            if(this.contains(this.btn_buy))
            {
               p.x = this.btn_buy.x;
               p.y = this.btn_buy.y;
               this.removeChild(this.btn_buy);
            }
            this.btn_buy.x = p.x;
            this.btn_buy.y = p.y;
            this.addChild(this.btn_buy);
         }
      }
      
      public function clearEquipment() : void
      {
         if(this.getChildByName("score_show_image") != null)
         {
            this.removeChild(this.getChildByName("score_show_image"));
         }
      }
      
      private function buyClick(e:MouseEvent) : void
      {
         trace("buyClick");
         if(this._anti.img == "dollImg")
         {
            if(gc.dataObject.turntableScore >= 12001)
            {
               gc.eventManger.dispatchEvent(new Event("showDoll"));
               return;
            }
            gc.ts.setTxt("积分不足");
            gc.stage.addChild(gc.ts);
            return;
         }
         if(this.player == null)
         {
            gc.ts.setTxt("请选择要购买的角色");
            gc.stage.addChild(gc.ts);
            return;
         }
         this.addRenewalseMask("您确定要花费" + this._anti.score + "点积分?");
      }
      
      public function addRenewalseMask(inst:String) : void
      {
         renewalse["txt"].text = inst;
         GMain.getInstance().getMainSence().addChild(renewalse);
         renewalse["okbtn"].addEventListener("click",renewalseOk);
         renewalse["nobtn"].addEventListener("click",renewalseChange);
      }
      
      private function renewalseOk(e:MouseEvent) : void
      {
         var urlRequest:* = null;
         var urlVariables:* = null;
         renewalse["okbtn"].removeEventListener("click",renewalseOk);
         renewalse["nobtn"].removeEventListener("click",renewalseChange);
         var enough:Boolean = true;
         if(gc.dataObject.turntableScore < this._anti.score)
         {
            gc.ts.setTxt("积分不足");
            gc.stage.addChild(gc.ts);
            enough = false;
         }
         if(enough)
         {
            if(String(this._anti.img).indexOf("wanou") != -1)
            {
               trace("buy wanou");
            }
            else
            {
               trace("gc.dataObject.turntableScore -->>" + gc.dataObject.turntableScore);
               trace("this.curObj.score -->>" + this._anti.score);
               gc.addActionMask("renewalse");
               urlLoader = new URLLoader();
               urlLoader.dataFormat = "text";
               urlLoader.addEventListener("complete",completeHandler);
               urlLoader.addEventListener("ioError",errorHandler);
               urlLoader.addEventListener("securityError",errorHandler);
               urlRequest = new URLRequest("https://huodong2.4399.com/zaomengxiyou3/zhuanpan/duihuang.php");
               urlRequest.method = "POST";
               urlVariables = new URLVariables();
               urlVariables.ac = "mark";
               urlVariables.lp_id = this._anti.score;
               urlRequest.data = urlVariables;
               urlLoader.load(urlRequest);
            }
         }
         if(renewalse && GMain.getInstance().getMainSence().contains(renewalse))
         {
            GMain.getInstance().getMainSence().removeChild(renewalse);
         }
      }
      
      private function renewalseChange(e:MouseEvent) : void
      {
         renewalse["okbtn"].removeEventListener("click",renewalseOk);
         renewalse["nobtn"].removeEventListener("click",renewalseChange);
         if(renewalse && GMain.getInstance().getMainSence().contains(renewalse))
         {
            GMain.getInstance().getMainSence().removeChild(renewalse);
         }
      }
      
      private function completeHandler(e:Event) : void
      {
         var temp:* = null;
         var exictmask:Sprite = gc.stage.getChildByName("execuitionActionrenewalse") as Sprite;
         if(exictmask)
         {
            gc.stage.removeChild(exictmask);
            exictmask = null;
         }
         urlLoader.removeEventListener("complete",completeHandler);
         urlLoader.removeEventListener("ioError",errorHandler);
         urlLoader.removeEventListener("securityError",errorHandler);
         if(int(urlLoader.data) != 1)
         {
            gc.ts.setTxt("兑换失败");
            gc.stage.addChild(gc.ts);
            return;
         }
         trace("this.curObj.img -->>" + this._anti.img);
         var ary:Array = String(this._anti.img).split("_");
         if(ary[1] == "exp")
         {
            gc.putQhsInBackPack(this.player,"xjyys",1);
         }
         else if(ary[1] == "cw")
         {
            this.cwExchange(ary[2]);
         }
         else
         {
            temp = gc.allEquip.findByName(ary[1]);
            if(temp != null)
            {
               trace("temp.type -->>" + temp.type);
               if(temp.type == "zbwp" || temp.type == "wpqhs")
               {
                  gc.putQhsInBackPack(this.player,ary[1],int(ary[2]));
               }
               else if(temp.type == "zbsz")
               {
                  temp.setFashionTime(gc.dataObjectInstance.curDate);
                  this.player.szlist.push(temp);
               }
               else
               {
                  if(temp.getFillName() == "qljfb")
                  {
                     temp.setEupdata(Number((this._anti.one_point_6 + RandomControllor.getIns().getRandom() * this._anti.zero_point_8).toFixed(1)));
                  }
                  this.player.zblist.push(temp);
               }
            }
         }
         gc.dataObject.turntableScore -= this._anti.score;
         gc.eventManger.dispatchEvent(new CommonEvent("ExchangeShopSuccess"));
         if(gc.isHideDebug)
         {
            gc.memory.setStorage(gc.luanqibazaojiami.saveId);
         }
      }
      
      private function cwExchange(fname:String) : void
      {
         var pif:PetInfo = new PetInfo();
         if(fname == "huwan")
         {
            pif.setPetNameAndLevel("tigress1",1);
            pif.setperception(5);
            pif.setwarpower(4);
            pif.settechnique(4);
            pif.sethpQuality(1300);
            pif.setmpQuality(1040);
            pif.setatkQuality(1300);
            pif.setdefQuality(520);
            pif.setHp(500);
            pif.setMp(150);
            pif.setAtk(30);
            pif.setDef(8);
         }
         else if(fname == "guibu")
         {
            pif.setPetNameAndLevel("turtle1",1);
            pif.setperception(5);
            pif.setwarpower(4);
            pif.settechnique(4);
            pif.sethpQuality(1560);
            pif.setmpQuality(910);
            pif.setatkQuality(1170);
            pif.setdefQuality(611);
            pif.setHp(600);
            pif.setMp(150);
            pif.setAtk(25);
            pif.setDef(10);
         }
         else if(fname == "quedan")
         {
            pif.setPetNameAndLevel("phoenix1",1);
            pif.setperception(5);
            pif.setwarpower(4);
            pif.settechnique(4);
            pif.sethpQuality(1170);
            pif.setmpQuality(1170);
            pif.setatkQuality(1300);
            pif.setdefQuality(520);
            pif.setHp(450);
            pif.setMp(200);
            pif.setAtk(32);
            pif.setDef(6);
         }
         else if(fname == "huowan")
         {
            pif.setPetNameAndLevel("monkey1",1);
            pif.setperception(5);
            pif.setwarpower(4);
            pif.settechnique(4);
            pif.sethpQuality(1040);
            pif.setmpQuality(1040);
            pif.setatkQuality(1040);
            pif.setdefQuality(520);
            pif.setHp(200);
            pif.setMp(150);
            pif.setAtk(20);
            pif.setDef(6);
         }
         else if(fname == "xueqiu")
         {
            pif.setPetNameAndLevel("horse1",1);
            pif.setperception(5);
            pif.setwarpower(4);
            pif.settechnique(4);
            pif.sethpQuality(949);
            pif.setmpQuality(1222);
            pif.setatkQuality(1105);
            pif.setdefQuality(520);
            pif.setHp(150);
            pif.setMp(250);
            pif.setAtk(25);
            pif.setDef(6);
         }
         pif.setSHp(pif.getHp());
         pif.setSMp(pif.getMp());
         this.player.petsAry.push(pif);
      }
      
      private function errorHandler(e:*) : void
      {
         urlLoader.removeEventListener("complete",completeHandler);
         urlLoader.removeEventListener("ioError",errorHandler);
         urlLoader.removeEventListener("securityError",errorHandler);
         var exictmask:Sprite = gc.stage.getChildByName("execuitionActionrenewalse") as Sprite;
         if(exictmask)
         {
            gc.stage.removeChild(exictmask);
            exictmask = null;
         }
      }
      
      public function setPlayer(_player:User) : void
      {
         this.player = _player;
      }
   }
}
