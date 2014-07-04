STUDIO_RENDER				= 1
STUDIO_EVENTS				= 2

MAX_CLIENTS					= 32
MAX_EDICTS					= 900

MAX_MODEL_NAME				= 64
MAX_MAP_HULLS				= 4
MIPLEVELS					= 4
NUM_AMBIENTS				= 4
MAXLIGHTMAPS				= 4
PLANE_ANYZ					= 5

ALIAS_Z_CLIP_PLANE			= 5
ALIAS_LEFT_CLIP				= 0x0001
ALIAS_TOP_CLIP				= 0x0002
ALIAS_RIGHT_CLIP			= 0x0004
ALIAS_BOTTOM_CLIP			= 0x0008
ALIAS_Z_CLIP				= 0x0010
ALIAS_ONSEAM				= 0x0020
ALIAS_XY_CLIP_MASK			= 0x000F

ZISCALE						= 32768.0

CACHE_SIZE					= 32

MAX_PHYSENTS				= 600 		  
MAX_MOVEENTS				= 64
MAX_CLIP_PLANES				= 5

PM_NORMAL					= 0x00000000
PM_STUDIO_IGNORE			= 0x00000001		
PM_STUDIO_BOX				= 0x00000002		
PM_GLASS_IGNORE				= 0x00000004		
PM_WORLD_ONLY				= 0x00000008		

PM_TRACELINE_PHYSENTSONLY	= 0
PM_TRACELINE_ANYVISIBLE		= 1

MAX_PHYSINFO_STRING			= 256


FL_FLY						= 1 shl 0
FL_SWIM						= 1 shl 1
FL_CONVEYOR					= 1 shl 2
FL_CLIENT					= 1 shl 3
FL_INWATER					= 1 shl 4
FL_MONSTER					= 1 shl 5
FL_GODMODE					= 1 shl 6
FL_NOTARGET					= 1 shl 7
FL_SKIPLOCALHOST			= 1 shl 8
FL_ONGROUND					= 1 shl 9
FL_PARTIALGROUND			= 1 shl 10
FL_WATERJUMP				= 1 shl 11
FL_FROZEN					= 1 shl 12
FL_FAKECLIENT				= 1 shl 13
FL_DUCKING					= 1 shl 14
FL_FLOAT					= 1 shl 15
FL_GRAPHED					= 1 shl 16
FL_IMMUNE_WATER				= 1 shl 17
FL_IMMUNE_SLIME				= 1 shl 18
FL_IMMUNE_LAVA				= 1 shl 19
FL_PROXY					= 1 shl 20
FL_ALWAYSTHINK				= 1 shl 21
FL_BASEVELOCITY				= 1 shl 22
FL_MONSTERCLIP				= 1 shl 23
FL_ONTRAIN					= 1 shl 24
FL_WORLDBRUSH				= 1 shl 25
FL_SPECTATOR        	    = 1 shl 26
FL_CUSTOMENTITY				= 1 shl 29
FL_KILLME					= 1 shl 30
FL_DORMANT					= 1 shl 31

FTRACE_SIMPLEBOX			= 1 shl 0

WALKMOVE_NORMAL				= 0
WALKMOVE_WORLDONLY			= 1
WALKMOVE_CHECKONLY			= 2
MOVETYPE_NONE				= 0
MOVETYPE_WALK				= 3
MOVETYPE_STEP				= 4
MOVETYPE_FLY				= 5
MOVETYPE_TOSS				= 6
MOVETYPE_PUSH				= 7
MOVETYPE_NOCLIP				= 8
MOVETYPE_FLYMISSILE			= 9
MOVETYPE_BOUNCE				= 10
MOVETYPE_BOUNCEMISSILE		= 11
MOVETYPE_FOLLOW				= 12
MOVETYPE_PUSHSTEP			= 13

SOLID_NOT					= 0
SOLID_TRIGGER				= 1
SOLID_BBOX					= 2
SOLID_SLIDEBOX				= 3
SOLID_BSP					= 4

DEAD_NO						= 0
DEAD_DYING					= 1
DEAD_DEAD					= 2
DEAD_RESPAWNABLE			= 3
DEAD_DISCARDBODY			= 4

DAMAGE_NO					= 0
DAMAGE_YES					= 1
DAMAGE_AIM					= 2

EF_BRIGHTFIELD				= 1 shl 0
EF_MUZZLEFLASH 				= 1 shl 1
EF_BRIGHTLIGHT 				= 1 shl 2
EF_DIMLIGHT 				= 1 shl 3
EF_INVLIGHT					= 1 shl 4
EF_NOINTERP					= 1 shl 5
EF_LIGHT					= 1 shl 6
EF_NODRAW					= 1 shl 7

EFLAG_SLERP					= 1

TE_BEAMPOINTS				= 0
TE_BEAMENTPOINT				= 1
TE_GUNSHOT					= 2
TE_EXPLOSION				= 3

