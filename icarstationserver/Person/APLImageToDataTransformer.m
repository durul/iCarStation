
#import "APLImageToDataTransformer.h"


@implementation APLImageToDataTransformer


+ (BOOL)allowsReverseTransformation {
	return YES;
}


+ (Class)transformedValueClass {
	return [NSData class];
}


- (id)transformedValue:(id)value {
	return UIImagePNGRepresentation(value);
}


- (id)reverseTransformedValue:(id)value {
	return [[UIImage alloc] initWithData:value];
}


@end

