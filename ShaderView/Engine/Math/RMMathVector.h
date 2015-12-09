//
//  RMMathVector.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/5/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMProceduralMesh.h"

typedef struct {
    float x,y;
} _RMVector2;

typedef struct {
    float x,y,z;
} _RMVector3;

typedef struct {
    float x,y,z,w;
} _RMVector4;


extern _RMVector2 const kRMVector2Zero;
extern _RMVector3 const kRMVector3Zero;



static inline float RMDotVector2(_RMVector2 a, _RMVector2 b)
{
    return a.x*b.x + a.y*b.y;
}

static inline float RMDotVector3(_RMVector3 a, _RMVector3 b)
{
    return a.x*b.x + a.y*b.y + a.z*b.z;
}

static inline _RMVector2 RMNormalizeVector2(_RMVector2 a)
{
    float invlength = 1.0/sqrtf(a.x*a.x + a.y*a.y);
    _RMVector2 result = {a.x*invlength, a.y*invlength};
    return result;
}

static inline _RMVector3 RMNormalizeVector3(_RMVector3 a)
{
    float invlength = 1.0/sqrtf(a.x*a.x + a.y*a.y + a.z*a.z);
    _RMVector3 result = {a.x*invlength, a.y*invlength, a.z*invlength};
    return result;
}

static inline _RMVector2 RMSumVector2(_RMVector2 a, _RMVector2 b)
{
    _RMVector2 result = {a.x+b.x, a.y+b.y};
    return result;
}

static inline _RMVector2 RMSubVector2(_RMVector2 a, _RMVector2 b)
{
    _RMVector2 result = {a.x-b.x, a.y-b.y};
    return result;
}

static inline _RMVector3 RMSumVector3(_RMVector3 a, _RMVector3 b)
{
    _RMVector3 result = {a.x+b.x, a.y+b.y, a.z+b.z};
    return result;
}

static inline _RMVector3 RMSubVector3(_RMVector3 a, _RMVector3 b)
{
    _RMVector3 result = {a.x-b.x, a.y-b.y, a.z-b.z};
    return result;
}

static inline float RMCrossVector2(_RMVector2 a, _RMVector2 b)
{
    return a.x*b.y - a.y*b.x;
}

static inline _RMVector3 RMCrossVector3(_RMVector3 a, _RMVector3 b)
{
    _RMVector3 result =  {-a.z*b.y + a.y*b.z, a.z*b.x - a.x*b.z, -a.y*b.x + a.x*b.y};
    return result;
}


static inline _RMVector3 RMRotateXVector3(float angle, _RMVector3 a)
{
    float cos = cosf(angle);
    float sin = sinf(angle);
    
    _RMVector3 result =  {a.x, a.y *cos - a.z*sin, a.z*cos + a.y*sin};
    return result;
}

static inline _RMVector2 RMRotateVector2(float angle, _RMVector2 a)
{
    float cos = cosf(angle);
    float sin = sinf(angle);
    
    _RMVector2 result =  { a.x * cos - a.y*sin, a.y*cos + a.x * sin};
    return result;
}

static inline _RMVector3 RMRotateYVector3(float angle, _RMVector3 a)
{
    float cos = cosf(angle);
    float sin = sinf(angle);
    
    _RMVector3 result =  {a.x*cos + a.z*sin, a.y, a.z*cos - a.x*sin};
    return result;
}

static  inline _RMVector3 RMRotateZVector3(float angle, _RMVector3 a)
{
    float cos = cosf(angle);
    float sin = sinf(angle);
    
    _RMVector3 result =  {a.x*cos - a.y*sin, a.y*cos + a.x*sin, a.z};
    return result;
}


static inline _RMVector3 RMScaleVector3(float scale, _RMVector3 a)
{
    _RMVector3 result =  {a.x*scale, a.y*scale, a.z*scale};
    return result;
}