TE_EXPLFLAG_NONE			= 0
TE_EXPLFLAG_NOADDITIVE		= 1
TE_EXPLFLAG_NODLIGHTS		= 2
TE_EXPLFLAG_NOSOUND			= 4
TE_EXPLFLAG_NOPARTICLES		= 8
TE_TAREXPLOSION				= 4
TE_SMOKE					= 5
TE_TRACER					= 6
TE_LIGHTNING				= 7
TE_BEAMENTS					= 8
TE_SPARKS					= 9
TE_LAVASPLASH				= 10
TE_TELEPORT					= 11
TE_EXPLOSION2				= 12
TE_BSPDECAL					= 13
TE_IMPLOSION				= 14
TE_SPRITETRAIL				= 15
TE_BEAM						= 16
TE_SPRITE					= 17
TE_BEAMSPRITE				= 18
TE_BEAMTORUS				= 19
TE_BEAMDISK					= 20
TE_BEAMCYLINDER				= 21
TE_BEAMFOLLOW				= 22
TE_GLOWSPRITE				= 23
TE_BEAMRING					= 24
TE_STREAK_SPLASH			= 25
TE_BEAMHOSE					= 26
TE_DLIGHT					= 27
TE_ELIGHT					= 28
TE_TEXTMESSAGE				= 29
TE_LINE						= 30
TE_BOX						= 31
TE_KILLBEAM					= 99
TE_LARGEFUNNEL				= 100
TE_BLOODSTREAM				= 101
TE_SHOWLINE					= 102
TE_BLOOD					= 103
TE_DECAL					= 104
TE_FIZZ						= 105
TE_MODEL					= 106
TE_EXPLODEMODEL				= 107
TE_BREAKMODEL				= 108
TE_GUNSHOTDECAL				= 109
TE_SPRITE_SPRAY				= 110
TE_ARMOR_RICOCHET			= 111
TE_PLAYERDECAL				= 112
TE_BUBBLES					= 113
TE_BUBBLETRAIL				= 114
TE_BLOODSPRITE				= 115
TE_WORLDDECAL				= 116
TE_WORLDDECALHIGH			= 117
TE_DECALHIGH				= 118
TE_PROJECTILE				= 119
TE_SPRAY					= 120
TE_PLAYERSPRITES			= 121
TE_PARTICLEBURST			= 122
TE_FIREFIELD				= 123
TE_PLAYERATTACHMENT			= 124
TE_KILLPLAYERATTACHMENTS	= 125
TE_MULTIGUNSHOT				= 126
TE_USERTRACER				= 127

TEFIRE_FLAG_ALLFLOAT		= 1 shl 0
TEFIRE_FLAG_SOMEFLOAT		= 1 shl 1
TEFIRE_FLAG_LOOP			= 1 shl 2
TEFIRE_FLAG_ALPHA			= 1 shl 3
TEFIRE_FLAG_PLANAR			= 1 shl 4

MSG_BROADCAST				= 0
MSG_ONE						= 1
MSG_ALL						= 2
MSG_INIT					= 3
MSG_PVS						= 4
MSG_PAS						= 5
MSG_PVS_R					= 6
MSG_PAS_R					= 7
MSG_ONE_UNRELIABLE			= 8
MSG_SPEC					= 9

CONTENTS_EMPTY				= -1
CONTENTS_SOLID				= -2
CONTENTS_WATER				= -3
CONTENTS_SLIME				= -4
CONTENTS_LAVA				= -5
CONTENTS_SKY				= -6
CONTENTS_ORIGIN				= -7
CONTENTS_CLIP				= -8
CONTENTS_CURRENT_0			= -9
CONTENTS_CURRENT_90			= -10
CONTENTS_CURRENT_180		= -11
CONTENTS_CURRENT_270		= -12
CONTENTS_CURRENT_UP			= -13
CONTENTS_CURRENT_DOWN		= -14
CONTENTS_TRANSLUCENT		= -15
CONTENTS_LADDER				= -16
CONTENT_FLYFIELD			= -17
CONTENT_GRAVITY_FLYFIELD	= -18
CONTENT_FOG					= -19

CONTENT_EMPTY				= -1
CONTENT_SOLID				= -2
CONTENT_WATER				= -3
CONTENT_SLIME				= -4
CONTENT_LAVA				= -5
CONTENT_SKY					= -6

CHAN_AUTO					= 0
CHAN_WEAPON					= 1
CHAN_VOICE					= 2
CHAN_ITEM					= 3
CHAN_BODY					= 4
CHAN_STREAM					= 5
CHAN_STATIC					= 6
CHAN_NETWORKVOICE_BASE		= 7
CHAN_NETWORKVOICE_END		= 500

ATTN_NONE					= 0
ATTN_NORM					= 0.8
ATTN_IDLE					= 2
ATTN_STATIC					= 1.25

PITCH_NORM					= 100
PITCH_LOW					= 95
PITCH_HIGH					= 120

VOL_NORM					= 1.0

PLAT_LOW_TRIGGER			= 1

SF_TRAIN_WAIT_RETRIGGER		= 1
SF_TRAIN_START_ON			= 4
SF_TRAIN_PASSABLE			= 8

BREAK_TYPEMASK				= 0x4F
BREAK_GLASS					= 0x01
BREAK_METAL					= 0x02
BREAK_FLESH					= 0x04
BREAK_WOOD					= 0x08
BREAK_SMOKE					= 0x10
BREAK_TRANS					= 0x20
BREAK_CONCRETE				= 0x40
BREAK_2						= 0x80

BOUNCE_GLASS				= BREAK_GLASS
BOUNCE_METAL				= BREAK_METAL
BOUNCE_FLESH				= BREAK_FLESH
BOUNCE_WOOD					= BREAK_WOOD
BOUNCE_SHRAP				= 0x10
BOUNCE_SHELL				= 0x20
BOUNCE_CONCRETE 			= BREAK_CONCRETE
BOUNCE_SHOTSHELL			= 0x80

TE_BOUNCE_NULL				= 0
TE_BOUNCE_SHELL				= 1
TE_BOUNCE_SHOTSHELL			= 2

kRenderNormal				= 0
kRenderTransColor			= 1
kRenderTransTexture			= 2
kRenderGlow					= 3
kRenderTransAlpha			= 4
kRenderTransAdd				= 5

