typedef struct command_struct {
    char *cmdname;
    unsigned long flags; /* Up to 32 flags */
    int data; /* Number of arguments for brace commands. */
} COMMAND;

extern COMMAND builtin_command_data[];
extern COMMAND *user_defined_command_data;

/* Command ID's with this bit set represent a user-defined command. */
#define USER_COMMAND_BIT 0x8000

enum command_id lookup_command (char *cmdname);

#define command_data(id) \
  (!((id) & USER_COMMAND_BIT) \
   ? builtin_command_data[(id)] \
   : user_defined_command_data[(id) & ~USER_COMMAND_BIT])

#define command_flags(e) (command_data((e)->cmd).flags)

enum command_id add_texinfo_command (char *name);

/* In indices.c */
void init_index_commands (void);

/* Available command flags.  Based on tp/Texinfo/Common.tp. */

#define CF_misc			        0x0001
#define CF_default_index	        0x0002
#define CF_root			        0x0004
#define CF_sectioning		        0x0008
#define CF_brace		        0x0010
#define CF_letter_no_arg	        0x0020
#define CF_accent		        0x0040
#define CF_style		        0x0080
#define CF_code_style		        0x0100
#define CF_regular_font_style	        0x0200
#define CF_context_brace	        0x0400
#define CF_ref			        0x0800
#define CF_explained		        0x1000
#define CF_block		        0x2000
#define CF_raw			        0x4000
#define CF_format_raw		        0x8000
// #define free                     	0x00010000
#define CF_def		        	0x00020000
#define CF_def_aliases	        	0x00040000
#define CF_menu		        	0x00080000
#define CF_align	        	0x00100000
#define CF_region	        	0x00200000
#define CF_preformatted	        	0x00400000
#define CF_preformatted_code		0x00800000
#define CF_item_container		0x01000000
#define CF_item_line			0x02000000
#define CF_nobrace			0x04000000
#define CF_blockitem			0x08000000
#define CF_inline			0x10000000
#define CF_MACRO 			0x20000000
// #define free   			0x40000000
// #define free 			0x80000000

/* Types of misc command (has CF_misc flag).  Values for COMMAND.data. */
/* See Common.pm:376 */
#define MISC_special -1
#define MISC_lineraw -2
#define MISC_skipline -3
#define MISC_skipspace -4
#define MISC_noarg -5
#define MISC_text -6
#define MISC_line -7

/* Types of block command (CF_block).  Common.pm:687. */
#define BLOCK_conditional -1
#define BLOCK_raw -2
#define BLOCK_multitable -3

#if 0
/* Types of brace command could go in 'flags', although then we risk running 
   out of space for flags.  If it does then we have the 'data' field free to 
   store a number of args in. */

/* Types of brace command (CF_brace). */
#define BRACE_context_brace -1

#endif