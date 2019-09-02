import MySQLdb
import subprocess

rank = {
	1: "S_PAWN",
	2: "KNIGHT",
	3: "S_KNIGHT",
	4: "BOSS",
	5: "KING",
}

typeee = {
	1: "NPC",
	2: "STONE",
	3: "WARP",
	4: "DOOR",
	5: "BUILDING",
	7: "POLYMORPH_PC",
	8: "HORSE",
	9: "GOTO",
}

battletype = {
	2: "RANGE",
	3: "MAGIC",
	4: "SPECIAL",
	5: "POWER",
	6: "TANKER",
}

def get_rank(level):
	if level in rank:
		return "\"" + rank[level] + "\""
	else:
		return "\"PAWN\""

def get_type(typee):
	if typee in typeee:
		return "\"" + typeee[typee] + "\""
	else:
		return "\"MONSTER\""
		
def get_battletype(battle):
	if battle in battletype:
		return "\"" + battletype[battle] + "\""
	else:
		return "\"MELEE\""
		
def get_flag(flag):
	if flag == "":
		return flag
	else:
		return "\"" + flag + "\""
		
def get_race(race):
	if race == "":
		return race
	else:
		return "\"" + race + "\""
		
def get_immune(immune):
	if immune == "":
		return immune
	else:
		return "\"" + immune + "\""
		
def get_folder(folder):
	if folder == "":
		return "\"wolf\""
	else:
		return "\"" + folder + "\""

process = subprocess.Popen("cd ../settings/settings_values/ && sh db_ip", stdout=subprocess.PIPE, shell=True)
host = process.communicate()[0]
process = subprocess.Popen("cd ../settings/settings_values/ && sh db_user", stdout=subprocess.PIPE, shell=True)
user = process.communicate()[0]
process = subprocess.Popen("cd ../settings/settings_values/ && sh db_password", stdout=subprocess.PIPE, shell=True)
passwd = process.communicate()[0]

print "Connecting to database player..."
db = MySQLdb.connect(host, user, passwd, db="player")
cur = db.cursor()

cur.execute("select * from mob_proto")
rows = cur.fetchall()
out_file_mobproto = open("../../shared/mob_proto.txt", "w")
out_file_mobnames = open("../../shared/mob_names.txt", "w")

print "Converting mob_proto..."

for row in rows:
	mob_proto_line = "%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s" % (row[0], "\"" + row[1] + "\"", get_rank(row[3]), get_type(row[4]), get_battletype(row[5]), row[6], row[7], get_flag(row[8]), row[9], get_race(row[10]), get_immune(row[11]), row[12], get_folder(row[13]), row[14], row[15], row[16], row[17], row[18], row[19], row[20], row[21], row[22], row[23], row[24], row[25], row[26], row[27], row[28], row[29], row[30], row[31], row[32], row[33], row[34], row[35], row[36], row[37], row[38], row[39], row[40], row[41], row[42], row[43], row[44], row[45], row[46], row[47], row[48], row[49], row[50], row[51], row[52], row[53], row[54], row[55], row[56], row[57], row[58], row[59], row[60], row[61], row[62], row[63], row[64], row[65], row[66], row[67], row[68], row[69], row[70], row[71])
	mob_names_line = "%s\t%s" % (row[0], row[2])
	out_file_mobproto.write(mob_proto_line + "\r")
	out_file_mobnames.write(mob_names_line + "\r")
out_file_mobproto.close()

print "Mob proto converted from database"