kRenderFxNone				= 0
kRenderFxPulseSlow			= 1
kRenderFxPulseFast			= 2
kRenderFxPulseSlowWide		= 3
kRenderFxPulseFastWide		= 4
kRenderFxFadeSlow			= 5
kRenderFxFadeFast			= 6
kRenderFxSolidSlow			= 7
kRenderFxSolidFast			= 8
kRenderFxStrobeSlow			= 9
kRenderFxStrobeFast			= 10
kRenderFxStrobeFaster		= 11
kRenderFxFlickerSlow		= 12
kRenderFxFlickerFast		= 13
kRenderFxNoDissipation		= 14
kRenderFxDistort			= 15
kRenderFxHologram			= 16
kRenderFxDeadPlayer			= 17
kRenderFxExplode			= 18
kRenderFxGlowShell			= 19
kRenderFxClampMinScale		= 20

IN_ATTACK					= 1 shl 0
IN_JUMP						= 1 shl 1
IN_DUCK						= 1 shl 2
IN_FORWARD					= 1 shl 3
IN_BACK						= 1 shl 4
IN_USE						= 1 shl 5
IN_CANCEL					= 1 shl 6
IN_LEFT						= 1 shl 7
IN_RIGHT					= 1 shl 8
IN_MOVELEFT					= 1 shl 9
IN_MOVERIGHT				= 1 shl 10
IN_ATTACK2					= 1 shl 11
IN_RUN						= 1 shl 12
IN_RELOAD					= 1 shl 13
IN_ALT1						= 1 shl 14
IN_SCORE					= 1 shl 15

;Resource types
t_sound						= 0
t_skin						= 1
t_model						= 2
t_decal						= 3
t_generic					= 4
t_eventscript				= 5
t_world						= 6 ;Fake type for world, is really t_model

HISTORY_MAX					= 64 ;Must be power of 2

MAX_SCOREBOARDNAME			= 32
MAX_QPATH					= 64
MAX_INFO_STRING				= 256

MAXSTUDIOBONES				= 128

struct vec2_s
	x dd ?
	y dd ?
ends ;vec2_s

struct vec3_s
	x dd ?
	y dd ?
	z dd ?
ends ;vec3_s

struct vec4_s
	x dd ?
	y dd ?
	z dd ?
	w dd ?
ends ;vec4_s

struct usercmd_s
	lerp_msec			dw ?
	msec				dw ?
	viewangles			vec3_s

	forwardmove			dd ?
	sidemove			dd ?
	upmove				dd ?
	lightlevel			dw ?
	buttons				dw ?
	impulse				dw ?
	weaponselect		dw ?

	impact_index		dd ?
	impact_position		vec3_s
ends ;usercmd_s

struct pmplane_s
	normal	vec3_s
	dist	dd ?
ends ;pmplane_s

struct pmtrace_s
	allsolid		dd ?
	startsolid		dd ?
	inopen			dd ?
	inwater			dd ?
	fraction		dd ?
	endpos			vec3_s
	plane			pmplane_s
	ent				dd ?
	deltavelocity	vec3_s
	hitgroup		dd ?
ends ;pmtrace_s

struct physent_s
	name			db 32 dup ?
	player			dd ?
	origin			vec3_s
	model			dd ? ;struct model_s*
	studiomodel		dd ? ;struct model_s*
	mins			vec3_s 
	maxs			vec3_s
	info			dd ?
	angles			vec3_s

	solid			dd ?
	skin			dd ?
	rendermode		dd ?
	
	frame			dd ?
	sequence		dd ?
	controller		db 4 dup ?
	blending		db 2 dup ?

	movetype		dd ?
	takedamage		dd ?
	blooddecal		dd ?
	team			dd ?
	classnumber		dd ?

	iuser1			dd ?
	iuser2			dd ?
	iuser3			dd ?
	iuser4			dd ?
	fuser1			dd ?
	fuser2			dd ?
	fuser3			dd ?
	fuser4			dd ?
	vuser1			vec3_s
	vuser2			vec3_s
	vuser3			vec3_s
	vuser4			vec3_s
ends ;physent_s

struct playermove_s
	player_index		dd ?
	server				dd ?

	multiplayer			dd ?
	time				dd ?
	frametime			dd ?

	forward				vec3_s
	right				vec3_s
	up					vec3_s
	
	origin				vec3_s
	angles				vec3_s
	oldangles			vec3_s
	velocity			vec3_s
	movedir				vec3_s
	basevelocity		vec3_s
	
	view_ofs			vec3_s
	flDuckTime			dd ?
	bInDuck				dd ?
	
	flTimeStepSound		dd ?
	iStepLeft			dd ?

	flFallVelocity		dd ?
	punchangle			vec3_s

	flSwimTime			dd ?

	flNextPrimaryAttack	dd ?

	effects				dd ?

	flags				dd ?
	usehull				dd ?
	gravity				dd ?
	friction			dd ?
	oldbuttons			dd ?
	waterjumptime		dd ?
	dead				dd ?
	deadflag			dd ?
	spectator			dd ?
	movetype			dd ?

	onground			dd ?
	waterlevel			dd ?
	watertype			dd ?
	oldwaterlevel		dd ?

	sztexturename		db 256 dup ?
	chtexturetype		db ?

	maxspeed			dd ?
	clientmaxspeed		dd ?

	iuser1				dd ?
	iuser2				dd ?
	iuser3				dd ?
	iuser4				dd ?
	fuser1				dd ?
	fuser2				dd ?
	fuser3				dd ?
	fuser4				dd ?
	vuser1				vec3_s
	vuser2				vec3_s
	vuser3				vec3_s
	vuser4				vec3_s

	numphysent			dd ?
	physents			db (sizeof.physent_s * MAX_PHYSENTS) dup ?

	nummoveent			dd ?
	moveents			db (sizeof.physent_s * MAX_MOVEENTS) dup ?

	numvisent			dd ?
	visents				db (sizeof.physent_s * MAX_PHYSENTS) dup ?

	cmd					usercmd_s

	numtouch			dd ?
	touchindex			db (sizeof.pmtrace_s * MAX_PHYSENTS) dup ?

	physinfo			db MAX_PHYSINFO_STRING dup ?

	movevars			dd ? ;struct movevars_s*
	
	player_mins			db (sizeof.vec3_s * 4) dup ?
	player_maxs			db (sizeof.vec3_s * 4) dup ?
