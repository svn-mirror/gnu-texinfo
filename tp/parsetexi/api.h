/* In api.c */
extern ELEMENT *Root;

void parse_file (char *filename);
ELEMENT *get_root (void);
char *element_type_name (ELEMENT *element);
int num_contents_children (ELEMENT *e);
int num_args_children (ELEMENT *e);
void reset_parser (void);

//HV *build_global_info (void);
//HV *build_global_info2 (void);

/* Defined in dump_perl.c */
char *dump_tree_to_string_1 (void);
char *dump_tree_to_string_2 (void);
char *dump_tree_to_string_25 (void);
char *dump_tree_to_string_3 (void);
char *dump_root_element_1 (void);
char *dump_root_element_2 (void);

/* In input.c */
void add_include_directory (char *filename);

/* In indices.c */
void init_index_commands (void);

/* In api.c */
void reset_context_stack (void);

void conf_set_show_menu (int i);
void reset_conf (void);
