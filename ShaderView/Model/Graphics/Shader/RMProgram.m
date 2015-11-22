//
//  RMProgram.m
//  HelloOpenGL
//
//  Created by Vitali Kurlovich on 11/18/15.
//
//

#import "RMProgram.h"


#import "RMVertexShader.h"
#import "RMFragmentShader.h"

#import "RMVertexAttribute.h"

#import "RMMatrix.h"

#import "RMVBODataField.h"
#import "RMVBODataBuffer.h"

@interface _RMTextureParam : NSObject
@property (nonnull, nonatomic, readonly) RMTexture* texture;
@property (nonnull, copy, readonly) NSString* paramName;

- (nonnull instancetype)initWithTexture:(nonnull RMTexture*)texture paramName:(nonnull NSString*)paramName;

@end

@interface RMProgram ()
@property (nonatomic, readonly) NSMutableDictionary<NSString*, RMMatrix2x2*> *martix2x2Params;
@property (nonatomic, readonly) NSMutableDictionary<NSString*, RMMatrix3x3*> *martix3x3Params;
@property (nonatomic, readonly) NSMutableDictionary<NSString*, RMMatrix4x4*> *martix4x4Params;

@property (nonatomic, readonly) NSMutableDictionary<NSString*, UIColor*> *colorParams;
@property (nonatomic, readonly) NSMutableDictionary<NSString*, NSNumber*> *numberParams;

@property (nonatomic, readonly) NSMutableArray<_RMTextureParam*> *textureParams;
@end


@implementation RMProgram

- (instancetype)init
{
    RMVertexShader* vs = nil;
    RMFragmentShader* fs = nil;
    return [self initWithVertexShader:vs fragmentShader:fs];
}


- (nullable instancetype)initWithName:(NSString*)name vertexShader:(RMVertexShader*)vertexShader fragmentShader:(RMFragmentShader*)fragmentShader
{
    if (vertexShader == nil || fragmentShader == nil)
    {
        return nil;
    }
    
    self = [super init];
    if (self)
    {
        _vertexShader = vertexShader;
        _fragmentShader = fragmentShader;
        _name = [name copy];
        
        _martix2x2Params = [NSMutableDictionary dictionary];
        _martix3x3Params = [NSMutableDictionary dictionary];
        _martix3x3Params = [NSMutableDictionary dictionary];
        _martix4x4Params = [NSMutableDictionary dictionary];
        
        _colorParams = [NSMutableDictionary dictionary];
        _numberParams = [NSMutableDictionary dictionary];
        
        _textureParams = [NSMutableArray arrayWithCapacity:4];
    }
    return self;
}

- (nullable instancetype)initWithVertexShader:(RMVertexShader*)vertexShader fragmentShader:(RMFragmentShader*)fragmentShader
{
    return [self initWithName:nil vertexShader:vertexShader fragmentShader:fragmentShader];
}


+ (nullable instancetype)programNamed:(nonnull NSString*)name
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
                                 vertexShader:[RMVertexShader shader:vsShaderString]
                               fragmentShader:[RMFragmentShader shader:fsShaderString]];
}

- (BOOL)isCompiled
{
    return NO;
}

- (BOOL)useProgram
{
    [self applyParams];
    return YES;
}

- (BOOL)compile
{
    return NO;
}


- (void)applyParams
{
    [self.martix2x2Params enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, RMMatrix2x2 * _Nonnull obj, BOOL * _Nonnull stop) {
        [self applyMatrix2x2:obj name:key];
    }];
    
    [self.martix3x3Params enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, RMMatrix3x3 * _Nonnull obj, BOOL * _Nonnull stop) {
        [self applyMatrix3x3:obj name:key];
    }];
    
    [self.martix4x4Params enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, RMMatrix4x4 * _Nonnull obj, BOOL * _Nonnull stop) {
        [self applyMatrix4x4:obj name:key];
    }];
    
    [self.textureParams enumerateObjectsUsingBlock:^(_RMTextureParam * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self applyTexture:obj.texture name:obj.paramName index:idx];
    }];
    
    [self.colorParams enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, UIColor * _Nonnull obj, BOOL * _Nonnull stop) {
        [self applyColor:obj name:key];
    }];
    
    [self.numberParams enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSNumber * _Nonnull obj, BOOL * _Nonnull stop) {
        [self applyNumber:obj name:key];
    }];
}


