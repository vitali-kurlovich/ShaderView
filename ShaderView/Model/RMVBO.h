//
//  RMGeometry.h
//  HelloOpenGL
//
//  Created by Vitali Kurlovich on 11/18/15.
//
//

@import Foundation;

typedef NS_ENUM(NSInteger, RMVBOFormat) {
    RMVBOFormat_P2 = 0, //RMVBO_Mesh_P2
    RMVBOFormat_P2_U0, //RMVBO_Mesh_P2_UV02
    RMVBOFormat_P2_U0_U1, //RMVBO_Mesh_P2_UV02_UV12
    
    RMVBOFormat_P3 , // RMVBO_Mesh_P3
    RMVBOFormat_P3_U0, // RMVBO_Mesh_P3_UV02
    RMVBOFormat_P3_U0_U1, // RMVBO_Mesh_P3_UV02_UV12
    RMVBOFormat_P3_N, // RMVBO_Mesh_P3_N3
    RMVBOFormat_P3_N_U0,
    RMVBOFormat_P3_N_U0_U1,
    RMVBOFormat_P3_N_U0_U1_C,
};

typedef struct {
    float position[2];
} RMVBO_Mesh_P2;

typedef struct {
    float position[2];
    float uv0[2];
} RMVBO_Mesh_P2_UV02;

typedef struct {
    float position[2];
    float uv0[2];
    float uv1[2];
} RMVBO_Mesh_P2_UV02_UV12;


typedef struct {
    float position[3];
} RMVBO_Mesh_P3;


typedef struct {
    float position[3];
    float normal[3];
} RMVBO_Mesh_P3_N3;

typedef struct {
    float position[3];
    float normal[3];
    float uv0[2];
} RMVBO_Mesh_P3_N3_UV02;

typedef struct {
    float position[3];
    float uv0[2];
} RMVBO_Mesh_P3_UV02;

typedef struct {
    float position[3];
    float uv0[2];
    float uv1[2];
} RMVBO_Mesh_P3_UV02_UV12;

typedef struct {
    float position[3];
    float normal[3];
    float uv0[2];
    float uv1[2];
} RMVBO_Mesh_P3_N3_UV02_UV12;

typedef struct {
    float position[3];
    float normal[3];
    float uv0[2];
    float uv1[2];
    float color[4];
} RMVBO_Mesh_P3_N3_UV02_UV12_C4;

// GLsizeiptr size, const GLvoid* data


typedef NS_ENUM(NSInteger, RMVBODataType) {
    RMVBODataTypeNone = 0,
    RMVBODataTypeVertex,
    RMVBODataTypeIndexe
};

@interface RMVBOData : NSObject

@property (nonatomic, readonly) RMVBODataType type;
@property (nonatomic, readonly) NSInteger count;
@property (nonatomic, readonly) NSInteger dataLenght;
@property (nonatomic, readonly) const void* data;

@end

@interface RMVBO : NSObject
@property (nonatomic, readonly) RMVBOFormat format;



@end
