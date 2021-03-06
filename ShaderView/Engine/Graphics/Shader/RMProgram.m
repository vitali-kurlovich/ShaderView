//
//  RMProgram.m
//  HelloOpenGL
//
//  Created by Vitali Kurlovich on 11/18/15.
//
//

#import "RMProgram.h"

@import UIKit;

#import "RMVertexShader.h"
#import "RMFragmentShader.h"

#import "RMVertexAttribute.h"

#import "RMMatrix.h"

#import "RMVBOVertexAttribute.h"
#import "RMVBOVertexBuffer.h"



@interface RMProgram ()

@property (nonatomic, copy, readonly) NSString* vertexShaderSrc;
@property (nonatomic, copy, readonly) NSString* fragmentShaderSrc;

@property (nonatomic) NSUInteger currentTextureUnit;

@end


@implementation RMProgram

@synthesize vertexShader = _vertexShader;
@synthesize fragmentShader = _fragmentShader;

- (instancetype)init
{
    return [self initWithVertexShader:@"" fragmentShader:@"" attributes:@[]];
}




- (nullable instancetype)initWithName:(nullable NSString*)name
                         vertexShader:(nonnull NSString*)vertexShader
                       fragmentShader:(nonnull NSString*)fragmentShader
                           attributes:(nonnull NSArray<RMVertexAttribute*>*)attributes
{
    if (vertexShader== nil || fragmentShader == nil || attributes == nil)
    {
        return nil;
    }
    
    self = [super init];
    if (self)
    {
        _attributes = [attributes copy];
        
        _name = [name copy];
        
        _vertexShaderSrc = [vertexShader copy];
        _fragmentShaderSrc = [fragmentShader copy];
        

    }
    return self;
}

- (nullable instancetype)initWithVertexShader:(nonnull NSString*)vertexShader
                               fragmentShader:(nonnull NSString*)fragmentShader
                                   attributes:(nonnull NSArray<RMVertexAttribute*>*)attributes

{
    return [self initWithName:nil vertexShader:vertexShader fragmentShader:fragmentShader attributes:attributes];
}


+ (nullable instancetype)programNamed:(nonnull NSString*)name attributes:(NSArray<RMVertexAttribute*>*)attributes
{
    NSString* vsShaderPath = [[NSBundle mainBundle] pathForResource:name ofType:@"vert"];
    
    if (vsShaderPath.length < 1)
    {
        return nil;
    }
    
    NSString* fsShaderPath = [[NSBundle mainBundle] pathForResource:name ofType:@"frag"];
    
    if (fsShaderPath.length < 1)
    {
        return nil;
    }
    
    NSError* error;
    NSString* vsShaderString = [NSString stringWithContentsOfFile:vsShaderPath encoding:NSUTF8StringEncoding error:&error];
    if (!vsShaderString) {
        NSLog(@"Error loading shader: %@", error.localizedDescription);
        return nil;
    }
    
    NSString* fsShaderString = [NSString stringWithContentsOfFile:fsShaderPath encoding:NSUTF8StringEncoding error:&error];
    if (!fsShaderString) {
        NSLog(@"Error loading shader: %@", error.localizedDescription);
        return nil;
    }
    
    return [[[self class] alloc] initWithName:name
                                 vertexShader:vsShaderString
                               fragmentShader:fsShaderString
                                   attributes:attributes
            ];
}


- (nullable RMVertexShader*)createVertexShader:(nonnull NSString*)src
{
    return nil;
}

- (nullable RMFragmentShader*)creatFragmentShader:(nonnull NSString*)src
{
    return nil;
}


- (RMVertexShader*)vertexShader
{
   if (_vertexShader == nil)
   {
       _vertexShader = [self createVertexShader:_vertexShaderSrc];
       if (_vertexShader)
       {
           _vertexShaderSrc = nil;
       }
   }
    return _vertexShader;
}

- (RMFragmentShader*)fragmentShader
{
    if (_fragmentShader == nil)
    {
        _fragmentShader = [self creatFragmentShader:_fragmentShaderSrc];
        if (_fragmentShader) {
            _fragmentShaderSrc = nil;
        }
    }
    return _fragmentShader;
}


- (BOOL)isCompiled
{
    return NO;
}

- (BOOL)useProgramBegin
{
    _active = YES;
    _currentTextureUnit = 0;
    return YES;
}

- (void)useProgramEnd
{
    _active = NO;
}


- (BOOL)compile
{
    return NO;
}

