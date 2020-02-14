import MySQLdb
import subprocess

item_type = {
	0: "ITEM_NONE",
	1: "ITEM_WEAPON",
	2: "ITEM_ARMOR",
	3: "ITEM_USE",
	4: "ITEM_AUTOUSE",
	5: "ITEM_MATERIAL",
	6: "ITEM_SPECIAL",
	7: "ITEM_TOOL",
	8: "ITEM_LOTTERY",
	9: "ITEM_ELK",
	10: "ITEM_METIN",
	11: "ITEM_CONTAINER",
	12: "ITEM_FISH",
	13: "ITEM_ROD",
	14: "ITEM_RESOURCE",
	15: "ITEM_CAMPFIRE",
	16: "ITEM_UNIQUE",
	17: "ITEM_SKILLBOOK",
	18: "ITEM_QUEST",
	19: "ITEM_POLYMORPH",
	20: "ITEM_TREASURE_BOX",
	21: "ITEM_TREASURE_KEY",
	22: "ITEM_SKILLFORGET",
	23: "ITEM_GIFTBOX",
	24: "ITEM_PICK",
	25: "ITEM_HAIR",
	26: "ITEM_TOTEM",
	27: "ITEM_BLEND",
	28: "ITEM_COSTUME",
	29: "ITEM_DS",
	30: "ITEM_SPECIAL_DS",
	31: "ITEM_EXTRACT",
	32: "ITEM_SECONDARY_COIN",
	33: "ITEM_RING",
	34: "ITEM_BELT",
}

