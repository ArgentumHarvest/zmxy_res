package export.pet
{
   import config.Config;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import my.PetEquipObj;
   
   public class PetEquipAttribute extends Sprite
   {
       
      
      private var attributeObj:PetEquipObj;
      
      private var bg:Sprite;
      
      private var info:Sprite;
      
      private var i:uint = 0;
      
      private var bigw:uint = 0;
      
      private var gc:Config;
      
      public function PetEquipAttribute(obj:PetEquipObj)
      {
         bg = new Sprite();
         info = new Sprite();
         super();
         gc = Config.getInstance();
         this.attributeObj = obj;
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
         this.drawInfo();
         this.drawbg();
         if(this.getChildIndex(bg) > this.getChildIndex(info))
         {
            this.swapChildren(bg,info);
         }
      }
      
      private function added(e:Event) : void
      {
      }
      
      private function removed(e:Event) : void
      {
      }
      
      private function drawInfo() : void
      {
         this.addChild(info);
         info.x = 20;
         info.y = 10;
         var txtformat:TextFormat = new TextFormat();
         var txtname:TextField = new TextField();
         txtname.embedFonts = true;
         txtformat.font = "FZCuYuan-M03S";
         txtformat.color = this.attributeObj.color;
         txtformat.size = 16;
         if(this.attributeObj.getStrengthLevel() == 0)
         {
            txtname.text = this.attributeObj.getEname();
         }
         else
         {
            txtname.text = this.attributeObj.getEname() + "(+" + this.attributeObj.getStrengthLevel() + ")";
         }
         txtname.setTextFormat(txtformat);
         txtname.height = 25;
         txtname.width = txtname.textWidth + 10;
         i++;
         if(this.attributeObj.quality != "")
         {
            this.drawpz("品质",this.attributeObj.color,this.attributeObj.quality);
         }
         if(this.attributeObj.user != "")
         {
            this.drawpz("类型",16777215,this.attributeObj.etype + "·" + this.attributeObj.user);
         }
         else
         {
            this.drawpz("类型",16777215,this.attributeObj.etype);
         }
         this.drawAttribute();
         this.drawInstruction();
         this.drawValue();
         info.addChild(txtname);
      }
      
      private function drawpz(firststr:String, _color:*, secondstr:String) : void
      {
         var txtformat:TextFormat = new TextFormat();
         var txtname:TextField = new TextField();
         txtname.embedFonts = true;
         txtformat.font = "FZCuYuan-M03S";
         txtformat.color = 0;
         txtformat.size = 16;
         txtformat.bold = true;
         txtname.filters = [this.GlowEffect()];
         txtname.text = firststr;
         txtname.setTextFormat(txtformat);
         txtname.y = i * 25;
         txtname.height = 25;
         txtname.width = txtname.textWidth + 10;
         if(this.bigw < txtname.width)
         {
            this.bigw = txtname.width;
         }
         info.addChild(txtname);
         var line:Sprite = new Sprite();
         line.x = txtname.x + txtname.width - 4;
         line.y = txtname.y + txtname.height - 6;
         line.graphics.lineStyle(2,16777215);
         line.graphics.lineGradientStyle("linear",[16777215,16777215],[1,0],[120,255]);
         line.graphics.moveTo(0,0);
         line.graphics.lineTo(80,0);
         info.addChild(line);
         var txtformat2:TextFormat = new TextFormat();
         var txtname2:TextField = new TextField();
         txtname2.embedFonts = true;
         txtformat2.font = "FZCuYuan-M03S";
         txtformat2.color = _color;
         txtformat2.size = 16;
         txtname2.text = "  " + secondstr;
         txtname2.setTextFormat(txtformat2);
         txtname2.x = txtname.x + txtname.width;
         txtname2.y = txtname.y - 1;
         txtname2.height = 25;
         txtname2.width = txtname2.textWidth + 10;
         if(this.bigw < txtname2.width)
         {
            this.bigw = txtname2.width;
         }
         info.addChild(txtname2);
         i++;
      }
      
      private function drawAttribute() : void
      {
         if(this.attributeObj.getFillName() != "t" && this.attributeObj.getFillName() != "c" && this.attributeObj.getFillName() != "ch")
         {
            if(int(this.attributeObj.getehp()) != 0)
            {
               this.drawSimpleAttribute("生命",int(this.attributeObj.getehp()),0);
            }
            if(int(this.attributeObj.getemp()) != 0)
            {
               this.drawSimpleAttribute("魔法",int(this.attributeObj.getemp()),0);
            }
            if(int(this.attributeObj.geteatt()) != 0)
            {
               this.drawSimpleAttribute("攻击",int(this.attributeObj.geteatt()),0);
            }
            if(int(this.attributeObj.getedef()) != 0)
            {
               this.drawSimpleAttribute("防御",int(this.attributeObj.getedef()),0);
            }
            if(int(this.attributeObj.getecrit() * 100) != 0)
            {
               this.drawSimpleAttribute("暴击",AUtils.changeNumber(Number(this.attributeObj.getecrit() * 100),2) + "%",0);
            }
            if(int(this.attributeObj.getemiss() * 100) != 0)
            {
               this.drawSimpleAttribute("闪避",AUtils.changeNumber(Number(this.attributeObj.getemiss() * 100),2) + "%",0);
            }
            if(int(this.attributeObj.geteahp()) != 0)
            {
               this.drawSimpleAttribute("回血",int(this.attributeObj.geteahp()),0);
            }
            if(int(this.attributeObj.geteamp()) != 0)
            {
               this.drawSimpleAttribute("回魔",int(this.attributeObj.geteamp()),0);
            }
            if(int(this.attributeObj.geteatblood() * 100) != 0)
            {
               this.drawSimpleAttribute("嗜血",AUtils.changeNumber(Number(this.attributeObj.geteatblood() * 100),2) + "%",0);
            }
            if(int(this.attributeObj.getmagicdef() * 100) != 0)
            {
               this.drawSimpleAttribute("魔抗",AUtils.changeNumber(Number(this.attributeObj.getmagicdef() * 100),2) + "%",0);
            }
            if(this.attributeObj.getspeed() != 0)
            {
               this.drawSimpleAttribute("移速",this.attributeObj.getspeed(),0);
            }
         }
      }
      
      private function drawSimpleAttribute(_name:String, _basenum:*, _qhnum:int = 0, _fmnum:uint = 0) : void
      {
         var txtformat:TextFormat = new TextFormat();
         txtformat.font = "FZCuYuan-M03S";
         txtformat.color = 16750899;
         txtformat.size = 16;
         txtformat.bold = true;
         var txt:TextField = new TextField();
         txt.embedFonts = true;
         if(_qhnum == 0)
         {
            txt.text = _name + "： " + _basenum;
         }
         else if(_qhnum > 0)
         {
            txt.text = _name + "： " + _basenum + "(+" + _qhnum + ")";
         }
         else
         {
            txt.text = _name + "： " + _basenum + "(" + _qhnum + ")";
         }
         txt.setTextFormat(txtformat);
         txt.y = i * 25;
         txt.height = 25;
         txt.width = txt.textWidth + 10;
         info.addChild(txt);
         i++;
      }
      
      private function drawInstruction() : void
      {
         var title:* = null;
         var allequip:* = null;
         var dict:* = null;
         var n:* = 0;
         var inst:* = null;
         var color:* = null;
         var str:* = null;
         var dict2:* = null;
         var _bool:Boolean = false;
         var color2:* = null;
         var txt:TextField = new TextField();
         txt.wordWrap = true;
         txt.multiline = true;
         txt.embedFonts = true;
         if(this.attributeObj.type == "zbjn")
         {
            title = gc.petJNSuitInfo.getSuitCnNameByEquip(this.attributeObj);
         }
         else
         {
            title = gc.petSuitInfo.getSuitCnNameByEquip(this.attributeObj);
         }
         if(title != "")
         {
            allequip = [];
            trace("this.attributeObj.getPetInfo() -->>" + this.attributeObj.getPetInfo());
            if(this.attributeObj.getPetInfo() == null)
            {
               allequip = [];
            }
            else
            {
               allequip = this.attributeObj.getPetInfo().getEquipArray();
            }
            if(this.attributeObj.type == "zbjn")
            {
               dict = gc.petJNSuitInfo.getSuitNameByEquip(this.attributeObj,allequip);
            }
            else
            {
               dict = gc.petSuitInfo.getSuitNameByEquip(this.attributeObj,allequip);
            }
            n = uint(0);
            inst = "";
            color = "";
            if(dict.length > 0)
            {
               str = "";
               for each(var obj in dict)
               {
                  if(int(obj.value) == 1)
                  {
                     n++;
                     color = this.attributeObj.color;
                     color = color.replace("0x","#");
                  }
                  else
                  {
                     color = "#999999";
                  }
                  str += "<font face=\'FZCuYuan-M03S\' size=\'14\' color=\'" + color + "\'>" + obj.cnname + "</font><br>";
               }
            }
            if(this.attributeObj.type == "zbjn")
            {
               inst = "<font face=\'FZCuYuan-M03S\' size=\'14\' color=\'#FFCC00\'>" + title + " (" + n + "/1)</font><br>";
            }
            else
            {
               inst = "<font face=\'FZCuYuan-M03S\' size=\'14\' color=\'#FFCC00\'>" + title + " (" + n + "/4)</font><br>";
            }
            inst += str;
            if(this.attributeObj.type == "zbjn")
            {
               dict2 = gc.petJNSuitInfo.getSuitEffectByEquip(this.attributeObj);
               _bool = gc.petJNSuitInfo.hasEquipTheSuit(allequip);
            }
            else
            {
               dict2 = gc.petSuitInfo.getSuitEffectByEquip(this.attributeObj);
               _bool = gc.petSuitInfo.hasEquipTheSuit(allequip);
            }
            color2 = "";
            if(_bool)
            {
               color2 = this.attributeObj.color;
               color2 = color2.replace("0x","#");
            }
            else
            {
               color2 = "#999999";
            }
            for each(var obj2 in dict2)
            {
               inst += "<font face=\'FZCuYuan-M03S\' size=\'14\' color=\'" + color2 + "\'>" + obj2.name + ":" + obj2.stringValue + " </font>";
            }
            txt.htmlText = inst;
         }
         else
         {
            txt.htmlText = "<font face=\'FZCuYuan-M03S\' size=\'14\' color=\'#ffffff\'>" + this.attributeObj.instruction + "</font>";
         }
         txt.y = i * 25;
         txt.height = txt.textHeight + 10;
         txt.width = 135;
         info.addChild(txt);
         var row:uint = Math.round(txt.height / 25);
         i += row;
      }
      
      private function drawValue() : void
      {
         var txtformat:TextFormat = new TextFormat();
         txtformat.font = "FZCuYuan-M03S";
         txtformat.color = 16750899;
         txtformat.size = 14;
         var txt:TextField = new TextField();
         txt.embedFonts = true;
         txt.text = "价值 : " + this.attributeObj.getValue() + " 灵魂";
         txt.setTextFormat(txtformat);
         txt.y = i * 25;
         txt.height = txt.textHeight + 10;
         txt.width = 135;
         info.addChild(txt);
      }
      
      private function drawbg() : void
      {
         this.addChild(bg);
         bg.graphics.lineStyle(1,16777215);
         bg.graphics.beginFill(0,0.7);
         bg.graphics.drawRoundRect(0,0,this.info.width + 35,this.info.height + 10,5,5);
         bg.graphics.endFill();
      }
      
      private function GlowEffect() : GlowFilter
      {
         return new GlowFilter(16777215,1,2,2,3,3,false,false);
      }
   }
}