- (void)prepareForUseVBOBuffer:(RMVBOVertexBuffer*)buffer
{
    __block NSMutableDictionary<NSNumber*, RMVertexAttribute*>* binding = [NSMutableDictionary dictionaryWithCapacity:self.attributes.count];
    
    [self.attributes enumerateObjectsUsingBlock:^(RMVertexAttribute * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        binding[@(obj.attribute)] = obj;
    }];
    
    NSInteger stride = buffer.dataSize/buffer.count;
    
    [buffer.attributes enumerateObjectsUsingBlock:^(RMVBOVertexAttribute* _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        RMVertexAttribute* attr = binding[@(obj.type)];
        if (attr)
        {
            [self enableVertexAttribute:attr numberOfComponents:obj.size stride:stride offset:obj.offset];
        }
    }];
}


- (void)setParam:(nonnull NSString*)name floatValue:(float)value
{
    if (name.length > 0)
    {
        [self applyFloatValue:value name:name];
    }
}

- (void)setParam:(nonnull NSString*)name intValue:(int)value
{
    if (name.length > 0)
    {
        [self applyIntValue:value name:name];
    }
}


- (void)setParam:(NSString*)name color:(UIColor*)color
{
    if (color && name.length > 0)
    {
        [self applyColor:color name:name];
    }
}

- (void)setParam:(NSString*)name number:(NSNumber*)number
{
    if (number && name.length > 0)
    {
        [self applyNumber:number name:name];
    }
}

- (void)setParam:(NSString*)name texture:(RMTexture*)texture
{
    if (texture && name.length > 0)
    {
        [self applyTexture:texture name:name textureUnit:self.currentTextureUnit];
         _currentTextureUnit++;
    }
}

- (void)setParam:(NSString*)name matrix:(RMMatrix*)matrix
{
    if (matrix == nil || name.length == 0)
    {
        return;
    }

    switch (matrix.type) {
        case RMMatrixType2x2:
           [self applyMatrix2x2:(RMMatrix2x2*)matrix name:name];
            break;
            
        case RMMatrixType3x3:
            [self applyMatrix3x3:(RMMatrix3x3*)matrix name:name];
            break;
            
        case RMMatrixType4x4:
            [self applyMatrix4x4:(RMMatrix4x4*)matrix name:name];
            break;
            
        default:
            break;
    }
}


- (void)setParam:(nonnull NSString*)name vector2:(nonnull RMVector2*)vector
{
     if (vector && name.length > 0)
     {
         [self applyVector2:vector name:name];
     }
}

- (void)setParam:(nonnull NSString*)name vector3:(nonnull RMVector3*)vector
{
    if (vector && name.length > 0)
    {
        [self applyVector3:vector name:name];
    }
}

- (void)setParam:(nonnull NSString*)name vector4:(nonnull RMVector4*)vector
{
    if (vector && name.length > 0)
    {
        [self applyVector4:vector name:name];
    }
}


- (void)applyFloatValue:(float)value name:(nonnull NSString*)name
{
    
}

- (void)applyIntValue:(float)value name:(nonnull NSString*)name
{
    
}


- (void)applyMatrix2x2:(RMMatrix2x2*)matrix name:(NSString*)name
{
    
}

- (void)applyMatrix3x3:(RMMatrix3x3*)matrix name:(NSString*)name
{
    
}

- (void)applyMatrix4x4:(RMMatrix4x4*)matrix name:(NSString*)name
{
    
}

- (void)applyTexture:(nonnull RMTexture*)texture name:(nonnull NSString*)name textureUnit:(NSUInteger)unit
{
    
}

- (void)applyVector2:(nonnull RMVector2*)vector name:(nonnull NSString*)name
{
    
}

- (void)applyVector3:(nonnull RMVector3*)vector name:(nonnull NSString*)name
{
    
}

- (void)applyVector4:(nonnull RMVector4*)vector name:(nonnull NSString*)name
{
    
}


- (void)applyNumber:(nonnull NSNumber*)number name:(nonnull NSString*)name
{
    [self applyFloatValue:[number floatValue] name:name];
}

- (void)enableVertexAttribute:(nonnull RMVertexAttribute*)attr numberOfComponents:(NSInteger)numberOfComponents stride:(NSInteger)stride offset:(NSInteger)offset
{
    
}

- (void)disableVertexAttribute:(nonnull RMVertexAttribute*)attr
{
    
}

@end

@implementation RMProgram (UIKit)

- (void)applyColor:(UIColor*)color name:(NSString*)name
{
    CGFloat r,g,b,a;
    [color getRed:&r green:&g blue:&b alpha:&a];
    
    _RMVector4 c = {r,g,b,a};
    [self applyVector4:[RMVector4 vectorWithRMVector:c ] name:name];
}
@end