item_subtype = {
	1: {
		0: "WEAPON_SWORD",
		1: "WEAPON_DAGGER",
		2: "WEAPON_BOW",
		3: "WEAPON_TWO_HANDED",
		4: "WEAPON_BELL",
		5: "WEAPON_FAN",
		6: "WEAPON_ARROW",
		7: "WEAPON_MOUNT_SPEAR",
	},
	2: {
		0: "ARMOR_BODY",
		1: "ARMOR_HEAD",
		2: "ARMOR_SHIELD",
		3: "ARMOR_WRIST",
		4: "ARMOR_FOOTS",
		5: "ARMOR_NECK",
		6: "ARMOR_EAR",
		7: "ARMOR_NUM_TYPES",
	},
	3 : {
		0: "USE_POTION",
		1: "USE_TALISMAN",
		2: "USE_TUNING",
		3: "USE_MOVE",
		4: "USE_TREASURE_BOX",
		5: "USE_MONEYBAG",
		6: "USE_BAIT",
		7: "USE_ABILITY_UP",
		8: "USE_AFFECT",
		9: "USE_CREATE_STONE",
		10: "USE_SPECIAL",
		11: "USE_POTION_NODELAY",
		12: "USE_CLEAR",
		13: "USE_INVISIBILITY",
		14: "USE_DETACHMENT",
		15: "USE_BUCKET",
		16: "USE_POTION_CONTINUE",
		17: "USE_CLEAN_SOCKET",
		18: "USE_CHANGE_ATTRIBUTE",
		19: "USE_ADD_ATTRIBUTE",
		20: "USE_ADD_ACCESSORY_SOCKET",
		21: "USE_PUT_INTO_ACCESSORY_SOCKET",
		22: "USE_ADD_ATTRIBUTE2",
		23: "USE_RECIPE",
		24: "USE_CHANGE_ATTRIBUTE2",
		25: "USE_BIND",
		26: "USE_UNBIND",
		27: "USE_TIME_CHARGE_PER",
		28: "USE_TIME_CHARGE_FIX",
		29: "USE_PUT_INTO_BELT_SOCKET",
		30: "USE_PUT_INTO_RING_SOCKET",
		31: "USE_INVULNERABILITY",
	},
	4: {
		0: "AUTOUSE_POTION",
		1: "AUTOUSE_ABILITY_UP",
		2: "AUTOUSE_BOMB",
		3: "AUTOUSE_GOLD",
		4: "AUTOUSE_MONEYBAG",
		5: "AUTOUSE_TREASURE_BOX",
	},
	5: {
		0: "MATERIAL_LEATHER",
		1: "MATERIAL_BLOOD",
		2: "MATERIAL_ROOT",
		3: "MATERIAL_NEEDLE",
		4: "MATERIAL_JEWEL",
		5: "MATERIAL_DS_REFINE_NORMAL",
		6: "MATERIAL_DS_REFINE_BLESSED",
		7: "MATERIAL_DS_REFINE_HOLLY",
	},
	6: {
		0: "SPECIAL_MAP",
		1: "SPECIAL_KEY",
		2: "SPECIAL_DOC",
		3: "SPECIAL_SPIRIT",
	},
	7: {
		0 : "TOOL_FISHING_ROD",
	},
	8: {
		0: "LOTTERY_TICKET",
		1: "LOTTERY_INSTANT",
	},
	10: {
		0: "METIN_NORMAL",
		1: "METIN_GOLD",
	},
	12: {
		0: "FISH_ALIVE",
		1: "FISH_DEAD",
	},
	14: {
		0: "RESOURCE_FISHBONE",
		1: "RESOURCE_WATERSTONEPIECE",
		2: "RESOURCE_WATERSTONE",
		3: "RESOURCE_BLOOD_PEARL",
		4: "RESOURCE_BLUE_PEARL",
		5: "RESOURCE_WHITE_PEARL",
		6: "RESOURCE_BUCKET",
		7: "RESOURCE_CRYSTAL",
		8: "RESOURCE_GEM",
		9: "RESOURCE_STONE",
		10: "RESOURCE_METIN",
		11: "RESOURCE_ORE",
	},
	16: {
		0: "UNIQUE_NONE",
		1: "UNIQUE_BOOK",
		2: "UNIQUE_SPECIAL_RIDE",
		3: "UNIQUE_3",
		4: "UNIQUE_4",
		5: "UNIQUE_5",
		6: "UNIQUE_6",
		7: "UNIQUE_7",
		8: "UNIQUE_8",
		9: "UNIQUE_9",
		10: "USE_SPECIAL",
	},
	28: {
		0: "COSTUME_BODY",
		1: "COSTUME_HAIR",
		2: "COSTUME_ACCE",
		3: "NONE",
		4: "NONE",
		5: "NONE",
		6: "NONE",
		7: "NONE",
		8: "NONE",
		9: "COSTUME_WEAPON_SWORD",
		10: "COSTUME_WEAPON_DAGGER",
		11: "COSTUME_WEAPON_BOW",
		12: "COSTUME_WEAPON_TWO_HANDED",
		13: "COSTUME_WEAPON_BELL",
		14: "COSTUME_WEAPON_FAN",
		15: "COSTUME_WEAPON_CLAW"
	},
	29: {
		0: "DS_SLOT1",
		1: "DS_SLOT2",
		2: "DS_SLOT3",
		3: "DS_SLOT4",
		4: "DS_SLOT5",
		5: "DS_SLOT6",
	},
	31: {
		0: "EXTRACT_DRAGON_SOUL",
		1: "EXTRACT_DRAGON_HEART",
	},
}

wearflag = {
	0: "NONE",
	1: "WEAR_BODY",
	2: "WEAR_HEAD",
	4: "WEAR_FOOTS",
	8: "WEAR_WRIST",
	16: "WEAR_WEAPON",
	32: "WEAR_NECK",
	64: "WEAR_EAR",
	128: "WEAR_SHIELD",
	256: "WEAR_UNIQUE",
	512: "WEAR_ARROW",
	1024: "WEAR_HAIR",
	2048: "WEAR_ABILITY",
	4096: "WEAR_COSTUME_BODY",
	8192: "WEAR_COSTUME_HAIR",
	16384: "WEAR_COSTUME_ACCE",
	32768: "WEAR_RING1",
	65536: "WEAR_RING2",
	131072: "WEAR_BELT",
	262144: "WEAR_COSTUME_MOUNT",
}

limittype = {
	0: "LIMIT_NONE",
	1: "LEVEL",
	2: "STR",
	3: "DEX",
	4: "INT",
	5: "CON",
	6: "PC_BANG",
	7: "REAL_TIME",
	8: "REAL_TIME_FIRST_USE",
	9: "TIMER_BASED_ON_WEAR",
	10: "ACTIVE_COOLDOWN_ITEM",
}

