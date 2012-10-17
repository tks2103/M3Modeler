//
//  M3Struct.h
//  M3Modeler
//
//  Created by Tanoy Sinha on 10/16/12.
//  Copyright (c) 2012 Tanoy Sinha. All rights reserved.
//

#ifndef M3Modeler_M3Struct_h
#define M3Modeler_M3Struct_h

#import <GLKit/GLKit.h>

typedef struct {
    unsigned char   m3id[4];
    unsigned int    reference_table_offset;
    unsigned int    reference_table_count;
    unsigned int    model_count;
    unsigned int    model_index;
} M3Header;

typedef struct {
    unsigned int    count;
    unsigned int    index;
    unsigned int    flags;
} M3Reference;

typedef struct {
    unsigned char   m3id[4];
    unsigned int    offset;
    unsigned int    count;
    unsigned int    type;
} M3ReferenceEntry;

typedef struct {
    int                             d1;
    M3Reference                     ref_name;
    unsigned int                    flags;
    short                           parent;
    short                           s1;
    float                           vertices[34];
    //M3AnimationReference_Vector3    translation;
    //M3AnimationReference_Quat       rotation;
    //M3AnimationReference_Vector3    scale;
    //M3AnimationReference_UInt32     ar1;
} M3Bone;

typedef struct {
    M3Reference     faces;
    M3Reference     REGN;
    M3Reference     BAT;
    M3Reference     MSEC;
    unsigned int    d1;
} M3Div;

typedef struct {
    unsigned int    d1;
    unsigned int    d2;
    unsigned int    offset_vert;
    unsigned int    num_verts;
    unsigned int    offset_faces;
    unsigned int    num_faces;
    unsigned short  bone_count;
    unsigned short  index_bone;
    unsigned short  num_bone;
    unsigned short  s1[3];
} M3Regn;

typedef struct {
    unsigned char   skip1[4];
    unsigned short  index_regn;
    unsigned char   skip2[4];
    unsigned short  index_mat;
    unsigned char   skip3[2];
} M3Bat;

typedef struct {
    GLKVector3      *vertices;
    int             num_verts;
    GLKVector4      *colors;
} M3Submesh;

typedef struct {
    GLKVector3          position;
    char                boneWeight[4];
    char                boneIndex[4];
    char                normal[4];
    short               uv[2];
    char                tangents[4];
} M3Vertex;

typedef struct {
    M3Reference         ref_name;
    unsigned int        version;
    M3Reference         ref_seqs;
    M3Reference         ref_stc;
    M3Reference         ref_stg;
    
    unsigned char       skip_buffer_1[28];
    
    M3Reference         ref_bones;
    unsigned int        d5;
    unsigned int        flags;
    M3Reference         ref_vertexReference;
    M3Reference         ref_div;
    M3Reference         ref_bonesI;
    
    GLKVector3          extents[2];
    float               radius;
    
    unsigned char       skip_buffer_2[64];
    
    M3Reference         ref_attachments;
    M3Reference         ref_attachmentLookup;
    M3Reference         ref_lights;
    M3Reference         ref_SHBX;
    M3Reference         ref_cameras;
    M3Reference         ref_D;
    M3Reference         ref_material_lookup;
    M3Reference         ref_materials;
    M3Reference         ref_DIS;
    M3Reference         ref_CMP;
    M3Reference         ref_TER;
} M3MODL23;

#endif