ends ;playermove_s

struct pcolor32_s
	r db ?
	g db ?
	b db ?
	a db ?
ends ;pcolor32_s

struct color24_s
	r dw ?
	g dw ?
	b dw ?
ends ;color24_s

struct colorVec
	r dd ?
	g dd ?
	b dd ?
	a dd ?
ends ;colorVec

struct entity_state_s
	;Fields which are filled in by routines outside of delta compression
	entityType			dd ?

	;Index into cl_entities array for this entity.
	number				dd ?
	msg_time			dd ?

	;Message number last time the player/entity state was updated.
	messagenum			dd ?

	;Fields which can be transitted and reconstructed over the network stream
	origin				vec3_s
	angles				vec3_s

	modelindex			dd ?
	sequence			dd ?
	frame				dd ?
	colormap			dd ?
	skin				dw ?
	solid				dw ?
	effects				dd ?
	scale				dd ?

	eflags				dw ?

	;Render information
	rendermode			dd ?
	renderamt			dd ?
	rendercolor			color24_s
	renderfx			dd ?

	movetype			dd ?
	animtime			dd ?
	framerate			dd ?
	body				dd ?
	controller			db 4 dup ?
	blending			db 4 dup ?
	velocity			vec3_s

	;Send bbox down to client for use during prediction.
	mins				vec3_s
	maxs				vec3_s

	aiment				dd ?

	;If owned by a player, the index of that player ( for projectiles ).
	owner				dd ?

	;Friction, for prediction.
	friction			dd ?       
	;Gravity multiplier
	gravity				dd ?		

	;PLAYER SPECIFIC
	team				dd ?
	playerclass			dd ?
	health				dd ?
	spectator			dd ?  
	weaponmodel			dd ?
	gaitsequence		dd ?
	;If standing on conveyor, e.g.
	basevelocity		vec3_s   
	;Use the crouched hull, or the regular player hull.
	usehull				dd ?		
	;Latched buttons last time state updated.
	oldbuttons			dd ?     
	;-1 = in air, else pmove entity number
	onground			dd ?		
	iStepLeft			dd ?
	;How fast we are falling
	flFallVelocity		dd ?  

	fov					dd ?
	weaponanim			dd ?

	;Parametric movement overrides
	startpos			vec3_s
	endpos				vec3_s
	impacttime			dd ?
	starttime			dd ?

	;For mods
	iuser1				dd ?
	iuser2				dd ?
	iuser3				dd ?
	iuser4				dd ?
	fuser1				dd ?
	fuser2				dd ?
	fuser3				dd ?
	fuser4				dd ?
	vuser1				vec3_s
	vuser2				vec3_s
	vuser3				vec3_s
	vuser4				vec3_s
ends ;entity_state_s

struct mouth_s
	mouthopen			dw ? ;0 = mouth closed, 255 = mouth agape
	sndcount			dw ? ;counter for running average
	sndavg				dd ? ;running average
ends ;mouth_s

struct latchedvars_s
	prevanimtime		dd ?  
	sequencetime		dd ?
	prevseqblending		dw 2 dup ?
	prevorigin			vec3_s
	prevangles			vec3_s

	prevsequence		dd ?
	prevframe			dd ?

	prevcontroller		db 4 dup ?
	prevblending		dw 2 dup ?
ends ;latchedvars_s

struct model_s
	name				db 64 dup ?
	needload			dd ? ;bmodels and sprites don't cache normally
	
	type				dd ?
	numframes			dd ?
	synctype			dd ?
	
	flags				dd ?
	
	mins				vec3_s
	maxs				vec3_s
ends ;model_s

struct efrag_s
	leaf				dd ? ;mleaf_s*
	leafnext			dd ? ;efrag_s*
	entity				dd ? ;cl_entity_s*
	entnext				dd ? ;efrag_s*
ends ;efrag_s

struct mnode_s
	;common with leaf
	contents			dd ? ;0, to differentiate from leafs
	visframe			dd ? ;node needs to be traversed if current

	minmaxs				dw 6 dup ? ;for bounding box culling

	parent				dd ? ;mnode_s*

	;node specific
	plane				dd ? ;mplane_s*
	children			dd 2 dup ? ;mnode_s*

	firstsurface		dw ?
	numsurfaces			dw ?
ends ;mnode_s

struct position_history_s
	animtime			dd ? ;Time stamp for this movement
	origin				vec3_s
	angles				vec3_s
ends ;position_history_s