bonus = {
	0: "APPLY_NONE",
	1: "APPLY_MAX_HP",
	2: "APPLY_MAX_SP",
	3: "APPLY_CON",
	4: "APPLY_INT",
	5: "APPLY_STR",
	6: "APPLY_DEX",
	7: "APPLY_ATT_SPEED",
	8: "APPLY_MOV_SPEED",
	9: "APPLY_CAST_SPEED",
	10: "APPLY_HP_REGEN",
	11: "APPLY_SP_REGEN",
	12: "APPLY_POISON_PCT",
	13: "APPLY_STUN_PCT",
	14: "APPLY_SLOW_PCT",
	15: "APPLY_CRITICAL_PCT",
	16: "APPLY_PENETRATE_PCT",
	17: "APPLY_ATTBONUS_HUMAN",
	18: "APPLY_ATTBONUS_ANIMAL",
	19: "APPLY_ATTBONUS_ORC",
	20: "APPLY_ATTBONUS_MILGYO",
	21: "APPLY_ATTBONUS_UNDEAD",
	22: "APPLY_ATTBONUS_DEVIL",
	23: "APPLY_STEAL_HP",
	24: "APPLY_STEAL_SP",
	25: "APPLY_MANA_BURN_PCT",
	26: "APPLY_DAMAGE_SP_RECOVER",
	27: "APPLY_BLOCK",
	28: "APPLY_DODGE",
	29: "APPLY_RESIST_SWORD",
	30: "APPLY_RESIST_TWOHAND",
	31: "APPLY_RESIST_DAGGER",
	32: "APPLY_RESIST_BELL",
	33: "APPLY_RESIST_FAN",
	34: "APPLY_RESIST_BOW",
	35: "APPLY_RESIST_FIRE",
	36: "APPLY_RESIST_ELEC",
	37: "APPLY_RESIST_MAGIC",
	38: "APPLY_RESIST_WIND",
	39: "APPLY_REFLECT_MELEE",
	40: "APPLY_REFLECT_CURSE",
	41: "APPLY_POISON_REDUCE",
	42: "APPLY_KILL_SP_RECOVER",
	43: "APPLY_EXP_DOUBLE_BONUS",
	44: "APPLY_GOLD_DOUBLE_BONUS",
	45: "APPLY_ITEM_DROP_BONUS",
	46: "APPLY_POTION_BONUS",
	47: "APPLY_KILL_HP_RECOVER",
	48: "APPLY_IMMUNE_STUN",
	49: "APPLY_IMMUNE_SLOW",
	50: "APPLY_IMMUNE_FALL",
	51: "APPLY_SKILL",
	52: "APPLY_BOW_DISTANCE",
	53: "APPLY_ATT_GRADE_BONUS",
	54: "APPLY_DEF_GRADE_BONUS",
	55: "APPLY_MAGIC_ATT_GRADE",
	56: "APPLY_MAGIC_DEF_GRADE",
	57: "APPLY_CURSE_PCT",
	58: "APPLY_MAX_STAMINA",
	59: "APPLY_ATTBONUS_WARRIOR",
	60: "APPLY_ATTBONUS_ASSASSIN",
	61: "APPLY_ATTBONUS_SURA",
	62: "APPLY_ATTBONUS_SHAMAN",
	63: "APPLY_ATTBONUS_MONSTER",
	64: "APPLY_MALL_ATTBONUS",
	65: "APPLY_MALL_DEFBONUS",
	66: "APPLY_MALL_EXPBONUS",
	67: "APPLY_MALL_ITEMBONUS",
	68: "APPLY_MALL_GOLDBONUS",
	69: "APPLY_MAX_HP_PCT",
	70: "APPLY_MAX_SP_PCT",
	71: "APPLY_SKILL_DAMAGE_BONUS",
	72: "APPLY_NORMAL_HIT_DAMAGE_BONUS",
	73: "APPLY_SKILL_DEFEND_BONUS",
	74: "APPLY_NORMAL_HIT_DEFEND_BONUS",
	75: "APPLY_PC_BANG_EXP_BONUS",
	76: "APPLY_PC_BANG_DROP_BONUS",
	77: "APPLY_EXTRACT_HP_PCT",
	78: "APPLY_RESIST_WARRIOR",
	79: "APPLY_RESIST_ASSASSIN",
	80: "APPLY_RESIST_SURA",
	81: "APPLY_RESIST_SHAMAN",
	82: "APPLY_ENERGY",
	83: "APPLY_DEF_GRADE",
	84: "APPLY_COSTUME_ATTR_BONUS",
	85: "APPLY_MAGIC_ATTBONUS_PER",
	86: "APPLY_MELEE_MAGIC_ATTBONUS_PER",
	87: "APPLY_RESIST_ICE",
	88: "APPLY_RESIST_EARTH",
	89: "APPLY_RESIST_DARK",
	90: "APPLY_ANTI_CRITICAL_PCT",
	91: "APPLY_ANTI_PENETRATE_PCT",
	92: "APPLY_TENACITY"
}

