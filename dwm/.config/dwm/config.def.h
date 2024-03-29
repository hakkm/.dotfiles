/* See LICENSE file for copyright and license details. */

#include <X11/XF86keysym.h>

/* sound keys */
static const char *volup[] = {"pactl", "set-sink-volume", "0", "+5%", NULL};
static const char *voldown[] = {"pactl", "set-sink-volume", "0", "-5%", NULL};
static const char *volmute[] = {"pactl", "set-sink-mute", "0", "toggle", NULL};

/* brightness */
static const char *brighter[] = {"brightnessctl", "set", "1%+", NULL};
static const char *dimmer[] = {"brightnessctl", "set", "1%-", NULL};

/* appearance */
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int swallowfloating    = 0;        /* 1 means swallow floating windows by default */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "monospace:size=10" };
static const char dmenufont[]       = "monospace:size=10";
static char normbgcolor[]           = "#222222";
static char normbordercolor[]       = "#444444";
static char normfgcolor[]           = "#bbbbbb";
static char selfgcolor[]            = "#eeeeee";
static char selbordercolor[]        = "#005577";
static char selbgcolor[]            = "#005577";
static char *colors[][3] = {
       /*               fg           bg           border   */
       [SchemeNorm] = { normfgcolor, normbgcolor, normbordercolor },
       [SchemeSel]  = { selfgcolor,  selbgcolor,  selbordercolor  },
 };

 typedef struct {
	const char *name;
	const void *cmd;
} Sp;
const char *spcmd1[] = {"alacritty", "--class", "spterm", NULL };
// const char *spcmd2[] = {"st", "-n", "spfm", "-g", "144x41", "-e", "ranger", NULL };
const char *spcmd2[] = {"alacritty", "--class", "spfm", "-e", "ranger", NULL };
// const char *spcmd3[] = {"keepassxc", NULL };
static Sp scratchpads[] = {
	/* name          cmd  */
	{"spterm",      spcmd1},
	{"spranger",    spcmd2},
	// {"keepassxc",   spcmd3},
};

/* tagging */
static const char *tags[] = {"󰣇", "", "", "", "󰑋", "6", "7", "", "🌐", "󰓇"};
 
static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     iscentered   isfloating isterminal  noswallow monitor */
	{ "Gimp",     NULL,       NULL,       0,            0,           1,         0,          0,        -1 },
	{ "Firefox",  NULL,       NULL,       1 << 8,       0,           0,         0,          0,        -1 },
	{ "centered", NULL,      NULL,       0,            1,           1,         1,          0,        -1 },
  { "Alacritty",NULL,      NULL,       0,            0,           0,         1,          0,        -1 },
  { NULL,		  "spterm",	  	NULL,		SPTAG(0),		      0,          1,          1,          0,			 -1 },
  { NULL,		  "spfm",		    NULL,		SPTAG(1),		      0,          1,          0,          0,			 -1 },
  { NULL,		  "keepassxc",	NULL,		SPTAG(2),		      0,          0,          0,          0,			 -1 },
  { "mpv",      "gl",      "HYPER_EFFICIENT_STUDY_WITH_ME.mp4 - mpv",       1 << 3,            0,           0,         0,          0,        -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "[M]",      monocle },
	{ "><>",      NULL },    /* no layout function means floating behavior */
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static const char *dmenucmd[] = { "dmenu_run", "-i", NULL };

static const char *termcmd[]  = { "alacritty", NULL };

static const Key keys[] = {
	/* modifier                     key           function        argument */
	{ MODKEY,                       XK_d,         spawn,          {.v = dmenucmd } },
	{ MODKEY,	                  		XK_Return,    spawn,          {.v = termcmd } },
	{ MODKEY|ShiftMask,             XK_b,         togglebar,      {0} },
	{ MODKEY,                       XK_j,         focusstackvis,  {.i = +1 } },
	{ MODKEY,                       XK_k,         focusstackvis,  {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_j,         focusstackhid,  {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_k,         focusstackhid,  {.i = -1 } },
	{ MODKEY|ControlMask,           XK_j,         pushdown,       {0} },
	{ MODKEY|ControlMask,           XK_k,         pushup,         {0} },
	{ MODKEY|ShiftMask,	          	XK_i,         incnmaster,     {.i = +1 } },
	{ MODKEY|ShiftMask,		          XK_d,         incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,         setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,         setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_s,         show,           {0} }, 				// not working 
	{ MODKEY|ShiftMask,             XK_s,         showall,        {0} },
	{ MODKEY|ShiftMask,	          	XK_h,         hide,           {0} },
	{ MODKEY|ShiftMask,	          	XK_Return,    zoom,           {0} },				// go to master
	{ MODKEY,                       XK_Tab,       view,           {0} },
	{ MODKEY,		                  	XK_q,         killclient,     {0} },
	{ MODKEY|ShiftMask,             XK_t,         setlayout,      {.v = &layouts[0]} },
	{ MODKEY|ShiftMask,             XK_m,         setlayout,      {.v = &layouts[1]} },
	{ MODKEY|ShiftMask,		          XK_f,         setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_space,     setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,     togglefloating, {0} },
	//{ MODKEY,                       XK_0,         view,           {.ui = ~0 } },
	// { MODKEY|ShiftMask,             XK_0,         tag,            {.ui = ~0 } },
  // scratch pad
	{ MODKEY,                  			XK_backslash, togglescratch,  {.ui = 0 } },
	{ MODKEY,                  			XK_u,         togglescratch,  {.ui = 1 } },
	// { MODKEY,                  			XK_x,         togglescratch,  {.ui = 2 } },
  ///
	{ MODKEY,                       XK_F5,        xrdb,           {.v = NULL } },
	{ MODKEY|ShiftMask|ControlMask, XK_q,         quit,           {0} },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
 	TAGKEYS(                        XK_0,                      9)
  {0, XF86XK_AudioRaiseVolume,    spawn,      {.v = volup}},
  {0, XF86XK_AudioLowerVolume,    spawn,      {.v = voldown}},
  {0, XF86XK_AudioMute,           spawn,      {.v = volmute}},
  {0, XF86XK_MonBrightnessDown,   spawn,      {.v = dimmer}},
  {0, XF86XK_MonBrightnessUp,     spawn,      {.v = brighter}},
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button1,        togglewin,      {0} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button1,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