struct cl_entity_s
	index				dd ? ;Index into cl_entities ( should match actual slot, but not necessarily )
	player				dd ? ;True if this entity is a "player"

	baseline			entity_state_s ;The original state from which to delta during an uncompressed message
	prevstate			entity_state_s ;The state information from the penultimate message received from the server
	curstate			entity_state_s ;The state information from the last message received from server

	current_position	dd ? ;Last received history update index
	ph					db (sizeof.position_history_s * HISTORY_MAX) dup ? ;History of position and angle updates for this player
	
	mouth				mouth_s ; For synchronizing mouth movements.

	latched				latchedvars_s ;Variables used by studio model rendering routines

	;Information based on interplocation, extrapolation, prediction, or just copied from last msg received.
	lastmove			dd ?

	;Actual render position and angles
	origin				vec3_s
	angles				vec3_s

	attachment			db (sizeof.vec3_s * 4) dup ? ;Attachment points

	trivial_accept		dd ? ;Other entity local information

	model				model_s ;cl.model_precache[ curstate.modelindes ];  all visible entities have a model
	efrag				efrag_s ;linked list of efrags
	topnode				mnode_s ;for bmodels, first world node that splits bmodel, or NULL if not split
	
	syncbase			dd ? ;for client-side animations -- used by obsolete alias animation system, remove?
	visframe			dd ? ;last frame this entity was found in an active leaf
	cvFloorColor		colorVec
ends ;cl_entity_s

struct resource_s
	szFileName			db MAX_QPATH dup ? ;File name to download/precache.
	type				dd ? ;t_sound, t_skin, t_model, t_decal.
	nIndex				dd ? ;For t_decals
	nDownloadSize		dd ? ;Size in Bytes if this must be downloaded.
	ucFlags				dw ?

	;For handling client to client resource propagation
	rgucMD5_hash		db 16 dup ? ;To determine if we already have it.
	playernum			dw ? ;Which player index this resource is associated with, if it's a custom resource.

	rguc_reserved		db 32 dup ? ;For future expansion
	pNext				dd ? ;struct resource_s *: Next in chain.
	pPrev				dd ? ;struct resource_s *
ends ;resource_s

struct customization_s
	bInUse				dd ? ;Is this customization in use;
	_resource			resource_s ;The resource_t for this customization
	bTranslated			dd ? ;Has the raw data been translated into a useable format?  
							 ;(e.g., raw decal .wad make into texture_t *)
	nUserData1			dd ? ;Customization specific data
	nUserData2			dd ? ;Customization specific data
	pInfo				dd ? ;void*: Buffer that holds the data structure that references the data (e.g., the cachewad_t)
	pBuffer				dd ? ;void*: Buffer that holds the data for the customization (the raw .wad data)
	pNext				dd ? ;struct customization_s*: Next in chain
ends ;customization_s

struct player_info_s
	;User id on server
	userid				dd ?

	;User info string
	userinfo			db MAX_INFO_STRING dup ?

	name				db MAX_SCOREBOARDNAME dup ?

	;Spectator or not, unused
	spectator			dd ?

	ping				dd ?
	packet_loss			dd ?

	;skin information
	model				db MAX_QPATH dup ?
	topcolor			dd ?
	bottomcolor			dd ?

	;last frame rendered
	renderframe			dd ?

	;Gait frame estimation
	gaitsequence		dd ?
	gaitframe			dd ? ;float
	gaityaw				dd ? ;float
	prevgaitorigin		vec3_s

	customdata			customization_s
ends ;player_info_t

struct screenfade_s
	fadeSpeed			dd ? ;float: How fast to fade (tics / second) (+ fade in, - fade out)
	fadeEnd				dd ? ;float: When the fading hits maximum
	fadeTotalEnd		dd ? ;float: Total End Time of the fade (used for FFADE_OUT)
	fadeReset			dd ? ;float: When to reset to not fading (for fadeout and hold)
	r					db ? ;Fade color, red
	g					db ? ;Fade color, green
	b					db ? ;Fade color, blue
	a					db ? ;Fade Alpha
	fadeFlags			dd ? ;Fading flags
ends

struct SCREENINFO_s
	iSize		dd sizeof.SCREENINFO_s
	iWidth		dd ?
	iHeight		dd ?
	iFlags		dd ?
	iCharHeight	dd ?
	charWidths	dw 256 dup ?
ends ;SCREENINFO

struct ClientDLL_s
	Initialize						dd ?
	HUD_Init						dd ?
	HUD_VidInit						dd ?
	HUD_Redraw						dd ?
	HUD_UpdateClientData			dd ?
	HUD_Reset						dd ?
	HUD_PlayerMove					dd ?
	HUD_PlayerMoveInit				dd ?
	HUD_PlayerMoveTexture			dd ?
	IN_ActivateMouse				dd ?
	IN_DeactivateMouse				dd ?
	IN_MouseEvent					dd ?
	IN_ClearStates					dd ?
	IN_Accumulate					dd ?
	CL_CreateMove					dd ?
	CL_IsThirdPerson				dd ?
	CL_CameraOffset					dd ?
	KB_Find							dd ?
	CAM_Think						dd ?
	V_CalcRefdef					dd ?
	HUD_AddEntity					dd ?
	HUD_CreateEntities				dd ?
	HUD_DrawNormalTriangles			dd ?
	HUD_DrawTransparentTriangles	dd ?
	HUD_StudioEvent					dd ?
	HUD_PostRunCmd					dd ?
	HUD_Shutdown					dd ?
	HUD_TxferLocalOverrides			dd ?
	HUD_ProcessPlayerState			dd ?
	HUD_TxferPredictionData			dd ?
	Demo_ReadBuffer					dd ?
	HUD_ConnectionlessPacket		dd ?
	HUD_GetHullBounds				dd ?
	HUD_Frame						dd ?
	HUD_Key_Event					dd ?
	HUD_TempEntUpdate				dd ?
	HUD_GetUserEntity				dd ?
	HUD_VoiceStatus					dd ?
	HUD_DirectorMessage				dd ?
	HUD_GetStudioModelInterface		dd ?
	HUD_ChatInputPosition			dd ?
	HUD_GetPlayerTeam				dd ?
	ClientFactory					dd ?
ends ;ClientDLL_s