immuneflag = {
	1: "PARA",
	2: "CURSE",
	3: "STUN",
	4: "SLEEP",
	5: "SLOW",
	6: "POISON",
	7: "TERROR",
}

addon_type = {
	180,
	181,
	182,
	183,
	184,
	185,
	186,
	187,
	188,
	189,
	190,
	191,
	192,
	193,
	194,
	195,
	196,
	197,
	198,
	199,
	290,
	291,
	292,
	293,
	294,
	295,
	296,
	297,
	298,
	299,
	1130,
	1131,
	1132,
	1133,
	1134,
	1135,
	1136,
	1137,
	1138,
	1139,
	1170,
	1171,
	1172,
	1173,
	1174,
	1175,
	1176,
	1177,
	1178,
	1179,
	2150,
	2151,
	2152,
	2153,
	2154,
	2155,
	2156,
	2157,
	2158,
	2159,
	2170,
	2171,
	2172,
	2173,
	2174,
	2175,
	2176,
	2177,
	2178,
	2179,
	3160,
	3161,
	3162,
	3163,
	3164,
	3165,
	3166,
	3167,
	3168,
	3169,
	3210,
	3211,
	3212,
	3213,
	3214,
	3215,
	3216,
	3217,
	3218,
	3219,
	5110,
	5111,
	5112,
	5113,
	5114,
	5115,
	5116,
	5117,
	5118,
	5119,
	5120,
	5121,
	5122,
	5123,
	5124,
	5125,
	5126,
	5127,
	5128,
	5129,
	7160,
	7161,
	7162,
	7163,
	7164,
	7165,
	7166,
	7167,
	7168,
	7169,
	65159,
	350,
	351,
	352,
	353,
	354,
	355,
	356,
	357,
	358,
	359,
	360,
	361,
	362,
	363,
	364,
	365,
	366,
	367,
	368,
	369,
	1300,
	1301,
	1302,
	1303,
	1304,
	1305,
	1306,
	1307,
	1308,
	1309,
	2340,
	2341,
	2342,
	2343,
	2344,
	2345,
	2346,
	2347,
	2348,
	2349,
	3330,
	3331,
	3332,
	3333,
	3334,
	3335,
	3336,
	3337,
	3338,
	3339,
	5290,
	5291,
	5292,
	5293,
	5294,
	5295,
	5296,
	5297,
	5298,
	5299,
}

errors = ""

def get_item_type(type, vnum):
	global errors
	if type in item_type:
		return item_type[type]
	else:
		errors += "Strange type in item %s\r\n" % vnum
		return item_type[0]

def get_item_subtype(type, subtype, vnum):
	global errors
	if type in item_subtype:
		if subtype in item_subtype[type]:
			return item_subtype[type][subtype]
	else:
		errors += "Strange subtype in item %s\r\n" % vnum
		return "NONE"

