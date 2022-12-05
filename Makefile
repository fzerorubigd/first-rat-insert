SPLIT = $(subst -, ,$@)
COMPONENT = $(word 2, $(SPLIT))
FILE = insert.scad
TARGET = game-insert.zip

all: player_box_x5 resource_box_top_x1 resource_box_bottom_x1 player_aid_x1 ellipse_x1 components_x1 tokens_x1
	@echo Done!

zip: clean all
	zip $(TARGET) dist/*.stl

player_box_x5: box-player_box_x5 lid-player_box_x5
resource_box_top_x1: box-resource_box_top_x1 lid-resource_box_top_x1
resource_box_bottom_x1: box-resource_box_bottom_x1 lid-resource_box_bottom_x1
player_aid_x1: box-player_aid_x1 lid-player_aid_x1
ellipse_x1: box-ellipse_x1 lid-ellipse_x1
components_x1: box-components_x1 lid-components_x1
tokens_x1: box-tokens_x1 lid-tokens_x1

dist: 
	mkdir -p dist

lid-%: dist
	openscad -D "g_isolated_print_box=\"$(COMPONENT)\"" -D "g_b_print_lid=true" -D "g_b_print_box=false" -D "g_lid_solid=true" -D "g_lid_label=false" -o dist/$(COMPONENT)-lid-solid.stl $(FILE)
	openscad -D "g_isolated_print_box=\"$(COMPONENT)\"" -D "g_b_print_lid=true" -D "g_b_print_box=false" -D "g_lid_solid=false" -D "g_lid_label=false" -o dist/$(COMPONENT)-lid.stl $(FILE)
	openscad -D "g_isolated_print_box=\"$(COMPONENT)\"" -D "g_b_print_lid=true" -D "g_b_print_box=false" -D "g_lid_solid=false" -D "g_lid_label=true" -o dist/$(COMPONENT)-lid-label.stl $(FILE)

box-%: dist
	openscad -D "g_isolated_print_box=\"$(COMPONENT)\"" -D "g_b_print_lid=false" -D "g_b_print_box=true" -o dist/$(COMPONENT)-box.stl $(FILE)

clean:
	rm -f dist/*.stl $(TARGET)