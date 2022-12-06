include <bit/boardgame_insert_toolkit_lib.2.scad>;

// determines whether lids are output.
g_b_print_lid = t;

// determines whether boxes are output.
g_b_print_box = t; 

// Focus on one box
g_isolated_print_box = ""; 

// Used to visualize how all of the boxes fit together. 
g_b_visualization = f;          
        
// this is the outer wall thickness. 
//Default = 1.5mm
g_wall_thickness = 1.5;

// The tolerance value is extra space put between planes of the lid and box that fit together.
// Increase the tolerance to loosen the fit and decrease it to tighten it.
//
// Note that the tolerance is applied exclusively to the lid.
// So if the lid is too tight or too loose, change this value ( up for looser fit, down for tighter fit ) and 
// you only need to reprint the lid.
// 
// The exception is the stackable box, where the bottom of the box is the lid of the box below,
// in which case the tolerance also affects that box bottom.
//
g_tolerance = 0.15;

// This adjusts the position of the lid detents downward. 
// The larger the value, the bigger the gap between the lid and the box.
g_tolerance_detents_pos = 0.1;

g_lid_solid = t;
g_lid_label = f;

function getLidAttributes(txt, rotation = 0, size = 9, solid=g_lid_solid) = (g_lid_label) ? [
    [ LABEL,
        [
            [ LBL_TEXT,    txt],
            [ LBL_SIZE,    size ],
            [ LBL_FONT,    "Ubuntu:style=bold" ],
            [ ROTATION,    rotation],
        ]
     ],
] : [[ LID_SOLID_B, solid]];

gw = g_wall_thickness;
gw2 = gw * 2;
gw3 = gw * 3;
gw4 = gw * 4;
gw5 = gw * 5;

box_width = 205;
box_height = 215;
box_depth = 44;

player_width = box_height / 5;
player_height = 60;
player_depth = box_depth;

player_aid_width = 65;
player_aid_height = 130;
player_aid_depth = 14;

elipse_depth = box_depth - player_aid_depth;

resources_width = box_height-player_aid_height;
resources_height = box_width - player_height;
resources_depth = box_depth / 2;

components_width = box_width - player_height - player_aid_width;
components_height = player_aid_height;
components_depth = 16;
token_depth = box_depth - components_depth;

score_tracks_width = 22;
score_tracks_height = 80;

card_width = 65;
card_height = 95;

echo("\nFirst Rat boardgame insert\nBy Forud Ghafouri");
data =
[
    [   "player_box_x5",
        [
            [ BOX_SIZE_XYZ, [player_height, player_width, player_depth] ],
            [ BOX_LID,
                getLidAttributes(txt="Players"),
            ],
            [ BOX_COMPONENT,
                [
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ player_height - gw2, player_width - gw2, player_depth - gw] ],
                ]
            ]
        ]
    ], 
    [   "resource_box_top_x1",
        [
            [ BOX_SIZE_XYZ, [resources_width, resources_height, resources_depth] ],
            [ BOX_LID,
                getLidAttributes(txt="Resources"),
            ],
            [ BOX_COMPONENT,
                [
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ (resources_width-gw3)/2 , (resources_height-gw3)/2 , resources_depth - gw] ],
                    [POSITION_XY, [0,0]],
                    [ CMP_SHAPE, FILLET ],
                    [CMP_SHAPE_ROTATED_B, t]
                ]
            ],            
            [ BOX_COMPONENT,
                [
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ (resources_width-gw3)/2 , (resources_height-gw3)/2 , resources_depth - gw] ],
                    [POSITION_XY, [(resources_width-gw3)/2+gw,0]],
                    [ CMP_SHAPE, FILLET ],
                    [CMP_SHAPE_ROTATED_B, t]
                ]
            ],
            [ BOX_COMPONENT,
                [
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ (resources_width-gw3)/2 , (resources_height-gw3)/2 , resources_depth - gw] ],
                    [POSITION_XY, [0,(resources_height-gw3)/2+gw]],
                    [ CMP_SHAPE, FILLET ],
                    [CMP_SHAPE_ROTATED_B, t]
                ]
            ],            
            [ BOX_COMPONENT,
                [
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ (resources_width-gw3)/2 , (resources_height-gw3)/2 , resources_depth - gw] ],
                    [POSITION_XY, [(resources_width-gw3)/2+gw,(resources_height-gw3)/2+gw]],
                    [ CMP_SHAPE, FILLET ],
                    [CMP_SHAPE_ROTATED_B, t]
                ]
            ],
         ]
     ],
     [   "resource_box_bottom_x1",
        [
            [ BOX_SIZE_XYZ, [resources_width, resources_height, resources_depth] ],
            [ BOX_NO_LID_B, true],
            [ BOX_STACKABLE_B, true],  
            [ BOX_COMPONENT,
                [
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ (resources_width-gw3)/2 , (resources_height-gw3)*2/3 , resources_depth - gw] ],
                    [POSITION_XY, [0,0]],
                    [ CMP_SHAPE, FILLET ],
                    [CMP_SHAPE_ROTATED_B, t]
                ]
            ],            
            [ BOX_COMPONENT,
                [
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ (resources_width-gw3)/2 , (resources_height-gw3)*2/3 , resources_depth - gw] ],
                    [POSITION_XY, [(resources_width-gw3)/2+gw,0]],
                    [ CMP_SHAPE, FILLET ],
                    [CMP_SHAPE_ROTATED_B, t]
                ]
            ],
            [ BOX_COMPONENT,
                [
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ (resources_width-gw3)/2 , (resources_height-gw3)/3 , resources_depth - gw] ],
                    [POSITION_XY, [0,(resources_height-gw3)*2/3+gw]],
                    [ CMP_SHAPE, FILLET ],
                    [CMP_SHAPE_ROTATED_B, t]
                ]
            ],            
            [ BOX_COMPONENT,
                [
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ (resources_width-gw3)/2 , (resources_height-gw3)/3 , resources_depth - gw] ],
                    [POSITION_XY, [(resources_width-gw3)/2+gw,(resources_height-gw3)*2/3+gw]],
                    [ CMP_SHAPE, FILLET ],
                    [CMP_SHAPE_ROTATED_B, t]
                ]
            ],
         ]
     ], 