def get_antiflag(antiflag, vnum):
	global errors
	str = ""
	if antiflag >= 131072:
		antiflag -= 131072
		if len(str) <= 0:
			str = "ANTI_SAFEBOX"
		else:
			str = "ANTI_SAFEBOX | " + str
	if antiflag >= 65536:
		antiflag -= 65536
		if len(str) <= 0:
			str = "ANTI_MYSHOP"
		else:
			str = "ANTI_MYSHOP | " + str
	if antiflag >= 32768:
		antiflag -= 32768
		if len(str) <= 0:
			str = "ANTI_STACK"
		else:
			str = "ANTI_STACK | " + str
	if antiflag >= 16384:
		antiflag -= 16384
		if len(str) <= 0:
			str = "ANTI_PKDROP"
		else:
			str = "ANTI_PKDROP | " + str
	if antiflag >= 8192:
		antiflag -= 8192
		if len(str) <= 0:
			str = "ANTI_GIVE"
		else:
			str = "ANTI_GIVE | " + str
	if antiflag >= 4096:
		antiflag -= 4096
		if len(str) <= 0:
			str = "ANTI_SAVE"
		else:
			str = "ANTI_SAVE | " + str
	if antiflag >= 2048:
		antiflag -= 2048
		if len(str) <= 0:
			str = "ANTI_EMPIRE_C"
		else:
			str = "ANTI_EMPIRE_C | " + str
	if antiflag >= 1024:
		antiflag -= 1024
		if len(str) <= 0:
			str = "ANTI_EMPIRE_B"
		else:
			str = "ANTI_EMPIRE_B | " + str
	if antiflag >= 512:
		antiflag -= 512
		if len(str) <= 0:
			str = "ANTI_EMPIRE_A"
		else:
			str = "ANTI_EMPIRE_A | " + str
	if antiflag >= 256:
		antiflag -= 256
		if len(str) <= 0:
			str = "ANTI_SELL"
		else:
			str = "ANTI_SELL | " + str
	if antiflag >= 128:
		antiflag -= 128
		if len(str) <= 0:
			str = "ANTI_DROP"
		else:
			str = "ANTI_DROP | " + str
	if antiflag >= 64:
		antiflag -= 64
		if len(str) <= 0:
			str = "ANTI_GET"
		else:
			str = "ANTI_GET | " + str
	if antiflag >= 32:
		antiflag -= 32
		if len(str) <= 0:
			str = "ANTI_MUDANG"
		else:
			str = "ANTI_MUDANG | " + str
	if antiflag >= 16:
		antiflag -= 16
		if len(str) <= 0:
			str = "ANTI_SURA"
		else:
			str = "ANTI_SURA | " + str
	if antiflag >= 8:
		antiflag -= 8
		if len(str) <= 0:
			str = "ANTI_ASSASSIN"
		else:
			str = "ANTI_ASSASSIN | " + str
	if antiflag >= 4:
		antiflag -= 4
		if len(str) <= 0:
			str = "ANTI_MUSA"
		else:
			str = "ANTI_MUSA | " + str
	if antiflag >= 2:
		antiflag -= 2
		if len(str) <= 0:
			str = "ANTI_MALE"
		else:
			str = "ANTI_MALE | " + str
	if antiflag >= 1:
		antiflag -= 1
		if len(str) <= 0:
			str = "ANTI_FEMALE"
		else:
			str = "ANTI_FEMALE | " + str
	if antiflag == 0 and len(str) > 0:
		return "\"" + str + "\""
	else:
		errors += "Strange antiflag in item %s\r\n" % vnum
		return "\"NONE\""
	