- (void)prepareForUseVBOBuffer:(RMVBOVertexDataBuffer*)buffer
{
    __block NSMutableDictionary<NSNumber*, RMVertexAttribute*>* binding = [NSMutableDictionary dictionary];
    
    [self.vertexShader.attributes enumerateObjectsUsingBlock:^(RMVertexAttribute * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        binding[@(obj.attribute)] = obj;
    }];
    
    NSInteger stride = buffer.dataSize/buffer.count;
    
    [buffer.fields enumerateObjectsUsingBlock:^(RMVBODataField* _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        RMVertexAttribute* attr = binding[@(obj.type)];
        if (attr)
        {
            [self enableVertexAttribute:attr numberOfComponents:obj.numberOfComponents stride:stride offset:obj.offset];
        }
    }];
}


- (void)setParam:(NSString*)name color:(UIColor*)color
{
    if (color == nil)
    {
        [self.colorParams removeObjectForKey:name];
        return;
    }
    
    self.colorParams[name] = color;
}

- (void)setParam:(NSString*)name number:(NSNumber*)number
{
    
    if (number == nil)
    {
        [self.numberParams removeObjectForKey:name];
        return;
    }
    
    self.numberParams[name] = number;
}

- (void)setParam:(NSString*)name texture:(RMTexture*)texture
{
    if (texture == nil)
    {
        __block _RMTextureParam* param = nil;
        [self.textureParams enumerateObjectsUsingBlock:^(_RMTextureParam * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.paramName isEqualToString:name])
            {
                param = obj;
                *stop = YES;
            }
        }];
        if (param)
        {
            [self.textureParams removeObject:param];
        }
        return;
    }
    
    [self.textureParams addObject:[[_RMTextureParam alloc] initWithTexture:texture paramName:name]];
}

- (void)setParam:(NSString*)name matrix:(RMMatrix*)matrix
{
    if (matrix == nil)
    {
        [self.martix2x2Params removeObjectForKey:name];
        [self.martix3x3Params removeObjectForKey:name];
        [self.martix4x4Params removeObjectForKey:name];
        return;
    }
    
    switch (matrix.type) {
        case RMMatrixType2x2:
            self.martix2x2Params[name] = (RMMatrix2x2*)matrix;
            break;
            
        case RMMatrixType3x3:
            self.martix3x3Params[name] = (RMMatrix3x3*)matrix;
            break;
            
        case RMMatrixType4x4:
            self.martix4x4Params[name] = (RMMatrix4x4*)matrix;
            break;
            
        default:
            break;
    }
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

- (void)applyTexture:(RMTexture*)texture name:(NSString*)name index:(NSInteger)index
{
    
}

- (void)applyColor:(UIColor*)color name:(NSString*)name
{
    
}

- (void)applyNumber:(nonnull NSNumber*)number name:(nonnull NSString*)name
{
    
}

- (void)enableVertexAttribute:(nonnull RMVertexAttribute*)attr numberOfComponents:(NSInteger)numberOfComponents stride:(NSInteger)stride offset:(NSInteger)offset
{
    
}

- (void)disableVertexAttribute:(nonnull RMVertexAttribute*)attr
{
    
}

@end


@implementation _RMTextureParam

- (nonnull instancetype)initWithTexture:(nonnull RMTexture*)texture paramName:(nonnull NSString*)paramName
{
    self = [super init];
    if (self)
    {
        _texture = texture;
        _paramName = [paramName copy];
    }
    return self;
}

@end
