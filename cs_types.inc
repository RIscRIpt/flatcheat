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

struct vec3_s
	x dd ?
	y dd ?
	z dd ?
ends ;vec3_s

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
ends

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
ends

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
ends