struct NET_API_s
	InitNetworking					dd ?
	Status							dd ?
	SendRequest						dd ?
	CancelRequest					dd ?
	CancelAllRequests				dd ?
	AdrToString						dd ?
	CompareAdr						dd ?
	StringToAdr						dd ?
	ValueForKey						dd ?
	RemoveKey						dd ?
	SetValueForKey					dd ?
ends ;NET_API_s

struct triangleapi_s
	version							dd ?
	RenderMode						dd ? ;void: int mode
	Begin							dd ? ;void: int primitiveCode
	End								dd ? ;void: void
	Color4f 						dd ? ;void: float r, float g, float b, float a
	Color4ub 						dd ? ;void: unsigned char r, unsigned char g, unsigned char b, unsigned char a
	TexCoord2f 						dd ? ;void: float u, float v
	Vertex3fv 						dd ? ;void: float *worldPnt
	Vertex3f 						dd ? ;void: float x, float y, float z
	Brightness 						dd ? ;void: float brightness
	CullFace 						dd ? ;void: TRICULLSTYLE style
	SpriteTexture 					dd ? ;int: struct model_s *pSpriteModel, int frame
	WorldToScreen					dd ? ;int: float *world, float *screen ;Returns 1 if it's z clipped
	Fog 							dd ? ;void: float flFogColor[3], float flStart, float flEnd, int bOn ;//Works just like GL_FOG, flFogColor is r/g/b.
	ScreenToWorld					dd ? ;void: float *screen, float *world
ends ;triangleapi_s

struct Engine_s
	pfnSPR_Load						dd ?
	pfnSPR_Frames					dd ?
	pfnSPR_Height					dd ?
	pfnSPR_Width					dd ?
	pfnSPR_Set						dd ?
	pfnSPR_Draw						dd ?
	pfnSPR_DrawHoles				dd ?
	pfnSPR_DrawAdditive				dd ?
	pfnSPR_EnableScissor			dd ?
	pfnSPR_DisableScissor			dd ?
	pfnSPR_GetList					dd ?
	pfnFillRGBA						dd ?
	pfnGetScreenInfo				dd ?
	pfnSetCrosshair					dd ?
	pfnRegisterVariable				dd ?
	pfnGetCvarFloat					dd ?
	pfnGetCvarString				dd ?
	pfnAddCommand					dd ?
	pfnHookUserMsg					dd ?
	pfnServerCmd					dd ?
	pfnClientCmd					dd ?
	pfnGetPlayerInfo				dd ?
	pfnPlaySoundByName				dd ?
	pfnPlaySoundByIndex				dd ?
	pfnAngleVectors					dd ?
	pfnTextMessageGet				dd ?
	pfnDrawCharacter				dd ?
	pfnDrawConsoleString			dd ?
	pfnDrawSetTextColor				dd ?
	pfnDrawConsoleStringLen			dd ?
	pfnConsolePrint					dd ?
	pfnCenterPrint					dd ?
	GetWindowCenterX				dd ?
	GetWindowCenterY				dd ?
	GetViewAngles					dd ?
	SetViewAngles					dd ?
	GetMaxClients					dd ?
	Cvar_SetValue					dd ?
	Cmd_Argc						dd ?
	Cmd_Argv						dd ?
	Con_Printf						dd ?
	Con_DPrintf						dd ?
	Con_NPrintf						dd ?
	Con_NXPrintf					dd ?
	PhysInfo_ValueForKey			dd ?
	ServerInfo_ValueForKey			dd ?
	GetClientMaxspeed				dd ?
	CheckParm						dd ?
	Key_Event						dd ?
	GetMousePosition				dd ?
	IsNoClipping					dd ?
	GetLocalPlayer					dd ?
	GetViewModel					dd ?
	GetEntityByIndex				dd ?
	GetClientTime					dd ?
	V_CalcShake						dd ?
	V_ApplyShake					dd ?
	PM_PointContents				dd ?
	PM_WaterEntity					dd ?
	PM_TraceLine					dd ?
	CL_LoadModel					dd ?
	CL_CreateVisibleEntity			dd ?
	GetSpritePointer				dd ?
	pfnPlaySoundByNameAtLocation	dd ?
	pfnPrecacheEvent				dd ?
	pfnPlaybackEvent				dd ?
	pfnWeaponAnim					dd ?
	pfnRandomFloat					dd ?
	pfnRandomLong					dd ?
	pfnHookEvent					dd ?
	Con_IsVisible					dd ?
	pfnGetGameDirectory				dd ?
	pfnGetCvarPointer				dd ?
	Key_LookupBinding				dd ?
	pfnGetLevelName					dd ?
	pfnGetScreenFade				dd ?
	pfnSetScreenFade				dd ?
	VGui_GetPanel					dd ?
	VGui_ViewportPaintBackground	dd ?
	COM_LoadFile					dd ?
	COM_ParseFile					dd ?
	COM_FreeFile					dd ?
	pTriAPI							dd ?
	pEfxAPI							dd ?
	pEventAPI						dd ?
	pDemoAPI						dd ?
	pNetAPI							dd ?
	pVoiceTweak						dd ?
	IsSpectateOnly					dd ?
	LoadMapSprite					dd ?
	COM_AddAppDirectoryToSearchPath	dd ?
	COM_ExpandFilename				dd ?
	PlayerInfo_ValueForKey			dd ?
	PlayerInfo_SetValueForKey		dd ?
	GetPlayerUniqueID				dd ?
	GetTrackerIDForPlayer			dd ?
	GetPlayerForTrackerID			dd ?
	pfnServerCmdUnreliable			dd ?
	pfnGetMousePos					dd ?
	pfnSetMousePos					dd ?
	pfnSetMouseEnable				dd ?
	pfnGetCvarList					dd ?
	pfnGetCmdList					dd ?
	pfnGetCvarName					dd ?
	pfnGetCmdName					dd ?
	pfnGetServerTime				dd ?
	pfnGetGravity					dd ?
	pfnPrecacheSprite				dd ?
	OverrideLightmap				dd ?
	SetLightmapColor				dd ?
	SetLightmapDarkness				dd ?
	pfnGetSequenceByName			dd ?
	pfnSPR_DrawGeneric				dd ?
	pfnLoadSentence					dd ?
	pfnDrawLocalizedHudString		dd ?
	pfnDrawLocalizedConsoleString	dd ?
	LocalPlayerInfo_ValueForKey		dd ?
	pfnDrawText_0					dd ?
	pfnDrawUnicodeCharacter			dd ?
	pfnCheckSoundFile				dd ?
	GetCareerGameInterface			dd ?
	pfnCvar_Set						dd ?
	IsSinglePlayer					dd ?
	pfnPlaySound					dd ?
	pfnPlayMp3						dd ?
	Sys_FloatTime					dd ?
	pfnSetArray						dd ?
	pfnSetClearArray				dd ?
	pfnClearArray					dd ?
	pfnPlaySound2					dd ?
	pfnTintRGBA						dd ?
