#ifndef WINDOW_H
#define WINDOW_H

typedef struct string string;
typedef struct main__WindowParams main__WindowParams;
typedef struct main__WindowInfo main__WindowInfo;

main__WindowInfo *window_app_init(void *params);
void window_app_run(main__WindowInfo *info);
void window_app_exit(main__WindowInfo *info);
void window_set_input_text(main__WindowInfo *info, const char *text);
void window_set_text_area(main__WindowInfo *info, const char *text);
void window_set_status_text(main__WindowInfo *info, const char *text);
void window_set_title_text(main__WindowInfo *info, const char *text);
void window_set_always_on_top(main__WindowInfo *info, int enabled);
int window_get_always_on_top(main__WindowInfo *info);
void window_set_checkbox_state(main__WindowInfo *info, int checked);
void window_set_number_value(main__WindowInfo *info, int value);
void window_set_background_color(main__WindowInfo *info, const char *color);
void window_set_font_color(main__WindowInfo *info, const char *color);
void window_set_control_background_color_by_name(main__WindowInfo *info, const char *name, const char *color);
void window_set_control_font_color_by_name(main__WindowInfo *info, const char *name, const char *color);
void window_set_control_width_by_name(main__WindowInfo *info, const char *name, int width);
void window_set_control_height_by_name(main__WindowInfo *info, const char *name, int height);
void window_set_control_font_size_by_name(main__WindowInfo *info, const char *name, int size);
void window_set_padding(main__WindowInfo *info, int padding);
void window_set_spacing(main__WindowInfo *info, int spacing);
void window_set_responsive_layout(main__WindowInfo *info, int enabled);
void *window_add_group_box_control(main__WindowInfo *info, const char *name, const char *title);
void *window_add_tabs_control(main__WindowInfo *info, const char *name, const char **titles, int titles_count);
void *window_add_scroll_view_control(main__WindowInfo *info, const char *name, int height);
void window_focus_control(main__WindowInfo *info, const char *name);
void window_set_placeholder_by_name(main__WindowInfo *info, const char *name, const char *text);
void window_set_error_by_name(main__WindowInfo *info, const char *name, const char *text);
void window_set_tooltip_by_name(main__WindowInfo *info, const char *name, const char *text);
void window_set_default_button_by_name(main__WindowInfo *info, const char *name);
void window_run_after(main__WindowInfo *info, int ms, const char *handler_name);
void window_show_toast(main__WindowInfo *info, const char *message);
void window_open_url(main__WindowInfo *info, const char *url);
void window_copy_to_clipboard(main__WindowInfo *info, const char *text);

// Name-based generic control accessors
void window_set_control_text_by_name(main__WindowInfo *info, const char *name, const char *text);
char *window_get_control_text_by_name(main__WindowInfo *info, const char *name);
void window_set_control_bool_by_name(main__WindowInfo *info, const char *name, int checked);
int window_get_control_bool_by_name(main__WindowInfo *info, const char *name);
void window_set_control_int_by_name(main__WindowInfo *info, const char *name, int value);
int window_get_control_int_by_name(main__WindowInfo *info, const char *name);

// Dynamic control creation bridges
void *window_add_label_control(main__WindowInfo *info, const char *name, const char *text);
void *window_add_input_control(main__WindowInfo *info, const char *name, const char *value);
void *window_add_password_control(main__WindowInfo *info, const char *name, const char *value);
void *window_add_textarea_control(main__WindowInfo *info, const char *name, const char *value);
void *window_add_html_view_control(main__WindowInfo *info, const char *name, const char *html);
void *window_add_drop_zone_control(main__WindowInfo *info, const char *name, const char *label);
void *window_add_checkbox_control(main__WindowInfo *info, const char *name, const char *text, int checked);
void *window_add_button_control(main__WindowInfo *info, const char *name, const char *text);
void *window_add_number_control(main__WindowInfo *info, const char *name, int value);
void *window_add_slider_control(main__WindowInfo *info, const char *name, int value);
void *window_add_theme_menu_control(main__WindowInfo *info, const char *name, const char *selected);
void *window_add_color_well_control(main__WindowInfo *info, const char *name, const char *color);
void *window_add_date_picker_control(main__WindowInfo *info, const char *name, const char *date);
void *window_add_mode_control_control(main__WindowInfo *info, const char *name, const char *selected);
void *window_add_progress_indicator_control(main__WindowInfo *info, const char *name, int value);

// Layout row groupings
void window_begin_row(main__WindowInfo *info, const char *name);
void window_end_row(main__WindowInfo *info);

// Popups and Dialogs
void window_show_alert(main__WindowInfo *info, const char *title, const char *message);
int window_show_confirm(main__WindowInfo *info, const char *title, const char *message);
char *window_show_prompt(main__WindowInfo *info, const char *title, const char *message, const char *default_val);

// File and Folder Pickers
char *window_select_file(main__WindowInfo *info);
char *window_select_folder(main__WindowInfo *info);
char *window_save_file_picker(main__WindowInfo *info);

// Visibility and Enabled states
void window_set_control_visible_by_name(main__WindowInfo *info, const char *name, int visible);
int window_get_control_visible_by_name(main__WindowInfo *info, const char *name);
void window_set_control_enabled_by_name(main__WindowInfo *info, const char *name, int enabled);
int window_get_control_enabled_by_name(main__WindowInfo *info, const char *name);

// Timers
void window_set_interval(main__WindowInfo *info, int ms, const char *timer_name);
void window_stop_interval(main__WindowInfo *info, const char *timer_name);

// List Box and Image View Controls
void *window_add_list_box_control(main__WindowInfo *info, const char *name, const char **items, int items_count);
void window_update_list_items(main__WindowInfo *info, const char *name, const char **items, int items_count);
void window_set_list_selected(main__WindowInfo *info, const char *name, int index);
int window_get_list_selected(main__WindowInfo *info, const char *name);
void *window_add_image_control(main__WindowInfo *info, const char *name, const char *file_path);
void window_set_image_path(main__WindowInfo *info, const char *name, const char *file_path);

// Hover Event Tracking
void window_enable_hover_events(main__WindowInfo *info, const char *name);

// Menu Customization
void window_add_menu_item(main__WindowInfo *info, const char *menu_name, const char *item_title, const char *shortcut, const char *handler_name);

// Spacers and Separators
void window_add_vertical_spacer(main__WindowInfo *info, int height);
void window_add_horizontal_spacer(main__WindowInfo *info, int width);
void window_add_separator(main__WindowInfo *info);

// Multi-Column Table Controls
void *window_add_table_control(main__WindowInfo *info, const char *name, const char **columns, int columns_count);
void window_set_table_rows(main__WindowInfo *info, const char *name, const char **flat_items, int total_count, int columns_count);

// System Menu Bar/Tray App Mode
void window_enable_status_bar(main__WindowInfo *info, const char *icon_path);
void window_show(main__WindowInfo *info);

// Thread Safety Runner
void window_run_on_main_thread(void *callback_fn, void *context);

#endif

