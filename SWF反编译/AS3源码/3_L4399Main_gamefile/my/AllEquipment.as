package my
{
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import mvc.controllor.RandomControllor;
   
   public class AllEquipment
   {
       
      
      private var normalEquipment:Array;
      
      public var otherEquipment:Array;
      
      public var wpEquipment:Array;
      
      public var sutraEquipment:Array;
      
      public var sellEquipment:Array;
      
      private var petEquipment:Array;
      
      private var normalClothes:MyEquipObj;
      
      private var normalStick:MyEquipObj;
      
      private var normalCassock:MyEquipObj;
      
      private var normalStaff:MyEquipObj;
      
      private var normalStoneAX:MyEquipObj;
      
      private var normalCymbidium:MyEquipObj;
      
      private var normalYueyaChan:MyEquipObj;
      
      private var normalRobe:MyEquipObj;
      
      private var normalnewSp:MyEquipObj;
      
      private var otherEquip1:MyEquipObj;
      
      private var otherEquip2:MyEquipObj;
      
      private var otherEquip3:MyEquipObj;
      
      private var otherEquip4:MyEquipObj;
      
      private var otherEquip5:MyEquipObj;
      
      private var otherEquip6:MyEquipObj;
      
      private var otherEquip7:MyEquipObj;
      
      private var otherEquip8:MyEquipObj;
      
      private var otherEquip9:MyEquipObj;
      
      private var otherEquip10:MyEquipObj;
      
      private var otherEquip11:MyEquipObj;
      
      private var otherEquip12:MyEquipObj;
      
      private var otherEquip13:MyEquipObj;
      
      private var otherEquip14:MyEquipObj;
      
      private var otherEquip15:MyEquipObj;
      
      private var otherEquip16:MyEquipObj;
      
      private var otherEquip17:MyEquipObj;
      
      private var otherEquip18:MyEquipObj;
      
      private var otherEquip19:MyEquipObj;
      
      private var otherEquip20:MyEquipObj;
      
      private var otherEquip21:MyEquipObj;
      
      private var otherEquip22:MyEquipObj;
      
      private var otherEquip23:MyEquipObj;
      
      private var otherEquip24:MyEquipObj;
      
      private var otherEquip25:MyEquipObj;
      
      private var otherEquip26:MyEquipObj;
      
      private var otherEquip27:MyEquipObj;
      
      private var otherEquip28:MyEquipObj;
      
      private var otherEquip29:MyEquipObj;
      
      private var otherEquip30:MyEquipObj;
      
      private var otherEquip31:MyEquipObj;
      
      private var otherEquip32:MyEquipObj;
      
      private var otherEquip33:MyEquipObj;
      
      private var otherEquip34:MyEquipObj;
      
      private var otherEquip35:MyEquipObj;
      
      private var otherEquip36:MyEquipObj;
      
      private var otherEquip37:MyEquipObj;
      
      private var otherEquip38:MyEquipObj;
      
      private var otherEquip39:MyEquipObj;
      
      private var otherEquip40:MyEquipObj;
      
      private var otherEquip41:MyEquipObj;
      
      private var otherEquip42:MyEquipObj;
      
      private var otherEquip43:MyEquipObj;
      
      private var otherEquip44:MyEquipObj;
      
      private var otherEquip45:MyEquipObj;
      
      private var otherEquip46:MyEquipObj;
      
      private var otherEquip47:MyEquipObj;
      
      private var otherEquip48:MyEquipObj;
      
      private var otherEquip49:MyEquipObj;
      
      private var otherEquip50:MyEquipObj;
      
      private var otherEquip51:MyEquipObj;
      
      private var otherEquip52:MyEquipObj;
      
      private var otherEquip53:MyEquipObj;
      
      private var otherEquip54:MyEquipObj;
      
      private var otherEquip55:MyEquipObj;
      
      private var otherEquip56:MyEquipObj;
      
      private var otherEquip57:MyEquipObj;
      
      private var otherEquip58:MyEquipObj;
      
      private var otherEquip59:MyEquipObj;
      
      private var otherEquip60:MyEquipObj;
      
      private var otherEquip61:MyEquipObj;
      
      private var otherEquip62:MyEquipObj;
      
      private var otherEquip63:MyEquipObj;
      
      private var otherEquip64:MyEquipObj;
      
      private var otherEquip65:MyEquipObj;
      
      private var otherEquip66:MyEquipObj;
      
      private var otherEquip67:MyEquipObj;
      
      private var otherEquip68:MyEquipObj;
      
      private var otherEquip69:MyEquipObj;
      
      private var otherEquip70:MyEquipObj;
      
      private var otherEquip71:MyEquipObj;
      
      private var otherEquip72:MyEquipObj;
      
      private var otherEquip73:MyEquipObj;
      
      private var otherEquip74:MyEquipObj;
      
      private var otherEquip75:MyEquipObj;
      
      private var otherEquip76:MyEquipObj;
      
      private var otherEquip77:MyEquipObj;
      
      private var otherEquip78:MyEquipObj;
      
      private var otherEquip79:MyEquipObj;
      
      private var otherEquip80:MyEquipObj;
      
      private var otherEquip81:MyEquipObj;
      
      private var otherEquip82:MyEquipObj;
      
      private var otherEquip83:MyEquipObj;
      
      private var otherEquip84:MyEquipObj;
      
      private var otherEquip85:MyEquipObj;
      
      private var otherEquip86:MyEquipObj;
      
      private var otherEquip87:MyEquipObj;
      
      private var otherEquip88:MyEquipObj;
      
      private var otherEquip89:MyEquipObj;
      
      private var otherEquip90:MyEquipObj;
      
      private var otherEquip91:MyEquipObj;
      
      private var otherEquip92:MyEquipObj;
      
      private var otherEquip93:MyEquipObj;
      
      private var otherEquip94:MyEquipObj;
      
      private var otherEquip95:MyEquipObj;
      
      private var otherEquip96:MyEquipObj;
      
      private var otherEquip97:MyEquipObj;
      
      private var otherEquip98:MyEquipObj;
      
      private var otherEquip99:MyEquipObj;
      
      private var otherEquip100:MyEquipObj;
      
      private var otherEquip101:MyEquipObj;
      
      private var otherEquip102:MyEquipObj;
      
      private var otherEquip103:MyEquipObj;
      
      private var otherEquip104:MyEquipObj;
      
      private var otherEquip105:MyEquipObj;
      
      private var otherEquip106:MyEquipObj;
      
      private var otherEquip107:MyEquipObj;
      
      private var otherEquip108:MyEquipObj;
      
      private var otherEquip109:MyEquipObj;
      
      private var otherEquip110:MyEquipObj;
      
      private var otherEquip111:MyEquipObj;
      
      private var otherEquip112:MyEquipObj;
      
      private var otherEquip113:MyEquipObj;
      
      private var otherEquip114:MyEquipObj;
      
      private var otherEquip115:MyEquipObj;
      
      private var otherEquip116:MyEquipObj;
      
      private var otherEquip117:MyEquipObj;
      
      private var otherEquip118:MyEquipObj;
      
      private var otherEquip119:MyEquipObj;
      
      private var otherEquip120:MyEquipObj;
      
      private var otherEquip121:MyEquipObj;
      
      private var wpEquip1:MyEquipObj;
      
      private var wpEquip2:MyEquipObj;
      
      private var wpEquip3:MyEquipObj;
      
      private var wpEquip4:MyEquipObj;
      
      private var wpEquip5:MyEquipObj;
      
      private var wpEquip6:MyEquipObj;
      
      private var wpEquip7:MyEquipObj;
      
      private var wpEquip8:MyEquipObj;
      
      private var wpEquip9:MyEquipObj;
      
      private var wpEquip10:MyEquipObj;
      
      private var wpEquip11:MyEquipObj;
      
      private var wpEquip12:MyEquipObj;
      
      private var wpEquip13:MyEquipObj;
      
      private var wpEquip14:MyEquipObj;
      
      private var wpEquip15:MyEquipObj;
      
      private var wpEquip16:MyEquipObj;
      
      private var wpEquip17:MyEquipObj;
      
      private var wpEquip18:MyEquipObj;
      
      private var wpEquip19:MyEquipObj;
      
      private var wpEquip20:MyEquipObj;
      
      private var wpEquip21:MyEquipObj;
      
      private var wpEquip22:MyEquipObj;
      
      private var wpEquip23:MyEquipObj;
      
      private var wpEquip24:MyEquipObj;
      
      private var wpEquip25:MyEquipObj;
      
      private var wpEquip26:MyEquipObj;
      
      private var wpEquip27:MyEquipObj;
      
      private var wpEquip28:MyEquipObj;
      
      private var wpEquip29:MyEquipObj;
      
      private var wpEquip30:MyEquipObj;
      
      private var wpEquip31:MyEquipObj;
      
      private var wpEquip32:MyEquipObj;
      
      private var wpEquip33:MyEquipObj;
      
      private var wpEquip34:MyEquipObj;
      
      private var wpEquip35:MyEquipObj;
      
      private var wpEquip36:MyEquipObj;
      
      private var wpEquip37:MyEquipObj;
      
      private var wpEquip38:MyEquipObj;
      
      private var wpEquip39:MyEquipObj;
      
      private var wpEquip40:MyEquipObj;
      
      private var wpEquip41:MyEquipObj;
      
      private var wpEquip42:MyEquipObj;
      
      private var wpEquip43:MyEquipObj;
      
      private var wpEquip44:MyEquipObj;
      
      private var wpEquip45:MyEquipObj;
      
      private var wpEquip46:MyEquipObj;
      
      private var wpEquip47:MyEquipObj;
      
      private var wpEquip48:MyEquipObj;
      
      private var wpEquip49:MyEquipObj;
      
      private var wpEquip50:MyEquipObj;
      
      private var wpEquip51:MyEquipObj;
      
      private var wpEquip52:MyEquipObj;
      
      private var wpEquip53:MyEquipObj;
      
      private var wpEquip54:MyEquipObj;
      
      private var wpEquip55:MyEquipObj;
      
      private var wpEquip56:MyEquipObj;
      
      private var wpEquip57:MyEquipObj;
      
      private var wpEquip58:MyEquipObj;
      
      private var wpEquip59:MyEquipObj;
      
      private var wpEquip60:MyEquipObj;
      
      private var wpEquip61:MyEquipObj;
      
      private var wpEquip62:MyEquipObj;
      
      private var wpEquip63:MyEquipObj;
      
      private var wpEquip64:MyEquipObj;
      
      private var wpEquip65:MyEquipObj;
      
      private var wpEquip66:MyEquipObj;
      
      private var wpEquip67:MyEquipObj;
      
      private var wpEquip68:MyEquipObj;
      
      private var wpEquip69:MyEquipObj;
      
      private var wpEquip70:MyEquipObj;
      
      private var wpEquip71:MyEquipObj;
      
      private var wpEquip72:MyEquipObj;
      
      private var wpEquip73:MyEquipObj;
      
      private var wpEquip74:MyEquipObj;
      
      private var wpEquip75:MyEquipObj;
      
      private var wpEquip76:MyEquipObj;
      
      private var wpEquip77:MyEquipObj;
      
      private var wpEquip78:MyEquipObj;
      
      private var wpEquip79:MyEquipObj;
      
      private var wpEquip80:MyEquipObj;
      
      private var wpEquip81:MyEquipObj;
      
      private var wpEquip82:MyEquipObj;
      
      private var wpEquip83:MyEquipObj;
      
      private var wpEquip84:MyEquipObj;
      
      private var wpEquip85:MyEquipObj;
      
      private var wpEquip86:MyEquipObj;
      
      private var wpEquip87:MyEquipObj;
      
      private var wpEquip88:MyEquipObj;
      
      private var wpEquip89:MyEquipObj;
      
      private var wpEquip90:MyEquipObj;
      
      private var wpEquip91:MyEquipObj;
      
      private var wpEquip92:MyEquipObj;
      
      private var wpEquip93:MyEquipObj;
      
      private var wpEquip94:MyEquipObj;
      
      private var wpEquip95:MyEquipObj;
      
      private var wpEquip96:MyEquipObj;
      
      private var wpEquip97:MyEquipObj;
      
      private var wpEquip98:MyEquipObj;
      
      private var wpEquip99:MyEquipObj;
      
      private var wpEquip100:MyEquipObj;
      
      private var wpEquip101:MyEquipObj;
      
      private var wpEquip102:MyEquipObj;
      
      private var wpEquip103:MyEquipObj;
      
      private var wpEquip104:MyEquipObj;
      
      private var wpEquip105:MyEquipObj;
      
      private var wpEquip106:MyEquipObj;
      
      private var wpEquip107:MyEquipObj;
      
      private var wpEquip108:MyEquipObj;
      
      private var wpEquip109:MyEquipObj;
      
      private var wpEquip110:MyEquipObj;
      
      private var wpEquip111:MyEquipObj;
      
      private var wpEquip112:MyEquipObj;
      
      private var wpEquip113:MyEquipObj;
      
      private var wpEquip114:MyEquipObj;
      
      private var wpEquip115:MyEquipObj;
      
      private var wpEquip116:MyEquipObj;
      
      private var wpEquip117:MyEquipObj;
      
      private var wpEquip118:MyEquipObj;
      
      private var wpEquip119:MyEquipObj;
      
      private var wpEquip120:MyEquipObj;
      
      private var wpEquip121:MyEquipObj;
      
      private var wpEquip122:MyEquipObj;
      
      private var wpEquip123:MyEquipObj;
      
      private var wpEquip124:MyEquipObj;
      
      private var wpEquip125:MyEquipObj;
      
      private var wpEquip126:MyEquipObj;
      
      private var wpEquip127:MyEquipObj;
      
      private var wpEquip128:MyEquipObj;
      
      private var wpEquip129:MyEquipObj;
      
      private var wpEquip130:MyEquipObj;
      
      private var wpEquip131:MyEquipObj;
      
      private var wpEquip132:MyEquipObj;
      
      private var wpEquip133:MyEquipObj;
      
      private var wpEquip134:MyEquipObj;
      
      private var wpEquip135:MyEquipObj;
      
      private var wpEquip136:MyEquipObj;
      
      private var wpEquip137:MyEquipObj;
      
      private var wpEquip138:MyEquipObj;
      
      private var wpEquip139:MyEquipObj;
      
      private var wpEquip140:MyEquipObj;
      
      private var wpEquip141:MyEquipObj;
      
      private var wpEquip142:MyEquipObj;
      
      private var wpEquip143:MyEquipObj;
      
      private var wpEquip144:MyEquipObj;
      
      private var wpEquip145:MyEquipObj;
      
      private var wpEquip146:MyEquipObj;
      
      private var wpEquip147:MyEquipObj;
      
      private var wpEquip148:MyEquipObj;
      
      private var wpEquip149:MyEquipObj;
      
      private var wpEquip150:MyEquipObj;
      
      private var wpEquip151:MyEquipObj;
      
      private var wpEquip152:MyEquipObj;
      
      private var wpEquip153:MyEquipObj;
      
      private var wpEquip154:MyEquipObj;
      
      private var wpEquip155:MyEquipObj;
      
      private var wpEquip156:MyEquipObj;
      
      private var wpEquip157:MyEquipObj;
      
      private var wpEquip158:MyEquipObj;
      
      private var wpEquip159:MyEquipObj;
      
      private var wpEquip160:MyEquipObj;
      
      private var wpEquip161:MyEquipObj;
      
      private var wpEquip162:MyEquipObj;
      
      private var wpEquip163:MyEquipObj;
      
      private var wpEquip164:MyEquipObj;
      
      private var wpEquip165:MyEquipObj;
      
      private var wpEquip166:MyEquipObj;
      
      private var wpEquip167:MyEquipObj;
      
      private var wpEquip168:MyEquipObj;
      
      private var wpEquip169:MyEquipObj;
      
      private var wpEquip170:MyEquipObj;
      
      private var wpEquip171:MyEquipObj;
      
      private var wpEquip172:MyEquipObj;
      
      private var wpEquip173:MyEquipObj;
      
      private var wpEquip174:MyEquipObj;
      
      private var wpEquip175:MyEquipObj;
      
      private var wpEquip176:MyEquipObj;
      
      private var wpEquip177:MyEquipObj;
      
      private var wpEquip178:MyEquipObj;
      
      private var wpEquip179:MyEquipObj;
      
      private var wpEquip180:MyEquipObj;
      
      private var wpEquip181:MyEquipObj;
      
      private var wpEquip182:MyEquipObj;
      
      private var wpEquip183:MyEquipObj;
      
      private var wpEquip184:MyEquipObj;
      
      private var wpEquip185:MyEquipObj;
      
      private var wpEquip186:MyEquipObj;
      
      private var wpEquip187:MyEquipObj;
      
      private var wpEquip188:MyEquipObj;
      
      private var wpEquip189:MyEquipObj;
      
      private var wpEquip190:MyEquipObj;
      
      private var wpEquip191:MyEquipObj;
      
      private var wpEquip192:MyEquipObj;
      
      private var wpEquip193:MyEquipObj;
      
      private var wpEquip194:MyEquipObj;
      
      private var wpEquip195:MyEquipObj;
      
      private var wpEquip196:MyEquipObj;
      
      private var wpEquip197:MyEquipObj;
      
      private var wpEquip198:MyEquipObj;
      
      private var wpEquip199:MyEquipObj;
      
      private var wpEquip200:MyEquipObj;
      
      private var wpEquip201:MyEquipObj;
      
      private var wpEquip202:MyEquipObj;
      
      private var wpEquip203:MyEquipObj;
      
      private var wpEquip204:MyEquipObj;
      
      private var wpEquip205:MyEquipObj;
      
      private var wpEquip206:MyEquipObj;
      
      private var luckEquip:MyEquipObj;
      
      private var baodiEquip:MyEquipObj;
      
      private var sbblEquip:MyEquipObj;
      
      private var wddEquip:MyEquipObj;
      
      private var fashionEquip1:MyEquipObj;
      
      private var fashionEquip2:MyEquipObj;
      
      private var fashionEquip3:MyEquipObj;
      
      private var fashionEquip4:MyEquipObj;
      
      private var fashionEquip5:MyEquipObj;
      
      private var fashionEquip6:MyEquipObj;
      
      private var fashionEquip7:MyEquipObj;
      
      private var fashionEquip8:MyEquipObj;
      
      private var fashionEquip9:MyEquipObj;
      
      private var fashionEquip10:MyEquipObj;
      
      private var fashionEquip11:MyEquipObj;
      
      private var fashionEquip12:MyEquipObj;
      
      private var fashionEquip13:MyEquipObj;
      
      private var fashionEquip14:MyEquipObj;
      
      private var fashionEquip15:MyEquipObj;
      
      private var fashionEquip16:MyEquipObj;
      
      private var fashionEquip17:MyEquipObj;
      
      private var fashionEquip18:MyEquipObj;
      
      private var fashionEquip19:MyEquipObj;
      
      private var fashionEquip20:MyEquipObj;
      
      private var sutra1:MyEquipObj;
      
      private var sutra2:MyEquipObj;
      
      private var sutra3:MyEquipObj;
      
      private var sutra4:MyEquipObj;
      
      private var sutra5:MyEquipObj;
      
      private var sutra6:MyEquipObj;
      
      private var sutra7:MyEquipObj;
      
      private var sutra8:MyEquipObj;
      
      private var sutra9:MyEquipObj;
      
      private var sutra10:MyEquipObj;
      
      private var sutra11:MyEquipObj;
      
      private var sutra12:MyEquipObj;
      
      private var sutra13:MyEquipObj;
      
      private var sutra14:MyEquipObj;
      
      private var sutra15:MyEquipObj;
      
      private var sutra16:MyEquipObj;
      
      private var sutra17:MyEquipObj;
      
      private var sutra18:MyEquipObj;
      
      private var sutra19:MyEquipObj;
      
      private var sutra20:MyEquipObj;
      
      private var sutra21:MyEquipObj;
      
      private var sutra22:MyEquipObj;
      
      private var sutra23:MyEquipObj;
      
      private var sutra24:MyEquipObj;
      
      private var sutra25:MyEquipObj;
      
      private var sutra26:MyEquipObj;
      
      private var sutra27:MyEquipObj;
      
      private var sutra28:MyEquipObj;
      
      private var sutra29:MyEquipObj;
      
      private var sutra30:MyEquipObj;
      
      private var sutra31:MyEquipObj;
      
      private var sutra32:MyEquipObj;
      
      private var sutra33:MyEquipObj;
      
      private var sutra34:MyEquipObj;
      
      private var petEquip1:PetEquipObj;
      
      private var petEquip2:PetEquipObj;
      
      private var petEquip3:PetEquipObj;
      
      private var petEquip4:PetEquipObj;
      
      private var petEquip5:PetEquipObj;
      
      private var petEquip6:PetEquipObj;
      
      private var petEquip7:PetEquipObj;
      
      private var petEquip8:PetEquipObj;
      
      private var petEquip9:PetEquipObj;
      
      private var petEquip10:PetEquipObj;
      
      private var petEquip11:PetEquipObj;
      
      private var petEquip12:PetEquipObj;
      
      private var petEquip13:PetEquipObj;
      
      private var petEquip14:PetEquipObj;
      
      private var petEquip15:PetEquipObj;
      
      private var petEquip16:PetEquipObj;
      
      private var petEquip17:PetEquipObj;
      
      private var petEquip18:PetEquipObj;
      
      private var petEquip19:PetEquipObj;
      
      private var petEquip20:PetEquipObj;
      
      private var petEquip21:PetEquipObj;
      
      private var petEquip22:PetEquipObj;
      
      private var petEquip23:PetEquipObj;
      
      private var petEquip24:PetEquipObj;
      
      private var petEquip25:PetEquipObj;
      
      private var petEquip26:PetEquipObj;
      
      private var petEquip27:PetEquipObj;
      
      private var petEquip28:PetEquipObj;
      
      private var petEquip29:PetEquipObj;
      
      private var petEquip30:PetEquipObj;
      
      private var petEquip31:PetEquipObj;
      
      private var petEquip32:PetEquipObj;
      
      private var petEquip33:PetEquipObj;
      
      private var petEquip34:PetEquipObj;
      
      private var petEquip35:PetEquipObj;
      
      private var petEquip36:PetEquipObj;
      
      private var petEquip37:PetEquipObj;
      
      private var petEquip38:PetEquipObj;
      
      private var petEquip39:PetEquipObj;
      
      private var petEquip40:PetEquipObj;
      
      private var petEquip41:PetEquipObj;
      
      private var petEquip42:PetEquipObj;
      
      private var petEquip43:PetEquipObj;
      
      private var petEquip44:PetEquipObj;
      
      private var petEquip45:PetEquipObj;
      
      private var petEquip46:PetEquipObj;
      
      private var petEquip47:PetEquipObj;
      
      private var petEquip48:PetEquipObj;
      
      private var petEquip49:PetEquipObj;
      
      private var petEquip50:PetEquipObj;
      
      private var petEquip51:PetEquipObj;
      
      private var petEquip52:PetEquipObj;
      
      private var petEquip53:PetEquipObj;
      
      private var petEquip54:PetEquipObj;
      
      private var petEquip55:PetEquipObj;
      
      private var petEquip56:PetEquipObj;
      
      private var petEquip57:PetEquipObj;
      
      private var petEquip58:PetEquipObj;
      
      private var petEquip59:PetEquipObj;
      
      private var petEquip60:PetEquipObj;
      
      private var _anti:Antiwear;
      
      public function AllEquipment()
      {
         normalEquipment = [];
         otherEquipment = [];
         wpEquipment = [];
         sutraEquipment = [];
         sellEquipment = [];
         petEquipment = [];
         _anti = new Antiwear(new binaryEncrypt());
         super();
         this._anti.zero_point_0 = 0;
         this._anti.zero_point_1 = 0.1;
         this._anti.zero_point_2 = 0.2;
         this._anti.zero_point_3 = 0.3;
         this._anti.zero_point_4 = 0.4;
         this._anti.zero_point_5 = 0.5;
         this._anti.zero_point_6 = 0.6;
         this._anti.zero_point_7 = 0.7;
         this._anti.zero_point_8 = 0.8;
         this._anti.zero_point_9 = 0.9;
         this._anti.one_point_0 = 1;
         this._anti.one_point_1 = 1.1;
         this._anti.one_point_2 = 1.2;
         this._anti.one_point_3 = 1.3;
         this._anti.one_point_4 = 1.4;
         this._anti.one_point_5 = 1.5;
         this._anti.one_point_6 = 1.6;
         this._anti.one_point_7 = 1.7;
         this._anti.one_point_8 = 1.8;
         this._anti.one_point_9 = 1.9;
         this._anti.two_point_0 = 2;
         this._anti.two_point_1 = 2.1;
         this._anti.two_point_2 = 2.2;
         this._anti.two_point_3 = 2.3;
         this._anti.two_point_4 = 2.4;
         this._anti.two_point_5 = 2.5;
         this._anti.zero_point_zero_one = 0.01;
         this._anti.zero_point_zero_two = 0.02;
         this._anti.zero_point_zero_three = 0.03;
         this._anti.zero_point_zero_four = 0.04;
         this._anti.zero_point_zero_five = 0.05;
         this._anti.zero_point_zero_six = 0.06;
         this._anti.zero_point_zero_eight = 0.08;
         this._anti.zero_point_seven = 0.07;
         this._anti.zero_point_night = 0.09;
         this._anti.one = 1;
         this._anti.two = 2;
         this._anti.three = 3;
         this._anti.four = 4;
         this._anti.five = 5;
         this._anti.six = 6;
         this._anti.seven = 7;
         this._anti.nigth = 9;
         this._anti.eight = 8;
         this._anti.ten = 10;
         this._anti.twelve = 12;
         this._anti.thirteen = 13;
         this._anti.fifteen = 15;
         this._anti.sixteen = 16;
         this._anti.seventeen = 17;
         this._anti.eighteen = 18;
         this._anti.nighteen = 19;
         this._anti.twenty = 20;
         this._anti.twenty_five = 25;
         this._anti.thirty_two = 32;
         this._anti.eight_two = 82;
         this._anti.fourty = 40;
         this._anti.fourty_four = 44;
         this._anti.eight_four = 84;
         this._anti.night_four = 94;
         this._anti.fourty_six = 46;
         this._anti.fifty = 50;
         this._anti.fifty_six = 56;
         this._anti.one_hundred_fifty_six = 156;
         this._anti.sixty = 60;
         this._anti.seventy = 70;
         this._anti.eighty = 80;
         this._anti.nighty = 90;
         this._anti.nighty_two = 92;
         this._anti.one_hundred_nighty_two = 192;
         this._anti.one_hundred = 100;
         this._anti.one_hundred_sixteen = 116;
         this._anti.one_hundred_thirty = 130;
         this._anti.one_hundred_sixty = 160;
         this._anti.one_hundred_eighty = 180;
         this._anti.one_hundred_fifyt = 150;
         this._anti.one_hundred_nighty = 190;
         this._anti.two_hundred_fourty_five = 245;
         this._anti.two_hundred_fifty = 250;
         this._anti.two_hundred_eighty = 280;
         this._anti.three_hundred_seventy = 370;
         this._anti.three_hundred_eighty = 380;
         this._anti.five_hundred = 500;
         this._anti.five_hundred_fifty = 550;
         this._anti.five_hundred_eighty = 580;
         this._anti.seven_hundred_fourty = 740;
         this._anti.one_thousand = 1000;
         this._anti.one_thousand_two_hundred_twenty = 1220;
         this._anti.three_hundred_twenty = 320;
         this._anti.two_thousand_fifty = 2500;
         this._anti.two_hundred_twenty = 220;
         this._anti.twenty_two = 22;
         this._anti.two_hundred = 200;
         this._anti.two_thousand = 2000;
         this._anti.three_thousand_fifty = 3500;
         this._anti.three_hundred = 300;
         this._anti.one_thousand_fifty = 1500;
         this._anti.thirty = 30;
         this._anti.five_hundred_fifty_night = 559;
         this._anti.eight_hundred_fifty_night = 859;
         this._anti.one_thousand_zero_night = 1009;
         this._anti.one_thousand_fifth_night = 1159;
         this._anti.two_thousand_zero_night = 2009;
         this._anti.zero_point_3_7_5 = 0.375;
         this._anti.zero_point_0_9_3_7 = 0.09;
         this._anti.zero_point_0_2_3_4 = 0.02;
         this._anti.zero_point_0_0_5_8 = 0.0058;
         _anti.shijiu = 19;
         _anti.ershijiu = 29;
         _anti.sanshijiu = 39;
         _anti.liushijiu = 69;
         _anti.qishijiu = 79;
         _anti.bashijiu = 89;
         _anti.sishijiu = 49;
         _anti.jiushijiu = 99;
         _anti.yibaiyishijiu = 119;
         _anti.yibaisanshijiu = 139;
         _anti.yibaisishijiu = 149;
         _anti.yibaiwushijiu = 159;
         _anti.yibailiushijiu = 169;
         _anti.yibaiqishijiu = 179;
         _anti.yibaibashijiu = 189;
         _anti.erbaiershijiu = 229;
         _anti.erbaiqishijiu = 279;
         _anti.erbaibashijiu = 289;
         _anti.sanbailingjiu = 309;
         _anti.sanbaiyishijiu = 319;
         _anti.sanbaisanshijiu = 339;
         _anti.sanbaisishijiu = 349;
         _anti.sanbailiushijiu = 369;
         _anti.sanbaibashijiu = 389;
         _anti.sanbaiwushijiu = 359;
         _anti.sanbaiershijiu = 329;
         _anti.sibaiqishijiu = 479;
         _anti.sibaibashijiu = 489;
         _anti.sibaijiushijiu = 499;
         _anti.erbaijiushijiu = 299;
         _anti.yibaijiushijiu = 199;
         _anti.erbaiwushijiu = 259;
         _anti.yibaiershijiu = 129;
         _anti.yibailingjiu = 109;
         _anti.wubaijiushijiu = 599;
         _anti.liubailingjiu = 609;
         _anti.liubailiushijiu = 669;
         _anti.liubaiqishijiu = 679;
         _anti.jiubaijiushijiu = 999;
         _anti.sanbaiqishijiu = 379;
         _anti.sanbaijiushijiu = 399;
         _anti.sibailinjiu = 409;
         _anti.sibaiyishijiu = 419;
         _anti.wubaiershijiu = 529;
         _anti.baishijiu = 89;
         _anti.yisiwujiu = 1459;
         _anti.yiqiwujiu = 1759;
         _anti.yisijiujiu = 1499;
         _anti.yisanjiujiu = 1399;
         _anti.sibaiershijiu = 429;
         _anti.sibaisanshijiu = 439;
         _anti.sanqianbajiujiu = 3899;
         _anti.sanbai = 300;
         _anti.jiubaijiu = 989;
         this._anti.zhhz = "zhhz";
         this._anti.phhl = "phhl";
         this._anti.bxhy = "bxhy";
         this._anti.zhhzzzs = "zhhzzzs";
         this._anti.phhlzzs = "phhlzzs";
         this._anti.bxhyzzs = "bxhyzzs";
         this._anti.wpygs = "wpygs";
         this._anti.hjxz = "hjxz";
         this._anti.zsxz = "zsxz";
         this._anti.nianqld = "nianqld";
         this._anti.nianjhd = "nianjhd";
         this._anti.p_cyst = "p_cyst";
         this._anti.p_jlcyst = "p_jlcyst";
         this._anti.p_sscyst = "p_sscyst";
         this._anti.p_cyyf = "p_cyyf";
         this._anti.p_jlcyyf = "p_jlcyyf";
         this._anti.p_sscyyf = "p_sscyyf";
         this._anti.p_cyxz = "p_cyxz";
         this._anti.p_jlcyxz = "p_jlcyxz";
         this._anti.p_sscyxz = "p_sscyxz";
         this._anti.p_cymz = "p_cymz";
         this._anti.p_jlcymz = "p_jlcymz";
         this._anti.p_sscymz = "p_sscymz";
         this._anti.p_cysx = "p_cysx";
         this._anti.p_jlcysx = "p_jlcysx";
         this._anti.p_sscysx = "p_sscysx";
         this._anti.p_cykx = "p_cykx";
         this._anti.p_jlcykx = "p_jlcykx";
         this._anti.p_sscykx = "p_sscykx";
         this._anti.p_cyhh = "p_cyhh";
         this._anti.p_jlcyhh = "p_jlcyhh";
         this._anti.p_sscyhh = "p_sscyhh";
         this._anti.p_cztk = "p_cztk";
         this._anti.p_jlcztk = "p_jlcztk";
         this._anti.p_sscztk = "p_sscztk";
         this._anti.p_czst = "p_czst";
         this._anti.p_jlczst = "p_jlczst";
         this._anti.p_ssczst = "p_ssczst";
         this._anti.p_czkj = "p_czkj";
         this._anti.p_jlczkj = "p_jlczkj";
         this._anti.p_ssczkj = "p_ssczkj";
         this._anti.p_czzx = "p_czzx";
         this._anti.p_jlczzx = "p_jlczzx";
         this._anti.p_ssczzx = "p_ssczzx";
         this._anti.p_cylhjl = "p_cylhjl";
         this._anti.p_jlcylhjl = "p_jlcylhjl";
         this._anti.p_sscylhjl = "p_sscylhjl";
         this._anti.p_cybxjl = "p_cybxjl";
         this._anti.p_jlcybxjl = "p_jlcybxjl";
         this._anti.p_sscybxjl = "p_sscybxjl";
         this._anti.p_cygsjl = "p_cygsjl";
         this._anti.p_jlcygsjl = "p_jlcygsjl";
         this._anti.p_sscygsjl = "p_sscygsjl";
         this._anti.p_cynsjl = "p_cynsjl";
         this._anti.p_jlcynsjl = "p_jlcynsjl";
         this._anti.p_sscynsjl = "p_sscynsjl";
         this._anti.p_cykljl = "p_cykljl";
         this._anti.p_jlcykljl = "p_jlcykljl";
         this._anti.p_sscykljl = "p_sscykljl";
         this._anti.p_cyzsjl = "p_cyzsjl";
         this._anti.p_jlcyzsjl = "p_jlcyzsjl";
         this._anti.p_sscyzsjl = "p_sscyzsjl";
         this._anti.p_cycnjl = "p_cycnjl";
         this._anti.p_jlcycnjl = "p_jlcycnjl";
         this._anti.p_sscycnjl = "p_sscycnjl";
         this._anti.p_cyymjl = "p_cyymjl";
         this._anti.p_jlcyymjl = "p_jlcyymjl";
         this._anti.p_sscyymjl = "p_sscyymjl";
         this._anti.p_cyyhjl = "p_cyyhjl";
         this._anti.p_jlcyyhjl = "p_jlcyyhjl";
         this._anti.p_sscyyhjl = "p_sscyyhjl";
         this._anti.ptdxzf = "ptdxzf";
         this._anti.ptdxzg = "ptdxzg";
         this._anti.ptdjs = "ptdjs";
         this._anti.ptdcz = "ptdcz";
         this._anti.ptddp = "ptddp";
         this._anti.ptdcs = "ptdcs";
         this._anti.ptdyyc = "ptdyyc";
         this._anti.ptdcp = "ptdcp";
         this._anti.mysz = "mysz";
         this._anti._4399zswj = "_4399zswj";
         this._anti._4399ptsjwj = "_4399ptsjwj";
         this._anti._4399yxsjwj = "_4399yxsjwj";
         this._anti._4399jlsjwj = "_4399jlsjwj";
         this._anti._4399sssjwj = "_4399sssjwj";
         this._anti._zmxyanniversary = "_zmxyanniversary";
         this._anti._zmszntx = "_zmszntx";
         this._anti._zmxyptxnkl = "_zmxyptxnkl";
         this._anti._zmxyyxxnkl = "_zmxyyxxnkl";
         this._anti._zmxyjlxnkl = "_zmxyjlxnkl";
         this._anti._zmxyssxnkl = "_zmxyssxnkl";
         this._anti._ptjsxstx = "_ptjsxstx";
         this._anti._yxjsxstx = "_yxjsxstx";
         this._anti._jljsxstx = "_jljsxstx";
         this._anti._ssjsxstx = "_ssjsxstx";
         this._anti._yxwsjkh = "_yxwsjkh";
         this._anti._jlwsjkh = "_jlwsjkh";
         this._anti._sswsjkh = "_sswsjkh";
         this._anti._ssggjtg = "_ssggjtg";
         this._anti._ssggjtg2015 = "_ssggjtg2015";
         this._anti.bgqmtx = "bgqmtx";
         this._anti._zmxyptxnkl2014 = "_zmxyptxnkl2014";
         this._anti._zmxyyxxnkl2014 = "_zmxyyxxnkl2014";
         this._anti._zmxyjlxnkl2014 = "_zmxyjlxnkl2014";
         this._anti._zmxyssxnkl2014 = "_zmxyssxnkl2014";
         this._anti._zmxyptxnkl2017 = "_zmxyptxnkl2017";
         this._anti._zmxyyxxnkl2017 = "_zmxyyxxnkl2017";
         this._anti._zmxyjlxnkl2017 = "_zmxyjlxnkl2017";
         this._anti._zmxyssxnkl2017 = "_zmxyssxnkl2017";
         this._anti._zmxyptxnkl2018 = "_zmxyptxnkl2018";
         this._anti._zmxyyxxnkl2018 = "_zmxyyxxnkl2018";
         this._anti._zmxyjlxnkl2018 = "_zmxyjlxnkl2018";
         this._anti._zmxyssxnkl2018 = "_zmxyssxnkl2018";
         this._anti._sryxpt = "_sryxpt";
         this._anti._sryxyx = "_sryxyx";
         this._anti._sryxjl = "_sryxjl";
         this._anti._sryxss = "_sryxss";
         this._anti._lsyxpt = "_lsyxpt";
         this._anti._lsyxyx = "_lsyxyx";
         this._anti._lsyxjl = "_lsyxjl";
         this._anti._lsyxss = "_lsyxss";
         this._anti._jsyxpt = "_jsyxpt";
         this._anti._jsyxyx = "_jsyxyx";
         this._anti._jsyxjl = "_jsyxjl";
         this._anti._jsyxss = "_jsyxss";
         this._anti.cs_wq_ll = "cs_wq_ll";
         this._anti.cs_wq_yt = "cs_wq_yt";
         this._anti.cs_wq_qs = "cs_wq_qs";
         this._anti.cs_wq_rc = "cs_wq_rc";
         this._anti.cs_fj_dz = "cs_fj_dz";
         this._anti.cs_fj_zt = "cs_fj_zt";
         this._anti.cs_fj_jt = "cs_fj_jt";
         this._anti.cs_fj_js = "cs_fj_js";
         this._anti.cs_sp_hy = "cs_sp_hy";
         this._anti.cs_wq_qs_zzs = "cs_wq_qs_zzs";
         this._anti.cs_wq_rc_zzs = "cs_wq_rc_zzs";
         this._anti.cs_wq_yt_zzs = "cs_wq_yt_zzs";
         this._anti.cs_wq_ll_zzs = "cs_wq_ll_zzs";
         this._anti.cs_fj_dz_zzs = "cs_fj_dz_zzs";
         this._anti.cs_fj_zt_zzs = "cs_fj_zt_zzs";
         this._anti.cs_fj_jt_zzs = "cs_fj_jt_zzs";
         this._anti.cs_fj_js_zzs = "cs_fj_js_zzs";
         this._anti.lyfbjns2 = "lyfbjns2";
         this._anti.tjgljns2 = "tjgljns2";
         this._anti.xgqjns2 = "xgqjns2";
         this._anti.tkjjns2 = "tkjjns2";
         this._anti.ghyb = "ghyb";
         this._anti.wpqhs1 = "wpqhs1";
         this._anti.wpqhs2 = "wpqhs2";
         this._anti.wpqhs3 = "wpqhs3";
         this._anti.wpqhs4 = "wpqhs4";
         this._anti.sms2 = "sms2";
         this._anti.sms3 = "sms3";
         this._anti.mfs2 = "mfs2";
         this._anti.mfs3 = "mfs3";
         this._anti.gjs2 = "gjs2";
         this._anti.gjs3 = "gjs3";
         this._anti.fys2 = "fys2";
         this._anti.fys3 = "fys3";
         this._anti.wpxyf = "wpxyf";
         this._anti.wpbdf = "wpbdf";
         this._anti.mpyj = "mpyj";
         this._anti.wpcsd = "wpcsd";
         this._anti.wphhd = "wphhd";
         this._anti.wptlz = "wptlz";
         this._anti.wpllz = "wpllz";
         this._anti.wphlz = "wphlz";
         this._anti.wpflz = "wpflz";
         this._anti.wpslz = "wpslz";
         this._anti.css12 = "css12";
         this._anti.css18 = "css18";
         this._anti.sbjyd = "sbjyd";
         this._anti.jyys = "jyys";
         this._anti.css_2 = "css_2";
         this._anti.cwzzxld = "cwzzxld";
         this._anti.cwjnxld = "cwjnxld";
         this._anti.jyd3 = "jyd3";
         this._anti.djyys = "djyys";
         this._anti.lhys = "lhys";
         this._anti.bmd = "bmd";
         this._anti.yp = "yp";
         this._anti.gz = "gz";
         this._anti.ml = "ml";
         this._anti.sz = "sz";
         this._anti.zz = "zz";
         this._anti.jbc = "jbc";
         this._anti.szj = "szj";
         this._anti.kly1 = "kly1";
         this._anti.kly2 = "kly2";
         this._anti.kly3 = "kly3";
         this._anti.kly4 = "kly4";
         this._anti.kly5 = "kly5";
         this._anti.xns1 = "xns1";
         this._anti.xns2 = "xns2";
         this._anti.xns3 = "xns3";
         this._anti.xns4 = "xns4";
         this._anti.xssp = "xssp";
         this._anti.wpfbyyin = "wpfbyyin";
         this._anti.wpfbyyan = "wpfbyyan";
         this._anti.wpfbtc = "wpfbtc";
         this._anti.lxfb = "lxfb";
         this._anti.sxfb = "sxfb";
         this._anti.yxfb = "yxfb";
         this._anti.lssp_1 = "lssp_1";
         this._anti.lssp_2 = "lssp_2";
         this._anti.lssp_3 = "lssp_3";
         this._anti.lssp_4 = "lssp_4";
         this._anti.lssp_5 = "lssp_5";
         this._anti.lssp_6 = "lssp_6";
         this._anti.lssp_7 = "lssp_7";
         this._anti.lssp_8 = "lssp_8";
         this._anti.lssp_9 = "lssp_9";
         this._anti.lxfs_1 = "lxfs_1";
         this._anti.lxfs_2 = "lxfs_2";
         this._anti.lxfs_3 = "lxfs_3";
         this._anti.ptnmwsz = "ptnmwsz";
         this._anti.yxnmwsz = "yxnmwsz";
         this._anti.jlnmwsz = "jlnmwsz";
         this._anti.ssnmwsz = "ssnmwsz";
         this._anti.ptzlwsz = "ptzlwsz";
         this._anti.yxzlwsz = "yxzlwsz";
         this._anti.jlzlwsz = "jlzlwsz";
         this._anti.sszlwsz = "sszlwsz";
         this._anti.ptsmsrsz = "ptsmsrsz";
         this._anti.yxsmsrsz = "yxsmsrsz";
         this._anti.jlsmsrsz = "jlsmsrsz";
         this._anti.sssmsrsz = "sssmsrsz";
         this._anti.ptttzssz = "ptttzssz";
         this._anti.yxttzssz = "yxttzssz";
         this._anti.jlttzssz = "jlttzssz";
         this._anti.ssttzssz = "ssttzssz";
         this._anti.ptzqsz = "ptzqsz";
         this._anti.yxzqsz = "yxzqsz";
         this._anti.jlzqsz = "jlzqsz";
         this._anti.sszqsz = "sszqsz";
         this._anti.hsqq = "hsqq";
         this._anti.h_sqq = "h_sqq";
         this._anti.lsqq = "lsqq";
         this._anti.csqq = "csqq";
         this._anti.l_sqq = "l_sqq";
         this._anti.zsqq = "zsqq";
         this._anti.fsqq = "fsqq";
         this._anti.sxyg = "sxyg";
         this._anti.dkhl = "dkhl";
         this._anti.yyb = "yyb";
         this._anti.hehua = "hehua";
         this._anti.tjbg = "tjbg";
         this._anti.hsj = "hsj";
         _anti.jlc = "jlc";
         this._anti.wpmgh = "wpmgh";
         this._anti.yysn = "yysn";
         this._anti.bxzq = "bxzq";
         this._anti.lxzhs = "lxzhs";
         this._anti.sxzhs = "sxzhs";
         _anti.cdjyys = "cdjyys";
         _anti.dlhys = "dlhys";
         _anti.bnnxz = "bnnxz";
         this._anti.wpsh_1 = "wpsh_1";
         this._anti.wpsh_2 = "wpsh_2";
         this._anti.wpsh_3 = "wpsh_3";
         this._anti.wpsh_4 = "wpsh_4";
         this._anti.wpsh_5 = "wpsh_5";
         this._anti.wpst_1 = "wpst_1";
         this._anti.wpst_2 = "wpst_2";
         this._anti.wpst_3 = "wpst_3";
         this._anti.wpst_4 = "wpst_4";
         this._anti.wpst_5 = "wpst_5";
         this._anti.p_cyst_obj = {"atk":2};
         this._anti.p_jlcyst_obj = {"atk":4};
         this._anti.p_sscyst_obj = {"atk":6};
         this._anti.p_cyyf_obj = {"hp":20};
         this._anti.p_jlcyyf_obj = {"hp":40};
         this._anti.p_sscyyf_obj = {"hp":80};
         this._anti.p_cymz_obj = {"mp":10};
         this._anti.p_jlcymz_obj = {"mp":20};
         this._anti.p_sscymz_obj = {"mp":30};
         this._anti.p_cyxz_obj = {"def":1};
         this._anti.p_jlcyxz_obj = {"def":2};
         this._anti.p_sscyxz_obj = {"def":4};
         this._anti.p_cysx_obj = {};
         this._anti.p_jlcysx_obj = {};
         this._anti.p_sscysx_obj = {};
         this.initWpEquipment("all");
         this.initSutraEquipment("all");
         this.initSellEquipment("all");
         this.newMyEquipObj("all");
         this.initPetEquip("all");
      }
      
      public function newMyEquipObj(equipName:String) : void
      {
         var i:* = 0;
         normalEquipment = [];
         otherEquipment = [];
         if(equipName == "all" || equipName == this._anti.ptdxzf)
         {
            normalClothes = new MyEquipObj(1,"普通的行者服",this._anti.ptdxzf,"zbfj","悟空","普 通","0xFFFFFF",this._anti.twenty + Math.round(RandomControllor.getIns().getRandom() * this._anti.twenty),this._anti.twelve + Math.round(RandomControllor.getIns().getRandom() * 13),0,2,0,0,0,0,0,0,0,{"def":2},"",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == this._anti.ptdxzg)
         {
            normalStick = new MyEquipObj(1,"普通的行者棍",this._anti.ptdxzg,"zbwq","悟空","普 通","0xFFFFFF",0,0,this._anti.two + Math.round(RandomControllor.getIns().getRandom() * 3),0,0,0,0,0,0,0,0,{"att":3},"",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == this._anti.ptdjs)
         {
            normalCassock = new MyEquipObj(1,"普通的袈裟",this._anti.ptdjs,"zbfj","唐僧","普 通","0xFFFFFF",this._anti.twelve + Math.round(RandomControllor.getIns().getRandom() * 13),this._anti.twenty_five + Math.round(RandomControllor.getIns().getRandom() * this._anti.twenty_five),0,1,0,0,0,0,0,0,0,{"def":2},"",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == this._anti.ptdcz)
         {
            normalStaff = new MyEquipObj(1,"普通的禅杖",this._anti.ptdcz,"zbwq","唐僧","普 通","0xFFFFFF",0,0,this._anti.three + Math.round(RandomControllor.getIns().getRandom() * 3),0,0,0,0,0,0,0,0,{"att":3},"",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == this._anti.ptddp)
         {
            normalStoneAX = new MyEquipObj(1,"普通的钉耙",this._anti.ptddp,"zbwq","八戒","普 通","0xFFFFFF",0,0,this._anti.five + Math.round(RandomControllor.getIns().getRandom() * 5),0,0,0,0,0,0,0,0,{"att":3},"",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == this._anti.ptdcs)
         {
            normalCymbidium = new MyEquipObj(1,"普通的长衫",this._anti.ptdcs,"zbfj","八戒","普 通","0xFFFFFF",this._anti.twenty_five + Math.round(RandomControllor.getIns().getRandom() * this._anti.twenty_five),8 + Math.round(RandomControllor.getIns().getRandom() * 9),0,2,0,0,0,0,0,0,0,{"def":2},"",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == this._anti.ptdyyc)
         {
            normalYueyaChan = new MyEquipObj(1,"普通的月牙铲",this._anti.ptdyyc,"zbwq","沙僧","普 通","0xFFFFFF",0,0,this._anti.four + Math.round(RandomControllor.getIns().getRandom() * 4),0,0,0,0,0,0,0,0,{"att":3},"",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == this._anti.ptdcp)
         {
            normalRobe = new MyEquipObj(1,"普通的长袍",this._anti.ptdcp,"zbfj","沙僧","普 通","0xFFFFFF",this._anti.seventeen + Math.round(RandomControllor.getIns().getRandom() * this._anti.eighteen),this._anti.seventeen + Math.round(RandomControllor.getIns().getRandom() * this._anti.eighteen),0,1,0,0,0,0,0,0,0,{"def":2},"",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == this._anti.mysz)
         {
            normalnewSp = new MyEquipObj(1,"秘银手镯",this._anti.mysz,"zbsp","","优 秀","0x00FF00",this._anti.one_hundred,this._anti.one_hundred,this._anti.five,this._anti.two,0,0,0,0,0,0,0,{
               "ehp":1,
               "emp":1
            },"",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         normalEquipment.push(normalClothes,normalStick,normalCassock,normalStaff,normalStoneAX,normalCymbidium,normalYueyaChan,normalRobe,normalnewSp);
         if(equipName == "all" || equipName == "kyg")
         {
            otherEquip1 = new MyEquipObj(5,"枯叶弓","kyg","zbwq","沙僧","优 秀","0x00FF00",0,0,this._anti.sixteen + Math.round(RandomControllor.getIns().getRandom() * 4),0,0,0,0,0,0,0,0,{"att":3},"一落红，一枯叶，落红离弦去，从此两难聚",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "kyz")
         {
            otherEquip2 = new MyEquipObj(2,"枯叶杖","kyz","zbwq","唐僧","优 秀","0x00FF00",0,this._anti.one_hundred + Math.round(RandomControllor.getIns().getRandom() * this._anti.twenty),this._anti.twelve + Math.round(RandomControllor.getIns().getRandom() * 8),0,0,0,0,0,0,0,0,{"att":3},"求不得，放不下，梧桐化成杖，孤走枯苍道",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "kys")
         {
            otherEquip3 = new MyEquipObj(2,"枯叶衫","kys","zbfj","悟空","优 秀","0x00FF00",this._anti.eighty + Math.round(RandomControllor.getIns().getRandom() * this._anti.fifty),this._anti.fifty + Math.round(RandomControllor.getIns().getRandom() * this._anti.twenty),0,2 + Math.round(RandomControllor.getIns().getRandom() * 2),0,0,0,0,0,0,0,{
               "hp":this._anti.twenty,
               "mp":10
            },"落黄昏，三更雨，临行密密缝，离愁丝丝苦",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "xhz")
         {
            otherEquip4 = new MyEquipObj(2,"宣花坠","xhz","zbsp","","优 秀","0x00FF00",0,0,this._anti.fifteen + Math.round(RandomControllor.getIns().getRandom() * 5),3 + Math.round(RandomControllor.getIns().getRandom() * 3),0,0,0,0,0,0,0,{
               "att":3,
               "def":1
            },"花映红，春风笑，佳人佩美坠，不知与谁同",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "xhc")
         {
            otherEquip5 = new MyEquipObj(2,"宣花锤","xhc","zbwq","八戒","优 秀","0x00FF00",this._anti.one_hundred + Math.round(RandomControllor.getIns().getRandom() * this._anti.seventy),0,this._anti.twenty + Math.round(RandomControllor.getIns().getRandom() * 6),0,0,0,0,0,0,0,0,{"att":4},"街喧闹，人过往，且记曾相识，不为少年留",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "xhp")
         {
            otherEquip6 = new MyEquipObj(2,"宣花袍","xhp","zbfj","沙僧","优 秀","0x00FF00",this._anti.seventy + Math.round(RandomControllor.getIns().getRandom() * 30),this._anti.seventy + Math.round(RandomControllor.getIns().getRandom() * 30),0,1 + Math.round(RandomControllor.getIns().getRandom() * 1),0,0,0,0,0,0,0,{
               "hp":this._anti.fifteen,
               "mp":this._anti.fifteen
            },"人离合，月圆缺，花开又花谢，不愿再相逢",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "whg")
         {
            otherEquip7 = new MyEquipObj(2,"尾火棍","whg","zbwq","悟空","优 秀","0x00FF00",0,0,10 + Math.round(RandomControllor.getIns().getRandom() * 5),0,0,0,0,0,0,0,0,{"att":2},"诸法因缘生，我说是因缘；因缘尽故灭，我作如是说",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "jmc")
         {
            otherEquip8 = new MyEquipObj(2,"角木铲","jmc","zbwq","沙僧","优 秀","0x00FF00",0,0,this._anti.eighteen + Math.round(RandomControllor.getIns().getRandom() * 6),0,0,0,0,0,0,0,0,{"att":3},"若人造重罪，作已深自责；忏悔更不造，能拔根本业",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "bsp")
         {
            otherEquip9 = new MyEquipObj(2,"壁水袍","bsp","zbfj","唐僧","优 秀","0x00FF00",this._anti.fifty + Math.round(RandomControllor.getIns().getRandom() * this._anti.twenty),this._anti.one_hundred + Math.round(RandomControllor.getIns().getRandom() * this._anti.twenty),0,1,0,0,0,0,0,0,0,{
               "hp":10,
               "mp":this._anti.twenty
            },"一切有为法。如梦幻泡影，如露亦如电。应作如是观",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "dtk")
         {
            otherEquip10 = new MyEquipObj(2,"氐土铠","dtk","zbfj","八戒","优 秀","0x00FF00",this._anti.one_hundred + Math.round(RandomControllor.getIns().getRandom() * this._anti.seventy),35 + Math.round(RandomControllor.getIns().getRandom() * this._anti.fifteen),0,4 + Math.round(RandomControllor.getIns().getRandom() * 1),0,0,0,0,0,0,0,{
               "hp":this._anti.twenty,
               "mp":7
            },"我本因地，以念佛心，入无生忍，今于此界，摄念佛人，归于净土",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "qybd")
         {
            otherEquip11 = new MyEquipObj(3,"青云冰刀","qybd","zbwq","悟空","精 良","0x0000FF",0,0,30 + Math.round(RandomControllor.getIns().getRandom() * 5),0,0.03,0,0,0,0,0,0,{
               "att":5,
               "crit":0.01
            },"凝霜夜，幽香梦，枕边人赴烽火，吹起一帘牵挂",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "qyfp")
         {
            otherEquip12 = new MyEquipObj(3,"青云法袍","qyfp","zbfj","唐僧","精 良","0x0000FF",this._anti.one_hundred_thirty + Math.round(RandomControllor.getIns().getRandom() * this._anti.twenty),260 + Math.round(RandomControllor.getIns().getRandom() * this._anti.fourty),0,4 + Math.round(RandomControllor.getIns().getRandom() * 1),0,0,0,0,0,0,0,{
               "hp":this._anti.twenty_five,
               "mp":this._anti.fifty,
               "def":1
            },"碧天阔，白云散，百万里无硝烟，大雁向南飞去",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "qysz")
         {
            otherEquip13 = new MyEquipObj(1,"青云手镯","qysz","zbsp","","精 良","0x0000FF",0,0,37 + Math.round(RandomControllor.getIns().getRandom() * 6),7 + Math.round(RandomControllor.getIns().getRandom() * 1),0.02,0,0,0,0,0,0,{
               "att":7,
               "def":2,
               "crit":0.01
            },"珠有泪，玉生烟，稀白头不胜簪，只是当时惘然",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "hylk")
         {
            otherEquip14 = new MyEquipObj(3,"混元龙铠","hylk","zbfj","八戒","精 良","0x0000FF",this._anti.three_hundred_eighty + Math.round(RandomControllor.getIns().getRandom() * this._anti.seventy),95 + Math.round(RandomControllor.getIns().getRandom() * this._anti.fifteen),0,8 + Math.round(RandomControllor.getIns().getRandom() * 1),0,0,0,0,0,0,0,{
               "hp":this._anti.seventy,
               "mp":this._anti.eighteen,
               "def":2
            },"龙吟恨，且回首，却在灯火阑珊",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "hylc")
         {
            otherEquip15 = new MyEquipObj(3,"混元雷叉","hylc","zbwq","沙僧","精 良","0x0000FF",0,0,42 + Math.round(RandomControllor.getIns().getRandom() * 6),0,0,0,1,1,0,0,0,{
               "att":7,
               "crit":0.01
            },"倾盆雨，惊天雷，众里寻他而去",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "hylz")
         {
            otherEquip16 = new MyEquipObj(3,"混元灵杖","hylz","zbwq","唐僧","精 良","0x0000FF",0,0,this._anti.fourty_four + Math.round(RandomControllor.getIns().getRandom() * 8),0,0,0,0,2,0,0,0,{
               "att":8,
               "emp":1
            },"损愁眉，哭断肠，待到佳期如梦",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "wtp")
         {
            otherEquip17 = new MyEquipObj(3,"胃土耙","wtp","zbwq","八戒","精 良","0x0000FF",0,0,this._anti.fourty_four + Math.round(RandomControllor.getIns().getRandom() * 6),0,0,0,2,0,0,0,0,{
               "att":8,
               "ehp":1
            },"当舍于懈怠，远离诸愦闹；寂静常知足，是人当解脱",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "yhj")
         {
            otherEquip18 = new MyEquipObj(3,"翼火甲","yhj","zbfj","悟空","精 良","0x0000FF",this._anti.two_hundred_eighty + Math.round(RandomControllor.getIns().getRandom() * this._anti.fifty),this._anti.one_hundred_thirty + Math.round(RandomControllor.getIns().getRandom() * this._anti.twenty),0,10 + Math.round(RandomControllor.getIns().getRandom() * 2),0,0,0,0,0,0,0,{
               "hp":this._anti.fifty,
               "mp":24,
               "def":2
            },"汝修三昧，本出尘劳。淫心不除，尘不可出",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "jmy")
         {
            otherEquip19 = new MyEquipObj(3,"井木衣","jmy","zbfj","沙僧","精 良","0x0000FF",this._anti.one_hundred_nighty + Math.round(RandomControllor.getIns().getRandom() * 30),this._anti.one_hundred_nighty + Math.round(RandomControllor.getIns().getRandom() * 30),0,5 + Math.round(RandomControllor.getIns().getRandom() * 1),0,0,0,0,0,0,0,{
               "hp":33,
               "mp":33,
               "def":1
            },"菩提本无树，明镜亦非台。本来无疑物，何处染尘埃",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "zjksf")
         {
            otherEquip20 = new MyEquipObj(4,"紫金开山斧","zjksf","zbwq","八戒","史 诗","0x660099",0,0,this._anti.eighty + Math.round(RandomControllor.getIns().getRandom() * this._anti.twelve),0,0,0,3,0,0,0,0,{
               "att":this._anti.fifteen,
               "ehp":1
            },"人间如梦，红尘万丈，劈不断相思情",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "zjqj")
         {
            otherEquip21 = new MyEquipObj(4,"紫金轻甲","zjqj","zbfj","悟空","史 诗","0x660099",this._anti.five_hundred_eighty + Math.round(RandomControllor.getIns().getRandom() * this._anti.one_hundred),this._anti.two_hundred_fifty + Math.round(RandomControllor.getIns().getRandom() * this._anti.fourty),0,22 + Math.round(RandomControllor.getIns().getRandom() * 4),0,0,0,0,0,0,0,{
               "hp":this._anti.one_hundred,
               "mp":this._anti.fifty,
               "def":4
            },"恨悠悠，几时休。爱轻轻，随风行",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "zjbtg")
         {
            otherEquip22 = new MyEquipObj(4,"紫金镔铁棍","zjbtg","zbwq","悟空","史 诗","0x660099",0,0,this._anti.sixty + Math.round(RandomControllor.getIns().getRandom() * 10),0,0.05,0,0,0,0,0,0,{
               "att":11,
               "crit":0.02
            },"人间道，路远茫，相逢终有期",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "jllm")
         {
            otherEquip23 = new MyEquipObj(4,"卷帘绿魔","jllm","zbfj","沙僧","史 诗","0x660099",this._anti.three_hundred_seventy + Math.round(RandomControllor.getIns().getRandom() * this._anti.sixty),this._anti.three_hundred_seventy + Math.round(RandomControllor.getIns().getRandom() * this._anti.sixty),0,11 + Math.round(RandomControllor.getIns().getRandom() * 2),0,0,2,2,0,0,0,{
               "hp":this._anti.seventy,
               "mp":this._anti.seventy,
               "def":2,
               "ehp":1
            },"风卷云残，俱消往昔，既然无缘，何立誓言",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "shsjt")
         {
            otherEquip24 = new MyEquipObj(1,"山河社稷图","shsjt","zbsp","","史 诗","0x660099",0,0,0,0,0,0,0,0,0,0,0,{},"英雄泪，只为江山。万里山河，千里孤城，破国恨，永难忘",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "smz")
         {
            otherEquip25 = new MyEquipObj(4,"嗜魔杖","smz","zbwq","唐僧","史 诗","0x660099",0,0,this._anti.nighty_two + Math.round(RandomControllor.getIns().getRandom() * this._anti.sixteen),0,0,0,0,3,0,0,0,{
               "att":this._anti.seventeen,
               "emp":1
            },"魔非魔，念人间，怎知情愁滋味",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "ydjg")
         {
            otherEquip26 = new MyEquipObj(4,"银弹金弓","ydjg","zbwq","沙僧","史 诗","0x660099",0,0,this._anti.fifty_six + Math.round(RandomControllor.getIns().getRandom() * 8),0,0.05,0,0,3,0,0,0,{
               "att":10,
               "crit":0.02
            },"挽金弓，如满月，望人间，凝伫久",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "wsjg")
         {
            otherEquip27 = new MyEquipObj(4,"顽石金刚","wsjg","zbfj","八戒","史 诗","0x660099",800 + Math.round(RandomControllor.getIns().getRandom() * 140),185 + Math.round(RandomControllor.getIns().getRandom() * 30),0,14 + Math.round(RandomControllor.getIns().getRandom() * 2),0,0,0,0,0,this._anti.zero_point_1,0,{
               "hp":150,
               "mp":35,
               "mdef":0.02
            },"心若顽石，不生多情，多情空于恨，此恨无绝期",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "hljh")
         {
            otherEquip28 = new MyEquipObj(4,"红莲教皇","hljh","zbfj","唐僧","史 诗","0x660099",this._anti.two_hundred_fifty + Math.round(RandomControllor.getIns().getRandom() * this._anti.fourty),this._anti.five_hundred + Math.round(RandomControllor.getIns().getRandom() * this._anti.eighty),0,10 + Math.round(RandomControllor.getIns().getRandom() * 2),0,0,0,3,0,0,0,{
               "hp":45,
               "mp":this._anti.nighty,
               "def":2,
               "emp":1
            },"一种相思，两处闲愁，火焰化红莲，此情自消衍",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "tflj")
         {
            otherEquip29 = new MyEquipObj(4,"通风灵戒","tflj","zbsp","","优 秀","0x00FF00",this._anti.one_hundred + Math.round(RandomControllor.getIns().getRandom() * this._anti.twenty),this._anti.nighty + Math.round(RandomControllor.getIns().getRandom() * this._anti.twenty),0,0,0,0,0,0,0,0,0,{
               "hp":this._anti.twenty,
               "mp":this._anti.fifteen,
               "emp":1
            },"风过处，百花残，心有意，爱无伤",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "mgzh")
         {
            otherEquip30 = new MyEquipObj(4,"马官指环","mgzh","zbsp","","精 良","0x0000FF",this._anti.two_hundred_fourty_five + Math.round(RandomControllor.getIns().getRandom() * 43),169 + Math.round(RandomControllor.getIns().getRandom() * 26),0,0,0,0,0,0,0,0,0,{
               "hp":45,
               "mp":30,
               "att":this._anti.fifteen
            },"马行处，雪无痕，相见难，别亦难",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "tdlzj")
         {
            otherEquip31 = new MyEquipObj(4,"提多罗吒戒","tdlzj","zbsp","","史 诗","0x660099",this._anti.five_hundred + Math.round(RandomControllor.getIns().getRandom() * 85),0,0,14 + Math.round(RandomControllor.getIns().getRandom() * 3),0,0,0,0,0,this._anti.zero_point_1,0,{
               "hp":this._anti.nighty,
               "def":3,
               "mdef":0.02
            },"殿可毁，人可亡，恨犹在，何时还",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "xley")
         {
            otherEquip32 = new MyEquipObj(5,"厄夜","xley","zbfj","悟空","邪 灵","0x666666",0,0,this._anti.nighty + Math.round(RandomControllor.getIns().getRandom() * 5),0,0.05,0,-1,0,0,0,0,{
               "att":this._anti.fifteen,
               "ehp":-1
            },"",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "xlcz")
         {
            otherEquip33 = new MyEquipObj(5,"残昼","xlcz","zbfj","唐僧","邪 灵","0x666666",-this._anti.one_hundred,this._anti.seven_hundred_fourty + Math.round(RandomControllor.getIns().getRandom() * this._anti.fourty),140 + Math.round(RandomControllor.getIns().getRandom() * 8),0,0,0,0,0,0,0,0,{
               "att":this._anti.twenty,
               "hp":-this._anti.fifty
            },"",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "xlry")
         {
            otherEquip34 = new MyEquipObj(5,"如狱","xlry","zbfj","八戒","邪 灵","0x666666",this._anti.one_thousand_two_hundred_twenty + Math.round(RandomControllor.getIns().getRandom() * this._anti.seventy),-this._anti.one_hundred,0,this._anti.fourty + Math.round(RandomControllor.getIns().getRandom() * 2),0,0,0,0,0,0,0,{
               "hp":200,
               "mp":-this._anti.fifty
            },"",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "xlyj")
         {
            otherEquip35 = new MyEquipObj(5,"犹绝","xlyj","zbfj","沙僧","邪 灵","0x666666",this._anti.five_hundred_fifty + Math.round(RandomControllor.getIns().getRandom() * 30),this._anti.five_hundred_fifty + Math.round(RandomControllor.getIns().getRandom() * 30),0,-10,0,0.05,0,0,0,0,0,{
               "miss":0.02,
               "def":-5
            },"",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "xlth")
         {
            otherEquip36 = new MyEquipObj(5,"天荒","xlth","zbwq","悟空","邪 灵","0x666666",0,0,this._anti.nighty + Math.round(RandomControllor.getIns().getRandom() * 5),0,0.05,0,0,0,0,0,0,{
               "att":this._anti.fifteen,
               "crit":0.02
            },"",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "xltc")
         {
            otherEquip37 = new MyEquipObj(5,"天残","xltc","zbwq","唐僧","邪 灵","0x666666",0,this._anti.seven_hundred_fourty + Math.round(RandomControllor.getIns().getRandom() * this._anti.fourty),140 + Math.round(RandomControllor.getIns().getRandom() * 8),0,0,0,0,0,0,0,0,{
               "att":24,
               "mp":this._anti.one_hundred_thirty
            },"",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "xltz")
         {
            otherEquip38 = new MyEquipObj(5,"天罪","xltz","zbwq","八戒","邪 灵","0x666666",0,0,this._anti.one_hundred_sixteen + Math.round(RandomControllor.getIns().getRandom() * 6),this._anti.twenty + Math.round(RandomControllor.getIns().getRandom() * 1),0,0,0,0,0,0,0,{
               "att":this._anti.twenty,
               "def":4
            },"",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "xlts")
         {
            otherEquip39 = new MyEquipObj(6,"天殇","xlts","zbwq","沙僧","邪 灵","0x666666",0,0,this._anti.eighty + Math.round(RandomControllor.getIns().getRandom() * 4),0,0,0.05,0,0,0,0,0,{
               "att":14,
               "crit":0.02
            },"",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "lly")
         {
            otherEquip40 = new MyEquipObj(1,"玲珑玉","lly","zbsp","","邪 灵","0x666666",this._anti.one_thousand,this._anti.one_thousand,this._anti.one_hundred,this._anti.fifty,0.02,0.02,0,0,0,0,0,{
               "hp":this._anti.one_hundred,
               "mp":this._anti.one_hundred,
               "att":this._anti.fifteen,
               "def":8
            },"",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "jlqrzr")
         {
            otherEquip41 = new MyEquipObj(6,"知汝","jlqrzr","zbwq","唐僧","精 良","0x0000FF",0,0,this._anti.night_four + Math.round(RandomControllor.getIns().getRandom() * 8),0,0,0,0,2,0,0,0,{
               "att":8,
               "emp":1
            },"",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "jlqrmj")
         {
            otherEquip42 = new MyEquipObj(7,"梦江","jlqrmj","zbwq","沙僧","精 良","0x0000FF",0,0,this._anti.eight_two + Math.round(RandomControllor.getIns().getRandom() * 4),0,0.03,0,0,0,0,0,0,{
               "att":6,
               "crit":0.01
            },"",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "jlqrcs")
         {
            otherEquip43 = new MyEquipObj(6,"长蛇","jlqrcs","zbwq","悟空","精 良","0x0000FF",0,0,80 + Math.round(RandomControllor.getIns().getRandom() * 5),0,0.03,0,0,0,0,0,0,{
               "att":5,
               "crit":0.01
            },"",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "jlqrhd")
         {
            otherEquip44 = new MyEquipObj(6,"蝴蝶","jlqrhd","zbwq","八戒","精 良","0x0000FF",0,0,this._anti.eight_four + Math.round(RandomControllor.getIns().getRandom() * 6),0,0,0,2,0,0,0,0,{
               "att":8,
               "ehp":1
            },"",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "ssqrzr")
         {
            otherEquip45 = new MyEquipObj(7,"知汝","ssqrzr","zbwq","唐僧","史 诗","0x660099",0,0,this._anti.one_hundred_nighty_two + Math.round(RandomControllor.getIns().getRandom() * this._anti.sixteen),0,0,0,0,3,0,0,0,{
               "att":this._anti.seventeen,
               "emp":1
            },"",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "ssqrmj")
         {
            otherEquip46 = new MyEquipObj(8,"梦江","ssqrmj","zbwq","沙僧","史 诗","0x660099",0,0,this._anti.one_hundred_fifty_six + Math.round(RandomControllor.getIns().getRandom() * 8),0,0.05,0,0,0,0,0,0,{
               "att":10,
               "crit":0.02
            },"",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "ssqrcs")
         {
            otherEquip47 = new MyEquipObj(7,"长蛇","ssqrcs","zbwq","悟空","史 诗","0x660099",0,0,this._anti.one_hundred_sixty + Math.round(RandomControllor.getIns().getRandom() * 10),0,0.05,0,0,0,0,0,0,{
               "att":11,
               "crit":0.02
            },"",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "ssqrhd")
         {
            otherEquip48 = new MyEquipObj(7,"蝴蝶","ssqrhd","zbwq","八戒","史 诗","0x660099",0,0,this._anti.one_hundred_eighty + Math.round(RandomControllor.getIns().getRandom() * this._anti.twelve),0,0,0,3,0,0,0,0,{
               "att":this._anti.fifteen,
               "ehp":1
            },"",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "qlj")
         {
            otherEquip49 = new MyEquipObj(9,"虬龙甲","qlj","zbfj","悟空","魂 器","0x66ffff",0,0,0,0,0,0,0,0,0,0,0,{"def":this._anti.ten},"",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "qlg")
         {
            otherEquip50 = new MyEquipObj(8,"虬龙棍","qlg","zbwq","悟空","魂 器","0x66ffff",0,0,0,0,0,0,0,0,0,0,0,{"att":this._anti.twenty},"",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "plp")
         {
            otherEquip51 = new MyEquipObj(9,"蟠龙袍","plp","zbfj","唐僧","魂 器","0x66ffff",0,0,0,0,0,0,0,0,0,0,0,{"def":this._anti.ten},"",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "plz")
         {
            otherEquip52 = new MyEquipObj(8,"蟠龙杖","plz","zbwq","唐僧","魂 器","0x66ffff",0,0,0,0,0,0,0,0,0,0,0,{"att":this._anti.twenty},"",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "ylk")
         {
            otherEquip53 = new MyEquipObj(9,"应龙铠","ylk","zbfj","八戒","魂 器","0x66ffff",0,0,0,0,0,0,0,0,0,0,0,{"def":this._anti.ten},"",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "ylh")
         {
            otherEquip54 = new MyEquipObj(8,"应龙斧","ylh","zbwq","八戒","魂 器","0x66ffff",0,0,0,0,0,0,0,0,0,0,0,{"att":this._anti.twenty},"",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "jlj")
         {
            otherEquip55 = new MyEquipObj(9,"蛟龙甲","jlj","zbfj","沙僧","魂 器","0x66ffff",0,0,0,0,0,0,0,0,0,0,0,{"def":this._anti.ten},"",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "jlg")
         {
            otherEquip56 = new MyEquipObj(9,"蛟龙弓","jlg","zbwq","沙僧","魂 器","0x66ffff",0,0,0,0,0,0,0,0,0,0,0,{"att":this._anti.twenty},"",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "clj")
         {
            otherEquip57 = new MyEquipObj(9,"苍龙戒","clj","zbsp","","魂 器","0x66ffff",1000,0,100,0,0,0,0,0,0,0.1,0,{
               "hp":100,
               "att":20,
               "mdef":0.02
            },"蕴藏神秘力量，力量释放完苍龙戒便会破碎。不能赠送，不能放入至尊仓库，且只能携带一个",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "psdclj")
         {
            otherEquip58 = new MyEquipObj(9,"破碎的苍龙戒","psdclj","zbsp","","魂 器","0x66ffff",100,0,10,0,0,0,0,0,0,0.01,0,{},"受混沌之光洗礼，方可复原",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti._4399zswj)
         {
            otherEquip59 = new MyEquipObj(1,"4399忠实玩家",_anti._4399zswj,"zbtx","","优 秀","0x00FF00",0,0,0,0,0,0,0,0,0,0,0,{},"4399八周年欢乐庆，绝版头衔，提升掉宝率",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti.cs_wq_qs)
         {
            otherEquip60 = new MyEquipObj(9,"祁水",_anti.cs_wq_qs,"zbwq","悟空","传 说","0xFF9933",0,0,this._anti.five_hundred,0,this._anti.zero_point_seven,0,0,0,0,0,0,{
               "att":this._anti.fifty,
               "crit":this._anti.zero_point_zero_two
            },"无支祁现于淮水，骇风奇袭，惊浪翻涌。大禹治水时，锁其四肢，压其龟山脚",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti.cs_wq_rc)
         {
            otherEquip61 = new MyEquipObj(9,"若禅",_anti.cs_wq_rc,"zbwq","唐僧","传 说","0xFF9933",0,0,this._anti.five_hundred,0,0,0,0,this._anti.six,0,0,0,{
               "att":this._anti.fifty,
               "emp":this._anti.two
            },"达摩驾一叶扁舟，东来传佛法。受嫉妒，七遭毒，手携只履，翩翩独逝",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti.cs_wq_yt)
         {
            otherEquip62 = new MyEquipObj(9,"夷图",_anti.cs_wq_yt,"zbwq","八戒","传 说","0xFF9933",0,0,this._anti.five_hundred,0,0,0,this._anti.nigth,0,0,0,0,{
               "att":this._anti.fifty,
               "ehp":this._anti.three
            },"河伯循琴音而去，见宓妃厌九隆，发大水抢妻，百年守护，只为美人笑，终而生情",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti.cs_wq_ll)
         {
            otherEquip63 = new MyEquipObj(10,"琉璃",_anti.cs_wq_ll,"zbwq","沙僧","传 说","0xFF9933",0,0,this._anti.five_hundred,0,this._anti.zero_point_seven,0,0,0,0,0,0,{
               "att":this._anti.fifty,
               "crit":this._anti.zero_point_zero_two
            },"琉璃光可照三界之暗",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti.cs_fj_dz)
         {
            otherEquip64 = new MyEquipObj(11,"斗战",_anti.cs_fj_dz,"zbfj","悟空","传 说","0xFF9933",this._anti.two_thousand_fifty,this._anti.one_thousand,0,this._anti.two_hundred_twenty,this._anti.zero_point_seven,0,0,0,0,this._anti.zero_point_1,0,{
               "def":this._anti.twenty_two,
               "hp":this._anti.two_hundred_fifty
            },"战无不胜",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti.cs_fj_zt)
         {
            otherEquip65 = new MyEquipObj(11,"旃檀",_anti.cs_fj_zt,"zbfj","唐僧","传 说","0xFF9933",this._anti.one_thousand,this._anti.two_thousand,this._anti.two_hundred,this._anti.two_hundred,0,0,0,0,0,this._anti.zero_point_1,0,{
               "def":this._anti.twenty,
               "mp":this._anti.two_hundred
            },"檀香不绝",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti.cs_fj_jt)
         {
            otherEquip66 = new MyEquipObj(11,"净坛",_anti.cs_fj_jt,"zbfj","八戒","传 说","0xFF9933",this._anti.three_thousand_fifty,0,this._anti.two_hundred,this._anti.three_hundred,0,0,0,0,0,this._anti.zero_point_1,0,{
               "def":this._anti.thirty,
               "mdef":this._anti.zero_point_zero_two
            },"凡尘不净",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti.cs_fj_js)
         {
            otherEquip67 = new MyEquipObj(11,"金身",_anti.cs_fj_js,"zbfj","沙僧","传 说","0xFF9933",this._anti.one_thousand_fifty,this._anti.one_thousand_fifty,0,this._anti.two_hundred,0,this._anti.zero_point_seven,0,0,0,this._anti.zero_point_1,0,{
               "def":this._anti.twenty,
               "miss":this._anti.zero_point_zero_two
            },"金身不灭",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti.zhhz)
         {
            otherEquip68 = new MyEquipObj(1,"镇魂花坠",_anti.zhhz,"zbsp","","邪 灵","0x666666",this._anti.two_thousand,0,0,0,0,0,0,0,0,this._anti.zero_point_1,0,{
               "hp":this._anti.two_hundred,
               "mdef":this._anti.zero_point_zero_two
            },"催眠飞行怪物，即便死亡也不会苏醒。可以合成最终的传说饰品",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti.phhl)
         {
            otherEquip69 = new MyEquipObj(1,"破幻花链",_anti.phhl,"zbsp","","邪 灵","0x666666",0,this._anti.two_thousand,0,0,0,0,0,this._anti.six,0,0,0,{
               "mp":this._anti.two_hundred,
               "emp":this._anti.two
            },"被眩晕、催眠后，立刻解除此状态。可以合成最终的传说饰品",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti.bxhy)
         {
            otherEquip70 = new MyEquipObj(1,"不朽花翼",_anti.bxhy,"zbsp","","邪 灵","0x666666",0,0,this._anti.one_hundred_fifyt,this._anti.one_hundred,0,0,0,0,0,0,0,{
               "att":this._anti.thirty,
               "def":this._anti.twenty
            },"不受攻击时，将拥有强大的回血能力。可以合成最终的传说饰品",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti.cs_sp_hy)
         {
            otherEquip71 = new MyEquipObj(1,"花宴",_anti.cs_sp_hy,"zbsp","","传 说","0xFF9933",0,0,0,0,0,0,0,0,0,0,0,{},"三仙降临，花遍人间，蕴藏无穷神力",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti._zmxyanniversary)
         {
            otherEquip72 = new MyEquipObj(1,"造梦英雄",_anti._zmxyanniversary,"zbtx","","精 良","0x0000FF",0,0,0,0,0,0,0,0,0,0,0,{},"造梦西游3一周年纪念，绝版头衔，提升10点幸运",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti._zmxyptxnkl)
         {
            otherEquip73 = new MyEquipObj(1,"新年",_anti._zmxyptxnkl,"zbtx","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"祝造梦西游玩家2013年新年快乐。提升2点幸运，可合成。",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti._zmxyyxxnkl)
         {
            otherEquip74 = new MyEquipObj(1,"新年",_anti._zmxyyxxnkl,"zbtx","","优 秀","0x00FF00",0,0,0,0,0,0,0,0,0,0,0,{},"祝造梦西游玩家2013年新年快乐。提升5点幸运，可合成。",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti._zmxyjlxnkl)
         {
            otherEquip75 = new MyEquipObj(1,"新年",_anti._zmxyjlxnkl,"zbtx","","精 良","0x0000FF",0,0,0,0,0,0,0,0,0,0,0,{},"祝造梦西游玩家2013年新年快乐。提升10点幸运，可合成。",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti._zmxyssxnkl)
         {
            otherEquip76 = new MyEquipObj(1,"新年",_anti._zmxyssxnkl,"zbtx","","史 诗","0x660099",0,0,0,0,0,0,0,0,0,0,0,{},"祝造梦西游玩家2013年新年快乐。提升15点幸运",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti.jlc)
         {
            otherEquip77 = new MyEquipObj(11,"蛟龙铲",_anti.jlc,"zbwq","沙僧","魂 器","0x66ffff",0,0,0,0,0,0,0,0,0,0,0,{"att":this._anti.twenty},"",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti._sryxpt)
         {
            otherEquip78 = new MyEquipObj(1,"射日英雄",_anti._sryxpt,"zbtx","","普 通","0xFFFFFF",0,0,0,0,this._anti.zero_point_zero_two,0,this._anti.three,0,0,0,0,{},"造梦西游2013年暑假绝版称号。提升3点回血和2%暴击，可合成。",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti._sryxyx)
         {
            otherEquip79 = new MyEquipObj(1,"射日英雄",_anti._sryxyx,"zbtx","","优 秀","0x00FF00",0,0,0,0,this._anti.zero_point_zero_four,0,this._anti.six,0,0,0,0,{},"造梦西游2013年暑假绝版称号。提升6点回血和4%暴击，可合成。",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti._sryxjl)
         {
            otherEquip80 = new MyEquipObj(1,"射日英雄",_anti._sryxjl,"zbtx","","精 良","0x0000FF",0,0,0,0,this._anti.zero_point_zero_six,0,this._anti.nigth,0,0,0,0,{},"造梦西游2013年暑假绝版称号。提升9点回血和6%暴击，可合成。",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti._sryxss)
         {
            otherEquip81 = new MyEquipObj(1,"射日英雄",_anti._sryxss,"zbtx","","史 诗","0x660099",0,0,0,0,this._anti.zero_point_zero_eight,0,this._anti.twelve,0,0,0,0,{},"造梦西游2013年暑假绝版称号。提升12点回血和8%暴击。",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti._lsyxpt)
         {
            otherEquip82 = new MyEquipObj(1,"乱世英雄",_anti._lsyxpt,"zbtx","","普 通","0xFFFFFF",0,0,0,0,this._anti.zero_point_zero_two,this._anti.zero_point_zero_two,0,0,0,0,0,{},"造梦西游2013年国庆绝版称号。提升2%暴击和2%闪避，可合成。",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti._lsyxyx)
         {
            otherEquip83 = new MyEquipObj(1,"乱世英雄",_anti._lsyxyx,"zbtx","","优 秀","0x00FF00",0,0,0,0,this._anti.zero_point_zero_four,this._anti.zero_point_zero_four,0,0,0,0,0,{},"造梦西游2013年国庆绝版称号。提升4%暴击和4%闪避，可合成。",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti._lsyxjl)
         {
            otherEquip84 = new MyEquipObj(1,"乱世英雄",_anti._lsyxjl,"zbtx","","精 良","0x0000FF",0,0,0,0,this._anti.zero_point_zero_six,this._anti.zero_point_zero_six,0,0,0,0,0,{},"造梦西游2013年国庆绝版称号。提升6%暴击和6%闪避，可合成。",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti._lsyxss)
         {
            otherEquip85 = new MyEquipObj(1,"乱世英雄",_anti._lsyxss,"zbtx","","史 诗","0x660099",0,0,0,0,this._anti.zero_point_zero_eight,this._anti.zero_point_zero_eight,0,0,0,0,0,{},"造梦西游2013年国庆绝版称号。提升8%暴击和8%闪避。",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti._jsyxpt)
         {
            otherEquip86 = new MyEquipObj(1,"救世英雄",_anti._jsyxpt,"zbtx","","普 通","0xFFFFFF",0,0,0,0,this._anti.zero_point_zero_three,this._anti.zero_point_zero_three,0,0,0,0,0,{},"乱世英雄称号升级版，提升3%暴击和3%闪避，可合成。",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti._jsyxyx)
         {
            otherEquip87 = new MyEquipObj(1,"救世英雄",_anti._jsyxyx,"zbtx","","优 秀","0x00FF00",0,0,0,0,this._anti.zero_point_zero_five,this._anti.zero_point_zero_five,0,0,0,0,0,{},"乱世英雄称号升级版，提升5%暴击和5%闪避，可合成。",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti._jsyxjl)
         {
            otherEquip88 = new MyEquipObj(1,"救世英雄",_anti._jsyxjl,"zbtx","","精 良","0x0000FF",0,0,0,0,this._anti.zero_point_seven,this._anti.zero_point_seven,0,0,0,0,0,{},"乱世英雄称号升级版，提升7%暴击和7%闪避，可合成。",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti._jsyxss)
         {
            otherEquip89 = new MyEquipObj(1,"救世英雄",_anti._jsyxss,"zbtx","","史 诗","0x660099",0,0,0,0,this._anti.zero_point_night,this._anti.zero_point_night,0,0,0,0,0,{},"乱世英雄称号升级版，提升9%暴击和9%闪避。",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti._zmxyptxnkl2014)
         {
            otherEquip90 = new MyEquipObj(1,"新年",_anti._zmxyptxnkl2014,"zbtx","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"祝造梦西游玩家2014年新年快乐。提升2点幸运，可合成。",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti._zmxyyxxnkl2014)
         {
            otherEquip91 = new MyEquipObj(1,"新年",_anti._zmxyyxxnkl2014,"zbtx","","优 秀","0x00FF00",0,0,0,0,0,0,0,0,0,0,0,{},"祝造梦西游玩家2014年新年快乐。提升5点幸运，可合成。",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti._zmxyjlxnkl2014)
         {
            otherEquip92 = new MyEquipObj(1,"新年",_anti._zmxyjlxnkl2014,"zbtx","","精 良","0x0000FF",0,0,0,0,0,0,0,0,0,0,0,{},"祝造梦西游玩家2014年新年快乐。提升10点幸运，可合成。",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti._zmxyssxnkl2014)
         {
            otherEquip93 = new MyEquipObj(1,"新年",_anti._zmxyssxnkl2014,"zbtx","","史 诗","0x660099",0,0,0,0,0,0,0,0,0,0,0,{},"祝造梦西游玩家2014年新年快乐。提升15点幸运",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti.bgqmtx)
         {
            otherEquip94 = new MyEquipObj(1,"白骨清明",_anti.bgqmtx,"zbtx","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"清明时节雨纷纷，路上行人欲断魂",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti._4399ptsjwj)
         {
            otherEquip95 = new MyEquipObj(1,"4399手机玩家",_anti._4399ptsjwj,"zbtx","","普 通","0xFFFFFF",0,0,0,0,0,0,this._anti.three,this._anti.two,0,0,0,{},"手机玩家专属，绝版头衔",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti._4399yxsjwj)
         {
            otherEquip96 = new MyEquipObj(1,"4399手机玩家",_anti._4399yxsjwj,"zbtx","","优 秀","0x00FF00",0,0,0,0,0,0,this._anti.six,this._anti.four,0,0,0,{},"手机玩家专属，绝版头衔",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti._4399jlsjwj)
         {
            otherEquip97 = new MyEquipObj(1,"4399手机玩家",_anti._4399jlsjwj,"zbtx","","精 良","0x0000FF",0,0,0,0,0,0,this._anti.nigth,this._anti.six,0,0,0,{},"手机玩家专属，绝版头衔",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti._4399sssjwj)
         {
            otherEquip98 = new MyEquipObj(1,"4399手机玩家",_anti._4399sssjwj,"zbtx","","史 诗","0x660099",0,0,0,0,0,0,this._anti.twelve,this._anti.eight,0,0,0,{},"手机玩家专属，绝版头衔",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti._yxwsjkh)
         {
            otherEquip99 = new MyEquipObj(1,"万圣节",_anti._yxwsjkh,"zbtx","","优 秀","0x00FF00",0,0,0,0,0,0,0,0,0,0,0,{},"2014年万圣节绝版头衔，提升10点幸运",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti._jlwsjkh)
         {
            otherEquip100 = new MyEquipObj(1,"万圣节",_anti._jlwsjkh,"zbtx","","精 良","0x0000FF",0,0,0,0,0,0,0,0,0,0,0,{},"2014年万圣节绝版头衔，提升20点幸运",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti._sswsjkh)
         {
            otherEquip101 = new MyEquipObj(1,"万圣节",_anti._sswsjkh,"zbtx","","史 诗","0x660099",0,0,0,0,0,0,0,0,0,0,0,{},"2014年万圣节绝版头衔，提升30点幸运",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti._ssggjtg)
         {
            otherEquip102 = new MyEquipObj(1,"光棍节脱光",_anti._ssggjtg,"zbtx","","史 诗","0x660099",1111,0,0,0,0,0,11,0,0,0,0,{},"11·11，光棍节绝版头衔",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti._zmszntx)
         {
            otherEquip103 = new MyEquipObj(1,"造梦三周年",_anti._zmszntx,"zbtx","","精 良","0x0000FF",0,0,0,0,0,0,0,0,0,0,0,{},"造梦西游3三周年纪念，绝版头衔，提升30点幸运",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti._ptjsxstx)
         {
            otherEquip104 = new MyEquipObj(1,"救世星宿",_anti._ptjsxstx,"zbtx","","普 通","0xFFFFFF",0,0,0,1 + Math.round(RandomControllor.getIns().getRandom() * 9),0,0,0,0,0,0,0,{},"造梦西游3中击败乱世星宿副本的邪恶boss掉落的信物头衔",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti._yxjsxstx)
         {
            otherEquip105 = new MyEquipObj(1,"救世星宿",_anti._yxjsxstx,"zbtx","","优 秀","0x00FF00",0,0,0,20 + Math.round(RandomControllor.getIns().getRandom() * 19),0,0,0,0,0,0,0,{},"造梦西游3中击败乱世星宿副本的邪恶boss掉落的信物头衔",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti._jljsxstx)
         {
            otherEquip106 = new MyEquipObj(1,"救世星宿",_anti._jljsxstx,"zbtx","","精 良","0x0000FF",0,0,0,50 + Math.round(RandomControllor.getIns().getRandom() * 29),0,0,0,0,0,0,0,{},"造梦西游3中击败乱世星宿副本的邪恶boss掉落的信物头衔",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti._ssjsxstx)
         {
            otherEquip107 = new MyEquipObj(1,"救世星宿",_anti._ssjsxstx,"zbtx","","史 诗","0x660099",0,0,0,90 + Math.round(RandomControllor.getIns().getRandom() * 39),0,0,0,0,0,0,0,{},"造梦西游3中击败乱世星宿副本的邪恶boss掉落的信物头衔",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti._ssggjtg2015)
         {
            otherEquip108 = new MyEquipObj(1,"2015光棍节脱光",_anti._ssggjtg2015,"zbtx","","史 诗","0x660099",0,1111,0,0,0,0,0,11,0,0,0,{},"11·11，光棍节绝版头衔",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti._zmxyptxnkl2017)
         {
            otherEquip109 = new MyEquipObj(1,"新年",_anti._zmxyptxnkl2017,"zbtx","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"祝造梦西游玩家2017年新年快乐。提升2点幸运，可合成。",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti._zmxyyxxnkl2017)
         {
            otherEquip110 = new MyEquipObj(1,"新年",_anti._zmxyyxxnkl2017,"zbtx","","优 秀","0x00FF00",0,0,0,0,0,0,0,0,0,0,0,{},"祝造梦西游玩家2017年新年快乐。提升5点幸运，可合成。",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti._zmxyjlxnkl2017)
         {
            otherEquip111 = new MyEquipObj(1,"新年",_anti._zmxyjlxnkl2017,"zbtx","","精 良","0x0000FF",0,0,0,0,0,0,0,0,0,0,0,{},"祝造梦西游玩家2017年新年快乐。提升10点幸运，可合成。",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti._zmxyssxnkl2017)
         {
            otherEquip112 = new MyEquipObj(1,"新年",_anti._zmxyssxnkl2017,"zbtx","","史 诗","0x660099",0,0,0,0,0,0,0,0,0,0,0,{},"祝造梦西游玩家2017年新年快乐。提升15点幸运",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti._zmxyptxnkl2018)
         {
            otherEquip113 = new MyEquipObj(1,"新年",_anti._zmxyptxnkl2018,"zbtx","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"祝造梦西游玩家2018年新年快乐。提升2点幸运，可合成。",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti._zmxyyxxnkl2018)
         {
            otherEquip114 = new MyEquipObj(1,"新年",_anti._zmxyyxxnkl2018,"zbtx","","优 秀","0x00FF00",0,0,0,0,0,0,0,0,0,0,0,{},"祝造梦西游玩家2018年新年快乐。提升5点幸运，可合成。",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti._zmxyjlxnkl2018)
         {
            otherEquip115 = new MyEquipObj(1,"新年",_anti._zmxyjlxnkl2018,"zbtx","","精 良","0x0000FF",0,0,0,0,0,0,0,0,0,0,0,{},"祝造梦西游玩家2018年新年快乐。提升10点幸运，可合成。",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == _anti._zmxyssxnkl2018)
         {
            otherEquip116 = new MyEquipObj(1,"新年",_anti._zmxyssxnkl2018,"zbtx","","史 诗","0x660099",0,0,0,0,0,0,0,0,0,0,0,{},"祝造梦西游玩家2018年新年快乐。提升15点幸运",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "ptsrdg")
         {
            otherEquip117 = new MyEquipObj(1,"生日蛋糕","ptsrdg","zbtx","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"造梦西游3九周年纪念，绝版头衔，提升6点幸运，可合成。",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "yxsrdg")
         {
            otherEquip118 = new MyEquipObj(1,"生日蛋糕","yxsrdg","zbtx","","优 秀","0x00FF00",0,0,0,0,0,0,0,0,0,0,0,{},"造梦西游3九周年纪念，绝版头衔，提升9点幸运，可合成。",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "jlsrdg")
         {
            otherEquip119 = new MyEquipObj(1,"生日蛋糕","jlsrdg","zbtx","","精 良","0x0000FF",0,0,0,0,0,0,0,0,0,0,0,{},"造梦西游3九周年纪念，绝版头衔，提升12点幸运，可合成。",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "sssrdg")
         {
            otherEquip120 = new MyEquipObj(1,"生日蛋糕","sssrdg","zbtx","","史 诗","0x660099",0,0,0,0,0,0,0,0,0,0,0,{},"造梦西游3九周年纪念，绝版头衔，提升15点幸运",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "sssrdg2")
         {
            otherEquip121 = new MyEquipObj(1,"造梦十周年头衔","sssrdg2","zbtx","","史 诗","0x660099",0,0,0,0,0,0,0,0,0,0,0,{},"造梦十周年纪念，绝版头衔，提升18点幸运",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         for(i = uint(0); i < 121; )
         {
            otherEquipment.push(this["otherEquip" + (i + 1)]);
            i++;
         }
      }
      
      public function initSutraEquipment(equipName:String) : void
      {
         sutraEquipment = null;
         sutraEquipment = [];
         if(equipName == "all" || equipName == "kyl")
         {
            sutra1 = new MyEquipObj(1,"枯叶灵","kyl","zbfb","","优 秀","0x00FF00",0,0,0,0,0,0,0,0,0,0,0,{},"缓慢回复少许生命",{
               "elevel":1,
               "eupdata":Number((this._anti.zero_point_5 + RandomControllor.getIns().getRandom() * this._anti.zero_point_5).toFixed(1))
            },this.initRondomPro());
         }
         if(equipName == "all" || equipName == "xhhl")
         {
            sutra2 = new MyEquipObj(1,"宣花葫芦","xhhl","zbfb","","精 良","0x0000FF",0,0,0,0,0,0,0,0,0,0,0,{},"有一定概率捕捉宠物",{
               "elevel":1,
               "eupdata":Number((this._anti.zero_point_6 + RandomControllor.getIns().getRandom() * this._anti.zero_point_6).toFixed(1))
            },this.initRondomPro());
         }
         if(equipName == "all" || equipName == "qyj")
         {
            sutra3 = new MyEquipObj(1,"青云剑","qyj","zbfb","","精 良","0x0000FF",0,0,0,0,0,0,0,0,0,0,0,{},"御剑飞行",{
               "elevel":1,
               "eupdata":Number((this._anti.zero_point_7 + RandomControllor.getIns().getRandom() * this._anti.zero_point_7).toFixed(1))
            },this.initRondomPro());
         }
         if(equipName == "all" || equipName == "hyzzs")
         {
            sutra4 = new MyEquipObj(1,"混元珍珠伞","hyzzs","zbfb","","精 良","0x0000FF",0,0,0,0,0,0,0,0,0,0,0,{},"抵挡一定伤害",{
               "elevel":1,
               "eupdata":Number((this._anti.zero_point_8 + RandomControllor.getIns().getRandom() * this._anti.zero_point_8).toFixed(1))
            },this.initRondomPro());
         }
         if(equipName == "all" || equipName == "zjld")
         {
            sutra5 = new MyEquipObj(1,"紫金铃铛","zjld","zbfb","","史 诗","0x660099",0,0,0,0,0,0,0,0,0,0,0,{},"增加幸运，开启宠物无双",{
               "elevel":1,
               "eupdata":Number((this._anti.one_point_0 + RandomControllor.getIns().getRandom() * this._anti.zero_point_8).toFixed(1))
            },this.initRondomPro());
         }
         if(equipName == "all" || equipName == "gcxdyy")
         {
            sutra6 = new MyEquipObj(1,"龟丞相的遗言","gcxdyy","zbfb","","邪 灵","0x666666",0,0,0,0,0,0,0,0,0,Number((0.05 + RandomControllor.getIns().getRandom() * 0.05).toFixed(2)),0,{},"召唤龟丞相，寻觅小龙女",{
               "elevel":1,
               "eupdata":Number((this._anti.one_point_2 + RandomControllor.getIns().getRandom() * this._anti.zero_point_8).toFixed(1))
            },this.initRondomPro());
         }
         if(equipName == "all" || equipName == "yjp")
         {
            sutra7 = new MyEquipObj(1,"玉净瓶","yjp","zbfb","","邪 灵","0x666666",0,0,0,0,0,0,0,0,0,Number((0.05 + RandomControllor.getIns().getRandom() * 0.05).toFixed(2)),0,{},"吸收BOSS灵魂，有一定概率激活BOSS技能",{
               "elevel":1,
               "eupdata":Number((this._anti.one_point_4 + RandomControllor.getIns().getRandom() * this._anti.zero_point_8).toFixed(1))
            },this.initRondomPro());
         }
         if(equipName == "all" || equipName == "qljfb")
         {
            sutra8 = new MyEquipObj(1,"青龙剑","qljfb","zbfb","","魂 器","0x66ffff",0,0,0,0,0,0,0,0,0,Number((0.05 + RandomControllor.getIns().getRandom() * 0.05).toFixed(2)),0,{},"御剑飞行",{
               "elevel":1,
               "eupdata":0
            },this.initRondomPro());
         }
         if(equipName == "all" || equipName == "nmwdnh")
         {
            sutra9 = new MyEquipObj(1,"牛魔王的怒吼","nmwdnh","zbfb","","邪 灵","0x666666",0,0,0,0,0,0,this._anti.five + Math.round(RandomControllor.getIns().getRandom() * this._anti.ten),0,0,0,0,{},"召唤牛魔王",{
               "elevel":1,
               "eupdata":Number((this._anti.one_point_6 + RandomControllor.getIns().getRandom() * this._anti.zero_point_8).toFixed(1))
            },this.initRondomPro());
         }
         if(equipName == "all" || equipName == "zlwdah")
         {
            sutra10 = new MyEquipObj(1,"转轮王的哀嚎","zlwdah","zbfb","","邪 灵","0x666666",0,0,0,0,0,0,0,0,0,Number((0.05 + RandomControllor.getIns().getRandom() * 0.05).toFixed(2)),0,{},"召唤转轮王",{
               "elevel":1,
               "eupdata":Number((this._anti.one_point_6 + RandomControllor.getIns().getRandom() * this._anti.zero_point_8).toFixed(1))
            },this.initRondomPro());
         }
         if(equipName == "all" || equipName == "xhhhl")
         {
            sutra11 = new MyEquipObj(1,"宣花红葫芦","xhhhl","zbfb","","邪 灵","0x666666",0,0,0,0,0,0,6,3,0,0,0,{},"百分百捕捉宠物和Boss",{
               "elevel":1,
               "eupdata":Number((this._anti.two_point_0 + RandomControllor.getIns().getRandom() * this._anti.zero_point_4).toFixed(1))
            },this.initRondomPro());
         }
         if(equipName == "all" || equipName == "yyzlj")
         {
            sutra12 = new MyEquipObj(1,"阴阳斩龙剑","yyzlj","zbfb","","魂 器","0x66ffff",0,0,0,0,0,0,this._anti.four + Math.round(RandomControllor.getIns().getRandom() * this._anti.eight),this._anti.one + Math.round(RandomControllor.getIns().getRandom() * this._anti.two),0,0,0,{},"",{
               "elevel":1,
               "eupdata":Number((this._anti.one_point_8 + RandomControllor.getIns().getRandom() * this._anti.zero_point_6).toFixed(1))
            },this.initRondomPro());
         }
         if(equipName == "all" || equipName == "ywhl")
         {
            sutra13 = new MyEquipObj(1,"药王葫芦","ywhl","zbfb","","邪 灵","0x666666",0,0,0,0,0,0,this._anti.five + Math.round(RandomControllor.getIns().getRandom() * this._anti.ten),0,0,Number((0.03 + RandomControllor.getIns().getRandom() * 0.06).toFixed(2)),0,{},"",{
               "elevel":1,
               "eupdata":Number((this._anti.one_point_8 + RandomControllor.getIns().getRandom() * this._anti.zero_point_6).toFixed(1))
            },this.initRondomPro());
         }
         if(equipName == "all" || equipName == "zhyx")
         {
            sutra14 = new MyEquipObj(1,"镇魂玉箫","zhyx","zbfb","","邪 灵","0x666666",0,0,0,0,0,0,0,this._anti.three + Math.round(RandomControllor.getIns().getRandom() * this._anti.seven),0,Number((0.03 + RandomControllor.getIns().getRandom() * 0.06).toFixed(2)),0,{},"",{
               "elevel":1,
               "eupdata":Number((this._anti.one_point_8 + RandomControllor.getIns().getRandom() * this._anti.zero_point_6).toFixed(1))
            },this.initRondomPro());
         }
         if(equipName == "all" || equipName == "bjs")
         {
            sutra15 = new MyEquipObj(1,"玄风棕扇","bjs","zbfb","","邪 灵","0x666666",0,0,0,0,0,0,0,0,0,this._anti.zero_point_1,0,{},"",{
               "elevel":1,
               "eupdata":Number((this._anti.one_point_8 + RandomControllor.getIns().getRandom() * this._anti.zero_point_6).toFixed(1))
            },this.initRondomPro());
         }
         if(equipName == "all" || equipName == this._anti.hsqq)
         {
            sutra16 = new MyEquipObj(1,"红色气球",this._anti.hsqq,"zbfb","","精 良","0x0000FF",0,0,0,0,0,0,this._anti.three,0,0,0,0,{},"可与黄或蓝的气球在炼丹炉使用混色剂合成更高品质的气球",{
               "elevel":1,
               "eupdata":Number((this._anti.zero_point_6 + RandomControllor.getIns().getRandom() * this._anti.zero_point_6).toFixed(1))
            },this.initRondomPro());
         }
         if(equipName == "all" || equipName == this._anti.h_sqq)
         {
            sutra17 = new MyEquipObj(1,"黄色气球",this._anti.h_sqq,"zbfb","","精 良","0x0000FF",0,0,0,0,0,0,0,0,0,this._anti.zero_point_zero_two,0,{},"可与红或蓝的气球在炼丹炉使用混色剂合成更高品质的气球",{
               "elevel":1,
               "eupdata":Number((this._anti.zero_point_6 + RandomControllor.getIns().getRandom() * this._anti.zero_point_6).toFixed(1))
            },this.initRondomPro());
         }
         if(equipName == "all" || equipName == this._anti.lsqq)
         {
            sutra18 = new MyEquipObj(1,"蓝色气球",this._anti.lsqq,"zbfb","","精 良","0x0000FF",0,0,0,0,0,0,0,this._anti.two,0,0,0,{},"可与红或黄的气球在炼丹炉使用混色剂合成更高品质的气球",{
               "elevel":1,
               "eupdata":Number((this._anti.zero_point_6 + RandomControllor.getIns().getRandom() * this._anti.zero_point_6).toFixed(1))
            },this.initRondomPro());
         }
         if(equipName == "all" || equipName == this._anti.csqq)
         {
            sutra19 = new MyEquipObj(1,"橙色气球",this._anti.csqq,"zbfb","","史 诗","0x660099",0,0,0,0,0,0,this._anti.six,0,0,this._anti.zero_point_zero_four,0,{},"紫绿橙气球可以在炼丹炉合成更高品质的气球",{
               "elevel":1,
               "eupdata":Number((this._anti.one_point_8 + RandomControllor.getIns().getRandom() * this._anti.zero_point_6).toFixed(1))
            },this.initRondomPro());
         }
         if(equipName == "all" || equipName == this._anti.l_sqq)
         {
            sutra20 = new MyEquipObj(1,"绿色气球",this._anti.l_sqq,"zbfb","","史 诗","0x660099",0,0,0,0,0,0,0,this._anti.four,0,this._anti.zero_point_zero_four,0,{},"紫绿橙气球可以在炼丹炉合成更高品质的气球",{
               "elevel":1,
               "eupdata":Number((this._anti.one_point_8 + RandomControllor.getIns().getRandom() * this._anti.zero_point_6).toFixed(1))
            },this.initRondomPro());
         }
         if(equipName == "all" || equipName == this._anti.zsqq)
         {
            sutra21 = new MyEquipObj(1,"紫色气球",this._anti.zsqq,"zbfb","","史 诗","0x660099",0,0,0,0,0,0,this._anti.six,this._anti.two,0,0,0,{},"紫绿橙气球可以在炼丹炉合成更高品质的气球",{
               "elevel":1,
               "eupdata":Number((this._anti.one_point_8 + RandomControllor.getIns().getRandom() * this._anti.zero_point_6).toFixed(1))
            },this.initRondomPro());
         }
         if(equipName == "all" || equipName == this._anti.fsqq)
         {
            sutra22 = new MyEquipObj(1,"粉色气球",this._anti.fsqq,"zbfb","","传 说","0xFF9933",0,0,0,0,0,0,0,0,0,this._anti.zero_point_1,0,{},"纪念六一儿童节的粉色气球",{
               "elevel":1,
               "eupdata":this._anti.two_point_5
            },this.initRondomPro());
         }
         if(equipName == "all" || equipName == this._anti.sxyg)
         {
            sutra23 = new MyEquipObj(1,"神行渔鼓",this._anti.sxyg,"zbfb","","邪 灵","0x666666",0,0,0,0,0,0,0,0,0,this._anti.zero_point_1,0,{},"",{
               "elevel":1,
               "eupdata":Number((this._anti.one_point_8 + RandomControllor.getIns().getRandom() * this._anti.zero_point_6).toFixed(1))
            },this.initRondomPro());
         }
         if(equipName == "all" || equipName == this._anti.dkhl)
         {
            sutra24 = new MyEquipObj(1,"地魁花篮",this._anti.dkhl,"zbfb","","邪 灵","0x666666",0,0,0,0,0,0,this._anti.five + RandomControllor.getIns().getRandom() * this._anti.ten,0,0,0,0,{},"",{
               "elevel":1,
               "eupdata":Number((this._anti.one_point_8 + RandomControllor.getIns().getRandom() * this._anti.zero_point_6).toFixed(1))
            },this.initRondomPro());
         }
         if(equipName == "all" || equipName == this._anti.yyb)
         {
            sutra25 = new MyEquipObj(1,"云阳板",this._anti.yyb,"zbfb","","邪 灵","0x666666",0,0,0,0,0,0,0,0,0,this._anti.zero_point_1,0,{},"",{
               "elevel":1,
               "eupdata":Number((this._anti.one_point_8 + RandomControllor.getIns().getRandom() * this._anti.zero_point_6).toFixed(1))
            },this.initRondomPro());
         }
         if(equipName == "all" || equipName == this._anti.hehua)
         {
            sutra26 = new MyEquipObj(1,"慈心妙莲",this._anti.hehua,"zbfb","","邪 灵","0x666666",0,0,0,0,0,0,0,this._anti.three + Math.round(RandomControllor.getIns().getRandom() * this._anti.seven),0,Number((0.03 + RandomControllor.getIns().getRandom() * 0.06).toFixed(2)),0,{},"",{
               "elevel":1,
               "eupdata":Number((this._anti.one_point_8 + RandomControllor.getIns().getRandom() * this._anti.zero_point_6).toFixed(1))
            },this.initRondomPro());
         }
         if(equipName == "all" || equipName == this._anti.tjbg)
         {
            sutra27 = new MyEquipObj(1,"太极八卦",this._anti.tjbg,"zbfb","","传 说","0xFF9933",0,0,0,0,Number((this._anti.zero_point_zero_six + RandomControllor.getIns().getRandom() * this._anti.zero_point_zero_two).toFixed(2)),Number((this._anti.zero_point_zero_six + RandomControllor.getIns().getRandom() * this._anti.zero_point_zero_two).toFixed(2)),this._anti.eight + Math.round(RandomControllor.getIns().getRandom() * this._anti.twenty),this._anti.six + Math.round(RandomControllor.getIns().getRandom() * this._anti.two),0,Number((this._anti.zero_point_zero_six + RandomControllor.getIns().getRandom() * this._anti.zero_point_zero_two).toFixed(2)),0,{},"",{
               "elevel":1,
               "eupdata":0
            },this.initRondomPro());
         }
         if(equipName == "all" || equipName == _anti.wpfbyyin)
         {
            sutra28 = new MyEquipObj(1,"爻阴",_anti.wpfbyyin,"zbfb","","邪 灵","0x666666",0,0,0,0,0,0,0,0,0,0,0,{},"用于合成传说法宝太极八卦",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.wpfbyyan)
         {
            sutra29 = new MyEquipObj(1,"爻阳",_anti.wpfbyyan,"zbfb","","邪 灵","0x666666",0,0,0,0,0,0,0,0,0,0,0,{},"用于合成传说法宝太极八卦",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.wpfbtc)
         {
            sutra30 = new MyEquipObj(1,"太初",_anti.wpfbtc,"zbfb","","邪 灵","0x666666",0,0,0,0,0,0,0,0,0,0,0,{},"用于合成传说法宝太极八卦",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.lxfb)
         {
            sutra31 = new MyEquipObj(1,"流邪",_anti.lxfb,"zbfb","","邪 灵","0x666666",0,0,this._anti.one_hundred,0,0,0,0,0,0,0,0,{},"入魔后攻击大幅提升，但会持续扣血",{
               "elevel":1,
               "eupdata":Number((this._anti.one_point_5 + RandomControllor.getIns().getRandom() * this._anti.one).toFixed(1))
            },this.initRondomPro());
         }
         if(equipName == "all" || equipName == _anti.bxzq)
         {
            sutra32 = new MyEquipObj(1,"足球",_anti.bxzq,"zbfb","","传 说","0xFF9933",0,0,0,0,this._anti.zero_point_zero_five,this._anti.zero_point_zero_five,this._anti.ten + Math.round(RandomControllor.getIns().getRandom() * this._anti.twenty),this._anti.five + Math.round(RandomControllor.getIns().getRandom() * this._anti.five),0,0,0,{},"",{
               "elevel":1,
               "eupdata":0
            },this.initRondomPro());
         }
         if(equipName == "all" || equipName == _anti.sxfb)
         {
            sutra33 = new MyEquipObj(1,"沙邪",_anti.sxfb,"zbfb","","邪 灵","0x666666",0,0,this._anti.one_hundred,0,0,0,0,0,0,0,0,{},"入魔后防御大幅提升，但会持续扣蓝",{
               "elevel":1,
               "eupdata":Number((this._anti.one_point_5 + RandomControllor.getIns().getRandom() * this._anti.one).toFixed(1))
            },this.initRondomPro());
         }
         if(equipName == "all" || equipName == _anti.yxfb)
         {
            sutra34 = new MyEquipObj(1,"渊邪",_anti.yxfb,"zbfb","","邪 灵","0x666666",this._anti.two_thousand,this._anti.two_thousand,this._anti.five_hundred,0,0,0,0,0,0,0,0,{},"入魔后将扣除一半生命值，攻击和暴击大幅提升",{
               "elevel":1,
               "eupdata":this._anti.two_point_5
            },this.initRondomPro());
         }
         sutraEquipment.push(sutra1,sutra2,sutra3,sutra4,sutra5,sutra6,sutra7,sutra8,sutra9,sutra10,sutra11,sutra12,sutra13,sutra14,sutra15,sutra16,sutra17,sutra18,sutra19,sutra20,sutra21,sutra22,sutra23,sutra24,sutra25,sutra26,sutra27,sutra28,sutra29,sutra30,sutra31,sutra32,sutra33,sutra34);
      }
      
      private function initRondomPro() : Object
      {
         var r:* = 0;
         var r1:* = 0;
         var r2:* = 0;
         var obj:Object = {
            "jin":false,
            "mu":false,
            "shui":false,
            "huo":false,
            "tu":false
         };
         var arr:Array = ["jin","mu","shui","huo","tu"];
         if(RandomControllor.getIns().getRandom() < 0.91)
         {
            r = uint(Math.round(RandomControllor.getIns().getRandom() * 4));
            obj[arr[r]] = true;
         }
         else
         {
            r1 = uint(Math.round(RandomControllor.getIns().getRandom() * 4));
            obj[arr[r1]] = true;
            arr.splice(r1,1);
            r2 = uint(Math.round(RandomControllor.getIns().getRandom() * 3));
            obj[arr[r2]] = true;
         }
         return obj;
      }
      
      public function initWpEquipment(equipName:String) : void
      {
         var i:* = 0;
         wpEquipment = null;
         wpEquipment = [];
         if(equipName == "all" || equipName == this._anti.wpqhs1)
         {
            wpEquip1 = new MyEquipObj(101,"1级强化石",this._anti.wpqhs1,"wpqhs","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"可以在炼丹炉内用来强化装备，提升装备的属性",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "scwpqhs2")
         {
            wpEquip2 = new MyEquipObj(2,"2级强化石（商城）","scwpqhs2","wpqhs","","优 秀","0x00FF00",0,0,0,0,0,0,0,0,0,0,0,{},"由3个1级强化石合成，可以在炼丹炉里用来强化装备，提升装备的属性。比1级强化石拥有更好的成功率",{
               "elevel":2,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "scwpqhs3")
         {
            wpEquip3 = new MyEquipObj(3,"3级强化石（商城）","scwpqhs3","wpqhs","","精 良","0x0000FF",0,0,0,0,0,0,0,0,0,0,0,{},"由3个2级强化石合成，可以在炼丹炉里用来强化装备，提升装备的属性。比2级强化石拥有更好的成功率",{
               "elevel":3,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "scwpqhs4")
         {
            wpEquip4 = new MyEquipObj(4,"4级强化石（商城）","scwpqhs4","wpqhs","","史 诗","0x660099",0,0,0,0,0,0,0,0,0,0,0,{},"由3个3级强化石合成，可以在炼丹炉里用来强化装备，提升装备的属性。比3级强化石拥有更好的成功率",{
               "elevel":4,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "scwpqhs5")
         {
            wpEquip5 = new MyEquipObj(5,"5级强化石（商城）","scwpqhs5","wpqhs","","史 诗","0x660099",0,0,0,0,0,0,0,0,0,0,0,{},"",{
               "elevel":5,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "sms1")
         {
            wpEquip6 = new MyEquipObj(101,"1级生命石","sms1","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"在炼丹炉内打造装备时可以加入此宝石，增加1~20的生命值",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "scsms2")
         {
            wpEquip7 = new MyEquipObj(101,"2级生命石（商城）","scsms2","zbwp","","优 秀","0x00FF00",0,0,0,0,0,0,0,0,0,0,0,{},"由3个1级生命石合成，在炼丹炉内打造装备时可以加入此宝石，增加40~110的生命值",{
               "elevel":2,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "scsms3")
         {
            wpEquip8 = new MyEquipObj(101,"3级生命石（商城）","scsms3","zbwp","","精 良","0x0000FF",0,0,0,0,0,0,0,0,0,0,0,{},"由3个2级生命石合成，在炼丹炉内打造装备时可以加入此宝石，增加85~200的生命值",{
               "elevel":3,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "mfs1")
         {
            wpEquip9 = new MyEquipObj(101,"1级魔法石","mfs1","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"在炼丹炉内打造装备时可以加入此宝石，增加1~20的魔法值",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "scmfs2")
         {
            wpEquip10 = new MyEquipObj(101,"2级魔法石（商城）","scmfs2","zbwp","","优 秀","0x00FF00",0,0,0,0,0,0,0,0,0,0,0,{},"由3个1级魔法石合成，在炼丹炉内打造装备时可以加入此宝石，增加40~110的魔法值",{
               "elevel":2,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "scmfs3")
         {
            wpEquip11 = new MyEquipObj(101,"3级魔法石（商城）","scmfs3","zbwp","","精 良","0x0000FF",0,0,0,0,0,0,0,0,0,0,0,{},"由3个2级魔法石合成，在炼丹炉内打造装备时可以加入此宝石，增加85~200的魔法值",{
               "elevel":3,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "gjs1")
         {
            wpEquip12 = new MyEquipObj(101,"1级攻击石","gjs1","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"在炼丹炉内打造装备时可以加入此宝石，增加1~10的攻击力",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "scgjs2")
         {
            wpEquip13 = new MyEquipObj(101,"2级攻击石（商城）","scgjs2","zbwp","","优 秀","0x00FF00",0,0,0,0,0,0,0,0,0,0,0,{},"由3个1级攻击石合成，在炼丹炉内打造装备时可以加入此宝石，增加7~20的攻击力",{
               "elevel":2,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "scgjs3")
         {
            wpEquip14 = new MyEquipObj(101,"3级攻击石（商城）","scgjs3","zbwp","","精 良","0x0000FF",0,0,0,0,0,0,0,0,0,0,0,{},"由3个2级攻击石合成，在炼丹炉内打造装备时可以加入此宝石，增加15~40的攻击力",{
               "elevel":3,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "fys1")
         {
            wpEquip15 = new MyEquipObj(101,"1级防御石","fys1","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"在炼丹炉内打造装备时可以加入此宝石，增加1~3的防御力",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "scfys2")
         {
            wpEquip16 = new MyEquipObj(101,"2级防御石（商城）","scfys2","zbwp","","优 秀","0x00FF00",0,0,0,0,0,0,0,0,0,0,0,{},"由3个1级防御石合成，在炼丹炉内打造装备时可以加入此宝石，增加2~6的防御力",{
               "elevel":2,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "scfys3")
         {
            wpEquip17 = new MyEquipObj(101,"3级防御石（商城）","scfys3","zbwp","","精 良","0x0000FF",0,0,0,0,0,0,0,0,0,0,0,{},"由3个2级防御石合成，在炼丹炉内打造装备时可以加入此宝石，增加5~12的防御力",{
               "elevel":3,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "wpsc")
         {
            wpEquip18 = new MyEquipObj(5,"丝绸","wpsc","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"在炼丹炉内打造装备所需的材料",{
               "elevel":0,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "wpxt")
         {
            wpEquip19 = new MyEquipObj(5,"玄铁","wpxt","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"在炼丹炉内打造装备所需的材料",{
               "elevel":0,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "wptm")
         {
            wpEquip20 = new MyEquipObj(5,"檀木","wptm","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"在炼丹炉内打造装备所需的材料",{
               "elevel":0,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "whgzzs")
         {
            wpEquip21 = new MyEquipObj(this._anti.one_hundred,"尾火棍制作书","whgzzs","zbwp","","优 秀","0x00FF00",0,0,0,0,0,0,0,0,0,0,0,{},"可以打造出一把悟空的优秀武器",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "jmczzs")
         {
            wpEquip22 = new MyEquipObj(this._anti.one_hundred,"角木铲制作书","jmczzs","zbwp","","优 秀","0x00FF00",0,0,0,0,0,0,0,0,0,0,0,{},"可以打造出一把沙僧的优秀武器",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "bspzzs")
         {
            wpEquip23 = new MyEquipObj(this._anti.one_hundred,"壁水袍制作书","bspzzs","zbwp","","优 秀","0x00FF00",0,0,0,0,0,0,0,0,0,0,0,{},"可以打造出一件唐僧的优秀防具",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "dtkzzs")
         {
            wpEquip24 = new MyEquipObj(this._anti.one_hundred,"氐土铠制作书","dtkzzs","zbwp","","优 秀","0x00FF00",0,0,0,0,0,0,0,0,0,0,0,{},"可以打造出一件八戒的优秀防具",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "tfljzzs")
         {
            wpEquip25 = new MyEquipObj(this._anti.one_hundred,"通风灵戒制作书","tfljzzs","zbwp","","优 秀","0x00FF00",0,0,0,0,0,0,0,0,0,0,0,{},"可以打造出一件优秀的饰品",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "wtpzzs")
         {
            wpEquip26 = new MyEquipObj(this._anti.one_hundred,"胃土耙制作书","wtpzzs","zbwp","","精 良","0x0000FF",0,0,0,0,0,0,0,0,0,0,0,{},"可以打造出一把八戒的精良武器",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "yhjzzs")
         {
            wpEquip27 = new MyEquipObj(this._anti.one_hundred,"翼火甲制作书","yhjzzs","zbwp","","精 良","0x0000FF",0,0,0,0,0,0,0,0,0,0,0,{},"可以打造出一件悟空的精良防具",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "jmyzzs")
         {
            wpEquip28 = new MyEquipObj(this._anti.one_hundred,"井木衣制作书","jmyzzs","zbwp","","精 良","0x0000FF",0,0,0,0,0,0,0,0,0,0,0,{},"可以打造出一件沙僧的精良防具",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "mgzhzzs")
         {
            wpEquip29 = new MyEquipObj(this._anti.one_hundred,"马官指环制作书","mgzhzzs","zbwp","","精 良","0x0000FF",0,0,0,0,0,0,0,0,0,0,0,{},"可以打造出一件精良的饰品",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "hljhzzs")
         {
            wpEquip30 = new MyEquipObj(this._anti.one_hundred,"红莲教皇制作书","hljhzzs","zbwp","","史 诗","0x660099",0,0,0,0,0,0,0,0,0,0,0,{},"可以打造出一件唐僧的史诗防具",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "wsjgzzs")
         {
            wpEquip31 = new MyEquipObj(this._anti.one_hundred,"顽石金刚制作书","wsjgzzs","zbwp","","史 诗","0x660099",0,0,0,0,0,0,0,0,0,0,0,{},"可以打造出一件八戒的史诗防具",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "ydjgzzs")
         {
            wpEquip32 = new MyEquipObj(this._anti.one_hundred,"银弹金弓制作书","ydjgzzs","zbwp","","史 诗","0x660099",0,0,0,0,0,0,0,0,0,0,0,{},"可以打造出一把沙僧的史诗武器",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "tdlzjzzs")
         {
            wpEquip33 = new MyEquipObj(this._anti.one_hundred,"提多罗吒戒制作书","tdlzjzzs","zbwp","","史 诗","0x660099",0,0,0,0,0,0,0,0,0,0,0,{},"可以打造出一件史诗的饰品",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == this._anti.wpqhs2)
         {
            wpEquip34 = new MyEquipObj(101,"2级强化石",this._anti.wpqhs2,"wpqhs","","优 秀","0x00FF00",0,0,0,0,0,0,0,0,0,0,0,{},"由3个1级强化石合成，可以在炼丹炉里用来强化装备，提升装备的属性。比1级强化石拥有更好的成功率",{
               "elevel":2,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == this._anti.wpqhs3)
         {
            wpEquip35 = new MyEquipObj(101,"3级强化石",this._anti.wpqhs3,"wpqhs","","精 良","0x0000FF",0,0,0,0,0,0,0,0,0,0,0,{},"由3个2级强化石合成，可以在炼丹炉里用来强化装备，提升装备的属性。比2级强化石拥有更好的成功率",{
               "elevel":3,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == this._anti.sms2)
         {
            wpEquip36 = new MyEquipObj(101,"2级生命石",this._anti.sms2,"zbwp","","优 秀","0x00FF00",0,0,0,0,0,0,0,0,0,0,0,{},"由3个1级生命石合成，在炼丹炉内打造装备时可以加入此宝石，增加40~110的生命值",{
               "elevel":2,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == this._anti.sms3)
         {
            wpEquip37 = new MyEquipObj(101,"3级生命石",this._anti.sms3,"zbwp","","精 良","0x0000FF",0,0,0,0,0,0,0,0,0,0,0,{},"由3个2级生命石合成，在炼丹炉内打造装备时可以加入此宝石，增加85~200的生命值",{
               "elevel":3,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == this._anti.mfs2)
         {
            wpEquip38 = new MyEquipObj(101,"2级魔法石",this._anti.mfs2,"zbwp","","优 秀","0x00FF00",0,0,0,0,0,0,0,0,0,0,0,{},"由3个1级魔法石合成，在炼丹炉内打造装备时可以加入此宝石，增加40~110的魔法值",{
               "elevel":2,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == this._anti.mfs3)
         {
            wpEquip39 = new MyEquipObj(101,"3级魔法石",this._anti.mfs3,"zbwp","","精 良","0x0000FF",0,0,0,0,0,0,0,0,0,0,0,{},"由3个2级魔法石合成，在炼丹炉内打造装备时可以加入此宝石，增加85~200的魔法值",{
               "elevel":3,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == this._anti.gjs2)
         {
            wpEquip40 = new MyEquipObj(101,"2级攻击石",this._anti.gjs2,"zbwp","","优 秀","0x00FF00",0,0,0,0,0,0,0,0,0,0,0,{},"由3个1级攻击石合成，在炼丹炉内打造装备时可以加入此宝石，增加7~20的攻击力",{
               "elevel":2,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == this._anti.gjs3)
         {
            wpEquip41 = new MyEquipObj(101,"3级攻击石",this._anti.gjs3,"zbwp","","精 良","0x0000FF",0,0,0,0,0,0,0,0,0,0,0,{},"由3个2级攻击石合成，在炼丹炉内打造装备时可以加入此宝石，增加15~40的攻击力",{
               "elevel":3,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == this._anti.fys2)
         {
            wpEquip42 = new MyEquipObj(101,"2级防御石",this._anti.fys2,"zbwp","","优 秀","0x00FF00",0,0,0,0,0,0,0,0,0,0,0,{},"由3个1级防御石合成，在炼丹炉内打造装备时可以加入此宝石，增加2~6的防御力",{
               "elevel":2,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == this._anti.fys3)
         {
            wpEquip43 = new MyEquipObj(101,"3级防御石",this._anti.fys3,"zbwp","","精 良","0x0000FF",0,0,0,0,0,0,0,0,0,0,0,{},"由3个2级防御石合成，在炼丹炉内打造装备时可以加入此宝石，增加5~12的防御力",{
               "elevel":3,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "wpxh")
         {
            wpEquip44 = new MyEquipObj(1,"宣花","wpxh","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"用宣花葫芦捕捉宠物时需要消耗此材料",{
               "elevel":0,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == this._anti.wpxyf)
         {
            wpEquip45 = new MyEquipObj(1,"幸运符",this._anti.wpxyf,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"可以较高的提升装备强化的概率",{
               "elevel":0,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == this._anti.wpbdf)
         {
            wpEquip46 = new MyEquipObj(1,"神恩符",this._anti.wpbdf,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"使装备在强化失败后不会承受降级惩罚",{
               "elevel":0,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == this._anti.wpqhs4)
         {
            wpEquip47 = new MyEquipObj(101,"4级强化石",this._anti.wpqhs4,"wpqhs","","史 诗","0x660099",0,0,0,0,0,0,0,0,0,0,0,{},"由3个3级强化石合成，可以在炼丹炉里用来强化装备，提升装备的属性。比3级强化石拥有更好的成功率",{
               "elevel":4,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == this._anti.mpyj)
         {
            wpEquip48 = new MyEquipObj(1,"孟婆药剂",this._anti.mpyj,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"传说中一种喝了可以忘记所有烦恼、所有爱恨情仇的茶汤,使用后心法不变,所学技能清零",{
               "elevel":0,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == this._anti.wpcsd)
         {
            wpEquip49 = new MyEquipObj(1,"长生丹",this._anti.wpcsd,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"服用后可以延长宠物寿命20点",{
               "elevel":0,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == this._anti.wphhd)
         {
            wpEquip50 = new MyEquipObj(1,"还魂丹",this._anti.wphhd,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"服用后可以复活当前出战的宠物",{
               "elevel":0,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == this._anti.wptlz)
         {
            wpEquip51 = new MyEquipObj(101,"土灵珠","wptlz","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"由3个土灵珠碎片合成，在炼丹炉内打造装备时可以加入此宝石，增加1%~2%的魔抗",{
               "elevel":0,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == this._anti.wpllz)
         {
            wpEquip52 = new MyEquipObj(101,"雷灵珠",this._anti.wpllz,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"由3个雷灵珠碎片合成，在炼丹炉内打造装备时可以加入此宝石，增加1%~2%的暴击",{
               "elevel":0,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == this._anti.wphlz)
         {
            wpEquip53 = new MyEquipObj(101,"火灵珠",this._anti.wphlz,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"由3个火灵珠碎片合成，在炼丹炉内打造装备时可以加入此宝石，增加1~3点的回血",{
               "elevel":0,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == this._anti.wpflz)
         {
            wpEquip54 = new MyEquipObj(101,"风灵珠",this._anti.wpflz,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"由3个风灵珠碎片合成，在炼丹炉内打造装备时可以加入此宝石，增加1%~2%的闪避",{
               "elevel":0,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == this._anti.wpslz)
         {
            wpEquip55 = new MyEquipObj(101,"水灵珠",this._anti.wpslz,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"由3个水灵珠碎片合成，在炼丹炉内打造装备时可以加入此宝石，增加1~2点的回魔",{
               "elevel":0,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "tlzsp")
         {
            wpEquip56 = new MyEquipObj(101,"土灵珠碎片","tlzsp","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"用于合成土灵珠的神秘碎片",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "llzsp")
         {
            wpEquip57 = new MyEquipObj(101,"雷灵珠碎片","llzsp","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"用于合成雷灵珠的神秘碎片",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "hlzsp")
         {
            wpEquip58 = new MyEquipObj(101,"火灵珠碎片","hlzsp","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"用于合成火灵珠的神秘碎片",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "flzsp")
         {
            wpEquip59 = new MyEquipObj(101,"风灵珠碎片","flzsp","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"用于合成风灵珠的神秘碎片",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "slzsp")
         {
            wpEquip60 = new MyEquipObj(101,"水灵珠碎片","slzsp","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"用于合成水灵珠的神秘碎片",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "xleyzzs")
         {
            wpEquip61 = new MyEquipObj(this._anti.one_hundred,"厄夜制作书","xleyzzs","zbwp","","邪 灵","0x666666",0,0,0,0,0,0,0,0,0,0,0,{},"可以打造出一把悟空的邪灵防具",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "xlczzzs")
         {
            wpEquip62 = new MyEquipObj(this._anti.one_hundred,"残昼制作书","xlczzzs","zbwp","","邪 灵","0x666666",0,0,0,0,0,0,0,0,0,0,0,{},"可以打造出一把唐僧的邪灵防具",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "xlryzzs")
         {
            wpEquip63 = new MyEquipObj(this._anti.one_hundred,"如狱制作书","xlryzzs","zbwp","","邪 灵","0x666666",0,0,0,0,0,0,0,0,0,0,0,{},"可以打造出一把八戒的邪灵防具",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "xlyjzzs")
         {
            wpEquip64 = new MyEquipObj(this._anti.one_hundred,"犹绝制作书","xlyjzzs","zbwp","","邪 灵","0x666666",0,0,0,0,0,0,0,0,0,0,0,{},"可以打造出一把沙僧的邪灵防具",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "xlthzzs")
         {
            wpEquip65 = new MyEquipObj(this._anti.one_hundred,"天荒制作书","xlthzzs","zbwp","","邪 灵","0x666666",0,0,0,0,0,0,0,0,0,0,0,{},"可以打造出一把悟空的邪灵武器",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "xltczzs")
         {
            wpEquip66 = new MyEquipObj(this._anti.one_hundred,"天残制作书","xltczzs","zbwp","","邪 灵","0x666666",0,0,0,0,0,0,0,0,0,0,0,{},"可以打造出一把唐僧的邪灵武器",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "xltzzzs")
         {
            wpEquip67 = new MyEquipObj(this._anti.one_hundred,"天罪制作书","xltzzzs","zbwp","","邪 灵","0x666666",0,0,0,0,0,0,0,0,0,0,0,{},"可以打造出一把八戒的邪灵武器",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "xltszzs")
         {
            wpEquip68 = new MyEquipObj(this._anti.one_hundred,"天殇制作书","xltszzs","zbwp","","邪 灵","0x666666",0,0,0,0,0,0,0,0,0,0,0,{},"可以打造出一把沙僧的邪灵武器",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "llyzzs")
         {
            wpEquip69 = new MyEquipObj(this._anti.one_hundred,"玲珑玉制作书","llyzzs","zbwp","","邪 灵","0x666666",0,0,0,0,0,0,0,0,0,0,0,{},"",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "rls")
         {
            wpEquip70 = new MyEquipObj(101,"熔炼石","rls","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"两颗熔炼石可以与邪灵装备合成高级材料",{
               "elevel":0,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "yhs")
         {
            wpEquip71 = new MyEquipObj(101,"玉衡石","yhs","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"打造所需的高级材料",{
               "elevel":0,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "tss")
         {
            wpEquip72 = new MyEquipObj(101,"天枢石","tss","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"打造所需的高级材料",{
               "elevel":0,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "css6")
         {
            wpEquip73 = new MyEquipObj(102,"6层传送石","css6","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"可以将您传送到玲珑宝塔第6层",{
               "elevel":0,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == this._anti.css12)
         {
            wpEquip74 = new MyEquipObj(102,"12层传送石",this._anti.css12,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"可以将您传送到玲珑宝塔第12层",{
               "elevel":0,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == this._anti.css18)
         {
            wpEquip75 = new MyEquipObj(102,"18层传送石",this._anti.css18,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"可以将您传送到玲珑宝塔第18层",{
               "elevel":0,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "jlqrzrzzs")
         {
            wpEquip76 = new MyEquipObj(this._anti.one_hundred,"知汝制作书","jlqrzrzzs","zbwp","","精 良","0x0000FF",0,0,0,0,0,0,0,0,0,0,0,{},"",{
               "elevel":1,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "jlqrmjzzs")
         {
            wpEquip77 = new MyEquipObj(this._anti.one_hundred,"梦江制作书","jlqrmjzzs","zbwp","","精 良","0x0000FF",0,0,0,0,0,0,0,0,0,0,0,{},"",{
               "elevel":1,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "jlqrcszzs")
         {
            wpEquip78 = new MyEquipObj(this._anti.one_hundred,"长蛇制作书","jlqrcszzs","zbwp","","精 良","0x0000FF",0,0,0,0,0,0,0,0,0,0,0,{},"",{
               "elevel":1,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "jlqrhdzzs")
         {
            wpEquip79 = new MyEquipObj(this._anti.one_hundred,"蝴蝶制作书","jlqrhdzzs","zbwp","","精 良","0x0000FF",0,0,0,0,0,0,0,0,0,0,0,{},"",{
               "elevel":1,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "ssqrzrzzs")
         {
            wpEquip80 = new MyEquipObj(this._anti.one_hundred,"知汝制作书","ssqrzrzzs","zbwp","","史 诗","0x660099",0,0,0,0,0,0,0,0,0,0,0,{},"",{
               "elevel":1,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "ssqrmjzzs")
         {
            wpEquip81 = new MyEquipObj(this._anti.one_hundred,"梦江制作书","ssqrmjzzs","zbwp","","史 诗","0x660099",0,0,0,0,0,0,0,0,0,0,0,{},"",{
               "elevel":1,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "ssqrcszzs")
         {
            wpEquip82 = new MyEquipObj(this._anti.one_hundred,"长蛇制作书","ssqrcszzs","zbwp","","史 诗","0x660099",0,0,0,0,0,0,0,0,0,0,0,{},"",{
               "elevel":1,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "ssqrhdzzs")
         {
            wpEquip83 = new MyEquipObj(this._anti.one_hundred,"蝴蝶制作书","ssqrhdzzs","zbwp","","史 诗","0x660099",0,0,0,0,0,0,0,0,0,0,0,{},"",{
               "elevel":1,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == this._anti.wpmgh)
         {
            wpEquip84 = new MyEquipObj(this._anti.one_hundred,"玫瑰花",this._anti.wpmgh,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"情人节活动的玫瑰，用于兑换情人节武器",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "wpbsz")
         {
            wpEquip85 = new MyEquipObj(this._anti.one_hundred,"避水珠","wpbsz","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"进入神兽森林水下迷宫副本的必备之物",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "wpzz")
         {
            wpEquip86 = new MyEquipObj(this._anti.one_hundred,"珍珠","wpzz","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"可以在珍珠店铺购买道具",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "wplwl")
         {
            wpEquip87 = new MyEquipObj(1,"龙王令","wplwl","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"进入水下迷宫隐藏副本玄武墓场的必备道具",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "wplvdyl")
         {
            wpEquip88 = new MyEquipObj(1,"龙女的眼泪","wplvdyl","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"在水下迷宫使用，直接传送到小龙女处；也是后期升级法宝所需的道具",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "wpsmd1")
         {
            wpEquip89 = new MyEquipObj(1,"一品生命丹","wpsmd1","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"服用后生命上限增加150",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "wpsmd2")
         {
            wpEquip90 = new MyEquipObj(1,"二品生命丹","wpsmd2","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"服用后生命上限增加200",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "wpsmd3")
         {
            wpEquip91 = new MyEquipObj(1,"三品生命丹","wpsmd3","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"服用后生命上限增加250",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "wpsmd4")
         {
            wpEquip92 = new MyEquipObj(1,"四品生命丹","wpsmd4","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"服用后生命上限增加300",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "wpsmd5")
         {
            wpEquip93 = new MyEquipObj(1,"五品生命丹","wpsmd5","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"服用后生命上限增加350",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "wplh")
         {
            wpEquip94 = new MyEquipObj(1,"硫磺","wplh","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"在炼丹炉内合成丹药所需的材料，硫磺+仙茅+鲮鲤=一品生命丹，四品生命丹+硫磺+孟婆药剂=五品生命丹",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "wpxm")
         {
            wpEquip95 = new MyEquipObj(1,"仙茅","wpxm","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"在炼丹炉内合成丹药所需的材料，一品生命丹+毒丹+仙茅=二品生命丹",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "wpll")
         {
            wpEquip96 = new MyEquipObj(1,"鲮鲤","wpll","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"在炼丹炉内合成丹药所需的材料",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "wpdd")
         {
            wpEquip97 = new MyEquipObj(1,"毒丹","wpdd","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"在炼丹炉内合成丹药所需的材料，似乎有毒",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "wpsg")
         {
            wpEquip98 = new MyEquipObj(1,"守宫","wpsg","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"在炼丹炉内合成丹药所需的材料，二品生命丹+鲮鲤+守宫=三品生命丹",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "wprs")
         {
            wpEquip99 = new MyEquipObj(1,"人参","wprs","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"在炼丹炉内合成丹药所需的材料，三品生命丹+硫磺+人参=四品生命丹",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "yjpyinsp")
         {
            wpEquip100 = new MyEquipObj(1,"玉净瓶阴碎片","yjpyinsp","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"合成玉净瓶所需的材料之一，愈合两块碎片还需要龙女的眼泪",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == "yjpyansp")
         {
            wpEquip101 = new MyEquipObj(1,"玉净瓶阳碎片","yjpyansp","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"合成玉净瓶所需的材料之一，愈合两块碎片还需要龙女的眼泪",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == this._anti.sbjyd)
         {
            wpEquip102 = new MyEquipObj(1,"双倍经验丹",this._anti.sbjyd,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"服用后打怪获得双倍经验，持续一小时，效果不能和vip领取的双倍经验叠加",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == this._anti.jyys)
         {
            wpEquip103 = new MyEquipObj(1,"经验药水",this._anti.jyys,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"服用后，提升1万点经验值",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == this._anti.css_2)
         {
            wpEquip104 = new MyEquipObj(102,"地下2层传送石",this._anti.css_2,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"可以将您传送到兜率宫地下2层",{
               "elevel":0,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == this._anti.cwzzxld)
         {
            wpEquip105 = new MyEquipObj(1,"宠物属性洗练丹",this._anti.cwzzxld,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"服用后重置宠物的悟性、根骨、灵力,不会改变宠物资质",{
               "elevel":0,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == this._anti.cwjnxld)
         {
            wpEquip106 = new MyEquipObj(1,"宠物技能洗练丹",this._anti.cwjnxld,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"服用后可以重新获得宠物技能",{
               "elevel":0,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "hmzjns2")
         {
            wpEquip107 = new MyEquipObj(1,"火魔斩2级技能书","hmzjns2","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"提升火魔斩空连时的威力，同时魔耗增加",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "tmcjns2")
         {
            wpEquip108 = new MyEquipObj(1,"土魔刺2级技能书","tmcjns2","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"提升土魔刺威力，生命值越高伤害越大，同时魔耗增加",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "mdsjns2")
         {
            wpEquip109 = new MyEquipObj(1,"猛毒素2级技能书","mdsjns2","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"提升猛毒素威力，并且毒素叠加增加到7层，同时魔耗增加",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "jhsjjns2")
         {
            wpEquip110 = new MyEquipObj(1,"九环佛经2级技能书","jhsjjns2","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"提升九环佛经威力，同时魔耗增加",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "css_3")
         {
            wpEquip111 = new MyEquipObj(1,"地下3层传送石","css_3","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"可以将您传送到兜率宫地下3层",{
               "elevel":0,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "wphtd")
         {
            wpEquip112 = new MyEquipObj(1,"宠物还童丹","wphtd","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"服用后，宠物还童到1级宝宝，技能保持不变，资质会随机提升",{
               "elevel":0,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == this._anti.jyd3)
         {
            wpEquip113 = new MyEquipObj(1,"三倍经验丹",this._anti.jyd3,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"服用后打怪获得三倍经验，持续一小时，效果不能和双倍经验叠加",{
               "elevel":0,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == this._anti.djyys)
         {
            wpEquip114 = new MyEquipObj(1,"大经验药水",this._anti.djyys,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"服用后，提升10万点经验值",{
               "elevel":0,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "ttlpsp1")
         {
            wpEquip115 = new MyEquipObj(1,"通天令牌碎片一","ttlpsp1","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"合成通天令牌的材料碎片",{
               "elevel":0,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "ttlpsp2")
         {
            wpEquip116 = new MyEquipObj(1,"通天令牌碎片二","ttlpsp2","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"合成通天令牌的材料碎片",{
               "elevel":0,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "ttlpsp3")
         {
            wpEquip117 = new MyEquipObj(1,"通天令牌碎片三","ttlpsp3","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"合成通天令牌的材料碎片",{
               "elevel":0,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "ttlp")
         {
            wpEquip118 = new MyEquipObj(1,"通天令牌","ttlp","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"拥有通天教主的通天令牌，方可进入截教天境",{
               "elevel":0,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "xjyys")
         {
            wpEquip119 = new MyEquipObj(1,"小经验药水","xjyys","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"服用后，提升2500点经验值",{
               "elevel":0,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == this._anti.lhys)
         {
            wpEquip120 = new MyEquipObj(1,"灵魂药水",this._anti.lhys,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"服用后，提升3800点灵魂",{
               "elevel":0,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "smbjns2")
         {
            wpEquip121 = new MyEquipObj(1,"水魔爆2级技能书","smbjns2","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"提升水魔爆的威力，同时魔耗增加",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "mmwjns2")
         {
            wpEquip122 = new MyEquipObj(1,"木魔舞2级技能书","mmwjns2","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"提升木魔舞的威力，同时魔耗增加",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "hyjjjns2")
         {
            wpEquip123 = new MyEquipObj(1,"火眼金睛2级技能书","hyjjjns2","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"提升火眼金睛的威力，同时魔耗增加",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "syzqjns2")
         {
            wpEquip124 = new MyEquipObj(1,"圣域之墙2级技能书","syzqjns2","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"提升圣域之墙的威力，同时魔耗增加",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.cs_wq_qs_zzs)
         {
            wpEquip125 = new MyEquipObj(100,"祁水制作书",_anti.cs_wq_qs_zzs,"zbwp","","传 说","0xFF9933",0,0,0,0,0,0,0,0,0,0,0,{},"可以通过炼丹炉打造出悟空传说武器",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.cs_wq_rc_zzs)
         {
            wpEquip126 = new MyEquipObj(100,"若禅制作书",_anti.cs_wq_rc_zzs,"zbwp","","传 说","0xFF9933",0,0,0,0,0,0,0,0,0,0,0,{},"可以通过炼丹炉打造出唐僧传说武器",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.cs_wq_yt_zzs)
         {
            wpEquip127 = new MyEquipObj(100,"夷图制作书",_anti.cs_wq_yt_zzs,"zbwp","","传 说","0xFF9933",0,0,0,0,0,0,0,0,0,0,0,{},"可以通过炼丹炉打造出八戒传说武器",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.cs_wq_ll_zzs)
         {
            wpEquip128 = new MyEquipObj(100,"琉璃制作书",_anti.cs_wq_ll_zzs,"zbwp","","传 说","0xFF9933",0,0,0,0,0,0,0,0,0,0,0,{},"可以通过炼丹炉打造出沙僧传说武器",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.lyfbjns2)
         {
            wpEquip129 = new MyEquipObj(1,"烈焰风暴2级技能书",_anti.lyfbjns2,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"提升烈焰风暴的威力，同时魔耗增加",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.tjgljns2)
         {
            wpEquip130 = new MyEquipObj(1,"天降甘露2级技能书",_anti.tjgljns2,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"提升天降甘露的回血，同时魔耗增加",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.xgqjns2)
         {
            wpEquip131 = new MyEquipObj(1,"旋滚球2级技能书",_anti.xgqjns2,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"提升旋滚球的威力，同时魔耗增加",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.tkjjns2)
         {
            wpEquip132 = new MyEquipObj(1,"腾空击2级技能书",_anti.tkjjns2,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"提升腾空击的威力，同时魔耗增加",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.cs_fj_dz_zzs)
         {
            wpEquip133 = new MyEquipObj(100,"斗战制作书",_anti.cs_fj_dz_zzs,"zbwp","","传 说","0xFF9933",0,0,0,0,0,0,0,0,0,0,0,{},"可以通过炼丹炉打造出悟空传说防具",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.cs_fj_zt_zzs)
         {
            wpEquip134 = new MyEquipObj(100,"旃檀制作书",_anti.cs_fj_zt_zzs,"zbwp","","传 说","0xFF9933",0,0,0,0,0,0,0,0,0,0,0,{},"可以通过炼丹炉打造出唐僧传说防具",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.cs_fj_jt_zzs)
         {
            wpEquip135 = new MyEquipObj(100,"净坛制作书",_anti.cs_fj_jt_zzs,"zbwp","","传 说","0xFF9933",0,0,0,0,0,0,0,0,0,0,0,{},"可以通过炼丹炉打造出八戒传说防具",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.cs_fj_js_zzs)
         {
            wpEquip136 = new MyEquipObj(100,"金身制作书",_anti.cs_fj_js_zzs,"zbwp","","传 说","0xFF9933",0,0,0,0,0,0,0,0,0,0,0,{},"可以通过炼丹炉打造出沙僧传说防具",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.ghyb)
         {
            wpEquip137 = new MyEquipObj(1,"桂花月饼",_anti.ghyb,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"食用后提升300点攻击力，持续一小时。",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.zhhzzzs)
         {
            wpEquip138 = new MyEquipObj(this._anti.one_hundred,"镇魂花坠制作书",_anti.zhhzzzs,"zbwp","","邪 灵","0x666666",0,0,0,0,0,0,0,0,0,0,0,{},"可以通过炼丹炉打造出镇魂花坠饰品",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.wpygs)
         {
            wpEquip139 = new MyEquipObj(1,"摇光石",_anti.wpygs,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"打造所需的高级材料",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.phhlzzs)
         {
            wpEquip140 = new MyEquipObj(this._anti.one_hundred,"破幻花链制作书",_anti.phhlzzs,"zbwp","","邪 灵","0x666666",0,0,0,0,0,0,0,0,0,0,0,{},"可以通过炼丹炉打造出破幻花链饰品",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.bxhyzzs)
         {
            wpEquip141 = new MyEquipObj(this._anti.one_hundred,"不朽花翼制作书",_anti.bxhyzzs,"zbwp","","邪 灵","0x666666",0,0,0,0,0,0,0,0,0,0,0,{},"可以通过炼丹炉打造出不朽花翼饰品",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.hjxz)
         {
            wpEquip142 = new MyEquipObj(1,"黄金勋章",_anti.hjxz,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"伢牙乐黄金勋章，使用后获得三个1级强化石",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.zsxz)
         {
            wpEquip143 = new MyEquipObj(1,"钻石勋章",_anti.zsxz,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"伢牙乐钻石勋章，使用后获得一件牛魔王时装",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.nianqld)
         {
            wpEquip144 = new MyEquipObj(1,"年兽潜力丹",_anti.nianqld,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"增加年兽100点潜力点",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.nianjhd)
         {
            wpEquip145 = new MyEquipObj(1,"年兽进化丹",_anti.nianjhd,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"小年兽32级可以服用，使其进化",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.hsj)
         {
            wpEquip146 = new MyEquipObj(1,"混色剂",_anti.hsj,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"可以和红黄蓝任意两个气球合成出更高品质的彩色气球",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.bmd)
         {
            wpEquip147 = new MyEquipObj(1,"白牡丹",_anti.bmd,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"吕洞宾喜好品，在八仙过海副本中使用，召唤魔吕洞宾",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.yp)
         {
            wpEquip148 = new MyEquipObj(1,"乐谱",_anti.yp,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"韩湘子喜好品，在八仙过海副本中使用，召唤魔韩湘子",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.gz)
         {
            wpEquip149 = new MyEquipObj(1,"拐杖",_anti.gz,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"铁拐李喜好品，在八仙过海副本中使用，召唤魔铁拐李",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.ml)
         {
            wpEquip150 = new MyEquipObj(1,"毛驴",_anti.ml,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"张果老喜好品，在八仙过海副本中使用，召唤魔张果老",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.kly1)
         {
            wpEquip151 = new MyEquipObj(1,"1级昆仑玉",_anti.kly1,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"用于升级1级传说法宝太极八卦，可合成2级昆仑玉",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.kly2)
         {
            wpEquip152 = new MyEquipObj(1,"2级昆仑玉",_anti.kly2,"zbwp","","优 秀","0x00FF00",0,0,0,0,0,0,0,0,0,0,0,{},"用于升级2级传说法宝太极八卦，可合成3级昆仑玉",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.kly3)
         {
            wpEquip153 = new MyEquipObj(1,"3级昆仑玉",_anti.kly3,"zbwp","","精 良","0x0000FF",0,0,0,0,0,0,0,0,0,0,0,{},"用于升级3级传说法宝太极八卦，可合成4级昆仑玉",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.kly4)
         {
            wpEquip154 = new MyEquipObj(1,"4级昆仑玉",_anti.kly4,"zbwp","","史 诗","0x660099",0,0,0,0,0,0,0,0,0,0,0,{},"用于升级4级传说法宝太极八卦，可合成5级昆仑玉",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.sz)
         {
            wpEquip155 = new MyEquipObj(1,"骰子",_anti.sz,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"汉钟离喜好品，在八仙过海副本中使用，召唤魔汉钟离",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.zz)
         {
            wpEquip156 = new MyEquipObj(1,"竹枕",_anti.zz,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"蓝采和喜好品，在八仙过海副本中使用，召唤魔蓝采和",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.jbc)
         {
            wpEquip157 = new MyEquipObj(1,"金白菜",_anti.jbc,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"曹国舅喜好品，在八仙过海副本中使用，召唤魔曹国舅",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.szj)
         {
            wpEquip158 = new MyEquipObj(1,"梳妆镜",_anti.szj,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"何仙姑喜好品，在八仙过海副本中使用，召唤魔何仙姑",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.xns1)
         {
            wpEquip159 = new MyEquipObj(1,"1级仙女石",_anti.xns1,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"用于升级5级传说法宝太极八卦，可合成2级仙女石",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.xns2)
         {
            wpEquip160 = new MyEquipObj(1,"2级仙女石",_anti.xns2,"zbwp","","优 秀","0x00FF00",0,0,0,0,0,0,0,0,0,0,0,{},"用于升级6级传说法宝太极八卦，可合成3级仙女石",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.xns3)
         {
            wpEquip161 = new MyEquipObj(1,"3级仙女石",_anti.xns3,"zbwp","","精 良","0x0000FF",0,0,0,0,0,0,0,0,0,0,0,{},"用于升级7级传说法宝太极八卦，可合成4级仙女石",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.xns4)
         {
            wpEquip162 = new MyEquipObj(1,"4级仙女石",_anti.xns4,"zbwp","","史 诗","0x660099",0,0,0,0,0,0,0,0,0,0,0,{},"用于升级8级传说法宝太极八卦，可合成5级仙女石",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "hyjjjns3")
         {
            wpEquip163 = new MyEquipObj(1,"火眼金睛3级技能书","hyjjjns3","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"提升火眼金睛的威力，同时魔耗增加",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "smbjns3")
         {
            wpEquip164 = new MyEquipObj(1,"水魔爆3级技能书","smbjns3","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"提升水魔爆的威力，同时魔耗增加",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "sxjns2")
         {
            wpEquip165 = new MyEquipObj(1,"嗜血2级技能书","sxjns2","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"提升嗜血的威力",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "tmcjns3")
         {
            wpEquip166 = new MyEquipObj(1,"土魔刺3级技能书","tmcjns3","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"提升土魔刺威力，生命值越高伤害越大，同时魔耗增加",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "mmwjns3")
         {
            wpEquip167 = new MyEquipObj(1,"木魔舞3级技能书","mmwjns3","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"提升木魔舞的威力，同时魔耗增加",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.xssp)
         {
            wpEquip168 = new MyEquipObj(1,"凶兽碎片",_anti.xssp,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"将“乱世英雄”称号升级到“救世英雄”所需的碎片",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.wpsh_1)
         {
            wpEquip169 = new MyEquipObj(1,"一重神火·骨凝",_anti.wpsh_1,"zbwp","","传 说","0xFF9933",0,0,0,0,0,0,0,0,0,0,0,{},"在炼丹炉内重铸传说装备所需的材料",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.wpsh_2)
         {
            wpEquip170 = new MyEquipObj(1,"二重神火·玄黯",_anti.wpsh_2,"zbwp","","传 说","0xFF9933",0,0,0,0,0,0,0,0,0,0,0,{},"在炼丹炉内重铸一重传说装备所需的材料",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.wpst_1)
         {
            wpEquip171 = new MyEquipObj(1,"一重神铁·轻羽",_anti.wpst_1,"zbwp","","传 说","0xFF9933",0,0,0,0,0,0,0,0,0,0,0,{},"在炼丹炉内重铸传说装备所需的材料",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.wpst_2)
         {
            wpEquip172 = new MyEquipObj(1,"二重神铁·甲麟",_anti.wpst_2,"zbwp","","传 说","0xFF9933",0,0,0,0,0,0,0,0,0,0,0,{},"在炼丹炉内重铸一重传说装备所需的材料",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.wpst_3)
         {
            wpEquip173 = new MyEquipObj(1,"三重神铁·点金",_anti.wpst_3,"zbwp","","传 说","0xFF9933",0,0,0,0,0,0,0,0,0,0,0,{},"在炼丹炉内重铸二重传说装备所需的材料",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.wpsh_3)
         {
            wpEquip174 = new MyEquipObj(1,"三重神火·洪荒",_anti.wpsh_3,"zbwp","","传 说","0xFF9933",0,0,0,0,0,0,0,0,0,0,0,{},"在炼丹炉内重铸二重传说装备所需的材料",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "hmzjns3")
         {
            wpEquip175 = new MyEquipObj(1,"火魔斩3级技能书","hmzjns3","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"提升火魔斩空连时的威力，同时魔耗增加",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "syzqjns3")
         {
            wpEquip176 = new MyEquipObj(1,"圣域之墙3级技能书","syzqjns3","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"提升圣域之墙的威力，同时魔耗增加",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "jhsjjns3")
         {
            wpEquip177 = new MyEquipObj(1,"九环佛经3级技能书","jhsjjns3","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"提升九环佛经威力，同时魔耗增加",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "mdsjns3")
         {
            wpEquip178 = new MyEquipObj(1,"猛毒素3级技能书","mdsjns3","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"提升猛毒素威力，并且毒素叠加增加到7层，同时魔耗增加",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "nianjhdd")
         {
            wpEquip179 = new MyEquipObj(1,"年兽进化大丹","nianjhdd","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"可以使年兽进化成第3形态，且丹药服用需要50级以上",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "xnhdl")
         {
            wpEquip180 = new MyEquipObj(1,"新年红灯笼","xnhdl","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"新年副本战胜年兽后，携带新年红灯笼进入传送门，可以传送到隐藏副本",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.wpst_4)
         {
            wpEquip181 = new MyEquipObj(1,"四重神铁·通明",_anti.wpst_4,"zbwp","","传 说","0xFF9933",0,0,0,0,0,0,0,0,0,0,0,{},"在炼丹炉内重铸三重传说装备所需的材料",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.wpsh_4)
         {
            wpEquip182 = new MyEquipObj(1,"四重神火·生明",_anti.wpsh_4,"zbwp","","传 说","0xFF9933",0,0,0,0,0,0,0,0,0,0,0,{},"在炼丹炉内重铸三重传说装备所需的材料",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.lssp_1)
         {
            wpEquip183 = new MyEquipObj(1,"流石碎片1",_anti.lssp_1,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"法宝流邪的碎片，被流沙河众邪神收藏，染其邪气，魔力惊人。集齐3块特定碎片后可合成相应的流邪符石",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.lssp_2)
         {
            wpEquip184 = new MyEquipObj(1,"流石碎片2",_anti.lssp_2,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"法宝流邪的碎片，被流沙河众邪神收藏，染其邪气，魔力惊人。集齐3块特定碎片后可合成相应的流邪符石",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.lssp_3)
         {
            wpEquip185 = new MyEquipObj(1,"流石碎片3",_anti.lssp_3,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"法宝流邪的碎片，被流沙河众邪神收藏，染其邪气，魔力惊人。集齐3块特定碎片后可合成相应的流邪符石",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.lssp_4)
         {
            wpEquip186 = new MyEquipObj(1,"流石碎片4",_anti.lssp_4,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"法宝流邪的碎片，被流沙河众邪神收藏，染其邪气，魔力惊人。集齐3块特定碎片后可合成相应的流邪符石",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.lssp_5)
         {
            wpEquip187 = new MyEquipObj(1,"流石碎片5",_anti.lssp_5,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"法宝流邪的碎片，被流沙河众邪神收藏，染其邪气，魔力惊人。集齐3块特定碎片后可合成相应的流邪符石",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.lssp_6)
         {
            wpEquip188 = new MyEquipObj(1,"流石碎片6",_anti.lssp_6,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"法宝流邪的碎片，被流沙河众邪神收藏，染其邪气，魔力惊人。集齐3块特定碎片后可合成相应的流邪符石",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.lssp_7)
         {
            wpEquip189 = new MyEquipObj(1,"流石碎片7",_anti.lssp_7,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"法宝流邪的碎片，被流沙河众邪神收藏，染其邪气，魔力惊人。集齐3块特定碎片后可合成相应的流邪符石",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.lssp_8)
         {
            wpEquip190 = new MyEquipObj(1,"流石碎片8",_anti.lssp_8,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"法宝流邪的碎片，被流沙河众邪神收藏，染其邪气，魔力惊人。集齐3块特定碎片后可合成相应的流邪符石",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.lssp_9)
         {
            wpEquip191 = new MyEquipObj(1,"流石碎片9",_anti.lssp_9,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"法宝流邪的碎片，被流沙河众邪神收藏，染其邪气，魔力惊人。集齐3块特定碎片后可合成相应的流邪符石",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.lxfs_1)
         {
            wpEquip192 = new MyEquipObj(1,"流邪符石1",_anti.lxfs_1,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"集齐流邪符石1、2、3后，可在炼丹炉内合成法宝流邪",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.lxfs_2)
         {
            wpEquip193 = new MyEquipObj(1,"流邪符石2",_anti.lxfs_2,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"集齐流邪符石1、2、3后，可在炼丹炉内合成法宝流邪",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.lxfs_3)
         {
            wpEquip194 = new MyEquipObj(1,"流邪符石3",_anti.lxfs_3,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"集齐流邪符石1、2、3后，可在炼丹炉内合成法宝流邪",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "ttslsp1")
         {
            wpEquip195 = new MyEquipObj(1,"通天赦令碎片一","ttslsp1","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"合成通天赦令的材料碎片",{
               "elevel":0,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "ttslsp2")
         {
            wpEquip196 = new MyEquipObj(1,"通天赦令碎片二","ttslsp2","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"合成通天赦令的材料碎片",{
               "elevel":0,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "ttslsp3")
         {
            wpEquip197 = new MyEquipObj(1,"通天赦令碎片三","ttslsp3","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"合成通天赦令的材料碎片",{
               "elevel":0,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == "ttsl")
         {
            wpEquip198 = new MyEquipObj(1,"通天赦令","ttsl","zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"拥有通天教主的通天赦令，方可进入碧游宫",{
               "elevel":0,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.wpsh_5)
         {
            wpEquip199 = new MyEquipObj(1,"五重神火·噬灵",_anti.wpsh_5,"zbwp","","传 说","0xFF9933",0,0,0,0,0,0,0,0,0,0,0,{},"在炼丹炉内重铸四重传说装备所需的材料",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.wpst_5)
         {
            wpEquip200 = new MyEquipObj(1,"五重神铁·玄光",_anti.wpst_5,"zbwp","","传 说","0xFF9933",0,0,0,0,0,0,0,0,0,0,0,{},"在炼丹炉内重铸四重传说装备所需的材料",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.yysn)
         {
            wpEquip201 = new MyEquipObj(1,"伢牙神弩",_anti.yysn,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"道具唯一，下次活动期开放可再生成道具",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.lxzhs)
         {
            wpEquip202 = new MyEquipObj(1,"流邪转换石",_anti.lxzhs,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"将流邪转换成沙邪，入魔后大幅提升防御力",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.sxzhs)
         {
            wpEquip203 = new MyEquipObj(1,"沙邪转换石",_anti.sxzhs,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"将沙邪转换成渊邪，入魔后大幅提升攻击和暴击",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == this._anti.cdjyys)
         {
            wpEquip204 = new MyEquipObj(1,"超大经验药水",this._anti.cdjyys,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"服用后，提升50万点经验值",{
               "elevel":0,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == this._anti.dlhys)
         {
            wpEquip205 = new MyEquipObj(1,"大灵魂药水",this._anti.dlhys,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"服用后，提升75000点灵魂",{
               "elevel":0,
               "eupdata":0,
               "num":1
            });
         }
         if(equipName == "all" || equipName == _anti.bnnxz)
         {
            wpEquip206 = new MyEquipObj(1,"笨nana活动勋章",_anti.bnnxz,"zbwp","","普 通","0xFFFFFF",0,0,0,0,0,0,0,0,0,0,0,{},"雀巢笨nana活动专属勋章，活动结束后点击勋章可获得其他道具",{
               "elevel":1,
               "eupdata":0,
               "num":1
            });
         }
         for(i = uint(0); i < 206; )
         {
            wpEquipment.push(this["wpEquip" + (i + 1)]);
            i++;
         }
      }
      
      public function initSellEquipment(equipName:String) : void
      {
         var i:* = 0;
         sellEquipment = null;
         sellEquipment = [];
         if(equipName == "all" || equipName == this._anti.ptnmwsz)
         {
            fashionEquip1 = new MyEquipObj(6,"牛魔王装",this._anti.ptnmwsz,"zbsz","","普 通","0xFFFFFF",1 + Math.round(RandomControllor.getIns().getRandom() * this._anti.nighteen),0,0,0,0,0,2,0,0,0,0,{"hp":10},"3个相同的时装可以合成更高品质的时装，有效时间30天",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == this._anti.yxnmwsz)
         {
            fashionEquip2 = new MyEquipObj(6,"牛魔王装",this._anti.yxnmwsz,"zbsz","","优 秀","0x00FF00",this._anti.fourty + Math.round(RandomControllor.getIns().getRandom() * this._anti.sixty),0,0,0,0,0,3,0,0,0,0,{"hp":this._anti.fifty},"3个相同的时装可以合成更高品质的时装，有效时间30天，拥有献祭无双",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == this._anti.jlnmwsz)
         {
            fashionEquip3 = new MyEquipObj(6,"牛魔王装",this._anti.jlnmwsz,"zbsz","","精 良","0x0000FF",this._anti.eighty + Math.round(RandomControllor.getIns().getRandom() * 120),0,0,0,0,0,4,0,0,0,0,{"hp":this._anti.one_hundred},"3个相同的时装可以合成更高品质的时装，有效时间30天，拥有献祭无双",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == this._anti.ssnmwsz)
         {
            fashionEquip4 = new MyEquipObj(6,"牛魔王装",this._anti.ssnmwsz,"zbsz","","史 诗","0x660099",this._anti.one_hundred_sixty + Math.round(RandomControllor.getIns().getRandom() * 240),0,0,0,0,0,5,0,0,0,0,{"hp":200},"3个相同的时装可以合成更高品质的时装，有效时间30天，拥有献祭无双",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == this._anti.ptzlwsz)
         {
            fashionEquip5 = new MyEquipObj(7,"转轮王装",this._anti.ptzlwsz,"zbsz","","普 通","0xFFFFFF",0,1 + Math.round(RandomControllor.getIns().getRandom() * this._anti.nighteen),0,0,0,0,0,2,0,0,0,{"mp":10},"3个相同的时装可以合成更高品质的时装，有效时间30天",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == this._anti.yxzlwsz)
         {
            fashionEquip6 = new MyEquipObj(7,"转轮王装",this._anti.yxzlwsz,"zbsz","","优 秀","0x00FF00",0,this._anti.fourty + Math.round(RandomControllor.getIns().getRandom() * this._anti.sixty),0,0,0,0,0,3,0,0,0,{"mp":this._anti.fifty},"3个相同的时装可以合成更高品质的时装，有效时间30天，拥有锁轮无双",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == this._anti.jlzlwsz)
         {
            fashionEquip7 = new MyEquipObj(7,"转轮王装",this._anti.jlzlwsz,"zbsz","","精 良","0x0000FF",0,this._anti.eighty + Math.round(RandomControllor.getIns().getRandom() * 120),0,0,0,0,0,4,0,0,0,{"mp":this._anti.one_hundred},"3个相同的时装可以合成更高品质的时装，有效时间30天，拥有锁轮无双",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == this._anti.sszlwsz)
         {
            fashionEquip8 = new MyEquipObj(7,"转轮王装",this._anti.sszlwsz,"zbsz","","史 诗","0x660099",0,this._anti.one_hundred_sixty + Math.round(RandomControllor.getIns().getRandom() * 240),0,0,0,0,0,5,0,0,0,{"mp":200},"3个相同的时装可以合成更高品质的时装，有效时间30天，拥有锁轮无双",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == this._anti.ptsmsrsz)
         {
            fashionEquip9 = new MyEquipObj(8,"神秘商人装",this._anti.ptsmsrsz,"zbsz","","普 通","0xFFFFFF",1 + Math.round(RandomControllor.getIns().getRandom() * 9),1 + Math.round(RandomControllor.getIns().getRandom() * 9),2,0,0,0,0,0,0,0,0,{"att":1},"3个相同的时装可以合成更高品质的时装，有效时间7天",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == this._anti.yxsmsrsz)
         {
            fashionEquip10 = new MyEquipObj(8,"神秘商人装",this._anti.yxsmsrsz,"zbsz","","优 秀","0x00FF00",this._anti.twenty + Math.round(RandomControllor.getIns().getRandom() * 30),this._anti.twenty + Math.round(RandomControllor.getIns().getRandom() * 30),4,0,0,0,0,0,0,0,0,{"att":4},"3个相同的时装可以合成更高品质的时装，有效时间7天,拥有回天无双",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == this._anti.jlsmsrsz)
         {
            fashionEquip11 = new MyEquipObj(8,"神秘商人装",this._anti.jlsmsrsz,"zbsz","","精 良","0x0000FF",this._anti.fourty + Math.round(RandomControllor.getIns().getRandom() * this._anti.sixty),this._anti.fourty + Math.round(RandomControllor.getIns().getRandom() * this._anti.sixty),8,0,0,0,0,0,0,0,0,{"att":8},"3个相同的时装可以合成更高品质的时装，有效时间7天,拥有回天无双",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == this._anti.sssmsrsz)
         {
            fashionEquip12 = new MyEquipObj(8,"神秘商人装",this._anti.sssmsrsz,"zbsz","","史 诗","0x660099",this._anti.eighty + Math.round(RandomControllor.getIns().getRandom() * 120),this._anti.eighty + Math.round(RandomControllor.getIns().getRandom() * 120),this._anti.sixteen,0,0,0,0,0,0,0,0,{"att":this._anti.sixteen},"3个相同的时装可以合成更高品质的时装，有效时间7天,拥有回天无双",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == this._anti.ptttzssz)
         {
            fashionEquip13 = new MyEquipObj(10,"天庭战神装",this._anti.ptttzssz,"zbsz","","普 通","0xFFFFFF",this._anti.one + Math.round(RandomControllor.getIns().getRandom() * 20),0,this._anti.two,0,0,0,0,0,0,0.01 + Math.round(RandomControllor.getIns().getRandom() * 0.02),0,{"att":1},"3个相同的时装可以合成更高品质的时装，有效时间30天",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == this._anti.yxttzssz)
         {
            fashionEquip14 = new MyEquipObj(10,"天庭战神装",this._anti.yxttzssz,"zbsz","","优 秀","0x00FF00",this._anti.fourty + Math.round(RandomControllor.getIns().getRandom() * 60),0,this._anti.four,0,0,0,0,0,0,0.04 + Math.round(RandomControllor.getIns().getRandom() * 0.02),0,{"att":4},"3个相同的时装可以合成更高品质的时装，有效时间30天，拥有破甲无双",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == this._anti.jlttzssz)
         {
            fashionEquip15 = new MyEquipObj(10,"天庭战神装",this._anti.jlttzssz,"zbsz","","精 良","0x0000FF",this._anti.eighty + Math.round(RandomControllor.getIns().getRandom() * 120),0,8,0,0,0,0,0,0,0.07 + Math.round(RandomControllor.getIns().getRandom() * 0.02),0,{"att":8},"3个相同的时装可以合成更高品质的时装，有效时间30天，拥有破甲无双",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == this._anti.ssttzssz)
         {
            fashionEquip16 = new MyEquipObj(10,"天庭战神装",this._anti.ssttzssz,"zbsz","","史 诗","0x660099",this._anti.one_hundred_sixty + Math.round(RandomControllor.getIns().getRandom() * 240),0,16,0,0,0,0,0,0,0.1 + Math.round(RandomControllor.getIns().getRandom() * 0.02),0,{"att":16},"拥有破甲无双",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == this._anti.ptzqsz)
         {
            fashionEquip17 = new MyEquipObj(12,"中秋时装",this._anti.ptzqsz,"zbsz","","普 通","0xFFFFFF",this._anti.one + Math.round(RandomControllor.getIns().getRandom() * 20),0,this._anti.two,0,0,0,0,0,0,0.01 + Math.round(RandomControllor.getIns().getRandom() * 0.02),0,{"att":1},"3个相同的时装可以合成更高品质的时装，有效时间30天",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == this._anti.yxzqsz)
         {
            fashionEquip18 = new MyEquipObj(12,"中秋时装",this._anti.yxzqsz,"zbsz","","优 秀","0x00FF00",this._anti.fourty + Math.round(RandomControllor.getIns().getRandom() * 60),0,this._anti.four,0,0,0,0,0,0,0.04 + Math.round(RandomControllor.getIns().getRandom() * 0.02),0,{"att":4},"3个相同的时装可以合成更高品质的时装，有效时间30天，拥有一般的群体回复能力",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == this._anti.jlzqsz)
         {
            fashionEquip19 = new MyEquipObj(12,"中秋时装",this._anti.jlzqsz,"zbsz","","精 良","0x0000FF",this._anti.eighty + Math.round(RandomControllor.getIns().getRandom() * 120),0,8,0,0,0,0,0,0,0.07 + Math.round(RandomControllor.getIns().getRandom() * 0.02),0,{"att":8},"3个相同的时装可以合成更高品质的时装，有效时间30天，拥有较强的群体回复能力",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         if(equipName == "all" || equipName == this._anti.sszqsz)
         {
            fashionEquip20 = new MyEquipObj(12,"中秋时装",this._anti.sszqsz,"zbsz","","史 诗","0x660099",this._anti.one_hundred_sixty + Math.round(RandomControllor.getIns().getRandom() * 240),0,16,0,0,0,0,0,0,0.1 + Math.round(RandomControllor.getIns().getRandom() * 0.02),0,{"att":16},"拥有极强的群体回复能力",{
               "elevel":0,
               "eupdata":0
            },{});
         }
         for(i = uint(0); i < this._anti.twenty; )
         {
            sellEquipment.push(this["fashionEquip" + (i + 1)]);
            i++;
         }
      }
      
      public function initPetEquip(equipName:String) : void
      {
         var i:* = 0;
         petEquipment = null;
         petEquipment = [];
         if(equipName == "all" || equipName == this._anti.p_cyst)
         {
            petEquip1 = new PetEquipObj(31,"赤烟手套",this._anti.p_cyst,"zbst","","优 秀","0x00FF00",0,0,this._anti.one + Math.round(RandomControllor.getIns().getRandom() * 54),0,0,0,0,0,0,0,0,"",this._anti.p_cyst_obj);
         }
         if(equipName == "all" || equipName == this._anti.p_cyyf)
         {
            petEquip2 = new PetEquipObj(31,"赤烟铠甲",this._anti.p_cyyf,"zbyf","","优 秀","0x00FF00",this._anti.one + Math.round(RandomControllor.getIns().getRandom() * 389),0,0,0,0,0,0,0,0,0,0,"",this._anti.p_cyyf_obj);
         }
         if(equipName == "all" || equipName == this._anti.p_cymz)
         {
            petEquip3 = new PetEquipObj(31,"赤烟头盔",this._anti.p_cymz,"zbmz","","优 秀","0x00FF00",0,this._anti.one + Math.round(RandomControllor.getIns().getRandom() * 389),0,0,0,0,0,0,0,0,0,"",this._anti.p_cymz_obj);
         }
         if(equipName == "all" || equipName == this._anti.p_jlcyst)
         {
            petEquip4 = new PetEquipObj(31,"赤烟手套",this._anti.p_jlcyst,"zbst","","精 良","0x0000FF",0,0,0,0,Number((0.01 + RandomControllor.getIns().getRandom() * 0.02).toFixed(2)),0,0,0,0,0,0,"",this._anti.p_jlcyst_obj);
         }
         if(equipName == "all" || equipName == this._anti.p_jlcyyf)
         {
            petEquip5 = new PetEquipObj(31,"赤烟铠甲",this._anti.p_jlcyyf,"zbyf","","精 良","0x0000FF",0,0,0,0,0,0,0,0,0,Number((0.01 + RandomControllor.getIns().getRandom() * 0.04).toFixed(2)),0,"",this._anti.p_jlcyyf_obj);
         }
         if(equipName == "all" || equipName == this._anti.p_jlcymz)
         {
            petEquip6 = new PetEquipObj(31,"赤烟头盔",this._anti.p_jlcymz,"zbmz","","精 良","0x0000FF",0,0,0,0,0,0,0,this._anti.one + Math.round(RandomControllor.getIns().getRandom() * this._anti.two),0,0,0,"",this._anti.p_jlcymz_obj);
         }
         if(equipName == "all" || equipName == this._anti.p_sscyst)
         {
            petEquip7 = new PetEquipObj(31,"赤烟手套",this._anti.p_sscyst,"zbst","","史 诗","0x660099",0,0,0,0,Number((0.01 + RandomControllor.getIns().getRandom() * 0.02).toFixed(2)),0,0,0,0,0,0,"",this._anti.p_sscyst_obj);
         }
         if(equipName == "all" || equipName == this._anti.p_sscyyf)
         {
            petEquip8 = new PetEquipObj(31,"赤烟铠甲",this._anti.p_sscyyf,"zbyf","","史 诗","0x660099",0,0,0,0,0,0,0,0,0,Number((0.01 + RandomControllor.getIns().getRandom() * 0.04).toFixed(2)),0,"",this._anti.p_sscyyf_obj);
         }
         if(equipName == "all" || equipName == this._anti.p_sscymz)
         {
            petEquip9 = new PetEquipObj(31,"赤烟头盔",this._anti.p_sscymz,"zbmz","","史 诗","0x660099",0,0,0,0,0,0,0,this._anti.one + Math.round(RandomControllor.getIns().getRandom() * this._anti.two),0,0,0,"",this._anti.p_sscymz_obj);
         }
         if(equipName == "all" || equipName == this._anti.p_cyxz)
         {
            petEquip10 = new PetEquipObj(31,"赤烟战靴",this._anti.p_cyxz,"zbxz","","优 秀","0x00FF00",0,0,0,this._anti.one + Math.round(RandomControllor.getIns().getRandom() * this._anti.nigth),0,0,0,0,0,0,0,"",this._anti.p_cyxz_obj);
         }
         if(equipName == "all" || equipName == this._anti.p_jlcyxz)
         {
            petEquip11 = new PetEquipObj(31,"赤烟战靴",this._anti.p_jlcyxz,"zbxz","","精 良","0x0000FF",0,0,0,0,0,0,0,0,0,0,Number((0.5 + RandomControllor.getIns().getRandom() * 0.5).toFixed(2)),"",this._anti.p_jlcyxz_obj);
         }
         if(equipName == "all" || equipName == this._anti.p_sscyxz)
         {
            petEquip12 = new PetEquipObj(31,"赤烟战靴",this._anti.p_sscyxz,"zbxz","","史 诗","0x660099",0,0,0,0,0,0,0,0,0,0,Number((0.5 + RandomControllor.getIns().getRandom() * 0.5).toFixed(2)),"",this._anti.p_sscyxz_obj);
         }
         if(equipName == "all" || equipName == this._anti.p_cysx)
         {
            petEquip13 = new PetEquipObj(31,"嗜血",this._anti.p_cysx,"zbjn","","优 秀","0x00FF00",0,0,0,0,0,0,0,0,0.03,0,0,"",this._anti.p_cysx_obj);
         }
         if(equipName == "all" || equipName == this._anti.p_jlcysx)
         {
            petEquip14 = new PetEquipObj(31,"嗜血",this._anti.p_jlcysx,"zbjn","","精 良","0x0000FF",0,0,0,0,0,0,0,0,0.03,0,0,"",this._anti.p_jlcysx_obj);
         }
         if(equipName == "all" || equipName == this._anti.p_sscysx)
         {
            petEquip15 = new PetEquipObj(31,"嗜血",this._anti.p_sscysx,"zbjn","","史 诗","0x660099",0,0,0,0,0,0,0,0,0.03,0,0,"",this._anti.p_sscysx_obj);
         }
         if(equipName == "all" || equipName == this._anti.p_cykx)
         {
            petEquip16 = new PetEquipObj(31,"抗性",this._anti.p_cykx,"zbjn","","优 秀","0x00FF00",0,0,0,0,0,0,0,0,0,0.05,0,"",{});
         }
         if(equipName == "all" || equipName == this._anti.p_jlcykx)
         {
            petEquip17 = new PetEquipObj(31,"抗性",this._anti.p_jlcykx,"zbjn","","精 良","0x0000FF",0,0,0,0,0,0,0,0,0,0.05,0,"",{});
         }
         if(equipName == "all" || equipName == this._anti.p_sscykx)
         {
            petEquip18 = new PetEquipObj(31,"抗性",this._anti.p_sscykx,"zbjn","","史 诗","0x660099",0,0,0,0,0,0,0,0,0,0.05,0,"",{});
         }
         if(equipName == "all" || equipName == this._anti.p_cyhh)
         {
            petEquip19 = new PetEquipObj(31,"辉煌",this._anti.p_cyhh,"zbjn","","优 秀","0x00FF00",0,0,0,0,0,0,0,2,0,0,0,"",{});
         }
         if(equipName == "all" || equipName == this._anti.p_jlcyhh)
         {
            petEquip20 = new PetEquipObj(31,"辉煌",this._anti.p_jlcyhh,"zbjn","","精 良","0x0000FF",0,0,0,0,0,0,0,2,0,0,0,"",{});
         }
         if(equipName == "all" || equipName == this._anti.p_sscyhh)
         {
            petEquip21 = new PetEquipObj(31,"辉煌",this._anti.p_sscyhh,"zbjn","","史 诗","0x660099",0,0,0,0,0,0,0,2,0,0,0,"",{});
         }
         if(equipName == "all" || equipName == this._anti.p_cztk)
         {
            petEquip22 = new PetEquipObj(31,"叱咤头盔",this._anti.p_cztk,"zbmz","","优 秀","0x00FF00",0,this._anti.two_hundred + Math.round(RandomControllor.getIns().getRandom() * this._anti.two_hundred_fifty),0,0,0,0,0,0,0,0,0,"",this._anti.p_cymz_obj);
         }
         if(equipName == "all" || equipName == this._anti.p_jlcztk)
         {
            petEquip23 = new PetEquipObj(31,"叱咤头盔",this._anti.p_jlcztk,"zbmz","","精 良","0x0000FF",0,0,0,0,0,0,0,this._anti.one + Math.round(RandomControllor.getIns().getRandom() * this._anti.two),0,0,0,"",this._anti.p_jlcymz_obj);
         }
         if(equipName == "all" || equipName == this._anti.p_sscztk)
         {
            petEquip24 = new PetEquipObj(31,"叱咤头盔",this._anti.p_sscztk,"zbmz","","史 诗","0x660099",0,0,0,0,0,0,0,this._anti.one + Math.round(RandomControllor.getIns().getRandom() * this._anti.two),0,0,0,"",this._anti.p_sscymz_obj);
         }
         if(equipName == "all" || equipName == this._anti.p_czst)
         {
            petEquip25 = new PetEquipObj(31,"叱咤手套",this._anti.p_czst,"zbst","","优 秀","0x00FF00",0,0,this._anti.twenty + Math.round(RandomControllor.getIns().getRandom() * this._anti.fourty),0,0,0,0,0,0,0,0,"",this._anti.p_cyst_obj);
         }
         if(equipName == "all" || equipName == this._anti.p_jlczst)
         {
            petEquip26 = new PetEquipObj(31,"叱咤手套",this._anti.p_jlczst,"zbst","","精 良","0x0000FF",0,0,0,0,Number((0.01 + RandomControllor.getIns().getRandom() * 0.02).toFixed(2)),0,0,0,0,0,0,"",this._anti.p_jlcyst_obj);
         }
         if(equipName == "all" || equipName == this._anti.p_ssczst)
         {
            petEquip27 = new PetEquipObj(31,"叱咤手套",this._anti.p_ssczst,"zbst","","史 诗","0x660099",0,0,0,0,Number((0.01 + RandomControllor.getIns().getRandom() * 0.02).toFixed(2)),0,0,0,0,0,0,"",this._anti.p_sscyst_obj);
         }
         if(equipName == "all" || equipName == this._anti.p_czkj)
         {
            petEquip28 = new PetEquipObj(31,"叱咤铠甲",this._anti.p_czkj,"zbyf","","优 秀","0x00FF00",this._anti.two_hundred + Math.round(RandomControllor.getIns().getRandom() * this._anti.two_hundred_fifty),0,0,0,0,0,0,0,0,0,0,"",this._anti.p_cyyf_obj);
         }
         if(equipName == "all" || equipName == this._anti.p_jlczkj)
         {
            petEquip29 = new PetEquipObj(31,"叱咤铠甲",this._anti.p_jlczkj,"zbyf","","精 良","0x0000FF",0,0,0,0,0,0,0,0,0,Number((0.01 + RandomControllor.getIns().getRandom() * 0.04).toFixed(2)),0,"",this._anti.p_jlcyyf_obj);
         }
         if(equipName == "all" || equipName == this._anti.p_ssczkj)
         {
            petEquip30 = new PetEquipObj(31,"叱咤铠甲",this._anti.p_ssczkj,"zbyf","","史 诗","0x660099",0,0,0,0,0,0,0,0,0,Number((0.01 + RandomControllor.getIns().getRandom() * 0.04).toFixed(2)),0,"",this._anti.p_sscyyf_obj);
         }
         if(equipName == "all" || equipName == this._anti.p_czzx)
         {
            petEquip31 = new PetEquipObj(31,"叱咤战鞋",this._anti.p_czzx,"zbxz","","优 秀","0x00FF00",0,0,0,this._anti.five + Math.round(RandomControllor.getIns().getRandom() * this._anti.five),0,0,0,0,0,0,0,"",this._anti.p_cyxz_obj);
         }
         if(equipName == "all" || equipName == this._anti.p_jlczzx)
         {
            petEquip32 = new PetEquipObj(31,"叱咤战鞋",this._anti.p_jlczzx,"zbxz","","精 良","0x0000FF",0,0,0,0,0,0,0,0,0,0,Number((this._anti.zero_point_5 + RandomControllor.getIns().getRandom() * this._anti.zero_point_5).toFixed(2)),"",this._anti.p_jlcyxz_obj);
         }
         if(equipName == "all" || equipName == this._anti.p_ssczzx)
         {
            petEquip33 = new PetEquipObj(31,"叱咤战鞋",this._anti.p_ssczzx,"zbxz","","史 诗","0x660099",0,0,0,0,0,0,0,0,0,0,Number((this._anti.zero_point_5 + RandomControllor.getIns().getRandom() * this._anti.zero_point_5).toFixed(2)),"",this._anti.p_sscyxz_obj);
         }
         if(equipName == "all" || equipName == this._anti.p_cylhjl)
         {
            petEquip34 = new PetEquipObj(31,"烈火精灵",this._anti.p_cylhjl,"zbjn","","优 秀","0x00FF00",500,0,0,0,0,0,0,0,0,0,0,"",{});
         }
         if(equipName == "all" || equipName == this._anti.p_jlcylhjl)
         {
            petEquip35 = new PetEquipObj(31,"烈火精灵",this._anti.p_jlcylhjl,"zbjn","","精 良","0x0000FF",500,0,0,0,0,0,0,0,0,0,0,"",{});
         }
         if(equipName == "all" || equipName == this._anti.p_sscylhjl)
         {
            petEquip36 = new PetEquipObj(31,"烈火精灵",this._anti.p_sscylhjl,"zbjn","","史 诗","0x660099",500,0,0,0,0,0,0,0,0,0,0,"",{});
         }
         if(equipName == "all" || equipName == this._anti.p_cybxjl)
         {
            petEquip37 = new PetEquipObj(31,"冰雪精灵",this._anti.p_cybxjl,"zbjn","","优 秀","0x00FF00",500,0,0,0,0,0,0,0,0,0,0,"",{});
         }
         if(equipName == "all" || equipName == this._anti.p_jlcybxjl)
         {
            petEquip38 = new PetEquipObj(31,"冰雪精灵",this._anti.p_jlcybxjl,"zbjn","","精 良","0x0000FF",500,0,0,0,0,0,0,0,0,0,0,"",{});
         }
         if(equipName == "all" || equipName == this._anti.p_sscybxjl)
         {
            petEquip39 = new PetEquipObj(31,"冰雪精灵",this._anti.p_sscybxjl,"zbjn","","史 诗","0x660099",500,0,0,0,0,0,0,0,0,0,0,"",{});
         }
         if(equipName == "all" || equipName == this._anti.p_cynsjl)
         {
            petEquip40 = new PetEquipObj(31,"年兽精灵",this._anti.p_cynsjl,"zbjn","","优 秀","0x00FF00",0,0,0,0,0,0,0,0,0.03,0,0,"",{});
         }
         if(equipName == "all" || equipName == this._anti.p_jlcynsjl)
         {
            petEquip41 = new PetEquipObj(31,"年兽精灵",this._anti.p_jlcynsjl,"zbjn","","精 良","0x0000FF",0,0,0,0,0,0,0,0,0.03,0,0,"",{});
         }
         if(equipName == "all" || equipName == this._anti.p_sscynsjl)
         {
            petEquip42 = new PetEquipObj(31,"年兽精灵",this._anti.p_sscynsjl,"zbjn","","史 诗","0x660099",0,0,0,0,0,0,0,0,0.03,0,0,"",{});
         }
         if(equipName == "all" || equipName == this._anti.p_cygsjl)
         {
            petEquip43 = new PetEquipObj(31,"钢石精灵",this._anti.p_cygsjl,"zbjn","","优 秀","0x00FF00",500,0,0,0,0,0,0,0,0,0,0,"",{});
         }
         if(equipName == "all" || equipName == this._anti.p_jlcygsjl)
         {
            petEquip44 = new PetEquipObj(31,"钢石精灵",this._anti.p_jlcygsjl,"zbjn","","精 良","0x0000FF",500,0,0,0,0,0,0,0,0,0,0,"",{});
         }
         if(equipName == "all" || equipName == this._anti.p_sscygsjl)
         {
            petEquip45 = new PetEquipObj(31,"钢石精灵",this._anti.p_sscygsjl,"zbjn","","史 诗","0x660099",500,0,0,0,0,0,0,0,0,0,0,"",{});
         }
         if(equipName == "all" || equipName == this._anti.p_cykljl)
         {
            petEquip46 = new PetEquipObj(31,"狂雷精灵",this._anti.p_cykljl,"zbjn","","优 秀","0x00FF00",500,0,0,0,0,0,0,0,0,0,0,"",{});
         }
         if(equipName == "all" || equipName == this._anti.p_jlcykljl)
         {
            petEquip47 = new PetEquipObj(31,"狂雷精灵",this._anti.p_jlcykljl,"zbjn","","精 良","0x0000FF",500,0,0,0,0,0,0,0,0,0,0,"",{});
         }
         if(equipName == "all" || equipName == this._anti.p_sscykljl)
         {
            petEquip48 = new PetEquipObj(31,"狂雷精灵",this._anti.p_sscykljl,"zbjn","","史 诗","0x660099",500,0,0,0,0,0,0,0,0,0,0,"",{});
         }
         if(equipName == "all" || equipName == this._anti.p_cyzsjl)
         {
            petEquip49 = new PetEquipObj(31,"子鼠精灵",this._anti.p_cyzsjl,"zbjn","","优 秀","0x00FF00",1000,0,0,0,0,0,0,0,0,0,0,"",{});
         }
         if(equipName == "all" || equipName == this._anti.p_jlcyzsjl)
         {
            petEquip50 = new PetEquipObj(31,"子鼠精灵",this._anti.p_jlcyzsjl,"zbjn","","精 良","0x0000FF",1000,0,0,0,0,0,0,0,0,0,0,"",{});
         }
         if(equipName == "all" || equipName == this._anti.p_sscyzsjl)
         {
            petEquip51 = new PetEquipObj(31,"子鼠精灵",this._anti.p_sscyzsjl,"zbjn","","史 诗","0x660099",1000,0,0,0,0,0,0,0,0,0,0,"",{});
         }
         if(equipName == "all" || equipName == this._anti.p_cycnjl)
         {
            petEquip52 = new PetEquipObj(31,"丑牛精灵",this._anti.p_cycnjl,"zbjn","","优 秀","0x00FF00",1000,0,0,0,0,0,0,0,0,0,0,"",{});
         }
         if(equipName == "all" || equipName == this._anti.p_jlcycnjl)
         {
            petEquip53 = new PetEquipObj(31,"丑牛精灵",this._anti.p_jlcycnjl,"zbjn","","精 良","0x0000FF",1000,0,0,0,0,0,0,0,0,0,0,"",{});
         }
         if(equipName == "all" || equipName == this._anti.p_sscycnjl)
         {
            petEquip54 = new PetEquipObj(31,"丑牛精灵",this._anti.p_sscycnjl,"zbjn","","史 诗","0x660099",1000,0,0,0,0,0,0,0,0,0,0,"",{});
         }
         if(equipName == "all" || equipName == this._anti.p_cyymjl)
         {
            petEquip55 = new PetEquipObj(31,"炎马精灵",this._anti.p_cyymjl,"zbjn","","优 秀","0x00FF00",1000,0,0,0,0,0,0,0,0,0,0,"",{});
         }
         if(equipName == "all" || equipName == this._anti.p_jlcyymjl)
         {
            petEquip56 = new PetEquipObj(31,"炎马精灵",this._anti.p_jlcyymjl,"zbjn","","精 良","0x0000FF",1000,0,0,0,0,0,0,0,0,0,0,"",{});
         }
         if(equipName == "all" || equipName == this._anti.p_sscyymjl)
         {
            petEquip57 = new PetEquipObj(31,"炎马精灵",this._anti.p_sscyymjl,"zbjn","","史 诗","0x660099",1000,0,0,0,0,0,0,0,0,0,0,"",{});
         }
         if(equipName == "all" || equipName == this._anti.p_cyyhjl)
         {
            petEquip58 = new PetEquipObj(31,"寅虎精灵",this._anti.p_cyyhjl,"zbjn","","优 秀","0x00FF00",1000,0,0,0,0,0,0,0,0,0,0,"",{});
         }
         if(equipName == "all" || equipName == this._anti.p_jlcyyhjl)
         {
            petEquip59 = new PetEquipObj(31,"寅虎精灵",this._anti.p_jlcyyhjl,"zbjn","","精 良","0x0000FF",1000,0,0,0,0,0,0,0,0,0,0,"",{});
         }
         if(equipName == "all" || equipName == this._anti.p_sscyyhjl)
         {
            petEquip60 = new PetEquipObj(31,"寅虎精灵",this._anti.p_sscyyhjl,"zbjn","","史 诗","0x660099",1000,0,0,0,0,0,0,0,0,0,0,"",{});
         }
         for(i = uint(0); i < 60; )
         {
            petEquipment.push(this["petEquip" + (i + 1)]);
            i++;
         }
      }
      
      private function reNewAll(fname:String) : void
      {
         this.initSutraEquipment(fname);
         this.initSellEquipment(fname);
         this.newMyEquipObj(fname);
         this.initWpEquipment(fname);
         this.initPetEquip(fname);
      }
      
      public function findByName(_name:String) : *
      {
         this.reNewAll(_name);
         var nlen:uint = this.normalEquipment.length;
         while(nlen-- > 0)
         {
            if(_name == this.normalEquipment[nlen].getFillName())
            {
               return this.normalEquipment[nlen];
            }
         }
         var olen:uint = this.otherEquipment.length;
         while(olen-- > 0)
         {
            if(_name == this.otherEquipment[olen].getFillName())
            {
               return this.otherEquipment[olen];
            }
         }
         var wplen:uint = this.wpEquipment.length;
         while(wplen-- > 0)
         {
            if(_name == this.wpEquipment[wplen].getFillName())
            {
               return this.wpEquipment[wplen];
            }
         }
         var splen:uint = this.sellEquipment.length;
         while(splen-- > 0)
         {
            if(_name == this.sellEquipment[splen].getFillName())
            {
               return this.sellEquipment[splen];
            }
         }
         var sulen:uint = this.sutraEquipment.length;
         while(sulen-- > 0)
         {
            if(_name == this.sutraEquipment[sulen].getFillName())
            {
               return this.sutraEquipment[sulen];
            }
         }
         var plen:uint = this.petEquipment.length;
         while(plen-- > 0)
         {
            if(_name == this.petEquipment[plen].getFillName())
            {
               return this.petEquipment[plen];
            }
         }
         return null;
      }
      
      public function isFashionEquipByFillName(fn:String) : Boolean
      {
         var someEquip:MyEquipObj = this.findByName(fn);
         if(someEquip.type == "zbsz")
         {
            return true;
         }
         return false;
      }
      
      public function getStrengthNumber(qhs:MyEquipObj, curequip:MyEquipObj) : Number
      {
         var rback:Number = 0;
         switch(int(qhs.getELevel()) - 1)
         {
            case 0:
               rback = this.transLevelToProbability(curequip,this._anti.zero_point_3_7_5,this._anti.zero_point_0_9_3_7,this._anti.zero_point_0_2_3_4,this._anti.zero_point_0_0_5_8,this._anti.zero_point_0,this._anti.zero_point_0,this._anti.zero_point_0);
               break;
            case 1:
               rback = this.transLevelToProbability(curequip,this._anti.one_point_0,this._anti.zero_point_3_7_5,this._anti.zero_point_0_9_3_7,this._anti.zero_point_0_2_3_4,this._anti.zero_point_0_0_5_8,this._anti.zero_point_0,this._anti.zero_point_0);
               break;
            case 2:
               rback = this.transLevelToProbability(curequip,this._anti.one_point_0,this._anti.one_point_0,this._anti.zero_point_3_7_5,this._anti.zero_point_0_9_3_7,this._anti.zero_point_0_2_3_4,this._anti.zero_point_0_0_5_8,this._anti.zero_point_0);
               break;
            case 3:
               rback = this.transLevelToProbability(curequip,this._anti.one_point_0,this._anti.one_point_0,this._anti.one_point_0,this._anti.zero_point_3_7_5,this._anti.zero_point_0_9_3_7,this._anti.zero_point_0_2_3_4,this._anti.zero_point_0_0_5_8);
         }
         return rback;
      }
      
      private function transLevelToProbability(curequip:MyEquipObj, a:Number, b:Number, c:Number, d:Number, e:Number, f:Number, g:Number) : Number
      {
         if(curequip.getStrengthValue() == 0)
         {
            return a;
         }
         if(curequip.getStrengthValue() == 1)
         {
            return b;
         }
         if(curequip.getStrengthValue() == 2)
         {
            return c;
         }
         if(curequip.getStrengthValue() == 3)
         {
            return d;
         }
         if(curequip.getStrengthValue() == 4)
         {
            return e;
         }
         if(curequip.getStrengthValue() == 5)
         {
            return f;
         }
         if(curequip.getStrengthValue() == 6)
         {
            return g;
         }
         return 0;
      }
      
      public function mixProduce(mater:Array) : Array
      {
         var marr:Array = [];
         for(var mlen:uint = mater.length; mlen-- > 0; )
         {
            marr.push(mater[mlen].getFillName());
         }
         if(this.transName(marr,["kyg","kyz","kys"]) == 123)
         {
            return ["kyl","枯叶灵"];
         }
         if(this.transName(marr,["xhz","xhc","xhp"]) == 123)
         {
            return ["xhhl","宣花葫芦"];
         }
         if(this.transName(marr,["qybd","qyfp","qysz"]) == 123)
         {
            return ["qyj","青云剑"];
         }
         if(this.transName(marr,["hylk","hylc","hylz"]) == 123)
         {
            return ["hyzzs","混元珍珠伞"];
         }
         if(this.transName(marr,["zjksf","zjqj","zjbtg"]) == 123)
         {
            return ["zjld","紫金铃铛"];
         }
         if(this.transName(marr,["wpqhs1","wpqhs1","wpqhs1"]) == 123)
         {
            return ["wpqhs2","2级强化石"];
         }
         if(this.transName(marr,["wpqhs2","wpqhs2","wpqhs2"]) == 123 || this.transName(marr,["scwpqhs2","scwpqhs2","scwpqhs2"]) == 123 || this.transName(marr,["wpqhs2","scwpqhs2","scwpqhs2"]) == 123 || this.transName(marr,["wpqhs2","wpqhs2","scwpqhs2"]) == 123)
         {
            return ["wpqhs3","3级强化石"];
         }
         if(this.transName(marr,["wpqhs3","wpqhs3","wpqhs3"]) == 123 || this.transName(marr,["scwpqhs3","scwpqhs3","scwpqhs3"]) == 123 || this.transName(marr,["wpqhs3","scwpqhs3","scwpqhs3"]) == 123 || this.transName(marr,["wpqhs3","wpqhs3","scwpqhs3"]) == 123)
         {
            return ["wpqhs4","4级强化石"];
         }
         if(this.transName(marr,["sms1","sms1","sms1"]) == 123)
         {
            return ["sms2","2级生命石"];
         }
         if(this.transName(marr,["sms2","sms2","sms2"]) == 123 || this.transName(marr,["scsms2","scsms2","scsms2"]) == 123 || this.transName(marr,["sms2","scsms2","scsms2"]) == 123 || this.transName(marr,["sms2","sms2","scsms2"]) == 123)
         {
            return ["sms3","3级生命石"];
         }
         if(this.transName(marr,["mfs1","mfs1","mfs1"]) == 123)
         {
            return ["mfs2","2级魔法石"];
         }
         if(this.transName(marr,["mfs2","mfs2","mfs2"]) == 123 || this.transName(marr,["scmfs2","scmfs2","scmfs2"]) == 123 || this.transName(marr,["mfs2","scmfs2","scmfs2"]) == 123 || this.transName(marr,["mfs2","mfs2","scmfs2"]) == 123)
         {
            return ["mfs3","3级魔法石"];
         }
         if(this.transName(marr,["gjs1","gjs1","gjs1"]) == 123)
         {
            return ["gjs2","2级攻击石"];
         }
         if(this.transName(marr,["gjs2","gjs2","gjs2"]) == 123 || this.transName(marr,["scgjs2","scgjs2","scgjs2"]) == 123 || this.transName(marr,["gjs2","scgjs2","scgjs2"]) == 123 || this.transName(marr,["gjs2","gjs2","scgjs2"]) == 123)
         {
            return ["gjs3","3级攻击石"];
         }
         if(this.transName(marr,["fys1","fys1","fys1"]) == 123)
         {
            return ["fys2","2级防御石"];
         }
         if(this.transName(marr,["fys2","fys2","fys2"]) == 123 || this.transName(marr,["scfys2","scfys2","scfys2"]) == 123 || this.transName(marr,["fys2","scfys2","scfys2"]) == 123 || this.transName(marr,["fys2","fys2","scfys2"]) == 123)
         {
            return ["fys3","3级防御石"];
         }
         if(this.transName(marr,["tlzsp","tlzsp","tlzsp"]) == 123)
         {
            return ["wptlz","土灵珠"];
         }
         if(this.transName(marr,["llzsp","llzsp","llzsp"]) == 123)
         {
            return ["wpllz","雷灵珠"];
         }
         if(this.transName(marr,["hlzsp","hlzsp","hlzsp"]) == 123)
         {
            return ["wphlz","火灵珠"];
         }
         if(this.transName(marr,["flzsp","flzsp","flzsp"]) == 123)
         {
            return ["wpflz","风灵珠"];
         }
         if(this.transName(marr,["slzsp","slzsp","slzsp"]) == 123)
         {
            return ["wpslz","水灵珠"];
         }
         if(this.transName(marr,["xley","rls","rls"]) == 123)
         {
            return ["yhs","玉衡石"];
         }
         if(this.transName(marr,["xlcz","rls","rls"]) == 123)
         {
            return ["yhs","玉衡石"];
         }
         if(this.transName(marr,["xlry","rls","rls"]) == 123)
         {
            return ["yhs","玉衡石"];
         }
         if(this.transName(marr,["xlyj","rls","rls"]) == 123)
         {
            return ["yhs","玉衡石"];
         }
         if(this.transName(marr,["xlth","rls","rls"]) == 123)
         {
            return ["tss","天枢石"];
         }
         if(this.transName(marr,["xltc","rls","rls"]) == 123)
         {
            return ["tss","天枢石"];
         }
         if(this.transName(marr,["xltz","rls","rls"]) == 123)
         {
            return ["tss","天枢石"];
         }
         if(this.transName(marr,["xlts","rls","rls"]) == 123)
         {
            return ["tss","天枢石"];
         }
         if(this.transName(marr,["ptnmwsz","ptnmwsz","ptnmwsz"]) == 123)
         {
            return ["yxnmwsz","牛魔王装"];
         }
         if(this.transName(marr,["yxnmwsz","yxnmwsz","yxnmwsz"]) == 123)
         {
            return ["jlnmwsz","牛魔王装"];
         }
         if(this.transName(marr,["jlnmwsz","jlnmwsz","jlnmwsz"]) == 123)
         {
            return ["ssnmwsz","牛魔王装"];
         }
         if(this.transName(marr,["ptzlwsz","ptzlwsz","ptzlwsz"]) == 123)
         {
            return ["yxzlwsz","转轮王装"];
         }
         if(this.transName(marr,["yxzlwsz","yxzlwsz","yxzlwsz"]) == 123)
         {
            return ["jlzlwsz","转轮王装"];
         }
         if(this.transName(marr,["jlzlwsz","jlzlwsz","jlzlwsz"]) == 123)
         {
            return ["sszlwsz","转轮王装"];
         }
         if(this.transName(marr,["ptsmsrsz","ptsmsrsz","ptsmsrsz"]) == 123)
         {
            return ["yxsmsrsz","神秘商人装"];
         }
         if(this.transName(marr,["yxsmsrsz","yxsmsrsz","yxsmsrsz"]) == 123)
         {
            return ["jlsmsrsz","神秘商人装"];
         }
         if(this.transName(marr,["jlsmsrsz","jlsmsrsz","jlsmsrsz"]) == 123)
         {
            return ["sssmsrsz","神秘商人装"];
         }
         if(this.transName(marr,["ptttzssz","ptttzssz","ptttzssz"]) == 123)
         {
            return ["yxttzssz","天庭战神装"];
         }
         if(this.transName(marr,["yxttzssz","yxttzssz","yxttzssz"]) == 123)
         {
            return ["jlttzssz","天庭战神装"];
         }
         if(this.transName(marr,["jlttzssz","jlttzssz","jlttzssz"]) == 123)
         {
            return ["ssttzssz","天庭战神装"];
         }
         if(this.transName(marr,["wplh","wpxm","wpll"]) == 123)
         {
            return ["wpsmd1","一品生命丹"];
         }
         if(this.transName(marr,["ptzqsz","ptzqsz","ptzqsz"]) == 123)
         {
            return ["yxzqsz","中秋时装"];
         }
         if(this.transName(marr,["yxzqsz","yxzqsz","yxzqsz"]) == 123)
         {
            return ["jlzqsz","中秋时装"];
         }
         if(this.transName(marr,["jlzqsz","jlzqsz","jlzqsz"]) == 123)
         {
            return ["sszqsz","中秋时装"];
         }
         if(this.transName(marr,["wplh","wpdd","wplvdyl"]) == 123)
         {
            return ["wpsmd1","一品生命丹"];
         }
         if(this.transName(marr,["wpsmd1","wpdd","wpxm"]) == 123)
         {
            return ["wpsmd2","二品生命丹"];
         }
         if(this.transName(marr,["wpsmd2","wpll","wpsg"]) == 123)
         {
            return ["wpsmd3","三品生命丹"];
         }
         if(this.transName(marr,["wpsmd3","wplh","wprs"]) == 123)
         {
            return ["wpsmd4","四品生命丹"];
         }
         if(this.transName(marr,["wpsmd4","wplh","mpyj"]) == 123)
         {
            return ["wpsmd5","五品生命丹"];
         }
         if(this.transName(marr,["yjpyinsp","yjpyansp","wplvdyl"]) == 123)
         {
            return ["yjp","玉净瓶"];
         }
         if(this.transName(marr,["qlg","qlg","qlg"]) == 123)
         {
            return ["rls","熔炼石"];
         }
         if(this.transName(marr,["qlj","qlj","qlj"]) == 123)
         {
            return ["rls","熔炼石"];
         }
         if(this.transName(marr,["plz","plz","plz"]) == 123)
         {
            return ["rls","熔炼石"];
         }
         if(this.transName(marr,["plp","plp","plp"]) == 123)
         {
            return ["rls","熔炼石"];
         }
         if(this.transName(marr,["ylh","ylh","ylh"]) == 123)
         {
            return ["rls","熔炼石"];
         }
         if(this.transName(marr,["ylk","ylk","ylk"]) == 123)
         {
            return ["rls","熔炼石"];
         }
         if(this.transName(marr,["jlg","jlg","jlg"]) == 123)
         {
            return ["rls","熔炼石"];
         }
         if(this.transName(marr,["jlj","jlj","jlj"]) == 123)
         {
            return ["rls","熔炼石"];
         }
         if(this.transName(marr,["jlc","jlc","jlc"]) == 123)
         {
            return ["rls","熔炼石"];
         }
         if(this.transName(marr,["ttlpsp1","ttlpsp2","ttlpsp3"]) == 123)
         {
            return ["ttlp","通天令牌"];
         }
         if(this.transName(marr,["ttslsp1","ttslsp2","ttslsp3"]) == 123)
         {
            return ["ttsl","通天赦令"];
         }
         if(this.transName(marr,["zhhz","phhl","bxhy"]) == 123)
         {
            return ["cs_sp_hy","花宴"];
         }
         if(this.transName(marr,["_zmxyptxnkl","_zmxyptxnkl","_zmxyptxnkl"]) == 123)
         {
            return ["_zmxyyxxnkl","新年快乐"];
         }
         if(this.transName(marr,["_zmxyyxxnkl","_zmxyyxxnkl","_zmxyyxxnkl"]) == 123)
         {
            return ["_zmxyjlxnkl","新年快乐"];
         }
         if(this.transName(marr,["_zmxyjlxnkl","_zmxyjlxnkl","_zmxyjlxnkl"]) == 123)
         {
            return ["_zmxyssxnkl","新年快乐"];
         }
         if(this.transName(marr,["_zmxyptxnkl2014","_zmxyptxnkl2014","_zmxyptxnkl2014"]) == 123)
         {
            return ["_zmxyyxxnkl2014","新年快乐"];
         }
         if(this.transName(marr,["_zmxyyxxnkl2014","_zmxyyxxnkl2014","_zmxyyxxnkl2014"]) == 123)
         {
            return ["_zmxyjlxnkl2014","新年快乐"];
         }
         if(this.transName(marr,["_zmxyjlxnkl2014","_zmxyjlxnkl2014","_zmxyjlxnkl2014"]) == 123)
         {
            return ["_zmxyssxnkl2014","新年快乐"];
         }
         if(this.transName(marr,["_zmxyptxnkl2017","_zmxyptxnkl2017","_zmxyptxnkl2017"]) == 123)
         {
            return ["_zmxyyxxnkl2017","新年快乐"];
         }
         if(this.transName(marr,["_zmxyyxxnkl2017","_zmxyyxxnkl2017","_zmxyyxxnkl2017"]) == 123)
         {
            return ["_zmxyjlxnkl2017","新年快乐"];
         }
         if(this.transName(marr,["_zmxyjlxnkl2017","_zmxyjlxnkl2017","_zmxyjlxnkl2017"]) == 123)
         {
            return ["_zmxyssxnkl2017","新年快乐"];
         }
         if(this.transName(marr,["_zmxyptxnkl2018","_zmxyptxnkl2018","_zmxyptxnkl2018"]) == 123)
         {
            return ["_zmxyyxxnkl2018","新年快乐"];
         }
         if(this.transName(marr,["_zmxyyxxnkl2018","_zmxyyxxnkl2018","_zmxyyxxnkl2018"]) == 123)
         {
            return ["_zmxyjlxnkl2018","新年快乐"];
         }
         if(this.transName(marr,["_zmxyjlxnkl2018","_zmxyjlxnkl2018","_zmxyjlxnkl2018"]) == 123)
         {
            return ["_zmxyssxnkl2018","新年快乐"];
         }
         if(this.transName(marr,["pusrdg","pusrdg","pusrdg"]) == 123)
         {
            return ["yxsrdg","生日蛋糕"];
         }
         if(this.transName(marr,["yxsrdg","yxsrdg","yxsrdg"]) == 123)
         {
            return ["jlsrdg","生日蛋糕"];
         }
         if(this.transName(marr,["jlsrdg","jlsrdg","jlsrdg"]) == 123)
         {
            return ["sssrdg","生日蛋糕"];
         }
         if(this.transName(marr,["_4399ptsjwj","_4399ptsjwj","_4399ptsjwj"]) == 123)
         {
            return ["_4399yxsjwj","4399手机玩家"];
         }
         if(this.transName(marr,["_4399yxsjwj","_4399yxsjwj","_4399yxsjwj"]) == 123)
         {
            return ["_4399jlsjwj","4399手机玩家"];
         }
         if(this.transName(marr,["_4399jlsjwj","_4399jlsjwj","_4399jlsjwj"]) == 123)
         {
            return ["_4399sssjwj","4399手机玩家"];
         }
         if(this.transName(marr,["_yxwsjkh","_yxwsjkh","_yxwsjkh"]) == 123)
         {
            return ["_jlwsjkh","万圣节"];
         }
         if(this.transName(marr,["_jlwsjkh","_jlwsjkh","_jlwsjkh"]) == 123)
         {
            return ["_sswsjkh","万圣节"];
         }
         if(this.transName(marr,[this._anti.hsqq,this._anti.h_sqq,"hsj"]) == 123)
         {
            return [this._anti.csqq,"橙色气球"];
         }
         if(this.transName(marr,[this._anti.hsqq,this._anti.lsqq,"hsj"]) == 123)
         {
            return [this._anti.zsqq,"紫色气球"];
         }
         if(this.transName(marr,[this._anti.lsqq,this._anti.h_sqq,"hsj"]) == 123)
         {
            return [this._anti.l_sqq,"绿色气球"];
         }
         if(this.transName(marr,[this._anti.csqq,this._anti.zsqq,this._anti.l_sqq]) == 123)
         {
            return [this._anti.fsqq,"粉色气球"];
         }
         if(this.transName(marr,["_sryxpt","_sryxpt","_sryxpt"]) == 123)
         {
            return ["_sryxyx","射日英雄"];
         }
         if(this.transName(marr,["_sryxyx","_sryxyx","_sryxyx"]) == 123)
         {
            return ["_sryxjl","射日英雄"];
         }
         if(this.transName(marr,["_sryxjl","_sryxjl","_sryxjl"]) == 123)
         {
            return ["_sryxss","射日英雄"];
         }
         if(this.transName(marr,["_lsyxpt","_lsyxpt","_lsyxpt"]) == 123)
         {
            return ["_lsyxyx","乱世英雄"];
         }
         if(this.transName(marr,["_lsyxyx","_lsyxyx","_lsyxyx"]) == 123)
         {
            return ["_lsyxjl","乱世英雄"];
         }
         if(this.transName(marr,["_lsyxjl","_lsyxjl","_lsyxjl"]) == 123)
         {
            return ["_lsyxss","乱世英雄"];
         }
         if(this.transName(marr,["_jsyxpt","_jsyxpt","_jsyxpt"]) == 123)
         {
            return ["_jsyxyx","救世英雄"];
         }
         if(this.transName(marr,["_jsyxyx","_jsyxyx","_jsyxyx"]) == 123)
         {
            return ["_jsyxjl","救世英雄"];
         }
         if(this.transName(marr,["_jsyxjl","_jsyxjl","_jsyxjl"]) == 123)
         {
            return ["_jsyxss","救世英雄"];
         }
         if(this.transName(marr,["_lsyxyx","xssp","xssp"]) == 123)
         {
            return ["_jsyxpt","救世英雄"];
         }
         if(this.transName(marr,["_lsyxjl","xssp","xssp"]) == 123)
         {
            return ["_jsyxyx","救世英雄"];
         }
         if(this.transName(marr,["_lsyxss","xssp","xssp"]) == 123)
         {
            return ["_jsyxjl","救世英雄"];
         }
         if(this.transName(marr,["kly1","kly1","kly1"]) == 123)
         {
            return ["kly2","2级昆仑玉"];
         }
         if(this.transName(marr,["kly2","kly2","kly2"]) == 123)
         {
            return ["kly3","3级昆仑玉"];
         }
         if(this.transName(marr,["kly3","kly3","kly3"]) == 123)
         {
            return ["kly4","4级昆仑玉"];
         }
         if(this.transName(marr,["xns1","xns1","xns1"]) == 123)
         {
            return ["xns2","2级仙女石"];
         }
         if(this.transName(marr,["xns2","xns2","xns2"]) == 123)
         {
            return ["xns3","3级仙女石"];
         }
         if(this.transName(marr,["xns3","xns3","xns3"]) == 123)
         {
            return ["xns4","4级仙女石"];
         }
         if(this.transName(marr,["yyzlj","ywhl","sxyg"]) == 123)
         {
            return ["wpfbyyin","爻阴"];
         }
         if(this.transName(marr,["zhyx","bjs","yyb"]) == 123)
         {
            return ["wpfbyyan","爻阳"];
         }
         if(this.transName(marr,["dkhl","hehua","kly3"]) == 123)
         {
            return ["wpfbtc","太初"];
         }
         if(this.transName(marr,["wpfbyyin","wpfbyyan","wpfbtc"]) == 123)
         {
            return ["tjbg","太极八卦"];
         }
         if(this.transName(marr,["lssp_1","lssp_2","lssp_3"]) == 123)
         {
            return ["lxfs_1","流邪符石1"];
         }
         if(this.transName(marr,["lssp_4","lssp_5","lssp_6"]) == 123)
         {
            return ["lxfs_2","流邪符石2"];
         }
         if(this.transName(marr,["lssp_7","lssp_8","lssp_9"]) == 123)
         {
            return ["lxfs_3","流邪符石3"];
         }
         if(this.transName(marr,["lxfs_1","lxfs_2","lxfs_3"]) == 123)
         {
            return ["lxfb","流邪"];
         }
         if(this.transName(marr,["lxfb","lxzhs","lxzhs"]) == 123)
         {
            return ["sxfb","沙邪"];
         }
         if(this.transName(marr,["sxfb","sxzhs","sxzhs"]) == 123)
         {
            return ["yxfb","渊邪"];
         }
         if(this.transName(marr,["_ptjsxstx","_ptjsxstx","_ptjsxstx"]) == 123)
         {
            return ["_yxjsxstx","救世星宿"];
         }
         if(this.transName(marr,["_yxjsxstx","_yxjsxstx","_yxjsxstx"]) == 123)
         {
            return ["_jljsxstx","救世星宿"];
         }
         if(this.transName(marr,["_jljsxstx","_jljsxstx","_jljsxstx"]) == 123)
         {
            return ["_ssjsxstx","救世星宿"];
         }
         if(this.transName(marr,["ptsrdg","ptsrdg","ptsrdg"]) == 123)
         {
            return ["yxsrdg","生日蛋糕"];
         }
         if(this.transName(marr,["yxsrdg","yxsrdg","yxsrdg"]) == 123)
         {
            return ["jlsrdg","生日蛋糕"];
         }
         if(this.transName(marr,["jlsrdg","jlsrdg","jlsrdg"]) == 123)
         {
            return ["sssrdg","生日蛋糕"];
         }
         return ["",""];
      }
      
      public function getSutraValue(_name:String, mater:Array) : MyEquipObj
      {
         var mhp:int = 0;
         var mmp:int = 0;
         var matk:int = 0;
         var mdef:int = 0;
         var myEquip:* = null;
         for(var mlen:uint = mater.length; mlen-- > 0; )
         {
            myEquip = mater[mlen];
            mhp += int(myEquip.getehp());
            mmp += int(myEquip.getemp());
            matk += int(myEquip.geteatt());
            mdef += int(myEquip.getedef());
         }
         trace("getSutraValue--------" + mhp + "," + mmp + "," + matk + "," + mdef);
         var temp:MyEquipObj = this.findByName(_name);
         if(!(temp.getFillName() == "" || temp.getFillName() == "wds"))
         {
            temp.setehp(int(mhp / 3));
            temp.setemp(int(mmp / 3));
            temp.seteatt(int(matk / 3));
            temp.setedef(int(mdef / 3));
         }
         return temp;
      }
      
      public function getSunValueEquip(_name:String, mater:Array) : MyEquipObj
      {
         var mhp:int = 0;
         var mmp:int = 0;
         var matk:int = 0;
         var mdef:int = 0;
         var mehp:int = 0;
         var memp:int = 0;
         var myEquip:* = null;
         var mcrit:Number = 0;
         var mmiss:Number = 0;
         var mmdef:Number = 0;
         for(var mlen:uint = mater.length; mlen-- > 0; )
         {
            myEquip = mater[mlen];
            if(myEquip.getehp() > 0)
            {
               mhp += int(myEquip.getehp());
            }
            if(myEquip.getemp() > 0)
            {
               mmp += int(myEquip.getemp());
            }
            if(myEquip.geteatt() > 0)
            {
               matk += int(myEquip.geteatt());
            }
            if(myEquip.getedef() > 0)
            {
               mdef += int(myEquip.getedef());
            }
            if(myEquip.getecrit() > 0)
            {
               mcrit += Number(myEquip.getecrit());
            }
            if(myEquip.getemiss() > 0)
            {
               mmiss += Number(myEquip.getemiss());
            }
            if(myEquip.geteahp() > 0)
            {
               mehp += int(myEquip.geteahp());
            }
            if(myEquip.geteamp() > 0)
            {
               memp += int(myEquip.geteamp());
            }
            if(myEquip.getmagicdef() > 0)
            {
               mmdef += Number(myEquip.getmagicdef());
            }
         }
         var temp:MyEquipObj = this.findByName(_name);
         temp.setehp(int(mhp));
         temp.setemp(int(mmp));
         temp.seteatt(int(matk));
         temp.setedef(int(mdef));
         temp.setecrit(Number(mcrit));
         temp.setemiss(Number(mmiss));
         temp.seteahp(int(mehp));
         temp.seteamp(int(memp));
         temp.setmagicdef(Number(mmdef));
         return temp;
      }
      
      public function getEupdataSunSutraValueEquip(_name:String, mater:Array) : MyEquipObj
      {
         var sEquip:* = null;
         var eupdata:Number = 0;
         for(var mlen:uint = mater.length; mlen-- > 0; )
         {
            sEquip = mater[mlen];
            if(sEquip.getEUpdata() > 0)
            {
               eupdata += sEquip.getEUpdata();
            }
         }
         var temp:MyEquipObj = this.findByName(_name);
         eupdata /= 3;
         if(_name == "tjbg")
         {
            eupdata += RandomControllor.getIns().getRandom() * this._anti.zero_point_8;
         }
         eupdata = Number(eupdata.toFixed(1));
         if(eupdata > 3)
         {
            eupdata = 3;
         }
         temp.setEupdata(eupdata);
         return temp;
      }
      
      public function getSunSutraValueEquip(_name:String, mater:Array, pjbool:Boolean = true) : MyEquipObj
      {
         var mhp:int = 0;
         var mmp:int = 0;
         var matk:int = 0;
         var mdef:int = 0;
         var mehp:int = 0;
         var memp:int = 0;
         var myEquip:* = null;
         var mcrit:Number = 0;
         var mmiss:Number = 0;
         var mmdef:Number = 0;
         var meupdata:Number = 0;
         for(var mlen:uint = mater.length; mlen-- > 0; )
         {
            myEquip = mater[mlen];
            if(myEquip.getehp() > 0)
            {
               mhp += int(myEquip.getehp());
            }
            if(myEquip.getemp() > 0)
            {
               mmp += int(myEquip.getemp());
            }
            if(myEquip.geteatt() > 0)
            {
               matk += int(myEquip.geteatt());
            }
            if(myEquip.getedef() > 0)
            {
               mdef += int(myEquip.getedef());
            }
            if(myEquip.getecrit() > 0)
            {
               mcrit += Number(myEquip.getecrit());
            }
            if(myEquip.getemiss() > 0)
            {
               mmiss += Number(myEquip.getemiss());
            }
            if(myEquip.geteahp() > 0)
            {
               mehp += int(myEquip.geteahp());
            }
            if(myEquip.geteamp() > 0)
            {
               memp += int(myEquip.geteamp());
            }
            if(myEquip.getmagicdef() > 0)
            {
               mmdef += Number(myEquip.getmagicdef());
            }
            if(myEquip.getEUpdata() > 0)
            {
               meupdata += myEquip.getEUpdata();
            }
         }
         var temp:MyEquipObj = this.findByName(_name);
         temp.setehp(int(mhp));
         temp.setemp(int(mmp));
         temp.seteatt(int(matk));
         temp.setedef(int(mdef));
         if(pjbool)
         {
            temp.setecrit(Number((mcrit / 2).toFixed(2)));
            temp.setemiss(Number((mmiss / 2).toFixed(2)));
            temp.setmagicdef(Number((mmdef / 2).toFixed(2)));
         }
         else
         {
            temp.setecrit(Number(mcrit.toFixed(2)));
            temp.setemiss(Number(mmiss.toFixed(2)));
            temp.setmagicdef(Number(mmdef.toFixed(2)));
         }
         temp.seteahp(int(mehp));
         temp.seteamp(int(memp));
         temp.setEupdata(Number(meupdata.toFixed(2)));
         return temp;
      }
      
      private function transName(namearray:Array, standardArr:Array) : uint
      {
         var sit:int = -1;
         var i:uint = 0;
         while(i < namearray.length)
         {
            if((sit = standardArr.indexOf(namearray[i])) != -1)
            {
               standardArr.splice(sit,1);
            }
            i++;
         }
         if(standardArr.length == 0)
         {
            return 123;
         }
         namearray = null;
         standardArr = null;
         return 321;
      }
      
      public function findResolution(resequip:MyEquipObj) : Array
      {
         var randEquip:* = null;
         var temp:* = null;
         var resAry:Array = [];
         var normalnum:int = 0;
         var specialnum:int = 0;
         if(resequip.quality == "普 通")
         {
            normalnum = 1;
         }
         else if(resequip.quality == "优 秀")
         {
            normalnum = 2;
            specialnum = 1;
         }
         else if(resequip.quality == "精 良")
         {
            normalnum = 3;
            specialnum = 2;
         }
         else if(resequip.quality == "史 诗")
         {
            normalnum = 4;
            specialnum = 2;
         }
         else if(resequip.quality == "邪 灵")
         {
            normalnum = 4;
            specialnum = 2;
         }
         else if(resequip.quality == "魂 器")
         {
            normalnum = 0;
            specialnum = 4;
         }
         else if(resequip.quality == "传 说")
         {
            normalnum = 0;
            specialnum = 6;
         }
         while(normalnum-- > 0)
         {
            if(resequip.type == "zbwq" || resequip.type == "zbsp")
            {
               if(RandomControllor.getIns().getRandom() >= this._anti.zero_point_5)
               {
                  randEquip = wpEquip19;
               }
               else
               {
                  randEquip = wpEquip20;
               }
            }
            else if(resequip.user == "悟空")
            {
               if(RandomControllor.getIns().getRandom() >= this._anti.zero_point_5)
               {
                  randEquip = wpEquip19;
               }
               else
               {
                  randEquip = wpEquip18;
               }
            }
            else if(resequip.user == "唐僧" || resequip.user == "沙僧")
            {
               randEquip = wpEquip18;
            }
            else if(resequip.user == "八戒")
            {
               randEquip = wpEquip19;
            }
            resAry.push(randEquip);
            randEquip = null;
         }
         if(resequip.getFillName() == "shsjt")
         {
            specialnum--;
            resAry.push(wpEquip117);
         }
         while(specialnum-- > 0)
         {
            if(RandomControllor.getIns().getRandom() < this._anti.zero_point_3 * specialnum)
            {
               if(resequip.getFillName() == "shsjt")
               {
                  if(resAry.indexOf(wpEquip117) != -1)
                  {
                     temp = this.randomOneLevelOneGem();
                  }
               }
               else
               {
                  temp = this.randomOneLevelOneGem();
               }
               randEquip = temp;
               temp = null;
               resAry.push(randEquip);
            }
            randEquip = null;
         }
         return resAry;
      }
      
      private function randomOneLevelOneGem() : MyEquipObj
      {
         var r:uint = 1 + Math.round(RandomControllor.getIns().getRandom() * 3);
         if(r == 1)
         {
            return wpEquip6;
         }
         if(r == 2)
         {
            return wpEquip9;
         }
         if(r == 3)
         {
            return wpEquip12;
         }
         return wpEquip15;
      }
      
      public function findNeedMaterialByName(fillname:String) : Array
      {
         var matAry:Array = [];
         switch(fillname)
         {
            case "whgzzs":
               matAry.push({
                  "equip":this.wpEquip20,
                  "count":this._anti.twenty
               });
               break;
            case "jmczzs":
               matAry.push({
                  "equip":this.wpEquip20,
                  "count":10
               },{
                  "equip":this.wpEquip19,
                  "count":10
               });
               break;
            case "bspzzs":
               matAry.push({
                  "equip":this.wpEquip18,
                  "count":this._anti.twenty
               });
               break;
            case "dtkzzs":
               matAry.push({
                  "equip":this.wpEquip19,
                  "count":this._anti.twenty
               });
               break;
            case "wtpzzs":
               matAry.push({
                  "equip":this.wpEquip20,
                  "count":this._anti.twenty
               },{
                  "equip":this.wpEquip19,
                  "count":this._anti.twenty
               });
               break;
            case "yhjzzs":
               matAry.push({
                  "equip":this.wpEquip18,
                  "count":this._anti.twenty
               },{
                  "equip":this.wpEquip19,
                  "count":this._anti.twenty
               });
               break;
            case "jmyzzs":
               matAry.push({
                  "equip":this.wpEquip18,
                  "count":this._anti.fourty
               });
               break;
            case "tfljzzs":
               matAry.push({
                  "equip":this.wpEquip18,
                  "count":this._anti.twenty
               },{
                  "equip":this.wpEquip19,
                  "count":this._anti.twenty
               });
               break;
            case "mgzhzzs":
               matAry.push({
                  "equip":this.wpEquip20,
                  "count":this._anti.twenty
               },{
                  "equip":this.wpEquip19,
                  "count":this._anti.fourty
               });
               break;
            case "hljhzzs":
               matAry.push({
                  "equip":this.wpEquip18,
                  "count":this._anti.eighty
               });
               break;
            case "wsjgzzs":
               matAry.push({
                  "equip":this.wpEquip19,
                  "count":this._anti.eighty
               });
               break;
            case "ydjgzzs":
               matAry.push({
                  "equip":this.wpEquip20,
                  "count":this._anti.fourty
               },{
                  "equip":this.wpEquip19,
                  "count":this._anti.fourty
               });
               break;
            case "tdlzjzzs":
               matAry.push({
                  "equip":this.wpEquip20,
                  "count":this._anti.fourty
               },{
                  "equip":this.wpEquip19,
                  "count":this._anti.eighty
               });
               break;
            case "xleyzzs":
               matAry.push({
                  "equip":this.wpEquip18,
                  "count":this._anti.eighty
               },{
                  "equip":this.wpEquip19,
                  "count":this._anti.eighty
               });
               break;
            case "xlczzzs":
               matAry.push({
                  "equip":this.wpEquip18,
                  "count":this._anti.one_hundred_sixty
               });
               break;
            case "xlryzzs":
               matAry.push({
                  "equip":this.wpEquip19,
                  "count":this._anti.one_hundred_sixty
               });
               break;
            case "xlyjzzs":
               matAry.push({
                  "equip":this.wpEquip18,
                  "count":this._anti.one_hundred_sixty
               });
               break;
            case "xlthzzs":
               matAry.push({
                  "equip":this.wpEquip20,
                  "count":this._anti.eighty
               },{
                  "equip":this.wpEquip19,
                  "count":this._anti.eighty
               });
               break;
            case "xltczzs":
               matAry.push({
                  "equip":this.wpEquip20,
                  "count":this._anti.one_hundred_sixty
               });
               break;
            case "xltzzzs":
               matAry.push({
                  "equip":this.wpEquip19,
                  "count":this._anti.one_hundred_sixty
               });
               break;
            case "xltszzs":
               matAry.push({
                  "equip":this.wpEquip20,
                  "count":this._anti.eighty
               },{
                  "equip":this.wpEquip19,
                  "count":this._anti.eighty
               });
               break;
            case "llyzzs":
               matAry.push({
                  "equip":this.wpEquip71,
                  "count":5
               },{
                  "equip":this.wpEquip72,
                  "count":5
               });
               break;
            case "jlqrzrzzs":
               matAry.push({
                  "equip":this.wpEquip19,
                  "count":this._anti.twenty
               },{
                  "equip":this.wpEquip20,
                  "count":this._anti.twenty
               });
               break;
            case "jlqrmjzzs":
               matAry.push({
                  "equip":this.wpEquip19,
                  "count":this._anti.twenty
               },{
                  "equip":this.wpEquip20,
                  "count":this._anti.twenty
               });
               break;
            case "jlqrcszzs":
               matAry.push({
                  "equip":this.wpEquip19,
                  "count":this._anti.twenty
               },{
                  "equip":this.wpEquip20,
                  "count":this._anti.twenty
               });
               break;
            case "jlqrhdzzs":
               matAry.push({
                  "equip":this.wpEquip19,
                  "count":this._anti.twenty
               },{
                  "equip":this.wpEquip20,
                  "count":this._anti.twenty
               });
               break;
            case "ssqrzrzzs":
               matAry.push({
                  "equip":this.wpEquip19,
                  "count":this._anti.fourty
               },{
                  "equip":this.wpEquip20,
                  "count":this._anti.fourty
               });
               break;
            case "ssqrmjzzs":
               matAry.push({
                  "equip":this.wpEquip19,
                  "count":this._anti.fourty
               },{
                  "equip":this.wpEquip20,
                  "count":this._anti.fourty
               });
               break;
            case "ssqrcszzs":
               matAry.push({
                  "equip":this.wpEquip19,
                  "count":this._anti.fourty
               },{
                  "equip":this.wpEquip20,
                  "count":this._anti.fourty
               });
               break;
            case "ssqrhdzzs":
               matAry.push({
                  "equip":this.wpEquip19,
                  "count":this._anti.fourty
               },{
                  "equip":this.wpEquip20,
                  "count":this._anti.fourty
               });
               break;
            case "cs_wq_qs_zzs":
               matAry.push({
                  "equip":this.wpEquip72,
                  "count":this._anti.ten
               },{
                  "equip":this.wpEquip19,
                  "count":this._anti.three_hundred_twenty
               });
               break;
            case "cs_wq_rc_zzs":
               matAry.push({
                  "equip":this.wpEquip71,
                  "count":this._anti.ten
               },{
                  "equip":this.wpEquip19,
                  "count":this._anti.three_hundred_twenty
               });
               break;
            case "cs_wq_yt_zzs":
               matAry.push({
                  "equip":this.wpEquip71,
                  "count":this._anti.ten
               },{
                  "equip":this.wpEquip19,
                  "count":this._anti.three_hundred_twenty
               });
               break;
            case "cs_wq_ll_zzs":
               matAry.push({
                  "equip":this.wpEquip72,
                  "count":this._anti.ten
               },{
                  "equip":this.wpEquip19,
                  "count":this._anti.three_hundred_twenty
               });
               break;
            case "cs_fj_dz_zzs":
               matAry.push({
                  "equip":this.wpEquip71,
                  "count":this._anti.ten
               },{
                  "equip":this.wpEquip19,
                  "count":this._anti.three_hundred_twenty
               });
               break;
            case "cs_fj_zt_zzs":
               matAry.push({
                  "equip":this.wpEquip72,
                  "count":this._anti.ten
               },{
                  "equip":this.wpEquip19,
                  "count":this._anti.three_hundred_twenty
               });
               break;
            case "cs_fj_jt_zzs":
               matAry.push({
                  "equip":this.wpEquip72,
                  "count":this._anti.ten
               },{
                  "equip":this.wpEquip19,
                  "count":this._anti.three_hundred_twenty
               });
               break;
            case "cs_fj_js_zzs":
               matAry.push({
                  "equip":this.wpEquip71,
                  "count":this._anti.ten
               },{
                  "equip":this.wpEquip19,
                  "count":this._anti.three_hundred_twenty
               });
               break;
            case "zhhzzzs":
               matAry.push({
                  "equip":this.wpEquip19,
                  "count":_anti.jiubaijiushijiu
               },{
                  "equip":this.wpEquip139,
                  "count":this._anti.five
               });
               break;
            case "phhlzzs":
               matAry.push({
                  "equip":this.wpEquip19,
                  "count":_anti.jiubaijiushijiu
               },{
                  "equip":this.wpEquip139,
                  "count":this._anti.five
               });
               break;
            case "bxhyzzs":
               matAry.push({
                  "equip":this.wpEquip19,
                  "count":_anti.jiubaijiushijiu
               },{
                  "equip":this.wpEquip139,
                  "count":this._anti.five
               });
         }
         return matAry;
      }
      
      public function refreshSutraAttribute(sutra:MyEquipObj) : void
      {
         var rand:int = 0;
         var i:* = 0;
         var sourceEupData:Number = sutra.getEUpdata();
         var obj:Object = sutra.getGrowthByName(sutra.getFillName());
         sutra.growthDown(obj);
         if(sourceEupData < 2.5)
         {
            rand = Math.ceil(RandomControllor.getIns().getRandom() * 3);
            if(RandomControllor.getIns().getRandom() <= this._anti.zero_point_5)
            {
               rand *= -1;
            }
            sourceEupData += Number((rand / 10).toFixed(1));
            if(sourceEupData > 2.5)
            {
               sourceEupData = 2.5;
            }
            else if(sourceEupData < this._anti.zero_point_8)
            {
               sourceEupData = this._anti.zero_point_8;
            }
         }
         sutra.setEupdata(sourceEupData);
         sutra.setWX(this.initRondomPro());
         for(i = uint(1); i < sutra.getELevel(); )
         {
            sutra.growth(obj,false);
            i++;
         }
      }
      
      public function isTheSameEquipmentByFillName(findEquip:MyEquipObj) : Boolean
      {
         var equip:MyEquipObj = this.findByName(findEquip.getFillName());
         if(equip.showid == findEquip.showid)
         {
            if(equip.ename == findEquip.ename)
            {
               if(equip.type == findEquip.type)
               {
                  if(equip.user == findEquip.user)
                  {
                     return true;
                  }
                  return false;
               }
            }
         }
         return false;
      }
      
      public function findSellPrice(_name:String) : Number
      {
         var price:int = 0;
         switch(_name)
         {
            case "wpqhs1":
               price = _anti.ershijiu;
               break;
            case "wpqhs2":
               price = _anti.qishijiu;
               break;
            case "gjs2":
               price = _anti.bashijiu;
               break;
            case "sms2":
               price = _anti.liushijiu;
               break;
            case "fys2":
               price = _anti.sanshijiu;
               break;
            case "mfs2":
               price = _anti.sishijiu;
               break;
            case "wpqhs3":
               price = _anti.erbaiershijiu;
               break;
            case "sms3":
               price = _anti.yibaijiushijiu;
               break;
            case "gjs3":
               price = _anti.erbaiwushijiu;
               break;
            case "mfs3":
               price = _anti.yibaiershijiu;
               break;
            case "fys3":
               price = _anti.yibailingjiu;
               break;
            case "wpqhs4":
               price = _anti.liubaiqishijiu;
               break;
            case "wpxyf":
               price = _anti.erbaijiushijiu;
               break;
            case "wptlz":
               price = _anti.erbaiqishijiu;
               break;
            case "wpllz":
               price = _anti.erbaibashijiu;
               break;
            case "wphlz":
               price = _anti.sanbailingjiu;
               break;
            case "wpflz":
               price = _anti.sanbaiyishijiu;
               break;
            case "wpslz":
               price = _anti.sanbaiershijiu;
               break;
            case "wpbdf":
               price = _anti.sibaibashijiu;
               break;
            case "mpyj":
               price = _anti.sibaiqishijiu;
               break;
            case "ptnmwsz":
               price = _anti.sibaijiushijiu;
               break;
            case "ptttzssz":
               price = _anti.liubailingjiu;
               break;
            case "wphhd":
               price = _anti.yibaiyishijiu;
               break;
            case "wpcsd":
               price = _anti.yibaiqishijiu;
               break;
            case "ptzlwsz":
               price = _anti.wubaijiushijiu;
               break;
            case "css12":
               price = _anti.jiushijiu;
               break;
            case "css18":
               price = _anti.yibaibashijiu;
               break;
            case "sbjyd":
               price = _anti.sanbaisanshijiu;
               break;
            case "jyys":
               price = _anti.yibaisanshijiu;
               break;
            case "css_2":
               price = _anti.yibaisishijiu;
               break;
            case "cwzzxld":
               price = _anti.yibailiushijiu;
               break;
            case "cwjnxld":
               price = _anti.yibaiwushijiu;
               break;
            case "jyd3":
               price = _anti.liubailiushijiu;
               break;
            case "djyys":
               price = _anti.jiubaijiushijiu;
               break;
            case "lhys":
               price = _anti.shijiu;
               break;
            case "bmd":
               price = _anti.sanbaisishijiu;
               break;
            case "yp":
               price = _anti.sanbailiushijiu;
               break;
            case "ml":
               price = _anti.sanbaibashijiu;
               break;
            case "gz":
               price = _anti.sanbaiwushijiu;
               break;
            case "sz":
               price = _anti.sanbaiqishijiu;
               break;
            case "zz":
               price = _anti.sanbaijiushijiu;
               break;
            case "jbc":
               price = _anti.sibailinjiu;
               break;
            case "szj":
               price = _anti.sibaiyishijiu;
               break;
            case "kly3":
               price = _anti.wubaiershijiu;
               break;
            case "xns1":
               price = _anti.baishijiu;
               break;
            case "wpsh_1":
               price = _anti.five_hundred_fifty_night;
               break;
            case "wpsh_2":
               price = _anti.eight_hundred_fifty_night;
               break;
            case "wpst_3":
               price = _anti.one_thousand_fifth_night;
               break;
            case "nianjhdd":
               price = _anti.jiubaijiushijiu;
               break;
            case "xnhdl":
               price = _anti.jiushijiu;
               break;
            case "wpst_4":
               price = _anti.yisiwujiu;
               break;
            case "wpst_5":
               price = _anti.yiqiwujiu;
               break;
            case "hmzjns3":
               price = _anti.yisijiujiu;
               break;
            case "hyjjjns3":
               price = _anti.yisanjiujiu;
               break;
            case "smbjns3":
               price = _anti.yisijiujiu;
               break;
            case "jhsjjns3":
               price = _anti.yisanjiujiu;
               break;
            case "tmcjns3":
               price = _anti.yisijiujiu;
               break;
            case "syzqjns3":
               price = _anti.yisanjiujiu;
               break;
            case "mmwjns3":
               price = _anti.yisijiujiu;
               break;
            case "mdsjns3":
               price = _anti.yisanjiujiu;
               break;
            case "lxzhs":
               price = _anti.sibaiershijiu;
               break;
            case "sxzhs":
               price = _anti.sibaisanshijiu;
               break;
            case "ptzqsz":
               price = _anti.liubailingjiu;
               break;
            case "cdjyys":
               price = _anti.sanqianbajiujiu;
               break;
            case "dlhys":
               price = _anti.sanbai;
               break;
            case "_ssggjtg":
               price = _anti.jiubaijiu;
               break;
            default:
               price = _anti.two_thousand_zero_night;
         }
         return price + RandomControllor.getIns().getRandom() / this._anti.one_thousand;
      }
   }
}