ends ;Engine_s

struct StudioInterface_s
	version				dd ?
	StudioDrawModel		dd ?
	StudioDrawPlayer	dd ?
ends ;StudioInterface_s

struct EngineStudio_s
	; Check to see if pointer is in the cache
	Cache_Check						dd ? ;void*: struct cache_user_s *c 
	; Load file into cache ( can be swapped out on demand )
	LoadCacheFile					dd ? ;void: char *path, struct cache_user_s *cu
	; Retrieve model pointer for the named model
	Mod_ForName						dd ? ;struct model_s*: const char *name, int crash_if_missing 
	; Retrieve pointer to studio model data block from a model
	Mod_Extradata					dd ? ;void*: struct model_s *mod 
	; Retrieve indexed model from client side model precache list
	GetModelByIndex					dd ? ;struct model_s*: int index
	; Get entity that is set for rendering
	GetCurrentEntity				dd ? ;struct cl_entity_s*: void
	; Get referenced player_info_t
	PlayerInfo						dd ? ;struct player_info_s*: int index
	; Get most recently received player state data from network system
	GetPlayerState					dd ? ;struct entity_state_s*: int index
	; Get viewentity
	GetViewEntity					dd ? ;struct cl_entity_s*: void
	; Get current frame count, and last two timestampes on client
	GetTimes						dd ? ;void: int *framecount, double *current, double *old
	; Get a pointer to a cvar by name
	GetCvar							dd ? ;struct cvar_s*: const char *name
	; Get current render origin and view vectors ( up, right and vpn )
	GetViewInfo						dd ? ;void: float *origin, float *upv, float *rightv, float *vpnv
	; Get sprite model used for applying chrome effect
	GetChromeSprite					dd ? ;struct model_s*: void
	; Get model counters so we can incement instrumentation
	GetModelCounters				dd ? ;void: int **s, int **a
	; Get software scaling coefficients
	GetAliasScale					dd ? ;void: float *x, float *y

	; Get bone, light, alias, and rotation matrices
	StudioGetBoneTransform			dd ? ;float ****:void
	StudioGetLightTransform			dd ? ;float ****:void
	StudioGetAliasTransform			dd ? ;float ***:void
	StudioGetRotationMatrix			dd ? ;float ***:void

	; Set up body part, and get submodel pointers
	StudioSetupModel				dd ? ;void: int bodypart, void **ppbodypart, void **ppsubmodel
	; Check if entity's bbox is in the view frustum
	StudioCheckBBox					dd ? ;int: void
	; Apply lighting effects to model
	StudioDynamicLight				dd ? ;void: struct cl_entity_s *ent, struct alight_s *plight
	StudioEntityLight				dd ? ;void: struct alight_s *plight
	StudioSetupLighting				dd ? ;void: struct alight_s *plighting

	; Draw mesh vertices
	StudioDrawPoints				dd ? ;void: void

	; Draw hulls around bones
	StudioDrawHulls					dd ? ;void: void
	; Draw bbox around studio models
	StudioDrawAbsBBox				dd ? ;void: void
	; Draws bones
	StudioDrawBones					dd ? ;void: void
	; Loads in appropriate texture for model
	StudioSetupSkin					dd ? ;void: void* ptexturehdr, int index
	; Sets up for remapped colors
	StudioSetRemapColors			dd ? ;void: int top, int bottom
	; Set's player model and returns model pointer
	SetupPlayerModel				dd ? ;struct model_s*: int index
	; Fires any events embedded in animation
	StudioClientEvents				dd ? ;void: void
	; Retrieve/set forced render effects flags
	GetForceFaceFlags				dd ? ;int: void
	SetForceFaceFlags				dd ? ;void: int flags
	; Tell engine the value of the studio model header
	StudioSetHeader					dd ? ;void: void* header
	; Tell engine which model_t * is being renderered
	SetRenderModel					dd ? ;void: struct model_s *model

	; Final state setup and restore for rendering
	SetupRenderer					dd ? ;void: int rendermode
	RestoreRenderer					dd ? ;void: void

	; Set render origin for applying chrome effect
	SetChromeOrigin					dd ? ;void: void

	; True if using D3D/OpenGL
	IsHardware						dd ? ;int: void

	; Only called by hardware interface
	GL_StudioDrawShadow				dd ? ;void: void 
	GL_SetRenderMode				dd ? ;void: int mode 
	StudioSetRenderamt				dd ? ;void: int iRenderamt ;!!!CZERO added for rendering glass on viewmodels
	StudioSetCullState				dd ? ;void: int iCull   
	StudioRenderShadow				dd ? ;void: int iSprite, float *p1, float *p2, float *p3, float *p4