[   "player_aid_x1",
        [
            [ BOX_SIZE_XYZ, [player_aid_height, player_aid_width, player_aid_depth] ],
            [ BOX_NO_LID_B, true],
            [ BOX_STACKABLE_B, true],     
            [ BOX_COMPONENT,
                [
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ player_aid_height - gw2, player_aid_width - gw2 , player_aid_depth ] ],
                    [POSITION_XY, [0,0]],
                    [CMP_PEDESTAL_BASE_B, t]
                ]
            ],  
         ]
     ],
     [   "ellipse_x1",
        [
            [ BOX_SIZE_XYZ, [player_aid_height, player_aid_width, elipse_depth] ],
            [ BOX_LID,
                getLidAttributes(txt="Ellipses"),
            ],
            [ BOX_COMPONENT,
                [
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ player_aid_height - gw2, player_aid_width - gw2 , elipse_depth ] ],
                    [POSITION_XY, [0,0]],
                ]
            ],  
         ]
     ],
     [   "components_x1",
        [
            [ BOX_SIZE_XYZ, [components_height, components_width, components_depth] ],
            [ BOX_NO_LID_B, true],
            [ BOX_STACKABLE_B, true], 
            [ BOX_COMPONENT,
                [
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ card_height, components_width-gw2, components_depth-gw ] ],
                    [POSITION_XY, [0,0]],
                ]
            ],
            [ BOX_COMPONENT,
                [
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ components_height-card_height-gw3, components_width-gw2, components_depth-gw ] ],
                    [POSITION_XY, [card_height+gw,0]],
                ]
            ]
         ]
     ],
     [   "tokens_x1",
        [
            [ BOX_SIZE_XYZ, [components_height, components_width, token_depth] ],
            [ BOX_LID,
                getLidAttributes(txt="Components"),
            ],
            [ BOX_COMPONENT,
                [
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ (components_height-score_tracks_width-gw5)/3, (components_width-gw3)/2, components_depth] ],
                    [ CMP_NUM_COMPARTMENTS_XY, [2, 2] ],
                    [POSITION_XY, [0,0]],
                ]
            ], 
            [ BOX_COMPONENT,
                [
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ (components_height-score_tracks_width-gw5)/3, components_width-gw2, components_depth] ],
                    [POSITION_XY, [2*((components_height-score_tracks_width-gw5)/3)+gw2,0]],
                ]
            ], 
            [ BOX_COMPONENT,
                [
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ score_tracks_width, components_width-gw2, components_depth] ],
                    [POSITION_XY, [3*((components_height-score_tracks_width-gw5)/3)+gw3,0]],
                ]
            ], 
         ]
     ],
];


MakeAll();