def get_flag(flag, vnum):
	global errors
	str = ""
	if flag >= 32768:
		flag -= 32768
		if len(str) <= 0:
			str = "ITEM_APPLICABLE"
		else:
			str = "ITEM_APPLICABLE | " + str
	if flag >= 16384:
		flag -= 16384
		if len(str) <= 0:
			str = "REFINEABLE"
		else:
			str = "REFINEABLE | " + str
	if flag >= 8192:
		flag -= 8192
		if len(str) <= 0:
			str = "LOG" 
		else:
			str = "LOG | " + str
	if flag >= 4096:
		flag -= 4096
		if len(str) <= 0:
			str = "ITEM_QUEST"
		else:
			str = "ITEM_QUEST | " + str
	if flag >= 2048:
		flag -= 2048
		if len(str) <= 0:
			str = "QUEST_GIVE"
		else:
			str = "QUEST_GIVE | " + str
	if flag >= 1024:
		flag -= 1024
		if len(str) <= 0:
			str = "QUEST_USE_MULTIPLE"
		else:
			str = "QUEST_USE_MULTIPLE | " + str
	if flag >= 512:
		flag -= 512
		if len(str) <= 0:
			str = "QUEST_USE"
		else:
			str = "QUEST_USE | " + str
	if flag >= 256:
		flag -= 256
		if len(str) <= 0:
			str = "CONFIRM_WHEN_USE"
		else:
			str = "CONFIRM_WHEN_USE | " + str
	if flag >= 128:
		flag -= 128
		if len(str) <= 0:
			str = "ITEM_IRREMOVABLE"
		else:
			str = "ITEM_IRREMOVABLE | " + str
	if flag >= 64:
		flag -= 64
		if len(str) <= 0:
			str = "ITEM_MAKECOUNT"
		else:
			str = "ITEM_MAKECOUNT | " + str
	if flag >= 32:
		flag -= 32
		if len(str) <= 0:
			str = "ITEM_UNIQUE"
		else:
			str = "ITEM_UNIQUE | " + str
	if flag >= 16:
		flag -= 16
		if len(str) <= 0:
			str = "ITEM_SLOW_QUERY"
		else:
			str = "ITEM_SLOW_QUERY | " + str
	if flag >= 8:
		flag -= 8
		if len(str) <= 0:
			str = "COUNT_PER_1GOLD"
		else:
			str = "COUNT_PER_1GOLD | " + str
	if flag >= 4:
		flag -= 4
		if len(str) <= 0:
			str = "ITEM_STACKABLE"
		else:
			str = "ITEM_STACKABLE | " + str
	if flag >= 2:
		flag -= 2
		if len(str) <= 0:
			str = "ITEM_SAVE"
		else:
			str = "ITEM_SAVE | " + str
	if flag >= 1:
		flag -= 1
		if len(str) <= 0:
			str = "ITEM_TUNABLE"
		else:
			str = "ITEM_TUNABLE | " + str
	if flag == 0 and len(str) > 0:
		return "\"" + str + "\""
	else:
		errors += "Strange flag in item %s\r\n" % vnum
		return "\"NONE\""

def get_wearflag(wear, vnum):
	global errors
	if wear in wearflag:
		return "\"" + wearflag[wear] + "\""
	else:
		errors += "Strange wearflag in item %s\r\n" % vnum
		return "\"NONE\""
		
def get_immuneflag(immune):
	if immune in immuneflag:
		return "\"" + immuneflag[immune] + "\""
	else:
		return "\"NONE\""
		
def get_limittype(limit):
	if limit in limittype:
		return "\"" + limittype[limit] + "\""
	else:
		return "\"LIMIT_NONE\""
		
def get_apply(apply):
	if apply in bonus:
		return "\"" + bonus[apply] + "\""
	else:
		return "\"APPLY_NONE\""

def socket(sockett):
	if sockett == 127:
		return 0
	else:
		return sockett


process = subprocess.Popen("cd ../settings/ && bash get_setting.sh database db_ip", stdout=subprocess.PIPE, shell=True)
host = process.communicate()[0]
process = subprocess.Popen("cd ../settings/ && bash get_setting.sh database db_user", stdout=subprocess.PIPE, shell=True)
user = process.communicate()[0]
process = subprocess.Popen("cd ../settings/ && bash get_setting.sh database", stdout=subprocess.PIPE, shell=True)
passwd = process.communicate()[0]

print "Connecting to database player..."
db = MySQLdb.connect(host, user, passwd, db="player")
cur = db.cursor()

cur.execute("select * from item_proto")
rows = cur.fetchall()
out_file_itemproto = open("../../shared/item_proto.txt", "w")
out_file_itemnames = open("../../shared/item_names.txt", "w")
print "Converting item_proto..."

for row in rows:
	item_proto_line = "%s~%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s" % (row[0], row[42], "\"" + row[1] + "\"", "\""  + get_item_type(row[3], row[0]) + "\"" , "\""  + get_item_subtype(row[3], row[4], row[0]) + "\"", row[6] , get_antiflag(row[7], row[0]), get_flag(row[8], row[0]), get_wearflag(row[9], row[0]), get_immuneflag(row[10]), row[11], row[12], row[13], row[14], row[16], get_limittype(row[17]), row[18], get_limittype(row[19]), row[20], get_apply(row[21]), row[22], get_apply(row[23]), row[24], get_apply(row[25]), row[26], row[27], row[28], row[29], row[30], row[31], row[32], row[39], row[40], row[41])
	item_names_line = "%s\t%s" % (row[0], row[2])
	out_file_itemproto.write(item_proto_line + "\r")
	out_file_itemnames.write(item_names_line + "\r")
out_file_itemproto.close()

print "Item Proto converted from database"
"""if len(errors) != 0:
	print "Errors during conversion:"
	print errors"""