ends ;EngineStudio_s

struct StudioModelRender_s
	CStudioModelRenderer				dd ? ;void: void
	Init								dd ? ;void: void
	StudioDrawModel						dd ? ;int: int flags
	StudioDrawPlayer					dd ? ;int: int flags, struct entity_state_s *pplayer
	StudioGetAnim						dd ? ;mstudioanim_t: model_t *m_pSubModel, mstudioseqdesc_t *pseqdesc
	StudioSetUpTransform				dd ? ;void: int trivial_accept
	StudioSetupBones					dd ? ;void: void
	StudioCalcAttachments				dd ? ;void: void
	StudioSaveBones						dd ? ;void: void
	StudioMergeBones					dd ? ;void: model_t *m_pSubModel
	StudioEstimateInterpolant			dd ? ;float: void
	StudioEstimateFrame					dd ? ;float: mstudioseqdesc_t *pseqdesc
	StudioFxTransform					dd ? ;void: cl_entity_t *ent, float transform[3][4]
	StudioSlerpBones					dd ? ;void: vec4_t q1[], float pos1[][3], vec4_t q2[], float pos2[][3], float s
	StudioCalcBoneAdj					dd ? ;void: float dadt, float *adj, const byte *pcontroller1, const byte *pcontroller2, byte mouthopen
	StudioCalcBoneQuaterion				dd ? ;void: int frame, float s, mstudiobone_t *pbone, mstudioanim_t *panim, float *adj, float *q
	StudioCalcBonePosition				dd ? ;void: int frame, float s, mstudiobone_t *pbone, mstudioanim_t *panim, float *adj, float *pos
	StudioCalcRotations					dd ? ;void: float pos[][3], vec4_t *q, mstudioseqdesc_t *pseqdesc, mstudioanim_t *panim, float f
	StudioRenderModel					dd ? ;void: void
	StudioRenderFinal					dd ? ;void: void
	StudioRenderFinal_Software			dd ? ;void: void
	StudioRenderFinal_Hardware			dd ? ;void: void
	StudioPlayerBlend					dd ? ;void: mstudioseqdesc_t *pseqdesc, int *pBlend, float *pPitch
	StudioEstimateGait					dd ? ;void: entity_state_t *pplayer
	StudioProcessGait					dd ? ;void: entity_state_t *pplayer
ends ;StudioModelRender_s

struct StudioModelRender_vars_s
	m_Unknown							db 8 dup ? ;Please tell me wtf is this
	m_clTime							dq ? ;Client clock
	m_clOldTime							dq ? ;Old Client clock

	m_fDoInterp							dd ? ;Do interpolation?
	m_fGaitEstimation					dd ? ;Do gait estimation?

	m_nFrameCount						dd ? ;Current render frame #

	;Cvars that studio model code needs to reference
	m_pCvarHiModels						dd ? ;ptr to cvar_t, Use high quality models?
	m_pCvarDeveloper					dd ? ;ptr to cvar_t, Developer debug output desired?
	m_pCvarDrawEntities					dd ? ;ptr to cvar_t, Draw entities bone hit boxes, etc?

	m_pCurrentEntity					dd ? ;ptr to cl_entity_s, The entity which we are currently rendering.

	m_pRenderModel						dd ? ;ptr to model_s, The model for the entity being rendered

	m_pPlayerInfo						dd ? ;ptr to player_info_s, Player info for current player, if drawing a player

	m_nPlayerIndex						dd ? ;The index of the player being drawn

	m_flGaitMovement					dd ? ;The player's gait movement

	m_pStudioHeader						dd ? ;ptr to studiohdr_t, Pointer to header block for studio model data

	;Pointers to current body part and submodel
	m_pBodyPart							dd ? ;ptr to mstudiobodyparts_t
	m_pSubModel							dd ? ;ptr to mstudiomodel_t

	;Palette substition for top and bottom of model
	m_nTopColor							dd ?			
	m_nBottomColor						dd ?

	m_pChromeSprite						dd ? ;ptr to model_s, Sprite model used for drawing studio model chrome

	;Caching
	m_nCachedBones						dd ? ;Number of bones in bone cache
	m_nCachedBoneNames					db MAXSTUDIOBONES * 32 dup ? ;Names of cached bones
	
	;Cached bone & light transformation matrices
	m_rgCachedBoneTransform				dd MAXSTUDIOBONES * 3 * 4 dup ? ;float
	m_rgCachedLightTransform			dd MAXSTUDIOBONES * 3 * 4 dup ? ;float

	;Software renderer scale factors
	m_fSoftwareXScale					dd ? ;float
	m_fSoftwareYScale					dd ? ;float

	;Current view vectors and render origin
	m_vUp								vec3_s
	m_vRight							vec3_s
	m_vNormal							vec3_s

	m_vRenderOrigin						vec3_s

	;Model render counters ( from engine )
	m_pStudioModelCount					dd ? ;ptr to int
	m_pModelsDrawn						dd ? ;ptr to int

	;Matrices
	;Model to world transformation
	m_protationmatrix					dd ? ;ptr to float m_protationmatrix[3][4]
	;Model to view transformation
	m_paliastransform					dd ? ;ptr to float m_paliastransform[3][4]

	;Concatenated bone and light transforms
	m_pbonetransform					dd ? ;ptr to float m_pbonetransform[MAXSTUDIOBONES][3][4]
	m_plighttransform					dd ? ;ptr to float m_plighttransform[MAXSTUDIOBONES][3][4]
ends ;StudioModelRender_This_s
